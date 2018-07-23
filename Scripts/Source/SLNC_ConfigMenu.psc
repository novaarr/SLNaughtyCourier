scriptname SLNC_ConfigMenu extends SKI_ConfigBase hidden

SLNC_System property System auto

SLNC_ConfigPage_Settings property PageStatus auto
SLNC_ConfigPage_AnimationTags property PageAnimationTags auto

int property TOP_LEFT = 0 autoReadOnly
int property TOP_RIGHT = 1 autoReadOnly

int function GetVersion()
  return 2
endFunction

event OnVersionUpdate(int version)
endEvent

event OnPageReset(string page)
  PageStatus.DisplayIfRequested(page)
  PageAnimationTags.DisplayIfRequested(page)
endEvent

event OnOptionHighlight(int option)
  PageStatus.OnHighlight(option)
  PageAnimationTags.OnHighlight(option)
endEvent

event OnOptionSelect(int option)
  PageStatus.OnSelect(option)
  PageAnimationTags.OnSelect(option)

  ForcePageReset()
endEvent

event OnOptionSliderOpen(int option)
  PageStatus.OnSliderOpen(option)
  PageAnimationTags.OnSliderOpen(option)
endEvent

event OnOptionSliderAccept(int option, float value)
  PageStatus.OnSliderAccept(option, value)
  PageAnimationTags.OnSliderAccept(option, value)

  ForcePageReset()
endEvent

event OnOptionInputOpen(int option)
  PageStatus.OnInputOpen(option)
  PageAnimationTags.OnInputOpen(option)
endEvent

event OnOptionInputAccept(int option, string value)
  PageStatus.OnInputAccept(option, value)
  PageAnimationTags.OnInputAccept(option, value)

  ForcePageReset()
endEvent
