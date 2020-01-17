;***********************************
;迷路仟整理 2017.06.09
;ListIconGadget_单元格图标
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #imgScreen
EndEnumeration


WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_单元格图标",WindowFlags) 
   hImage = LoadImage(#imgScreen, "PureBasic.ico")
   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_FullRowSelect) 
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)
   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i), hImage)
   Next
   
   SendMessage_(hGadget, #LVM_SETEXTENDEDLISTVIEWSTYLE , #LVS_EX_SUBITEMIMAGES, #LVS_EX_SUBITEMIMAGES)  

   Target.lv_item  
   Target\mask     = #LVIF_IMAGE | #LVIF_TEXT  
   Target\iItem    = 5        ; 行
   Target\iSubItem = 2        ; 列 
   Target\pszText  = @"Try"   ; 文本
   Target\iImage   = 1        ; 图标索引
   SendMessage_(hGadget, #LVM_SETITEM, 0, Target) 
   
Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 25
; FirstLine = 10
; Folding = -
; EnableXP
; Executable = 自修改程序.exe