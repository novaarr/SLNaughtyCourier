scriptname SLNC_System extends Quest hidden

; Options
SLNC_CommonAnimTagList property CommonAnimationTagList auto

SLNC_OralAnimTagList property OralAnimationTagList auto
SLNC_AnalAnimTagList property AnalAnimationTagList auto
SLNC_VaginalAnimTagList property VaginalAnimationTagList auto

SLNC_PlayerRapeAnimTagList property PlayerRapeAnimationTagList auto
SLNC_CourierRapeAnimTagList property CourierRapeAnimationTagList auto

bool property DeactivatedRapeTagsSuppressOtherTags auto

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

bool SexVariantAnal
bool SexVariantOral
bool SexVariantVaginal

; Stages
int property StageInitial = 0 autoReadOnly
int property StageInitiateSex = 2 autoReadOnly
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
string property SettingsCommonTagListFileName = "slnaughtycourier-tl-common.json" autoReadOnly
string property SettingsOralTagListFileName = "slnaughtycourier-tl-oral.json" autoReadOnly
string property SettingsAnalTagListFileName = "slnaughtycourier-tl-anal.json" autoReadOnly
string property SettingsVaginalTagListFileName = "slnaughtycourier-tl-vaginal.json" autoReadOnly
string property SettingsCourierRapeTagListFileName = "slnaughtycourier-tl-courier-rape.json" autoReadOnly
string property SettingsPlayerRapeTagListFileName = "slnaughtycourier-tl-player-rape.json" autoReadOnly

string property SettingKeyAnimTagList = "animtags" autoReadOnly

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
  if JsonUtil.Load(SettingsCommonTagListFileName)
    CommonAnimationTagList.Set(JsonUtil.GetStringValue(SettingsCommonTagListFileName, SettingKeyAnimTagList))
  endIf

  if JsonUtil.Load(SettingsOralTagListFileName)
    OralAnimationTagList.Set(JsonUtil.GetStringValue(SettingsOralTagListFileName, SettingKeyAnimTagList))
  endIf

  if JsonUtil.Load(SettingsAnalTagListFileName)
    AnalAnimationTagList.Set(JsonUtil.GetStringValue(SettingsAnalTagListFileName, SettingKeyAnimTagList))
  endIf

  if JsonUtil.Load(SettingsVaginalTagListFileName)
    VaginalAnimationTagList.Set(JsonUtil.GetStringValue(SettingsVaginalTagListFileName, SettingKeyAnimTagList))
  endIf

  if JsonUtil.Load(SettingsPlayerRapeTagListFileName)
    PlayerRapeAnimationTagList.Set(JsonUtil.GetStringValue(SettingsPlayerRapeTagListFileName, SettingKeyAnimTagList))
  endIf

  if JsonUtil.Load(SettingsCourierRapeTagListFileName)
    CourierRapeAnimationTagList.Set(JsonUtil.GetStringValue(SettingsCourierRapeTagListFileName, SettingKeyAnimTagList))
  endIf

  if !JsonUtil.Load(SettingsFileName)
    return
  endIf

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
  JsonUtil.SetStringValue(SettingsCommonTagListFileName, SettingKeyAnimTagList, CommonAnimationTagList.Get())
  JsonUtil.Save(SettingsCommonTagListFileName)

  JsonUtil.SetStringValue(SettingsOralTagListFileName, SettingKeyAnimTagList, OralAnimationTagList.Get())
  JsonUtil.Save(SettingsOralTagListFileName)

  JsonUtil.SetStringValue(SettingsAnalTagListFileName, SettingKeyAnimTagList, AnalAnimationTagList.Get())
  JsonUtil.Save(SettingsAnalTagListFileName)

  JsonUtil.SetStringValue(SettingsVaginalTagListFileName, SettingKeyAnimTagList, VaginalAnimationTagList.Get())
  JsonUtil.Save(SettingsVaginalTagListFileName)

  JsonUtil.SetStringValue(SettingsPlayerRapeTagListFileName, SettingKeyAnimTagList, PlayerRapeAnimationTagList.Get())
  JsonUtil.Save(SettingsPlayerRapeTagListFileName)

  JsonUtil.SetStringValue(SettingsCourierRapeTagListFileName, SettingKeyAnimTagList, CourierRapeAnimationTagList.Get())
  JsonUtil.Save(SettingsCourierRapeTagListFileName)

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

function ResetSexVariants(bool oral = false, bool vaginal = false, bool anal = false)
  SexVariantAnal = anal
  SexVariantOral = oral
  SexVariantVaginal = vaginal
endFunction

