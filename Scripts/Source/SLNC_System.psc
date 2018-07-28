scriptname SLNC_System extends Quest hidden

; Options
SLNC_CommonAnimTagList property CommonAnimationTagList auto

SLNC_OralAnimTagList property OralAnimationTagList auto
SLNC_AnalAnimTagList property AnalAnimationTagList auto
SLNC_VaginalAnimTagList property VaginalAnimationTagList auto

SLNC_RapeAnimTagList property RapeAnimationTagList auto
bool property DeactivatedRapeSuppressCommon auto

GlobalVariable property SpeechcraftCheckEnabled auto
GlobalVariable property ForceCheckEnabled auto
GlobalVariable property HardcoreEnabled auto
bool property ArousalInfluenceEnabled auto

GlobalVariable property SexWithFollower auto
GlobalVariable property SexWithPlayer auto

GlobalVariable property SpeechcraftCheckSexSuccess auto
GlobalVariable property SpeechcraftCheckSexFail auto
GlobalVariable property SpeechcraftCheckMoneySuccess auto
GlobalVariable property SpeechcraftCheckMoneyFail auto

int property NeedyArousalThreshold auto
float property NeedyForceMultiplier auto

int property CoolArousalThreshold auto
float property CoolForceMultiplier auto

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
slaFrameworkScr property SLAroused auto
WICourierScript property CourierScript auto

Actor property PlayerRef auto
ReferenceAlias property CourierAlias auto
ReferenceAlias property FollowerAlias auto

GlobalVariable property TemporaryCourierItemCount auto

GlobalVariable property PlayerForce auto
GlobalVariable property CourierForce auto

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
int property StageResumeCourierQuest = 10 autoReadOnly

; Encounters
GlobalVariable property TimesMet auto
GlobalVariable property LastPartingStage auto

; Random Appearances
bool property RandomAppearanceCooldownActive auto

float lastUpdate
float timeElapsed

; Settings
string property SettingsFileName = "slnaughtycourier.json" autoReadOnly

string property SettingKeyCommonAnimTagList = "animtags.common" autoReadOnly
string property SettingKeyOralAnimTagList = "animtags.oral" autoReadOnly
string property SettingKeyAnalAnimTagList = "animtags.anal" autoReadOnly
string property SettingKeyVaginalAnimTagList = "animtags.vaginal" autoReadOnly
string property SettingKeyRapeAnimTagList = "animtags.rape" autoReadOnly

string property SettingKeyHardcoreEnabled = "hardcore.enabled" autoReadOnly

string property SettingKeySpeechEnabled = "speechcraft.enabled" autoReadOnly
string property SettingKeySpeechCheckSexSuccess = "speechcraft.sex.success" autoReadOnly
string property SettingKeySpeechCheckSexFail = "speechcraft.sex.fail" autoReadOnly
string property SettingKeySpeechCheckMoneySuccess = "speechcraft.money.success" autoReadOnly
string property SettingKeySpeechCheckMoneyFail = "speechcraft.money.fail" autoReadOnly

string property SettingKeyForceEnabled = "force.enabled" autoreadonly
string property SettingKeyCourierForce = "force.courier.force" autoReadOnly

string property SettingKeyArousalInfluence = "arousal.enabled" autoReadOnly
string property SettingKeyCoolArousalThresthold = "arousal.cool.arousal.threshold" autoReadOnly
string property SettingKeyCoolForceMultiplier = "arousal.cool.force.multiplier" autoReadOnly
string property SettingKeyNeedyArousalThresthold = "arousal.needy.arousal.threshold" autoReadOnly
string property SettingKeyNeedyForceMultiplier = "arousal.needy.force.multiplier" autoReadOnly

string property SettingKeySexPlayer = "sex.player" autoReadOnly
string property SettingKeySexFollower = "sex.follower" autoReadOnly

string property SettingKeyRandomAppearanceChance = "random_appearance.chance" autoReadOnly
string property SettingKeyRandomAppearanceCd = "random_appearance.cooldown" autoReadOnly


