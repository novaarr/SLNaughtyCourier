;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLNC_TIF_RewardSexNoSpeechcraft Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Quest SLNCQ = GetOwningQuest()
SLNC_System System = SLNCQ as SLNC_System

SLNCQ.SetStage(System.StageInitiateSex)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
int property StateInitiateSex = 5 autoReadOnly
