;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname SLNC_CourierQuest Extends Quest Hidden

;BEGIN ALIAS PROPERTY CourierContainerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CourierContainerAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CourierAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CourierAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
RegisterForSingleUpdate(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
RegisterForSingleUpdate(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
RegisterForSingleUpdate(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE SLNC_System
Quest __temp = self as Quest
SLNC_System kmyQuest = __temp as SLNC_System
;END AUTOCAST
;BEGIN CODE
Game.DisablePlayerControls()

kmyQuest.ResetSexVariants()
kmyQuest.PlayerRef.SetLookAt(kmyQuest.CourierAlias.GetReference(), true)

Utility.Wait(2)

kmyQuest.ResumeCourierQuest()

Game.EnablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
event OnUpdate()
  SLNC_System System = (self as Quest) as SLNC_System

  int currentStage = GetStage()

  System.LastPartingStage.SetValue(currentStage as float)

;  Debug.Notification(currentStage)

  if currentStage == System.StageInitiateRapeByCourier
    System.StartSex(Alias_CourierAlias.GetActorReference())

  elseIf currentStage == System.StageInitiateRapeByPlayer
    System.StartSex(Alias_PlayerAlias.GetActorReference())

  elseIf currentStage == System.StageInitiateSex
    System.StartSex()

  endIf
endEvent
