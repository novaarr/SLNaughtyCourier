scriptname SLNC_ConfigPage_Settings extends SLNC_ConfigPageBase hidden

int oidRandomAppearanceChance
int oidRandomAppearanceCooldown

int oidHardcoreDialogue

int oidSexWithPlayer
int oidSexWithFollower

int oidSpeechcraftCheck

int oidSpeechcraftCheckMoneyFail
int oidSpeechcraftCheckMoneySuccess

int oidSpeechcraftCheckSexFail
int oidSpeechcraftCheckSexSuccess

int oidForceCheck
int oidPlayerForce
int oidCourierForce


function Display()
  Menu.SetCursorFillMode(Menu.TOP_TO_BOTTOM)
  Menu.SetCursorPosition(Menu.TOP_LEFT)

  Menu.AddHeaderOption("$SLNC_SETTINGS_SPEECHCRAFT")

  oidSpeechcraftCheck = Menu.AddToggleOption(                                 \
                            "$SLNC_SETTINGS_SPEECHCRAFT_ENABLED",             \
                            System.SpeechcraftCheckEnabled.GetValue() as bool )

  Menu.AddEmptyOption()

  oidSpeechcraftCheckSexSuccess = Menu.AddSliderOption(                       \
                            "$SLNC_SETTINGS_SPEECHCRAFT_CHECK_SEX_SUCCESS",   \
                            System.SpeechcraftCheckSexSuccess.GetValue(),     \
                            "$SLNC_SETTINGS_SPEECHCRAFT_CHECK_FORMAT"         )

  oidSpeechcraftCheckSexFail = Menu.AddSliderOption(                          \
                            "$SLNC_SETTINGS_SPEECHCRAFT_CHECK_SEX_FAIL",      \
                            System.SpeechcraftCheckSexFail.GetValue(),        \
                            "$SLNC_SETTINGS_SPEECHCRAFT_CHECK_FORMAT"         )

  Menu.AddEmptyOption()

  oidSpeechcraftCheckMoneySuccess = Menu.AddSliderOption(                     \
                            "$SLNC_SETTINGS_SPEECHCRAFT_CHECK_MONEY_SUCCESS", \
                            System.SpeechcraftCheckMoneySuccess.GetValue(),   \
                            "$SLNC_SETTINGS_SPEECHCRAFT_CHECK_FORMAT"         )

  oidSpeechcraftCheckMoneyFail = Menu.AddSliderOption(                        \
                            "$SLNC_SETTINGS_SPEECHCRAFT_CHECK_MONEY_FAIL",    \
                            System.SpeechcraftCheckMoneyFail.GetValue(),      \
                            "$SLNC_SETTINGS_SPEECHCRAFT_CHECK_FORMAT"         )

  Menu.AddEmptyOption()

  Menu.AddHeaderOption("$SLNC_SETTINGS_FORCE")

  Menu.AddEmptyOption()

  oidForceCheck = Menu.AddToggleOption(                                       \
                            "$SLNC_SETTINGS_FORCE_ENABLED",                   \
                            System.ForceCheckEnabled.GetValue() as bool       )

  Menu.AddEmptyOption()

  oidPlayerForce = Menu.AddSliderOption(                                      \
                            "$SLNC_SETTINGS_FORCE_PLAYER",                    \
                            System.PlayerForce.GetValue(),                    \
                            "$SLNC_SETTINGS_FORCE_CHECK_FORMAT",              \
                            Menu.OPTION_FLAG_DISABLED                         )

  Menu.AddEmptyOption()

  oidCourierForce = Menu.AddSliderOption(                                     \
                            "$SLNC_SETTINGS_FORCE_COURIER",                   \
                            System.CourierForce.GetValue(),                   \
                            "$SLNC_SETTINGS_FORCE_CHECK_FORMAT"               )


  Menu.SetCursorPosition(Menu.TOP_RIGHT)

  oidHardcoreDialogue = Menu.AddToggleOption(                                 \
                            "$SLNC_SETTINGS_HARDCORE_DIALOGUE",               \
                            System.HardcoreEnabled.GetValue() as bool         )


  Menu.AddEmptyOption()
  Menu.AddHeaderOption("$SLNC_SETTINGS_SEX_PARTNERS")

  oidSexWithPlayer = Menu.AddToggleOption(                                    \
                            "$SLNC_SETTINGS_SEX_PARTNER_PLAYER",              \
                            System.SexWithPlayer.GetValue() as bool           )

  oidSexWithFollower = Menu.AddToggleOption(                                  \
                            "$SLNC_SETTINGS_SEX_PARTNER_FOLLOWER",            \
                            System.SexWithFollower.GetValue() as bool         )

  Menu.AddEmptyOption()
  Menu.AddHeaderOption("$SLNC_SETTINGS_RANDAPP")

  oidRandomAppearanceChance = Menu.AddSliderOption(                           \
                            "$SLNC_SETTINGS_RANDAPP_CHANCE",                  \
                            System.RandomAppearanceChance,                    \
                            "$SLNC_SETTINGS_RANDAPP_CHANCE_FORMAT"            )

  oidRandomAppearanceCooldown = Menu.AddSliderOption(                         \
                            "$SLNC_SETTINGS_RANDAPP_COOLDOWN",                \
                            System.RandomAppearanceCooldown,                  \
                            "$SLNC_SETTINGS_RANDAPP_COOLDOWN_FORMAT"          )
endFunction

