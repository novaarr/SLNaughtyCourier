scriptname SLNC_ConfigMenu extends SKI_ConfigBase hidden

SLNC_ConfigPage_Settings property PageStatus auto
SLNC_System property System auto

int function GetVersion()
  return 1
endFunction

event OnVersionUpdate(int version)
endEvent

event OnPageReset(string page)
  if PageStatus.IsRequested(page)
    PageStatus.Display()
  endIf
endEvent

event OnOptionHighlight(int option)
  PageStatus.OnOptionHighlight(option)
endEvent


event OnOptionSelect(int option)
  PageStatus.OnOptionSelect(option)
endEvent
