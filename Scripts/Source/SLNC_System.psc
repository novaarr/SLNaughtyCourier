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

function RewardMoney()
  PlayerRef.RemoveItem(Gold, 50)
endFunction

function RewardSex()
  if !SexWithPlayer && !SexWithFollower
    Reset()
    return
  endIf

  Actor CourierRef = CourierAlias.GetActorReference()
  Actor PlayerRefTmp = PlayerRef
  Actor FollowerRef = FollowerAlias.GetActorReference()

  if SexWithPlayer.GetValue() == 0.0
    PlayerRefTmp = None
  endIf

  if SexWithFollower.GetValue() == 0.0
    FollowerRef = None
  endIf

  sslThreadController thread = SexLab.QuickStart( CourierRef,                 \
                                                  PlayerRefTmp,               \
                                                  FollowerRef                 )

  while thread.isLocked
    Utility.Wait(0.5)
  endWhile

  Game.DisablePlayerControls()
  PlayerRef.SetLookAt(CourierRef, true)
  Game.EnablePlayerControls()

  Reset()
endFunction

float function GetPlayerSpeechcraftLevel()
  return PlayerRef.GetActorValue("Speech")
endFunction