function OnHighlight(int option)
  if option == oidHardcoreDialogue
    Menu.SetInfoText("$SLNC_SETTINGS_HARDCORE_DIALOGUE_HINT")

  elseIf option == oidCourierForce
    Menu.SetInfoText("$SLNC_SETTINGS_FORCE_COURIER_HINT")

  elseIf  option == oidSpeechcraftCheckMoneySuccess                           \
  ||      option == oidSpeechcraftCheckSexSuccess
    Menu.SetInfoText("$SLNC_SETTINGS_SPEECHCRAFT_CHECK_SUCCESS_HINT")

  elseIf  option == oidSpeechcraftCheckMoneyFail                              \
  ||      option == oidSpeechcraftCheckSexFail
    Menu.SetInfoText("$SLNC_SETTINGS_SPEECHCRAFT_CHECK_FAIL_HINT")

  elseIf option == oidRandomAppearanceChance
    Menu.SetInfoText("$SLNC_SETTINGS_RANDAPP_CHANCE_HINT")

  elseIf option == oidForceCheck
    Menu.SetInfoText("$SLNC_SETTINGS_FORCE_HINT")

  endIf
endFunction

function OnSelect(int option)
  if option == oidSpeechcraftCheck
    bool tmp = System.SpeechcraftCheckEnabled.GetValue() as bool
    System.SpeechcraftCheckEnabled.SetValue((!tmp) as int)

  elseIf option == oidHardcoreDialogue
    bool tmp = System.HardcoreEnabled.GetValue() as bool
    System.HardcoreEnabled.SetValue((!tmp) as int)

  elseIf option == oidSexWithPlayer
    bool tmp = System.SexWithPlayer.GetValue() as bool
    System.SexWithPlayer.SetValue((!tmp) as int)

  elseIf option == oidSexWithFollower
    bool tmp = System.SexWithFollower.GetValue() as bool
    System.SexWithFollower.SetValue((!tmp) as int)

  elseIf option == oidForceCheck
    bool tmp = System.ForceCheckEnabled.GetValue() as bool
    System.ForceCheckEnabled.SetValue((!tmp) as int)

  endIf
endFunction

function OnSliderOpen(int option)
  if option == oidCourierForce
    float startValue = System.CourierForce.GetValue() as float

    Menu.SetSliderDialogStartValue(startValue)
    Menu.SetSliderDialogInterval(1.0)
    Menu.SetSliderDialogRange(0.0, 600.0)

  elseIf option == oidSpeechcraftCheckMoneyFail
    float startValue = System.SpeechcraftCheckMoneyFail.GetValue() as float
    float maxValue = System.SpeechcraftCheckMoneySuccess.GetValue() as float

    Menu.SetSliderDialogStartValue(startValue)
    Menu.SetSliderDialogInterval(1.0)
    Menu.SetSliderDialogRange(0.0, maxValue)

  elseIf option == oidSpeechcraftCheckMoneySuccess
    float startValue = System.SpeechcraftCheckMoneySuccess.GetValue() as float

    Menu.SetSliderDialogStartValue(startValue)
    Menu.SetSliderDialogInterval(1.0)
    Menu.SetSliderDialogRange(0.0, 100.0)

  elseIf option == oidSpeechcraftCheckSexFail
    float startValue = System.SpeechcraftCheckSexFail.GetValue() as float
    float maxValue = System.SpeechcraftCheckSexSuccess.GetValue() as float

    Menu.SetSliderDialogStartValue(startValue)
    Menu.SetSliderDialogInterval(1.0)
    Menu.SetSliderDialogRange(0.0, maxValue)

  elseIf option == oidSpeechcraftCheckSexSuccess
    float startValue = System.SpeechcraftCheckSexSuccess.GetValue() as float

    Menu.SetSliderDialogStartValue(startValue)
    Menu.SetSliderDialogInterval(1.0)
    Menu.SetSliderDialogRange(0.0, 100.0)

  elseIf option == oidRandomAppearanceChance
    Menu.SetSliderDialogStartValue(System.RandomAppearanceChance)
    Menu.SetSliderDialogInterval(0.001)
    Menu.SetSliderDialogRange(0.0, 1.0)

  elseIf option == oidRandomAppearanceCooldown
    Menu.SetSliderDialogStartValue(System.RandomAppearanceCooldown)
    Menu.SetSliderDialogInterval(1.0)
    Menu.SetSliderDialogRange(0.0, 240.0) ; 10 days

  endIf
endFunction

function OnSliderAccept(int option, float value)
  if option == oidCourierForce
    System.CourierForce.SetValue(value)

  elseIf option == oidSpeechcraftCheckMoneyFail
    System.SpeechcraftCheckMoneyFail.SetValue(value)

  elseIf option == oidSpeechcraftCheckMoneySuccess
    System.SpeechcraftCheckMoneySuccess.SetValue(value)

    if value < System.SpeechcraftCheckMoneyFail.GetValue()
      System.SpeechcraftCheckMoneyFail.SetValue(value)
    endIf

  elseIf option == oidSpeechcraftCheckSexFail
    System.SpeechcraftCheckSexFail.SetValue(value)

  elseIf option == oidSpeechcraftCheckSexSuccess
    System.SpeechcraftCheckSexSuccess.SetValue(value)

    if value < System.SpeechcraftCheckSexFail.GetValue()
      System.SpeechcraftCheckSexFail.SetValue(value)
    endIf

  elseIf option == oidRandomAppearanceChance
    System.RandomAppearanceChance = value

  elseIf option == oidRandomAppearanceCooldown
    System.RandomAppearanceCooldown = value

  endIf
endFunction
