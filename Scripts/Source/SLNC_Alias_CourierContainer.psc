scriptname SLNC_Alias_CourierContainer extends ReferenceAlias hidden

SLNC_System property System auto

event OnItemRemoved(Form item, int amount, ObjectReference itemRef, ObjectReference container)
  if GetReference().GetNumItems() == 0
    System.TemporaryCourierItemCount.SetValue(0)
    System.Reset()
    System.SetStage(System.StageInitial)
  endIf
endevent