function SettingsImport()
  if !JsonUtil.Load(SettingsFileName)
    return
  endIf

  CommonAnimationTagList.Set(JsonUtil.GetStringValue(SettingsFileName, SettingKeyCommonAnimTagList))
  OralAnimationTagList.Set(JsonUtil.GetStringValue(SettingsFileName, SettingKeyOralAnimTagList))
  AnalAnimationTagList.Set(JsonUtil.GetStringValue(SettingsFileName, SettingKeyAnalAnimTagList))
  VaginalAnimationTagList.Set(JsonUtil.GetStringValue(SettingsFileName, SettingKeyVaginalAnimTagList))
  RapeAnimationTagList.Set(JsonUtil.GetStringValue(SettingsFileName, SettingKeyRapeAnimTagList))

  HardcoreEnabled.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingKeyHardcoreEnabled))

  ForceCheckEnabled.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingKeyForceEnabled))
  CourierForce.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingKeyCourierForce))

  ArousalInfluenceEnabled = JsonUtil.GetIntValue(SettingsFileName, SettingKeyArousalInfluence) as bool
  CoolArousalThreshold = JsonUtil.GetIntValue(SettingsFileName, SettingKeyCoolArousalThresthold)
  CoolForceMultiplier = JsonUtil.GetFloatValue(SettingsFileName, SettingKeyCoolForceMultiplier)
  NeedyArousalThreshold = JsonUtil.GetIntValue(SettingsFileName, SettingKeyNeedyArousalThresthold)
  NeedyForceMultiplier = JsonUtil.GetFloatValue(SettingsFileName, SettingKeyNeedyForceMultiplier)

  SexWithFollower.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingKeySexPlayer))
  SexWithPlayer.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingKeySexFollower))

  SpeechcraftCheckEnabled.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingKeySpeechEnabled))
  SpeechcraftCheckSexSuccess.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingKeySpeechCheckSexSuccess))
  SpeechcraftCheckSexFail.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingKeySpeechCheckSexFail))
  SpeechcraftCheckMoneySuccess.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingKeySpeechCheckMoneySuccess))
  SpeechcraftCheckMoneyFail.SetValue(JsonUtil.GetFloatValue(SettingsFileName, SettingKeySpeechCheckMoneyFail))

  RandomAppearanceChance = JsonUtil.GetFloatValue(SettingsFileName, SettingKeyRandomAppearanceChance)
  RandomAppearanceCooldown = JsonUtil.GetFloatValue(SettingsFileName, SettingKeyRandomAppearanceCd)
endFunction

function SettingsExport()
  JsonUtil.SetStringValue(SettingsFileName, SettingKeyCommonAnimTagList, CommonAnimationTagList.Get())
  JsonUtil.SetStringValue(SettingsFileName, SettingKeyOralAnimTagList, OralAnimationTagList.Get())
  JsonUtil.SetStringValue(SettingsFileName, SettingKeyAnalAnimTagList, AnalAnimationTagList.Get())
  JsonUtil.SetStringValue(SettingsFileName, SettingKeyVaginalAnimTagList, VaginalAnimationTagList.Get())
  JsonUtil.SetStringValue(SettingsFileName, SettingKeyRapeAnimTagList, RapeAnimationTagList.Get())

  JsonUtil.SetFloatValue(SettingsFileName, SettingKeyHardcoreEnabled, HardcoreEnabled.GetValue())

  JsonUtil.SetFloatValue(SettingsFileName, SettingKeyForceEnabled, ForceCheckEnabled.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingKeyCourierForce, CourierForce.GetValue())

  JsonUtil.SetIntValue(SettingsFileName, SettingKeyArousalInfluence, ArousalInfluenceEnabled as int)
  JsonUtil.SetIntValue(SettingsFileName, SettingKeyCoolArousalThresthold, CoolArousalThreshold)
  JsonUtil.SetFloatValue(SettingsFileName, SettingKeyCoolForceMultiplier, CoolForceMultiplier)
  JsonUtil.SetIntValue(SettingsFileName, SettingKeyNeedyArousalThresthold, NeedyArousalThreshold)
  JsonUtil.SetFloatValue(SettingsFileName, SettingKeyNeedyForceMultiplier, NeedyForceMultiplier)

  JsonUtil.SetFloatValue(SettingsFileName, SettingKeySexPlayer, SexWithFollower.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingKeySexFollower, SexWithPlayer.GetValue())

  JsonUtil.SetFloatValue(SettingsFileName, SettingKeySpeechEnabled, SpeechcraftCheckEnabled.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingKeySpeechCheckSexSuccess, SpeechcraftCheckSexSuccess.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingKeySpeechCheckSexFail, SpeechcraftCheckSexFail.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingKeySpeechCheckMoneySuccess, SpeechcraftCheckMoneySuccess.GetValue())
  JsonUtil.SetFloatValue(SettingsFileName, SettingKeySpeechCheckMoneyFail, SpeechcraftCheckMoneyFail.GetValue())

  JsonUtil.SetFloatValue(SettingsFileName, SettingKeyRandomAppearanceChance, RandomAppearanceChance)
  JsonUtil.SetFloatValue(SettingsFileName, SettingKeyRandomAppearanceCd, RandomAppearanceCooldown)

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

