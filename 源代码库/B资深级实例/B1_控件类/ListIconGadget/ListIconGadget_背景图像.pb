;***********************************
;迷路仟整理 2019.01.18
;ListIconGadget_背景图像
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #imgScreen
EndEnumeration

#LVBKIF_SOURCE_NONE = 0 
#LVBKIF_SOURCE_HBITMAP = 1 
#LVBKIF_SOURCE_URL = 2 
#LVBKIF_SOURCE_MASK = 3 
#LVBKIF_STYLE_NORMAL = 0 
#LVBKIF_STYLE_TILE = $10 
#LVBKIF_STYLE_MASK = $10 
#LVM_SETBKIMAGEW = #LVM_FIRST + 138 
#LVM_GETBKIMAGEW = #LVM_FIRST + 139 

Structure LVBKIMAGE 
  ulFlags.l 
  hbm.l 
  pszImage.l 
  cchImageMax.l 
  xOffsetPercent.l 
  yOffsetPercent.l 
EndStructure 


WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_背景图像",WindowFlags) 
   hImage = LoadImage(#imgScreen, "PureBasic.ico")
   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_FullRowSelect) 
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)
   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i), hImage)
   Next

   ImageName$  = GetCurrentDirectory()+"Test.bmp" ;需要完整路径,支持PNG,JPG等,无须图像解码器
   Background.LVBKIMAGE 
   Background\ulFlags = #LVBKIF_STYLE_NORMAL|#LVBKIF_SOURCE_URL
   Background\pszImage = @ImageName$ 
   SendMessage_(hGadget, #LVM_SETBKIMAGE, 0, Background) 

Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 35
; FirstLine = 24
; Folding = -
; EnableXP
; Executable = 自修改程序.exe