scriptname SLNC_ConfigPage_Settings extends SLNC_ConfigPageBase hidden

int oidSpeechcraftCheck
int oidHardcoreDialogue

int oidSexWithPlayer
int oidSexWithFollower

bool function IsRequested(string page)
  if page == "$SLNC_PAGE_SETTINGS" || page == ""
    return true
  endIf

  return false
endFunction

function Display()
  Menu.SetCursorFillMode(Menu.TOP_TO_BOTTOM)
  Menu.SetCursorPosition(Menu.TOP_LEFT)

  oidSpeechcraftCheck = Menu.AddToggleOption(                                 \
                            "$SLNC_SETTINGS_SPEECHCRAFT_CHECK",               \
                            System.SpeechcraftCheck.GetValue() as bool        )

  oidHardcoreDialogue = Menu.AddToggleOption(                                 \
                            "$SLNC_SETTINGS_HARDCORE_DIALOGUE",               \
                            System.Hardcore.GetValue() as bool                )


  Menu.SetCursorPosition(Menu.TOP_RIGHT)

  Menu.AddHeaderOption("$SLNC_SETTINGS_SEX_PARTNERS")

  oidSexWithPlayer = Menu.AddToggleOption(                                    \
                            "$SLNC_SETTINGS_SEX_PARTNER_PLAYER",              \
                            System.SexWithPlayer.GetValue() as bool           )

  oidSexWithFollower = Menu.AddToggleOption(                                  \
                            "$SLNC_SETTINGS_SEX_PARTNER_FOLLOWER",            \
                            System.SexWithFollower.GetValue() as bool         )
endFunction

function OnOptionHighlight(int option)

endFunction

function OnOptionSelect(int option)
  if option == oidSpeechcraftCheck
    bool tmp = System.SpeechcraftCheck.GetValue() as bool
    System.SpeechcraftCheck.SetValue((!tmp) as int)

  elseIf option == oidHardcoreDialogue
    bool tmp = System.Hardcore.GetValue() as bool
    System.Hardcore.SetValue((!tmp) as int)

  elseIf option == oidSexWithPlayer
    bool tmp = System.SexWithPlayer.GetValue() as bool
    System.SexWithPlayer.SetValue((!tmp) as int)

  elseIf option == oidSexWithFollower
    bool tmp = System.SexWithFollower.GetValue() as bool
    System.SexWithFollower.SetValue((!tmp) as int)

  endIf
endFunction