function PauseCourierQuest()
  TemporaryCourierItemCount.SetValue(CourierScript.pWICourierItemCount.GetValue())
  CourierScript.pWICourierItemCount.SetValue(0)
endFunction

function ResumeCourierQuest()
  CourierScript.pWICourierItemCount.SetValue(TemporaryCourierItemCount.GetValue())
endFunction

function DeterminePlayerForce()
  float onehanded = PlayerRef.GetAV("OneHanded")
  float twohanded = PlayerRef.GetAV("TwoHanded")
  float archery = PlayerRef.GetAV("Marksman")
  float conjuration = PlayerRef.GetAV("Conjuration")
  float destruction = PlayerRef.GetAV("Destruction")
  float illusion = PlayerRef.GetAV("Illusion")

  float forcemult = 1.0
  float mean = onehanded+twohanded+archery+conjuration+destruction+illusion
        mean /= 6.0

  if ArousalInfluenceEnabled
    int arousal = SLAroused.GetActorArousal(PlayerRef)

    if arousal <= CoolArousalThreshold
      forcemult = CoolForceMultiplier

    elseIf arousal > NeedyArousalThreshold || arousal >= 100
      forcemult = NeedyForceMultiplier

    endIf
  endIf

  PlayerForce.SetValue(mean * forcemult)
endFunction

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

  ; Determine actors
  ; - Aggressor: Courier
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

  ; - Aggressor: Player
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

  ; - No Aggressor
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

  ; Determine tags
  SLNC_AnimTagList RapeSuppressTagList = None

  if DeactivatedRapeSuppressCommon && VictimRef
    RapeSuppressTagList = RapeAnimationTagList
  endIf

  string AnimationTags = CommonAnimationTagList.AssembleTags(RapeSuppressTagList)

  if VictimRef
    AnimationTags += "," + RapeAnimationTagList.AssembleTags()
  endIf

  if vaginal
    AnimationTags += "," + VaginalAnimationTagList.AssembleTags(RapeSuppressTagList)
  endIf

  if oral
    AnimationTags += "," + OralAnimationTagList.AssembleTags(RapeSuppressTagList)
  endIf

  if anal
    AnimationTags += "," + AnalAnimationTagList.AssembleTags(RapeSuppressTagList)
  endIf

  AnimationTags += "," + GetAnimationGenderTags(MainRef, PartnerRef, OtherRef)

  if VictimRef
    Debug.Trace("[NC] Victim:        " + VictimRef.GetDisplayName())
  endIf

  if aggressor
    Debug.Trace("[NC] Aggressor:     " + aggressor.GetDisplayName())
  endIf

  Debug.Trace("[NC] --")

  Debug.Trace("[NC] Main:          " + MainRef.GetDisplayName())
  Debug.Trace("[NC] Partner:       " + PartnerRef.GetDisplayName())

  if OtherRef
    Debug.Trace("[NC] Other:         " + OtherRef.GetDisplayName())
  endIf

  Debug.Trace("[NC] AnimationTags: " + AnimationTags)

  ; Fire!
  ; TODO: Suppressing Tags?
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
