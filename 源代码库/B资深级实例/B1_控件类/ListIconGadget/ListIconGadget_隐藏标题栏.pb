;***********************************
;迷路仟整理 2017.06.09
;ListIconGadget_隐藏标题栏.
;***********************************

#winScreen = 0 
#lstScreen = 0 

WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_隐藏标题栏.",WindowFlags) 

   GadgetFlags = #LVS_NOCOLUMNHEADER|#PB_ListIcon_FullRowSelect|#PB_ListIcon_CheckBoxes
   ListIconGadget(#lstScreen,010,010,480,230,"",300,GadgetFlags) 
   For i = 1 To 32
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i) )
   Next
   
Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 16
; EnableXP
; Executable = 自修改程序.exe