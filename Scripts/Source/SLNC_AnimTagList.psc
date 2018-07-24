scriptname SLNC_AnimTagList extends Quest hidden

string[] property TagList auto
bool[] property TagStateList auto

string function AssembleTags()
  if !TagList
    return ""
  endIf

  string tags = ""
  int pos = TagList.Length

  while pos
    pos -= 1

    if TagStateList[pos] && TagList[pos]
      tags += TagList[pos]

      if pos > 0
        tags += ","
      endIf
    endIf
  endWhile

  return tags
endFunction

function Set(string tags)
  TagList = Utility.ResizeStringArray(TagList, 0)
  TagStateList = Utility.ResizeBoolArray(TagStateList, 0)

  string[] tmp = StringUtil.Split(tags, ",")
  int pos = tmp.Length

  while pos
    pos -= 1

    string tagState = StringUtil.GetNthChar(tmp[pos], 0)
    string tag = StringUtil.Substring(tmp[pos], 1)

    if tagState == "+"
      AddTag(tag, true)

    elseIf tagState == "-"
      AddTag(tag)

    else
      Debug.Trace("[SLNC] Warning: Unable to determine tag state. Incorrect state: '" + tagState + "'")
    endIf
  endWhile
endFunction

string function Get()
  if !TagList
    return ""
  endIf

  string tags = ""
  int pos = TagList.Length

  while pos
    pos -= 1

    if TagList[pos]
      if TagStateList[pos]
        tags += "+"
      else
        tags += "-"
      endIf

      tags += TagList[pos]

      if pos > 0
        tags += ","
      endIf
    endIf
  endWhile

  return tags
endFunction

function AddTag(string tag, bool enabled = false)
  if !TagList
    TagList = new string[1]
    TagStateList = new bool[1]
  endIf

  if tag == "" || TagList.Find(tag) != -1
    return
  endIf

  int pos = TagList.Find("")

  if pos < 0
    pos = TagList.Length

    TagList = Utility.ResizeStringArray(TagList, pos + 1)

    bool[] TmpStateList = Utility.CreateBoolArray(pos + 1)
    int cpyPos = TagStateList.Length

    while cpyPos
      cpyPos -= 1

      TmpStateList[cpyPos] = TagStateList[cpyPos]
    endWhile

    TagStateList = TmpStateList
    ;TagStateList = Utility.ResizeBoolArray(TagStateList, pos + 1)
    ; - Doesn't seem to copy the old values
  endIf

  TagList[pos] = tag
  TagStateList[pos] = enabled

  Sort()
endFunction

string function GetTag(int pos)
  if TagList && TagList.Length > pos
    return TagList[pos]
  endIf

  return "<error: invalid index>"
endFunction

function SetTag(string rep, int pos)
  if TagList && TagList.Length > pos
    TagList[pos] = rep
  endIf

  Trim()
  Sort()
endFunction

bool function GetTagState(int pos)
  if TagStateList && TagStateList.Length > pos
    return TagStateList[pos]
  endIf

  return false
endFunction

function ToggleTagState(int pos)
  if TagStateList && TagStateList.Length > pos
    TagStateList[pos] = !TagStateList[pos]
  endIf
endFunction

function SetTagState(bool rep, int pos)
  if TagStateList && TagStateList.Length > pos
    TagStateList[pos] = rep
  endIf
endFunction

int function GetTagCount()
  if TagList
    return TagList.Length
  endIf

  return 0
endFunction

function Sort()
  if !TagList || TagList.Length <= 1
    return
  endIf

  int i = 0
  int j = 0

  while i < TagList.Length
    j = i

    while j < TagList.Length
      if TagList[j] < TagList[i]
        string tag = TagList[i]
        bool tagState = TagStateList[i]

        TagList[i] = TagList[j]
        TagStateList[i] = TagStateList[j]

        TagList[j] = tag
        TagStateList[j] = tagState
      endIf

      j += 1
    endWhile

    i += 1
  endWhile
endFunction

function Trim()
  if !TagList
    return
  endif

  if TagList.Find("") < 0
    return
  endIf

  int pos = 0

  while pos < TagList.Length ; TODO: optimize
    if TagList[pos] != "" && pos > 0
      int posEmpty = TagList.Find("")

      if posEmpty < 0
        pos = TagList.Length - 1

      elseif posEmpty >= 0 && pos > posEmpty
        TagList[posEmpty] = TagList[pos]
        TagStateList[posEmpty] = TagList[pos]

        TagList[pos] = ""
        tagStateList[pos] = false
      endIf
    endIf

    pos += 1
  endWhile

  pos = TagList.Find("")

  if pos > 0
    TagList = Utility.ResizeStringArray(TagList, pos)
    TagStateList = Utility.ResizeBoolArray(TagStateList, pos)
  endIf
endFunction
