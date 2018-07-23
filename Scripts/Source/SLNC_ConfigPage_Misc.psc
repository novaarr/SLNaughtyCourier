scriptname SLNC_ConfigPage_Misc extends SLNC_ConfigPageBase hidden

int oidSettingsImport
int oidSettingsExport

function Display()
  oidSettingsImport = Menu.AddTextOption("$SLNC_MISC_IMPORT", "")
  oidSettingsExport = Menu.AddTextOption("$SLNC_MISC_EXPORT", "")
endFunction

function OnSelect(int option)
  if oidSettingsExport == option
    System.SettingsExport()

  elseIf oidSettingsImport == option
    System.SettingsImport()

  endIf
endFunction
