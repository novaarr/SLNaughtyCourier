;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLNC_TIF_C_GR07 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Random Appearance: First Encounter
SLNC_System System = (GetOwningQuest() as Quest) as SLNC_System
System.TimesMet.Mod(1.0)
System.CourierScript.pCourierContainer.RemoveItem(System.DummyItem)
System.CourierScript.pWICourierItemCount.Mod(-1.0)

if System.ForceCheckEnabled
  System.DeterminePlayerForce()
endIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
