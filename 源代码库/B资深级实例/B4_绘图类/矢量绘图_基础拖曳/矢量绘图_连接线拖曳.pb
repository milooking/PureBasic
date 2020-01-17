;***********************************
;迷路仟整理 2020.01.12
;矢量绘图_连接线拖曳,右键点击可以改变连接线方向
;***********************************


Enumeration
   #winScreen
   #cvsScreen
EndEnumeration

Structure __GraphicsInfo
   Point1.Point
   Point2.Point
   Offset1.Point
   Offset2.Point
   IsMouseDown0.b
   IsMouseDown1.b
   IsMouseDown2.b
   State.b
EndStructure

Global _Graphics.__GraphicsInfo

;-
;动态的绘制几何图形
Procedure Redraw_Graphics()
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()
      
      MovePathCursor(_Graphics\Point1\x, _Graphics\Point1\y)
      If _Graphics\State = 1
         AddPathLine(_Graphics\Point1\x, _Graphics\Point2\y)
         AddPathLine(_Graphics\Point2\x, _Graphics\Point2\y)
      Else 
         AddPathLine(_Graphics\Point2\x, _Graphics\Point1\y)
         AddPathLine(_Graphics\Point2\x, _Graphics\Point2\y)
      EndIf 
      If _Graphics\IsMouseDown0 = #True Or _Graphics\IsMouseDown1 = #True Or _Graphics\IsMouseDown2 = #True
         VectorSourceColor($FF0000FF)
      Else 
         VectorSourceColor($FF404040)
      EndIf 
      StrokePath(3) 
      FillPath()      
      
      AddPathCircle(_Graphics\Point1\x, _Graphics\Point1\y, 8)
      If _Graphics\IsMouseDown0 = #True Or _Graphics\IsMouseDown1 = #True
         VectorSourceColor($FF0000FF)
      Else 
         VectorSourceColor($FFFF0000)
      EndIf 
      FillPath()      
      AddPathCircle(_Graphics\Point2\x, _Graphics\Point2\y, 8)
      If _Graphics\IsMouseDown0 = #True Or _Graphics\IsMouseDown2 = #True
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
   With _Graphics
      Select EventType()
         Case #PB_EventType_RightClick
            _Graphics\State = 1 - _Graphics\State
            Debug _Graphics\State 
            Redraw_Graphics()
         Case #PB_EventType_LeftButtonDown
            X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
            Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
            If x >= \Point1\x-5 And x<=\Point1\x-5+10 And y>=\Point1\y-5 And y<=\Point1\y-5+10
               \Offset1\x = X - \Point1\x
               \Offset1\y = Y - \Point1\y
               \IsMouseDown1 = #True
               Redraw_Graphics()
               ProcedureReturn
            EndIf 
            If x >= \Point2\x-5 And x<=\Point2\x-5+10 And y>=\Point2\y-5 And y<=\Point2\y-5+10
               \Offset2\x = X - \Point2\x
               \Offset2\y = Y - \Point2\y
               \IsMouseDown2 = #True
               Redraw_Graphics()
               ProcedureReturn
            EndIf 

            If \Point1\x > \Point2\x 
               X1 = \Point2\x : X2 = \Point1\x
            Else 
               X1 = \Point1\x : X2 = \Point2\x
            EndIf 
            
            If \Point1\y > \Point2\y 
               Y1 = \Point2\y : Y2 = \Point1\y
            Else 
               Y1 = \Point1\y : Y2 = \Point2\y
            EndIf             
            If X1 <= X And X <= X2 And Y1 <= Y And Y <= Y2
               \Offset1\x = X - \Point1\x
               \Offset1\y = Y - \Point1\y
               \Offset2\x = X - \Point2\x
               \Offset2\y = Y - \Point2\y
               \IsMouseDown0 = #True
               Redraw_Graphics()
            EndIf                  
 
         Case #PB_EventType_LeftButtonUp
            If \IsMouseDown1 = #True
               X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
               Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
               \Point1\x = X - \Offset1\x
               \Point1\y = Y - \Offset1\y
               \IsMouseDown1 = #False
               Redraw_Graphics()
            ElseIf \IsMouseDown2 = #True
               X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
               Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
               \Point2\x = X - \Offset2\x
               \Point2\y = Y - \Offset2\y
               \IsMouseDown2 = #False
               Redraw_Graphics()               
            ElseIf \IsMouseDown0 = #True
               X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
               Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
               \Point1\x = X - \Offset1\x
               \Point1\y = Y - \Offset1\y
               \Point2\x = X - \Offset2\x
               \Point2\y = Y - \Offset2\y               
               \IsMouseDown0 = #False
               Redraw_Graphics()
            EndIf 
   
         Case #PB_EventType_MouseMove
            If \IsMouseDown1 = #True
               X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
               Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
               \Point1\x = X - \Offset1\x
               \Point1\y = Y - \Offset1\y
               Redraw_Graphics()
            ElseIf \IsMouseDown2 = #True
               X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
               Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
               \Point2\x = X - \Offset2\x
               \Point2\y = Y - \Offset2\y
               Redraw_Graphics()  
            ElseIf \IsMouseDown0 = #True
               X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
               Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
               \Point1\x = X - \Offset1\x
               \Point1\y = Y - \Offset1\y
               \Point2\x = X - \Offset2\x
               \Point2\y = Y - \Offset2\y  
               Redraw_Graphics()
            EndIf 
      EndSelect
   EndWith
EndProcedure

_Graphics\Point1\x = 350
_Graphics\Point1\y = 250
_Graphics\Point2\x = 450
_Graphics\Point2\y = 350


If OpenWindow(#winScreen, 0, 0, 800, 600, "矢量绘图_连接线拖曳", #PB_Window_SystemMenu|#PB_Window_ScreenCentered)
   CanvasGadget(#cvsScreen, 0, 0, 800, 600, #PB_Canvas_ClipMouse)
   Redraw_Graphics() 
   BindGadgetEvent(#cvsScreen, @EventGadget_cvsScreen())
   Repeat
      WinEvent = WindowEvent()
      Select WinEvent 
         Case #PB_Event_CloseWindow : IsExitWindow = #True
         Case #PB_Event_Gadget
      EndSelect
   Until IsExitWindow = #True
EndIf

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 109
; FirstLine = 84
; Folding = -
; EnableXP