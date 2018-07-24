scriptname SLNC_ConfigGroup_AnimTagList extends SLNC_ConfigGroupBase hidden

int oidDisableAll
int oidEnableAll

int[] oidTag
int[] oidTagState

int oidNewTag

; SLNC_ConfigGroupBase
function DisplayExpanded()
  SLNC_AnimTagList TagList = GetTagList()

  if !TagList
    return
  endIf

  Menu.SetCursorFillMode(MENU.LEFT_TO_RIGHT)

  oidEnableAll = Menu.AddTextOption("", "$SLNC_ANIMATIONTAGS_ENABLEALL")
  oidDisableAll = Menu.AddTextOption("", "$SLNC_ANIMATIONTAGS_DISABLEALL")

  Menu.SetCursorFillMode(MENU.TOP_TO_BOTTOM)
  Menu.AddEmptyOption()

  Menu.SetCursorFillMode(MENU.LEFT_TO_RIGHT)

  int tagCount = TagList.GetTagCount()

  if !oidTag || tagCount != oidTag.Length
    oidTag = Utility.CreateIntArray(tagCount)
    oidTagState = Utility.CreateIntArray(tagCount)

    TagList.Sort()
  endIf

  int pos
  while pos < tagCount
    oidTag[pos] = Menu.AddInputOption("$SLNC_ANIMATIONTAGS_TAG",              \
                                      TagList.GetTag(pos)                     )

    oidTagState[pos] = Menu.AddToggleOption("$SLNC_ANIMATIONTAGS_STATE",      \
                                            TagList.GetTagState(pos)          )

    pos += 1
  endWhile

  oidNewTag = Menu.AddInputOption("$SLNC_ANIMATIONTAGS_ADDTAG", "")
endFunction

function OnSelect(int option)
  CheckCollapseOption(option)

  if !oidTagState
    return
  endIf

  if option == oidEnableAll || option == oidDisableAll
    int pos = oidTagState.Length
    bool stateRep = false

    if option == oidEnableAll
      stateRep = true
    endIf

    while pos
      pos -= 1

      GetTagList().SetTagState(stateRep, pos)
    endWhile

  else
    int pos = oidTagState.Find(option)

    if pos != -1
      GetTagList().ToggleTagState(pos)
    endIf
  endIf
endFunction

function OnInputOpen(int option)
  if !oidTag
    return
  endIf

  int pos = oidTag.Find(option)

  if pos != -1
    Menu.SetInputDialogStartText(GetTagList().GetTag(pos))
  endIf
endFunction

function OnInputAccept(int option, string value)
  if option == oidNewTag
    GetTagList().AddTag(value)
  endIf

  if !oidTag
    return
  endIf

  int pos = oidTag.Find(option)

  if pos != -1
    GetTagList().SetTag(value, pos)
  endIf
endFunction

; SLNC_ConfigGroup_AnimTagList
SLNC_AnimTagList function GetTagList()
  return None
endFunction
