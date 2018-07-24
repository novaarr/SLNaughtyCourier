scriptname SLNC_ConfigGroup_RapeAnimTagList extends SLNC_ConfigGroup_AnimTagList hidden

int oidSuppress

; SLNC_ConfigGroupBase
function DisplayExpanded()
  oidSuppress = Menu.AddToggleOption("$SLNC_ANIMATIONTAGS_RAPE_SUPPRESS",     \
                                      Menu.System.DeactivatedRapeSuppressCommon)

  Menu.AddEmptyOption()

  parent.DisplayExpanded()
endFunction

function OnSelect(int option)
  if oidSuppress == option
    Menu.System.DeactivatedRapeSuppressCommon =                               \
                                    !Menu.System.DeactivatedRapeSuppressCommon
  else
    parent.OnSelect(option)
  endIf
endFunction

function OnHighlight(int option)
  if oidSuppress == option
    Menu.SetInfoText("$SLNC_ANIMATIONTAGS_RAPE_SUPPRESS_HINT")
  else
    parent.OnHighlight(option)
  endIf
endFunction

; SLNC_ConfigGroup_AnimTagList
SLNC_AnimTagList function GetTagList()
  return Menu.System.RapeAnimationTagList
endFunction
