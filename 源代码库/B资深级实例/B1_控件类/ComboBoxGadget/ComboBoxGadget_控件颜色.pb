;***********************************
;迷路仟整理 2019.01.17
;控件颜色
;***********************************

Enumeration
   #WinScreen
   #cmbScreen
EndEnumeration

Procedure Window_CallBack(hWindow, uMsg, wParam, lParam) 
   *pMemSkin = GetWindowLong_(hWindow, #GWL_USERDATA) 
   Result  = CallWindowProc_(PeekL(*pMemSkin+16), hWindow, uMsg, wParam, lParam) 
   Select uMsg
      Case #WM_DESTROY
         DeleteObject_( PeekL(*pMemSkin+12) ) 
         GlobalFree_(*pMemSkin) 
         PostQuitMessage_(0) 
      Case #WM_CTLCOLOREDIT,#WM_CTLCOLORLISTBOX
         SetTextColor_(wParam, PeekL(*pMemSkin+0) ) 
         SetBkColor_  (wParam, PeekL(*pMemSkin+4))
         Result = PeekL(*pMemSkin+12)
   EndSelect
   ProcedureReturn Result 
EndProcedure

Procedure ComboBox_Custom(GadgetID, FrontColor, BackColor) 
   *pMemSkin = GlobalAlloc_(#Null,5*4) 
   SetWindowLong_(GadgetID(GadgetID), #GWL_USERDATA, *pMemSkin)
   PokeL(*pMemSkin+ 0, FrontColor ) 
   PokeL(*pMemSkin+ 4, BackColor )
   PokeL(*pMemSkin+12, CreateSolidBrush_(BackColor))
   PokeL(*pMemSkin+16, SetWindowLong_(GadgetID(GadgetID), #GWL_WNDPROC, @Window_CallBack())) 
EndProcedure

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "控件颜色", WindowFlags)

hGadget = ComboBoxGadget(#cmbScreen, 150, 050, 100, 22, #PB_ComboBox_Editable) 
For k = 1 To 10 
   AddGadgetItem(#cmbScreen, -1, "子项-"+Str(Random(100))) 
Next 
SetGadgetState(#cmbScreen, 0)
ComboBox_Custom(#cmbScreen, $0000FF, $CFFFFF)
  
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         Debug EventGadget()
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = 6
; EnableXP