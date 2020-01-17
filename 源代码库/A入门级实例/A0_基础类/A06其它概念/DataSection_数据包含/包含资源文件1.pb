;***********************************
;迷路仟整理 2019.01.16
;包含资源文件1
;***********************************




#winScreen = 0
#wmbScreen = 1
#btnScreen = 2
#imgScreen = 3

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "包含资源文件1", WindowFlags)

CatchImage(#imgScreen, ?_ICON_PureBasic)
ImageGadget(#imgScreen, 180, 100, 0, 0, ImageID(#imgScreen))

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Menu 
         Debug EventMenu() 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End

;- ##########################
;- [Data]
DataSection
_ICON_PureBasic:
   IncludeBinary ".\PureBasic.ico" 
EndDataSection












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; Folding = -
; EnableXP