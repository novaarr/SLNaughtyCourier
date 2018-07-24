scriptname SLNC_System extends Quest hidden

; Options
SLNC_CommonAnimTagList property CommonAnimationTagList auto

SLNC_RapeAnimTagList property RapeAnimationTagList auto
bool property DeactivatedRapeSuppressCommon auto

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
int property StageInitial = 0 autoReadOnly
int property StageInitiateAnySex = 2 autoReadOnly
int property StageInitiateOralSex = 3 autoReadOnly
int property StageInitiateAnalSex = 4 autoReadOnly
int property StageInitiateVaginalSex = 5 autoReadOnly
int property StageInitiateRapeByPlayer = 6 autoReadOnly
int property StageInitiateRapeByCourier = 7 autoReadOnly

; Random Appearances
bool property RandomAppearanceCooldownActive auto

float lastUpdate
float timeElapsed

; Settings
string property SettingsFileName = "slnaughtycourier.json" autoReadOnly
string property SettingKeyCommonAnimTagList = "animtags.common" autoReadOnly
string property SettingKeyRapeAnimTagList = "animtags.rape" autoReadOnly
string property SettingsKeySpeechEnabled = "speechcraft.enabled" autoReadOnly
string property SettingsKeyHardcoreEnabled = "hardcore.enabled" autoReadOnly
string property SettingsKeySexPlayer = "sex.player" autoReadOnly
string property SettingsKeySexFollower = "sex.follower" autoReadOnly
string property SettingsKeySpeechCheckSexSuccess = "speechcraft.sex.success" autoReadOnly
string property SettingsKeySpeechCheckSexFail = "speechcraft.sex.fail" autoReadOnly
string property SettingsKeySpeechCheckMoneySuccess = "speechcraft.money.success" autoReadOnly
string property SettingsKeySpeechCheckMoneyFail = "speechcraft.money.fail" autoReadOnly
string property SettingsKeySpeechCheckRapeSuccess = "speechcraft.rape.success" autoReadOnly
string property SettingsKeySpeechCheckRapeFail = "speechcraft.rape.fail" autoReadOnly
string property SettingsKeyRandomAppearanceChance = "random_appearance.chance" autoReadOnly
string property SettingsKeyRandomAppearanceCd = "random_appearance.cooldown" autoReadOnly


function SettingsImport()
  if !JsonUtil.Load(SettingsFileName)
    return
  endIf

  CommonAnimationTagList.Set(JsonUtil.GetStringValue(SettingsFileName, SettingKeyCommonAnimTagList))
  RapeAnimationTagList.Set(JsonUtil.GetStringValue(SettingsFileName, SettingKeyRapeAnimTagList))

  SpeechcraftCheckEnabled.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingsKeySpeechEnabled))
  HardcoreEnabled.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingsKeyHardcoreEnabled))

  SexWithFollower.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingsKeySexPlayer))
  SexWithPlayer.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingsKeySexFollower))

  SpeechcraftCheckSexSuccess.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingsKeySpeechCheckSexSuccess))
  SpeechcraftCheckSexFail.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingsKeySpeechCheckSexFail))
  SpeechcraftCheckMoneySuccess.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingsKeySpeechCheckMoneySuccess))
  SpeechcraftCheckMoneyFail.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingsKeySpeechCheckMoneyFail))
  SpeechcraftCheckRapeSuccess.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingsKeySpeechCheckRapeSuccess))
  SpeechcraftCheckRapeFail.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingsKeySpeechCheckRapeFail))

  RandomAppearanceChance = JsonUtil.GetFloatValue(SettingsFileName, SettingsKeyRandomAppearanceChance)
  RandomAppearanceCooldown = JsonUtil.GetFloatValue(SettingsFileName, SettingsKeyRandomAppearanceCd)
endFunction

function SettingsExport()
  JsonUtil.SetStringValue(SettingsFileName, SettingKeyCommonAnimTagList, CommonAnimationTagList.Get())
  JsonUtil.SetStringValue(SettingsFileName, SettingKeyRapeAnimTagList, RapeAnimationTagList.Get())

  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeySpeechEnabled, SpeechcraftCheckEnabled.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeyHardcoreEnabled, HardcoreEnabled.GetValue())

  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeySexPlayer, SexWithFollower.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeySexFollower, SexWithPlayer.GetValue())

  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeySpeechCheckSexSuccess, SpeechcraftCheckSexSuccess.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeySpeechCheckSexFail, SpeechcraftCheckSexFail.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeySpeechCheckMoneySuccess, SpeechcraftCheckMoneySuccess.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeySpeechCheckMoneyFail, SpeechcraftCheckMoneyFail.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeySpeechCheckRapeSuccess, SpeechcraftCheckRapeSuccess.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeySpeechCheckRapeFail, SpeechcraftCheckRapeFail.GetValue())

  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeyRandomAppearanceChance, RandomAppearanceChance)
  JsonUtil.SetFloatValue(SettingsFileName, SettingsKeyRandomAppearanceCd, RandomAppearanceCooldown)

  JsonUtil.Save(SettingsFileName)
endFunction

; System
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

function StartSex(bool oral = false, bool vaginal = false, bool anal = false, Actor aggressor = None) ; aggressor != None indicates rape
  if !SexWithPlayer && !SexWithFollower
    Debug.Notification("$SLNC_NO_SEX_TARGET")

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

  string AnimationTags = ""

  if VictimRef
    if DeactivatedRapeSuppressCommon
      AnimationTags = CommonAnimationTagList.AssembleTags(RapeAnimationTagList)
      AnimationTags += "," + RapeAnimationTagList.AssembleTags()
    else
      AnimationTags = CommonAnimationTagList.AssembleTags()
      AnimationTags += "," + RapeAnimationTagList.AssembleTags()
    endIf
  else
    AnimationTags = CommonAnimationTagList.AssembleTags()
  endIf

  AnimationTags += "," + GetAnimationGenderTags(MainRef, PartnerRef, OtherRef)

;  if VictimRef
;    Debug.Trace("[NC] Victim:        " + VictimRef.GetDisplayName())
;  endIf
;
;  if aggressor
;    Debug.Trace("[NC] Aggressor:     " + aggressor.GetDisplayName())
;  endIf
;
;  Debug.Trace("[NC] --")
;
;  Debug.Trace("[NC] Main:          " + MainRef.GetDisplayName())
;  Debug.Trace("[NC] Partner:       " + PartnerRef.GetDisplayName())
;
;  if OtherRef
;    Debug.Trace("[NC] Other:         " + OtherRef.GetDisplayName())
;  endIf
;
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

  if GenderTagLeadingMale == InvertedGenderTag
    return GenderTagLeadingMale
  endIf

  return GenderTagLeadingMale + "," + InvertedGenderTag
endFunction
