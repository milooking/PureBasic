;***********************************
;迷路仟整理 2019.01.20
;画布控件1
;***********************************

Enumeration
   #winScreen
   #cvsScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "画布控件1", WindowFlags)

CanvasGadget(#cvsScreen, 10, 10, 380, 230)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #cvsScreen
            Bool = Bool(EventType() = #PB_EventType_MouseMove And GetGadgetAttribute(#cvsScreen, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
            If EventType() = #PB_EventType_LeftButtonDown Or Bool
               If StartDrawing(CanvasOutput(#cvsScreen))
                  x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
                  y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
                  Circle(x, y, 10, RGB(Random(255), Random(255), Random(255)))
                  StopDrawing()
               EndIf
            EndIf
        EndIf
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP