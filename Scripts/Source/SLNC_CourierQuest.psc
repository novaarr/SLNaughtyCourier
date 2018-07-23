;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname SLNC_CourierQuest Extends Quest Hidden

;BEGIN ALIAS PROPERTY Courier
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Courier Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE SLNC_System
Quest __temp = self as Quest
SLNC_System kmyQuest = __temp as SLNC_System
;END AUTOCAST
;BEGIN CODE
RegisterForSingleUpdate(5)
;END CODE
EndFunction
;END FRAGMENT

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

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN AUTOCAST TYPE SLNC_System
Quest __temp = self as Quest
SLNC_System kmyQuest = __temp as SLNC_System
;END AUTOCAST
;BEGIN CODE
RegisterForSingleUpdate(5)
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

  int currentStage = GetStage()

  if currentStage == System.StageInitiateRapeByCourier
    System.StartSex(Alias_Courier.GetActorReference())

  elseIf currentStage == System.StageInitiateRapeByPlayer
    System.StartSex(Alias_Player.GetActorReference())

  elseIf currentStage == System.StageInitiateSex
    System.StartSex()

  endIf
endEvent
