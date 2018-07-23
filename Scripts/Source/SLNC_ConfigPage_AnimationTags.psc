scriptname SLNC_ConfigPage_AnimationTags extends SLNC_ConfigPageBase hidden

SLNC_ConfigGroup_CommonAnimTagList property CommonTagGroup auto
SLNC_ConfigGroup_RapeAnimTagList property RapeTagGroup auto

function Display()
  CommonTagGroup.Display()

  Menu.AddEmptyOption()
  Menu.AddEmptyOption()

  RapeTagGroup.Display()
endFunction

function OnSelect(int option)
  CommonTagGroup.OnSelect(option)
  RapeTagGroup.OnSelect(option)
endFunction

function OnInputOpen(int option)
  CommonTagGroup.OnInputOpen(option)
  RapeTagGroup.OnInputOpen(option)
endFunction

function OnInputAccept(int option, string value)
  CommonTagGroup.OnInputAccept(option, value)
  RapeTagGroup.OnInputAccept(option, value)
endFunction
