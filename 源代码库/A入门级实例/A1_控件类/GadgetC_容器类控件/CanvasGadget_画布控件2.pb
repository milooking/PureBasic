;***********************************
;迷路仟整理 2019.01.20
;画布控件2
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #btnScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "画布控件2", WindowFlags)

;注意: ImageGadget()在CanvasGadget()中会产生异常.
CanvasGadget(#cvsScreen, 10, 10, 380, 230, #PB_Canvas_Container)
    ButtonGadget(#btnScreen, 10, 10, 80, 30, "清空")
CloseGadgetList()

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         Select EventGadget()
            Case #btnScreen
               If StartDrawing(CanvasOutput(#cvsScreen))
                  Box(0, 0, 380, 230, #White)
                  StopDrawing()
               EndIf
            Case #cvsScreen
               Bool = Bool(EventType() = #PB_EventType_MouseMove And GetGadgetAttribute(#cvsScreen, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
               If EventType() = #PB_EventType_LeftButtonDown Or Bool
                  If StartDrawing(CanvasOutput(#cvsScreen))
                     x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
                     y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
                     Circle(x, y, 10, RGB(Random(255), Random(255), Random(255)))
                     StopDrawing()
                  EndIf
               EndIf
        EndSelect
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 21
; FirstLine = 3
; Folding = -
; EnableXP