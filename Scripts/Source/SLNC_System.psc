scriptname SLNC_System extends Quest hidden

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
