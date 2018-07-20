scriptname SLNC_System extends Quest hidden

; Options
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
  if CourierScript.IsActive()
    return
  endIf

  UpdateTimeElapsed()

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
  Actor OtherRef = None

  if SexWithPlayer.GetValue() == 0.0
    PlayerRefTmp = None
  endIf

  if SexWithFollower.GetValue() == 0.0
    FollowerRef = None
  endIf

  if aggressor == CourierRef
    if !PlayerRefTmp
      VictimRef = FollowerRef
    else
      VictimRef = PlayerRef
      OtherRef = FollowerRef
    endIf

  elseIf aggressor == PlayerRef
    VictimRef = CourierRef
    OtherRef = FollowerRef
  endIf

;  Debug.Notification("Victim: " + VictimRef.GetDisplayName())
;  Debug.Notification("Aggressor: " + aggressor.GetDisplayName())
;  Debug.Notification("Other: " + OtherRef.GetDisplayName())

  sslThreadController thread = SexLab.QuickStart( VictimRef,                  \
                                                  aggressor,                  \
                                                  OtherRef,                   \
                                                  Victim = VictimRef          )

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
endFunction
