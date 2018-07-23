scriptname SLNC_ConfigPageBase extends Quest hidden

SLNC_System property System auto
SLNC_ConfigMenu property Menu auto

string property Name auto
bool property Default auto

bool function IsRequested(string page)
  if Default && page == ""
    return true
  endIf

  if page == Name
    return true
  endIf

  return false
endFunction

function DisplayIfRequested(string page)
  if IsRequested(page)
    Display()
  endIf
endFunction

function Display()
endFunction

function OnHighlight(int option)
endFunction

function OnSelect(int option)
endFunction

function OnSliderOpen(int option)
endFunction

function OnSliderAccept(int option, float value)
endFunction

function OnInputOpen(int option)
endFunction

function OnInputAccept(int option, string value)
endFunction
