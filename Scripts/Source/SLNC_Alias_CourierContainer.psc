scriptname SLNC_Alias_CourierContainer extends ReferenceAlias hidden

SLNC_System property System auto

event OnInit()
  RemoveAllInventoryEventFilters()
endEvent

event OnItemRemoved(Form item, int amount, ObjectReference itemRef, ObjectReference container)
  if GetReference().GetNumItems() == 0
    System.TemporaryCourierItemCount.SetValue(0)

    while UI.IsMenuOpen("Dialogue Menu")
      Utility.Wait(5)
    endWhile

    System.Reset()
    System.SetStage(System.StageInitial)
  endIf
endevent
