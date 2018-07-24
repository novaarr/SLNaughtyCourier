scriptname SLNC_ConfigMenu extends SKI_ConfigBase hidden

SLNC_System property System auto

SLNC_ConfigPage_Settings property PageStatus auto
SLNC_ConfigPage_AnimationTags property PageAnimationTags auto
SLNC_ConfigPage_Misc property PageMisc auto

int property TOP_LEFT = 0 autoReadOnly
int property TOP_RIGHT = 1 autoReadOnly

int function GetVersion()
  return 3
endFunction

event OnVersionUpdate(int version)
  Debug.Notification("OnVersionUpdate("+version+"). Current: " + CurrentVersion)
endEvent

event OnPageReset(string page)
  PageStatus.DisplayIfRequested(page)
  PageAnimationTags.DisplayIfRequested(page)
  PageMisc.DisplayIfRequested(page)
endEvent

event OnOptionHighlight(int option)
  PageStatus.OnHighlight(option)
  PageAnimationTags.OnHighlight(option)
  PageMisc.OnHighlight(option)
endEvent

event OnOptionSelect(int option)
  PageStatus.OnSelect(option)
  PageAnimationTags.OnSelect(option)
  PageMisc.OnSelect(option)

  ForcePageReset()
endEvent

event OnOptionSliderOpen(int option)
  PageStatus.OnSliderOpen(option)
  PageAnimationTags.OnSliderOpen(option)
  PageMisc.OnSliderOpen(option)
endEvent

event OnOptionSliderAccept(int option, float value)
  PageStatus.OnSliderAccept(option, value)
  PageAnimationTags.OnSliderAccept(option, value)
  PageMisc.OnSliderAccept(option, value)

  ForcePageReset()
endEvent

event OnOptionInputOpen(int option)
  PageStatus.OnInputOpen(option)
  PageAnimationTags.OnInputOpen(option)
  PageMisc.OnInputOpen(option)
endEvent

event OnOptionInputAccept(int option, string value)
  PageStatus.OnInputAccept(option, value)
  PageAnimationTags.OnInputAccept(option, value)
  PageMisc.OnInputAccept(option, value)

  ForcePageReset()
endEvent
