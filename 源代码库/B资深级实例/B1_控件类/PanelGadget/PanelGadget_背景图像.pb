;***********************************
;迷路仟整理 2019.01.20
;分页控件页面尺寸
;***********************************


Enumeration
   #winScreen
   #pnlScreen
   #imgScreen
EndEnumeration



WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "分页控件页面尺寸", WindowFlags)
hGadget = PanelGadget(#pnlScreen, 10, 10, 380, 230)
   AddGadgetItem (#pnlScreen, -1, "分页项1")
   AddGadgetItem (#pnlScreen, -1, "分页项2")
CloseGadgetList()

hImage = LoadImage(#imgScreen, ".\Background.bmp")
hBrush = CreatePatternBrush_(hImage)
FreeImage(#imgScreen)

SetWindowTheme_(hGadget, @Null.w, @Null.w)
SetClassLongPtr_(hGadget, #GCL_HBRBACKGROUND, hBrush)
  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 25
; FirstLine = 1
; Folding = -
; EnableXP