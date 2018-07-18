scriptname SLNC_ConfigPage_Settings extends SLNC_ConfigPageBase hidden

int oidSpeechcraftCheck
int oidHardcoreDialogue

bool function IsRequested(string page)
  if page == "$SLNC_PAGE_SETTINGS" || page == ""
    return true
  endIf

  return false
endFunction

function Display()
  oidSpeechcraftCheck = Menu.AddToggleOption(                                 \
                                        "$SLNC_SETTINGS_SPEECHCRAFT_CHECK",   \
                                        System.SpeechcraftCheck               )

  oidHardcoreDialogue = Menu.AddToggleOption(                                 \
                                        "$SLNC_SETTINGS_HARDCORE_DIALOGUE",   \
                                        System.Hardcore.GetValue() as bool    )
endFunction

function OnOptionHighlight(int option)

endFunction

function OnOptionSelect(int option)
  if option == oidSpeechcraftCheck
    System.SpeechcraftCheck != System.SpeechcraftCheck

  elseIf option == oidHardcoreDialogue
    bool hardcore = System.Hardcore.GetValue() as bool
    System.Hardcore.SetValue((!hardcore) as int)

  endIf
endFunction
