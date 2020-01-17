;***********************************
;迷路仟整理 2019.01.18
;ListIconGadget_大尺寸图标
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #imgScreen
EndEnumeration


WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_大尺寸图标",WindowFlags) 
   hImage = LoadImage(#imgScreen, "PureBasic.ico")
   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_FullRowSelect) 
   
   hBigIcon = ImageList_Create_(64, 64, #ILC_MASK|#ILC_COLOR32, 0, 30) 
   SendMessage_(hGadget, #LVM_SETIMAGELIST, #LVSIL_SMALL, hBigIcon) 
   hListIcon = ImageList_AddIcon_(hBigIcon, hImage) 
   
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)
   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i))
   Next
   

   
Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True
ImageList_Destroy_(hBigIcon)  



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 33
; FirstLine = 11
; Folding = -
; EnableXP
; Executable = 自修改程序.exe