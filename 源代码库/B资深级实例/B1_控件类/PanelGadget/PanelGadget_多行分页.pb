;***********************************
;迷路仟整理 2019.01.20
;分页控件-多行分页
;***********************************


Enumeration
   #winScreen
   #pnlScreen
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "多行分页", WindowFlags)
hGadget = PanelGadget(#pnlScreen, 10, 10, 380, 230)
   For k = 1 To 20
      AddGadgetItem (#pnlScreen, -1, "分页项-"+Str(k))
   Next 
CloseGadgetList()

NewStyle.l = GetWindowLong_(hGadget, #GWL_STYLE) 
NewStyle = NewStyle | #TCS_MULTILINE  
SetWindowLong_(hGadget, #GWL_STYLE, NewStyle) 
SetGadgetState(#pnlScreen, 0) ;起刷新控件作用
   
Rows = SendMessage_(hGadget,#TCM_GETROWCOUNT,0,0)  

Debug "总行数: " + Str(Rows)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 28
; Folding = -
; EnableXP