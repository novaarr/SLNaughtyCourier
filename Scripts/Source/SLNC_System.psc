scriptname SLNC_System extends Quest hidden

SexLabFramework property SexLab auto

Actor property PlayerRef auto
ReferenceAlias property CourierAlias auto

MiscObject property Gold auto

int property StageAfterSex = 0 autoReadOnly

function RewardMoney()
  PlayerRef.RemoveItem(Gold, 50)
endFunction

function RewardSex()
  sslThreadController thread = SexLab.QuickStart(                             \
                                  PlayerRef,                                  \
                                  CourierAlias.GetActorReference())           \

  while thread.isLocked
    Utility.Wait(2)
  endWhile

  SetStage(StageAfterSex)
endFunction
