scriptname SLNC_ConfigPageBase extends Quest hidden

SLNC_System property System auto
SLNC_ConfigMenu property Menu auto

bool function IsRequested(string page)
  return false
endFunction

function DisplayIfRequested(string page)
  if IsRequested(page)
    Display()
  endIf
endFunction

function Display()
endFunction

function OnOptionHighlight(int option)
endFunction

function OnOptionSelect(int option)
endFunction

function OnOptionSliderOpen(int option)
endFunction

function OnOptionSliderAccept(int option, float value)
endFunction
