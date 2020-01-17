;***********************************
;迷路仟整理 2019.03.15
;AboutRequester_关于我们
;***********************************

Enumeration
   #winScreen
   #btnScreen
EndEnumeration

Procedure AboutRequester(hWindow,Title$,Text1$,Text2$,Image$)
   ImageID = LoadImage(#PB_Any, Image$) 
   Image.l = ImageID(ImageID) 
   ShellAbout_(hWindow, Title$+" # "+Text1$, Text2$, ImageID(ImageID))
   FreeImage(ImageID)
EndProcedure

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "AboutRequester_关于我们", WindowFlags)

ButtonGadget(#btnScreen, 150, 100, 100, 030, "关于我们")


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen
            AboutRequester(hWindow, "关于我们","当前操作系统", "这里是你想啰嗦的地方...","..\PureBasic.ico")
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 16
; Folding = -
; EnableXP