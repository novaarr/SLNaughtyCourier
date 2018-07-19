scriptname SLNC_ConfigMenu extends SKI_ConfigBase hidden

SLNC_ConfigPage_Settings property PageStatus auto
SLNC_System property System auto

int property TOP_LEFT = 0 autoReadOnly
int property TOP_RIGHT = 1 AutoReadOnly

int function GetVersion()
  return 1
endFunction

event OnVersionUpdate(int version)
endEvent

event OnPageReset(string page)
  PageStatus.DisplayIfRequested(page)
endEvent

event OnOptionHighlight(int option)
  PageStatus.OnOptionHighlight(option)
endEvent


event OnOptionSelect(int option)
  PageStatus.OnOptionSelect(option)

  ForcePageReset()
endEvent
