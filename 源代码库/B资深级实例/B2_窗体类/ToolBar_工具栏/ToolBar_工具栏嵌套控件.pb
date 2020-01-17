;***********************************
;迷路仟整理 2019.01.16
;工具栏嵌套控件
;***********************************


Enumeration
   #winScreen
   #wtbScreen 
    
   #cmbScreen 
   #pgrScreen
   #chkScreen
EndEnumeration


Procedure InsertGadget(hToolBar, Width, *pRect.RECT)
   Separator.TBBUTTON
   Pos =  SendMessage_(hToolBar, #TB_BUTTONCOUNT, 0, 0)-1
   SendMessage_(hToolBar, #TB_GETBUTTON,  Pos, @Separator)
   Separator\iBitmap = Width
   SendMessage_(hToolBar, #TB_DELETEBUTTON, Pos, 0)
   SendMessage_(hToolBar, #TB_INSERTBUTTON, Pos, @Separator)
   SendMessage_(hToolBar, #TB_GETITEMRECT,  Pos, *pRect)
   UseGadgetList(hToolBar)
EndProcedure


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "工具栏嵌套控件", WindowFlags)

hToolBar = CreateToolBar(#wtbScreen, hWindow)
If hToolBar
   ToolBarStandardButton(0, #PB_ToolBarIcon_New)
   ToolBarStandardButton(1, #PB_ToolBarIcon_Open)
   ToolBarStandardButton(2, #PB_ToolBarIcon_Save)
   ToolBarSeparator()
   Rect.RECT
   ToolBarSeparator()
   
   InsertGadget(hToolBar, 65, Rect)
   ComboBoxGadget(#cmbScreen, Rect\left, Rect\top+1, 60, 20)
   AddGadgetItem(#cmbScreen, -1, "内容1")
   AddGadgetItem(#cmbScreen, -1, "内容2")
   ToolBarSeparator()
   
   InsertGadget(hToolBar, 105, Rect)
   ProgressBarGadget(#pgrScreen, Rect\left, Rect\top+1, 100, 20, 0, 100)
   SetGadgetState(#pgrScreen, 50)
   ToolBarSeparator()

   InsertGadget(hToolBar, 60, Rect)
   CheckBoxGadget(#chkScreen, Rect\left+10, Rect\top+1, 55, 20, "选项")
   SetGadgetState(#chkScreen, 1) 

   ToolBarSeparator()
   ToolBarStandardButton(3, #PB_ToolBarIcon_Open)
   ToolBarStandardButton(4, #PB_ToolBarIcon_Save)
EndIf 
  
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget  
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 60
; FirstLine = 28
; Folding = 9
; EnableXP