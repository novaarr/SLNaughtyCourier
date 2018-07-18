;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLNC_CourierQuest Extends Quest Hidden

;BEGIN ALIAS PROPERTY Courier
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Courier Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE SLNC_System
Quest __temp = self as Quest
SLNC_System kmyQuest = __temp as SLNC_System
;END AUTOCAST
;BEGIN CODE
RegisterForSingleUpdate(5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE SLNC_System
Quest __temp = self as Quest
SLNC_System kmyQuest = __temp as SLNC_System
;END AUTOCAST
;BEGIN CODE
kmyQuest.RewardSex()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
event OnUpdate()
  SLNC_System System = (self as Quest) as SLNC_System

  if System.PlayerRef.GetDialogueTarget()
    RegisterForSingleUpdate(2)
    return
  endIf


  SetStage(StageRewardSex)
endEvent

int property StageRewardSex = 6 autoReadOnly
