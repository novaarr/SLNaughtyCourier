;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 7
Scriptname SLNC_CourierQuest Extends Quest Hidden

;BEGIN ALIAS PROPERTY CourierAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CourierAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN AUTOCAST TYPE SLNC_System
Quest __temp = self as Quest
SLNC_System kmyQuest = __temp as SLNC_System
;END AUTOCAST
;BEGIN CODE
RegisterForSingleUpdate(2)
Debug.Notification("Oral")
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
RegisterForSingleUpdate(2)
Debug.Notification("Vaginal")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE SLNC_System
Quest __temp = self as Quest
SLNC_System kmyQuest = __temp as SLNC_System
;END AUTOCAST
;BEGIN CODE
RegisterForSingleUpdate(2)
Debug.Notification("Rape by player")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN AUTOCAST TYPE SLNC_System
Quest __temp = self as Quest
SLNC_System kmyQuest = __temp as SLNC_System
;END AUTOCAST
;BEGIN CODE
RegisterForSingleUpdate(2)
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
RegisterForSingleUpdate(2)
Debug.Notification("Rape by courier")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN AUTOCAST TYPE SLNC_System
Quest __temp = self as Quest
SLNC_System kmyQuest = __temp as SLNC_System
;END AUTOCAST
;BEGIN CODE
RegisterForSingleUpdate(2)
Debug.Notification("Anal")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
event OnUpdate()
  SLNC_System System = (self as Quest) as SLNC_System

  int currentStage = GetStage()

  if currentStage == System.StageInitiateRapeByCourier
    System.StartSex(aggressor = Alias_CourierAlias.GetActorReference())

  elseIf currentStage == System.StageInitiateRapeByPlayer
    System.StartSex(aggressor = Alias_PlayerAlias.GetActorReference())

  elseIf currentStage == System.StageInitiateVaginalSex
    System.StartSex(vaginal = true)

  elseIf currentStage == System.StageInitiateAnalSex
    System.StartSex(anal = true)

  elseIf currentStage == System.StageInitiateOralSex
    System.StartSex(oral = true)

  else
    Debug.Notification("Error: Invalid Stage")

  endIf

  Reset()
  SetStage(System.StageInitial)
endEvent
