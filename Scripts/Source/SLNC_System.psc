scriptname SLNC_System extends Quest hidden

; Options
bool property SpeechcraftCheck auto
GlobalVariable property Hardcore auto

; System
SexLabFramework property SexLab auto

Actor property PlayerRef auto
ReferenceAlias property CourierAlias auto

MiscObject property Gold auto



function RewardMoney()
  PlayerRef.RemoveItem(Gold, 50)
endFunction

function RewardSex()
  Actor CourierRef = CourierAlias.GetActorReference()
  sslThreadController thread = SexLab.QuickStart(PlayerRef, CourierRef)

  while thread.isLocked
    Utility.Wait(0.5)
  endWhile

  Game.DisablePlayerControls()
  PlayerRef.SetLookAt(CourierRef, true)
  Game.EnablePlayerControls()

  Reset()
endFunction
