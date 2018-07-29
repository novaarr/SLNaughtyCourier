scriptname SLNC_Alias_CourierContainer extends ReferenceAlias hidden

SLNC_System property System auto

event OnInit()
  RemoveAllInventoryEventFilters()
endEvent

event OnUpdate()
  while UI.IsMenuOpen("Dialogue Menu")                                        \
  ||    System.SexLab.IsActorActive(System.CourierAlias.GetActorReference())
    RegisterForSingleUpdate(5)
    return
  endWhile

  System.Reset()
  System.SetStage(System.StageInitial)
endEvent

event OnItemRemoved(Form item, int amount, ObjectReference itemRef, ObjectReference container)
  if GetReference().GetNumItems() == 0
    System.TemporaryCourierItemCount.SetValue(0)

    if item == System.DummyItem
      RegisterForSingleUpdate(10)
    else
      RegisterForSingleUpdate(0.1)
    endIf
  endIf
endevent
