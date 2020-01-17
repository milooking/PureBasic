;***********************************
;迷路仟整理 2019.03.14
;ListIconGadget_标题栏字体样式
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #fntScreen
EndEnumeration

hFont = LoadFont(#fntScreen, "宋体", 16, #PB_Font_Bold)


WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_标题栏字体样式",WindowFlags) 

   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_FullRowSelect) 
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)
   
   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i))
   Next
   SetGadgetItemColor(#lstScreen, #PB_All, #PB_Gadget_FrontColor, $FF)
   
   hHeader =SendMessage_(hGadget, #LVM_GETHEADER, 0, 0)
   SendMessage_(hHeader, #WM_SETFONT, hFont, #True)

   
Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; Folding = -
; EnableXP
; EnableUnicode