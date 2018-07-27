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

int oidArousalInfluence
int oidCoolThreshold
int oidCoolMult
int oidNeedyThreshold
int oidNeedyMult


function Display()
  System.DeterminePlayerForce()

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

  oidForceCheck = Menu.AddToggleOption(                                       \
                            "$SLNC_SETTINGS_FORCE_ENABLED",                   \
                            System.ForceCheckEnabled.GetValue() as bool       )

  Menu.AddEmptyOption()

  oidPlayerForce = Menu.AddSliderOption(                                      \
                            "$SLNC_SETTINGS_FORCE_PLAYER",                    \
                            System.PlayerForce.GetValue(),                    \
                            "$SLNC_SETTINGS_FORCE_CHECK_FORMAT",              \
                            Menu.OPTION_FLAG_DISABLED                         )

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

  Menu.AddEmptyOption()
  Menu.AddHeaderOption("$SLNC_SETTINGS_AROUSAL")

  oidArousalInfluence = Menu.AddToggleOption(                                 \
                            "$SLNC_SETTINGS_AROUSAL_ENABLED",                 \
                            System.ArousalInfluenceEnabled                    )

  Menu.AddEmptyOption()

  oidCoolThreshold = Menu.AddSliderOption(                                    \
                            "$SLNC_SETTINGS_COOL_AROUSAL_THRESHOLD",          \
                            System.CoolArousalThreshold,                      \
                            "$SLNC_SETTINGS_AROUSAL_THRESHOLD_FORMAT"         )

  oidCoolMult = Menu.AddSliderOption(                                         \
                            "$SLNC_SETTINGS_COOL_FORCE_MULTIPLIER",           \
                            System.CoolForceMultiplier,                       \
                            "$SLNC_SETTINGS_FORCE_MULTIPLIER_FORMAT"          )

  Menu.AddEmptyOption()

  oidNeedyThreshold = Menu.AddSliderOption(                                   \
                            "$SLNC_SETTINGS_NEEDY_AROUSAL_THRESHOLD",         \
                            System.NeedyArousalThreshold,                     \
                            "$SLNC_SETTINGS_AROUSAL_THRESHOLD_FORMAT"         )

  oidNeedyMult = Menu.AddSliderOption(                                        \
                            "$SLNC_SETTINGS_NEEDY_FORCE_MULTIPLIER",          \
                            System.NeedyForceMultiplier,                      \
                            "$SLNC_SETTINGS_FORCE_MULTIPLIER_FORMAT"          )
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

  elseIf option == oidArousalInfluence
    Menu.SetInfoText("$SLNC_SETTINGS_AROUSAL_HINT")

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

  elseIf option == oidArousalInfluence
    System.ArousalInfluenceEnabled = !System.ArousalInfluenceEnabled

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

  elseIf option == oidCoolThreshold
    Menu.SetSliderDialogStartValue(System.CoolArousalThreshold)
    Menu.SetSliderDialogInterval(1.0)
    Menu.SetSliderDialogRange(0.0, 100.0)

  elseIf option == oidCoolMult
    Menu.SetSliderDialogStartValue(System.CoolForceMultiplier)
    Menu.SetSliderDialogInterval(0.01)
    Menu.SetSliderDialogRange(1.0, 3.0)

  elseIf option == oidNeedyThreshold
    Menu.SetSliderDialogStartValue(System.NeedyArousalThreshold)
    Menu.SetSliderDialogInterval(1.0)
    Menu.SetSliderDialogRange(0.0, 100.0)

  elseIf option == oidNeedyMult
    Menu.SetSliderDialogStartValue(System.NeedyForceMultiplier)
    Menu.SetSliderDialogInterval(0.01)
    Menu.SetSliderDialogRange(0.3, 1.0)

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

  elseIf option == oidCoolThreshold
    if value > System.NeedyArousalThreshold as float
      value = System.NeedyArousalThreshold as float
    endIf

    System.CoolArousalThreshold = value as int

  elseIf option == oidCoolMult
    System.CoolForceMultiplier = value

  elseIf option == oidNeedyThreshold
    if value < System.CoolArousalThreshold as float
      value = System.CoolArousalThreshold as float
    endIf

    System.NeedyArousalThreshold = value as int

  elseIf option == oidNeedyMult
    System.NeedyForceMultiplier = value

  endIf
endFunction
