;***********************************
;迷路仟整理 2019.01.20
;分页控件
;***********************************

Enumeration
   #winScreen
   #pnlScreen1
   #ptnScreen2
   #btnScreen1
   #btnScreen2
   
   #imgScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "分页控件", WindowFlags)

hImage = LoadImage(#imgScreen, "PureBasic.ico")
PanelGadget(#pnlScreen1, 10, 10, 380, 230)
   AddGadgetItem (#pnlScreen1, -1, "分页项1")
  PanelGadget (#ptnScreen2, 10, 10, 300, 150)
    AddGadgetItem(#ptnScreen2, -1, "子页项-1", hImage)
    AddGadgetItem(#ptnScreen2, -1, "子页项-2", hImage)
    AddGadgetItem(#ptnScreen2, -1, "子页项-3", hImage)
  CloseGadgetList()
AddGadgetItem (#pnlScreen1, -1,"分页项2")
  ButtonGadget(#btnScreen1, 10, 15, 80, 24,"按键1")
  ButtonGadget(#btnScreen2, 95, 15, 80, 24,"按键2")
CloseGadgetList()


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
; CursorPosition = 24
; FirstLine = 3
; Folding = -
; EnableXP