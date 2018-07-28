;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 0
Scriptname SLNC_TIF_C_GR02 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Random Appearance
SLNC_System System = (GetOwningQuest() as Quest) as SLNC_System

System.TimesMet.Mod(1.0)

System.CourierScript.pCourierContainer.RemoveItem(System.DummyItem)
System.CourierScript.pWICourierItemCount.Mod(-1.0)

System.ResetSexVariants()

if System.ForceCheckEnabled
  System.DeterminePlayerForce()
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
