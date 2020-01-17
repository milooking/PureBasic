;***********************************
;迷路仟整理 2019.03.28
;List_链表位置移动
;***********************************

Enumeration
   #winScreen
   #lvwScreen
   #btnMoveUpon
   #btnMoveDown
EndEnumeration


Global NewList _ListValue$()
For k = 1 To 30
   AddElement(_ListValue$()) : _ListValue$() = "链表元素 - " + Str(k)
Next 

Procedure EventGadget_lvwScreen()
   Count = CountGadgetItems(#lvwScreen)
   State = GetGadgetState(#lvwScreen)
   IsMoveUpon = Bool(State < 1)
   IsMoveDown = Bool(State < 0 Or State >= Count-1)
   DisableGadget(#btnMoveUpon, IsMoveUpon)
   DisableGadget(#btnMoveDown, IsMoveDown) 
EndProcedure

Procedure EventGadget_btnMoveUpon()
   State = GetGadgetState(#lvwScreen)
   If State > 0 
      *pCurrElement = GetGadgetItemData(#lvwScreen, State)
      ChangeCurrentElement(_ListValue$(), *pCurrElement)
      *pPrevElement = PreviousElement(_ListValue$())
      SwapElements(_ListValue$(), *pCurrElement, *pPrevElement)
      
      ClearGadgetItems(#lvwScreen)
      ForEach _ListValue$()
         AddGadgetItem(#lvwScreen, -1, _ListValue$())
         SetGadgetItemData(#lvwScreen, Index, @_ListValue$())
         Index+1
      Next 
      
      SetGadgetState(#lvwScreen, State-1)
      EventGadget_lvwScreen()
   EndIf 
EndProcedure

Procedure EventGadget_btnMoveDown()
   Count = CountGadgetItems(#lvwScreen)
   State = GetGadgetState(#lvwScreen)
   If State < Count-1
      *pCurrElement = GetGadgetItemData(#lvwScreen, State)
      ChangeCurrentElement(_ListValue$(), *pCurrElement)
      *pNextElement = NextElement(_ListValue$())
      SwapElements(_ListValue$(), *pCurrElement, *pNextElement)
      
      ClearGadgetItems(#lvwScreen)
      ForEach _ListValue$()
         AddGadgetItem(#lvwScreen, -1, _ListValue$())
         SetGadgetItemData(#lvwScreen, Index, @_ListValue$())
         Index+1
      Next 
      
      SetGadgetState(#lvwScreen, State+1)
      EventGadget_lvwScreen()
   EndIf 
EndProcedure


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "List_链表位置移动", WindowFlags)

ListViewGadget(#lvwScreen,   010, 010, 300, 230)
ButtonGadget  (#btnMoveUpon, 320, 050, 070, 030, "上移")
ButtonGadget  (#btnMoveDown, 320, 100, 070, 030, "下移")

ForEach _ListValue$()
   AddGadgetItem(#lvwScreen, -1, _ListValue$())
   SetGadgetItemData(#lvwScreen, Index, @_ListValue$())
   Index+1
Next 

BindGadgetEvent(#lvwScreen,   @EventGadget_lvwScreen())
BindGadgetEvent(#btnMoveUpon, @EventGadget_btnMoveUpon())
BindGadgetEvent(#btnMoveDown, @EventGadget_btnMoveDown())
EventGadget_lvwScreen()
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 75
; FirstLine = 54
; Folding = -
; EnableXP