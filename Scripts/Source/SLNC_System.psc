scriptname SLNC_System extends Quest hidden

; Options
SLNC_CommonAnimTagList property CommonAnimationTagList auto
SLNC_RapeAnimTagList property RapeAnimationTagList auto

GlobalVariable property SpeechcraftCheckEnabled auto
GlobalVariable property HardcoreEnabled auto

GlobalVariable property SexWithFollower auto
GlobalVariable property SexWithPlayer auto

GlobalVariable property SpeechcraftCheckSexSuccess auto
GlobalVariable property SpeechcraftCheckSexFail auto

GlobalVariable property SpeechcraftCheckMoneySuccess auto
GlobalVariable property SpeechcraftCheckMoneyFail auto

GlobalVariable property SpeechcraftCheckRapeSuccess auto
GlobalVariable property SpeechcraftCheckRapeFail auto

float _RandomAppearanceChance
float property RandomAppearanceChance
  function Set(float value)
    if value == 0.0
      UnregisterForUpdateGameTime()
    else
      RegisterForUpdateGameTime(1.0)
    endIf

    _RandomAppearanceChance = value
  endFunction

  float function Get()
    return _RandomAppearanceChance
  endFunction
endProperty

float property RandomAppearanceCooldown auto

; System
SexLabFramework property SexLab auto
WICourierScript property CourierScript auto

Actor property PlayerRef auto
ReferenceAlias property CourierAlias auto
ReferenceAlias property FollowerAlias auto

MiscObject property Gold auto
Book property DummyItem auto

; Stages
int property StageInitiateSex = 5 autoReadOnly
int property StageInitiateRapeByPlayer = 6 autoReadOnly
int property StageInitiateRapeByCourier = 7 autoReadOnly

; Random Appearances
bool property RandomAppearanceCooldownActive auto

float lastUpdate
float timeElapsed

function UpdateTimeElapsed()
  float currentTime = Utility.GetCurrentGameTime() * 24.0
  timeElapsed += currentTime - lastUpdate
  lastUpdate = currentTime
endFunction

bool function RandomAppearanceChanceMet()
  float prob = Utility.RandomFloat()

  if prob <= RandomAppearanceChance
    return true
  endif

  return false
endFunction

event OnInit()
  lastUpdate = Utility.GetCurrentGameTime() * 24.0
  timeElapsed = 0
endEvent

event OnUpdateGameTime()
  UpdateTimeElapsed()

  if CourierScript.IsActive() || CourierScript.pCourierContainer.GetNumItems()
    timeElapsed = 0
    return
  endIf

  ; CD passed and our item was used and CD still active: reset
  if timeElapsed >= RandomAppearanceCooldown                                  \
  && !CourierScript.pCourierContainer.GetItemCount(DummyItem)                 \
  && RandomAppearanceCooldownActive

    RandomAppearanceCooldownActive = false
    timeElapsed = 0

  endIf

  ; No CD and chance met: go
  if !RandomAppearanceCooldownActive                                          \
  && RandomAppearanceChanceMet()

    CourierScript.addItemToContainer(DummyItem)
    RandomAppearanceCooldownActive = true
    timeElapsed = 0

    Debug.Notification("$SLNC_RANDOM_APPEARANCE_START")

  endIf
endEvent

function GiveGold(int sum)
  if sum == -1
    PlayerRef.RemoveItem(Gold, PlayerRef.GetGoldAmount())
  else
    PlayerRef.RemoveItem(Gold, sum)
  endIf
endFunction

function StartSex(Actor aggressor = None) ; aggressor != None indicates rape
  if !SexWithPlayer && !SexWithFollower
    Reset()
    return
  endIf

  Actor CourierRef = CourierAlias.GetActorReference()
  Actor FollowerRef = FollowerAlias.GetActorReference()
  Actor PlayerRefTmp = PlayerRef

  Actor VictimRef = None

  Actor MainRef = None
  Actor PartnerRef = None
  Actor OtherRef = None

  string AnimationTags = CommonAnimationTagList.AssembleTags()

  if SexWithPlayer.GetValue() == 0.0
    PlayerRefTmp = None
  endIf

  if SexWithFollower.GetValue() == 0.0
    FollowerRef = None
  endIf

  ; Aggressor: Courier
  if aggressor == CourierRef
    if !PlayerRefTmp
      MainRef = FollowerRef
      VictimRef = FollowerRef

      PartnerRef = CourierRef
    else
      MainRef = PlayerRef
      VictimRef = PlayerRef

      PartnerRef = CourierRef
      OtherRef = FollowerRef
    endIf

  ; Aggressor: Player
  elseIf aggressor == PlayerRef
    MainRef = CourierRef
    VictimRef = CourierRef

    ; ..but Player not in scene
    if !PlayerRefTmp
      PartnerRef = FollowerRef
    else
      PartnerRef = PlayerRef
      OtherRef = FollowerRef
    endIf

  ; No Aggressor
  else
    if !PlayerRefTmp
      MainRef = FollowerRef
      PartnerRef = CourierRef
    else
      MainRef = PlayerRef
      PartnerRef = CourierRef
      OtherRef = FollowerRef
    endIf
  endIf

  if VictimRef
    AnimationTags += ","+ RapeAnimationTagList.AssembleTags()
  endIf

  AnimationTags += "," + GetAnimationGenderTags(MainRef, PartnerRef, OtherRef)

;  Debug.Trace("[NC] Victim:        " + VictimRef.GetDisplayName())
;  Debug.Trace("[NC] Aggressor:     " + aggressor.GetDisplayName())
;  Debug.Trace("[NC] --")
;  Debug.Trace("[NC] Main:          " + MainRef.GetDisplayName())
;  Debug.Trace("[NC] Partner:       " + PartnerRef.GetDisplayName())
;  Debug.Trace("[NC] Other:         " + OtherRef.GetDisplayName())
;  Debug.Trace("[NC] AnimationTags: " + AnimationTags)

  sslThreadController thread = SexLab.QuickStart( MainRef,                    \
                                                  PartnerRef,                 \
                                                  OtherRef,                   \
                                                  Victim = VictimRef,         \
                                                  AnimationTags = AnimationTags)

  if thread
    while thread.isLocked
      Utility.Wait(0.5)
    endWhile

    Game.DisablePlayerControls()
    PlayerRef.SetLookAt(CourierRef, true)
    Game.EnablePlayerControls()
  else
    Debug.Notification("$SLNC_SEXLAB_THREAD_FAILURE")
  endIf

  Reset()
  SetStage(0)
endFunction

; Utility
string function GetAnimationGenderTags(Actor a1, Actor a2, Actor a3=None)
  int FemaleCount = 0
  int MaleCount = 0
  int ActorCount = 0

  Actor[] actors = new Actor[3]
  actors[0] = a1
  actors[1] = a2
  actors[2] = a3

  int pos = 3
  while pos
    pos -= 1

    if actors[pos]
      ActorCount += 1

      if actors[pos].GetActorBase().GetSex()
        FemaleCount += 1
      else
        MaleCount += 1
      endIf
    endIf
  endWhile

  string GenderTagLeadingMale = ""
  string InvertedGenderTag = ""

  while MaleCount
    MaleCount -= 1

    GenderTagLeadingMale += "M"
  endWhile

  while FemaleCount
    FemaleCount -= 1

    GenderTagLeadingMale += "F"
  endWhile

  while ActorCount
    ActorCount -= 1

    InvertedGenderTag += StringUtil.GetNthChar(GenderTagLeadingMale, ActorCount)
  endWhile

  return GenderTagLeadingMale + "," + InvertedGenderTag
endFunction
