;***********************************
;迷路仟整理 2019.01.24
;ColorRequester_颜色对话框
;***********************************


#winScreen = 0
#cvsScreen = 1

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "颜色对话框:点击控件可以修改颜色", WindowFlags)

CanvasGadget(#cvsScreen,150, 075, 100, 100) 
If StartDrawing(CanvasOutput(#cvsScreen))
   Box(000,000,100,100,$FFFFFF)
   StopDrawing()
EndIf 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #cvsScreen And EventType() = #PB_EventType_LeftClick
           Color = ColorRequester()
           If Color > -1
               If StartDrawing(CanvasOutput(#cvsScreen))
                  Box(000,000,100,100,Color)
                  StopDrawing()
               EndIf 
           EndIf
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 14
; FirstLine = 4
; EnableXP