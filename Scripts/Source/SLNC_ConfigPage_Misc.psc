scriptname SLNC_ConfigPage_Misc extends SLNC_ConfigPageBase hidden

int oidSettingsImport
int oidSettingsExport

function Display()
  Menu.SetCursorFillMode(Menu.TOP_TO_BOTTOM)

  int expimp_flag = Menu.OPTION_FLAG_DISABLED

  if SKSE.GetPluginVersion("papyrusutil plugin") != -1
    expimp_flag = Menu.OPTION_FLAG_NONE
  endIf

  oidSettingsImport = Menu.AddTextOption("$SLNC_MISC_IMPORT", "", expimp_flag)
  oidSettingsExport = Menu.AddTextOption("$SLNC_MISC_EXPORT", "", expimp_flag)
endFunction

function OnSelect(int option)
  if oidSettingsExport == option
    System.SettingsExport()

  elseIf oidSettingsImport == option
    System.SettingsImport()

  endIf
endFunction