function StartSex(Actor aggressor = None) ; aggressor != None indicates rape
  if !SexWithPlayer && !SexWithFollower
    Debug.Notification("$SLNC_NO_SEX_TARGET")

    Reset()
    return
  endIf

  Actor CourierRef = CourierAlias.GetActorReference()
  Actor FollowerRef = FollowerAlias.GetActorReference()
  Actor PlayerRefTmp = PlayerRef

  Actor VictimRef = None

  if SexWithPlayer.GetValue() == 0.0
    PlayerRefTmp = None
  endIf

  if SexWithFollower.GetValue() == 0.0
    FollowerRef = None
  endIf

  ; Determine victim
  ; - Aggressor: Courier
  if aggressor == CourierRef
    if !PlayerRefTmp
      VictimRef = FollowerRef
    else
      VictimRef = PlayerRef
    endIf

  ; - Aggressor: Player
  elseIf aggressor == PlayerRef
    VictimRef = CourierRef

  endIf

  ; Determine tags
  SLNC_AnimTagList RapeSuppressTagList = None

  if DeactivatedRapeTagsSuppressOtherTags
    if VictimRef == PlayerRef
      RapeSuppressTagList = PlayerRapeAnimationTagList
    elseIf VictimRef == CourierRef
      RapeSuppressTagList = CourierRapeAnimationTagList
    endIf
  endIf

  string AnimationTags = CommonAnimationTagList.AssembleTags(RapeSuppressTagList)
  string SuppressionTags = CommonAnimationTagList.AssembleDisabledTags()

  if VictimRef == PlayerRef
    AnimationTags += "," + PlayerRapeAnimationTagList.AssembleTags()
  elseIf VictimRef == CourierRef
    AnimationTags += "," + CourierRapeAnimationTagList.AssembleTags()
  endIf

  if SexVariantVaginal
    AnimationTags += "," + VaginalAnimationTagList.AssembleTags(RapeSuppressTagList)
    SuppressionTags += "," + VaginalAnimationTagList.AssembleDisabledTags()
  endIf

  if SexVariantOral
    AnimationTags += "," + OralAnimationTagList.AssembleTags(RapeSuppressTagList)
    SuppressionTags += "," + OralAnimationTagList.AssembleDisabledTags()
  endIf

  if SexVariantAnal
    AnimationTags += "," + AnalAnimationTagList.AssembleTags(RapeSuppressTagList)
    SuppressionTags += "," + AnalAnimationTagList.AssembleDisabledTags()
  endIf

  if RapeSuppressTagList
    SuppressionTags += "," + RapeSuppressTagList.AssembleDisabledTags()
  endIf

  string GenderTag = GetAnimationGenderTag(PlayerRefTmp, FollowerRef, CourierRef)

  Actor[] Positions = SexLabUtil.MakeActorArray(PlayerRefTmp, FollowerRef, CourierRef)
  sslBaseAnimation[] Anims = GetSexVariantAnimations(Positions, AnimationTags, SuppressionTags, GenderTag)

  Positions = SexLab.SortActors(Positions)

  int threadId = SexLab.StartSex(Positions, Anims, VictimRef, none, true, "")

	sslThreadController thread = SexLab.ThreadSlots.GetController(threadId)

  if thread
    while thread.isLocked
      Utility.Wait(0.5)
    endWhile
  else
    Debug.Notification("$SLNC_SEXLAB_THREAD_FAILURE")
  endIf
endFunction

; Utility
string function GetAnimationGenderTag(Actor a1, Actor a2=None, Actor a3=None)
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

  while MaleCount
    MaleCount -= 1

    GenderTagLeadingMale += "M"
  endWhile

  while FemaleCount
    FemaleCount -= 1

    GenderTagLeadingMale += "F"
  endWhile

  return GenderTagLeadingMale
endFunction

sslBaseAnimation[] function GetSexVariantAnimations(Actor[] Positions, string AnimationTags, string SuppressionTags, string GenderTag = "")
  sslBaseAnimation[] TmpAnims = SexLab.AnimSlots.GetByTags(Positions.Length, AnimationTags, SuppressionTags, false)
  bool[] ValidAnims = Utility.CreateBoolArray(TmpAnims.Length)

  int pos = TmpAnims.Length
  int ValidAnimCount = 0

  while pos
    pos -= 1

    if ((SexVariantVaginal && TmpAnims[pos].IsVaginal)                        \
    || (SexVariantOral && TmpAnims[pos].IsOral)                               \
    || (SexVariantAnal && TmpAnims[pos].IsAnal))                              \
    && GenderTag == TmpAnims[pos].GetGenderTag(Reverse = true)

      ValidAnims[pos] = true
      ValidAnimCount += 1

    else

      ValidAnims[pos] = false

    endIf
  endWhile

  sslBaseAnimation[] Anims = sslUtility.AnimationArray(ValidAnimCount)

  if !Anims
    return None
  endIf

  pos = ValidAnims.Length
  while pos
    pos -= 1

    if ValidAnims[pos]
      ValidAnimCount -= 1
      Anims[ValidAnimCount] = TmpAnims[pos]
    endIf
  endWhile

  return Anims
endFunction
