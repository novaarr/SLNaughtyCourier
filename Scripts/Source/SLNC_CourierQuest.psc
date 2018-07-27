;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname SLNC_CourierQuest Extends Quest Hidden

;BEGIN ALIAS PROPERTY CourierAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CourierAlias Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerAlias
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerAlias Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
RegisterForSingleUpdate(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
RegisterForSingleUpdate(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
RegisterForSingleUpdate(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
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

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
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
kmyQuest.WaitForCourierQuest()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
event OnUpdate()
  SLNC_System System = (self as Quest) as SLNC_System

  int currentStage = GetStage()

  System.LastPartingStage.SetValue(currentStage as float)

  if currentStage == System.StageInitiateRapeByCourier
    System.StartSex(vaginal = true, anal = true,                              \
                    aggressor = Alias_CourierAlias.GetActorReference()        )

  elseIf currentStage == System.StageInitiateRapeByPlayer
    System.StartSex(vaginal = true, anal = true,                              \
                    aggressor = Alias_PlayerAlias.GetActorReference()         )

  elseIf currentStage == System.StageInitiateVaginalSex
    System.StartSex(vaginal = true)

  elseIf currentStage == System.StageInitiateAnalSex
    System.StartSex(anal = true)

  elseIf currentStage == System.StageInitiateOralSex
    System.StartSex(oral = true)

  elseIf currentStage == System.StageInitiateAnySex
    System.StartSex(oral = true, anal = true, vaginal = true)

  endIf  
endEvent
