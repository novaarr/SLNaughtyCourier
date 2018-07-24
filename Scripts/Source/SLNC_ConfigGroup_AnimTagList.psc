scriptname SLNC_ConfigGroup_AnimTagList extends SLNC_ConfigGroupBase hidden

int[] oidTag
int[] oidTagState

int oidNewTag

; SLNC_ConfigGroupBase
function DisplayExpanded()
  SLNC_AnimTagList TagList = GetTagList()

  if !TagList
    return
  endIf

  int tagCount = TagList.GetTagCount()

  if !oidTag || tagCount != oidTag.Length
    oidTag = Utility.CreateIntArray(tagCount)
    oidTagState = Utility.CreateIntArray(tagCount)

    TagList.Sort()
  endIf

  Menu.SetCursorFillMode(MENU.LEFT_TO_RIGHT)

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

  int pos = oidTagState.Find(option)

  if pos != -1
    GetTagList().ToggleTagState(pos)
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
