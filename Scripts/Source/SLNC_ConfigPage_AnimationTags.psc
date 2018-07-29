scriptname SLNC_ConfigPage_AnimationTags extends SLNC_ConfigPageBase hidden

SLNC_ConfigGroup_CommonAnimTagList property CommonTagGroup auto
SLNC_ConfigGroup_OralAnimTagList property OralTagGroup auto
SLNC_ConfigGroup_AnalAnimTagList property AnalTagGroup auto
SLNC_ConfigGroup_VaginalAnimTagList property VaginalTagGroup auto

SLNC_ConfigGroup_PlayerRapeAnimTagList property PlayerRapeTagGroup auto
SLNC_ConfigGroup_CourrRapeAnimTagList property CourierRapeTagGroup auto

function Display()
  CommonTagGroup.Display()

  Menu.AddEmptyOption()
  Menu.AddEmptyOption()

  OralTagGroup.Display()

  Menu.AddEmptyOption()
  Menu.AddEmptyOption()

  AnalTagGroup.Display()

  Menu.AddEmptyOption()
  Menu.AddEmptyOption()

  VaginalTagGroup.Display()

  Menu.AddEmptyOption()
  Menu.AddEmptyOption()

  PlayerRapeTagGroup.Display()

  Menu.AddEmptyOption()
  Menu.AddEmptyOption()

  CourierRapeTagGroup.Display()
endFunction

function OnSelect(int option)
  CommonTagGroup.OnSelect(option)

  OralTagGroup.OnSelect(option)
  AnalTagGroup.OnSelect(option)
  VaginalTagGroup.OnSelect(option)

  PlayerRapeTagGroup.OnSelect(option)
  CourierRapeTagGroup.OnSelect(option)
endFunction

function OnHighlight(int option)
  PlayerRapeTagGroup.OnHighlight(option)
  CourierRapeTagGroup.OnHighlight(option)
endFunction

function OnInputOpen(int option)
  CommonTagGroup.OnInputOpen(option)

  OralTagGroup.OnInputOpen(option)
  AnalTagGroup.OnInputOpen(option)
  VaginalTagGroup.OnInputOpen(option)

  PlayerRapeTagGroup.OnInputOpen(option)
  CourierRapeTagGroup.OnInputOpen(option)
endFunction

function OnInputAccept(int option, string value)
  CommonTagGroup.OnInputAccept(option, value)

  OralTagGroup.OnInputAccept(option, value)
  AnalTagGroup.OnInputAccept(option, value)
  VaginalTagGroup.OnInputAccept(option, value)

  PlayerRapeTagGroup.OnInputAccept(option, value)
  CourierRapeTagGroup.OnInputAccept(option, value)
endFunction
