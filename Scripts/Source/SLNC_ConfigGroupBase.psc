scriptname SLNC_ConfigGroupBase extends Quest hidden

SLNC_ConfigMenu property Menu auto

string property Name auto
bool property ExpandOnBothPages auto

bool property Collapsed auto

int oidCollapsibleToggle

function Display()
  if !ExpandOnBothPages
    Menu.SetCursorFillMode(Menu.TOP_TO_BOTTOM)
  else
    Menu.SetCursorFillMode(Menu.LEFT_TO_RIGHT)
  endif

  Menu.AddHeaderOption(Name)
  Menu.AddHeaderOption("")

  Menu.SetCursorFillMode(Menu.TOP_TO_BOTTOM)

  if !Collapsed
    oidCollapsibleToggle = Menu.AddTextOption("", "$SLNC_CONFIGGROUP_COLLAPSE")
    Menu.AddEmptyOption()

    DisplayExpanded()
  else
    oidCollapsibleToggle = Menu.AddTextOption("", "$SLNC_CONFIGGROUP_EXPAND")
  endIf

  Menu.AddEmptyOption()
endFunction

function DisplayExpanded()
endFunction

function CheckCollapseOption(int option)
  if option == oidCollapsibleToggle
    Collapsed = !Collapsed
  endIf
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
