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

; System
SexLabFramework property SexLab auto

Actor property PlayerRef auto
ReferenceAlias property CourierAlias auto
ReferenceAlias property FollowerAlias auto

MiscObject property Gold auto

; Stages
int property StageInitiateSex = 5 autoReadOnly
int property StageInitiateRapeByPlayer = 6 autoReadOnly
int property StageInitiateRapeByCourier = 7 autoReadOnly

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

  sslThreadController thread = SexLab.QuickStart( VictimRef,                  \
                                                  aggressor,                  \
                                                  OtherRef,                   \
                                                  Victim = VictimRef          )

  while thread.isLocked
    Utility.Wait(0.5)
  endWhile

  Game.DisablePlayerControls()
  PlayerRef.SetLookAt(CourierRef, true)
  Game.EnablePlayerControls()

  Reset()
endFunction
