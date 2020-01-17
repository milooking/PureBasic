;***********************************
;迷路仟整理 2020.01.12
;矢量绘图_点拖曳
;***********************************


Enumeration
   #winScreen
   #cvsScreen
EndEnumeration

Global _MyPoint.Point
Global _Offsets.Point
Global _IsMouseDown

;-
;动态的绘制几何图形
Procedure Redraw_Graphics()
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()
      AddPathBox(_MyPoint\x-8, _MyPoint\y-8, 16, 16)
      If _IsMouseDown = #True
         VectorSourceColor($FF0000FF)
      Else 
         VectorSourceColor($FFFF0000)
      EndIf 
      FillPath()          
      StopVectorDrawing()
   EndIf
EndProcedure

;画布事件
Procedure EventGadget_cvsScreen()
   Select EventType()
      Case #PB_EventType_LeftButtonDown
         X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
         If Sqr(Pow(_MyPoint\X - X, 2) + Pow(_MyPoint\Y - Y, 2)) < 8
            _Offsets\x = X - _MyPoint\x
            _Offsets\y = Y - _MyPoint\y
            _IsMouseDown = #True
            Redraw_Graphics()
         EndIf          
         
      Case #PB_EventType_LeftButtonUp
         If _IsMouseDown = #True
            X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
            Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
            _MyPoint\x = X - _Offsets\x
            _MyPoint\y = Y - _Offsets\y
            _IsMouseDown = #False
            Redraw_Graphics()
         EndIf 

      Case #PB_EventType_MouseMove
         If _IsMouseDown = #True
            X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
            Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
            _MyPoint\x = X - _Offsets\x
            _MyPoint\y = Y - _Offsets\y
            Redraw_Graphics()
         EndIf 
   EndSelect
EndProcedure

_MyPoint\x = 400
_MyPoint\y = 300

If OpenWindow(#winScreen, 0, 0, 800, 600, "矢量绘图_点拖曳", #PB_Window_SystemMenu|#PB_Window_ScreenCentered)
   CanvasGadget(#cvsScreen, 0, 0, 800, 600, #PB_Canvas_ClipMouse)
   Redraw_Graphics() 
   BindGadgetEvent(#cvsScreen, @EventGadget_cvsScreen())
   Repeat
      WinEvent = WindowEvent()
      Select WinEvent 
         Case #PB_Event_CloseWindow : IsExitWindow = #True
         Case #PB_Event_Gadget
            Select EventGadget()
               Case #cvsScreen : EventGadget_cvsScreen()
            EndSelect
      EndSelect
   Until IsExitWindow = #True
EndIf

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = 0
; EnableXP