;***********************************
;迷路仟整理 2020.01.12
;矢量绘图_直线拖曳1,这里用到三点共线的数学原理
;***********************************


Enumeration
   #winScreen
   #cvsScreen
EndEnumeration
#ErrorValue = 0.05  ;控制三点共线的精度，精度越小，越难用鼠标激活直线

Structure __GraphicsInfo
   Point1.Point
   Point2.Point
   Offset1.Point
   Offset2.Point
   IsMouseDown.b
EndStructure

Global _Graphics.__GraphicsInfo

;-
;动态的绘制几何图形
Procedure Redraw_Graphics()
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()
      MovePathCursor(_Graphics\Point1\x, _Graphics\Point1\y)
      AddPathLine(_Graphics\Point2\x, _Graphics\Point2\y)
      If _Graphics\IsMouseDown = #True
         VectorSourceColor($FF0000FF)
      Else 
         VectorSourceColor($FF404040)
      EndIf 
      StrokePath(3) 
      FillPath()      
      
      AddPathCircle(_Graphics\Point1\x, _Graphics\Point1\y, 8)
      AddPathCircle(_Graphics\Point2\x, _Graphics\Point2\y, 8)
      If _Graphics\IsMouseDown = #True
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
         Case #PB_EventType_LeftButtonDown
            X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
            Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
            ;三点共线
            Collinear = Abs((\Point2\y - Y)*(\Point1\x - X)-(\Point2\x - X)*(\Point1\y - Y))
            Distance0 = (\Point1\x-\Point2\x)*(\Point1\x-\Point2\x)+(\Point1\y-\Point2\y)*(\Point1\y-\Point2\y)
            If Collinear < #ErrorValue * Distance0
               ;判断是否在两个端点之间
               Distance1 = (\Point1\x-X)*(\Point1\x-X)+(\Point1\y-Y)*(\Point1\y-Y) 
               Distance2 = (\Point2\x-X)*(\Point2\x-X)+(\Point2\y-Y)*(\Point2\y-Y) 
               If Distance0 >= Distance1 And Distance0 >= Distance2
                  \Offset1\x = X - \Point1\x
                  \Offset1\y = Y - \Point1\y
                  \Offset2\x = X - \Point2\x
                  \Offset2\y = Y - \Point2\y               
                  \IsMouseDown = #True
                  Redraw_Graphics()
               EndIf 
            EndIf          
            
         Case #PB_EventType_LeftButtonUp
            If \IsMouseDown = #True
               X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
               Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
               \Point1\x = X - \Offset1\x
               \Point1\y = Y - \Offset1\y
               \Point2\x = X - \Offset2\x
               \Point2\y = Y - \Offset2\y               
               \IsMouseDown = #False
               Redraw_Graphics()
            EndIf 
   
         Case #PB_EventType_MouseMove
            If \IsMouseDown = #True
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


If OpenWindow(#winScreen, 0, 0, 800, 600, "矢量绘图_直线拖曳1", #PB_Window_SystemMenu|#PB_Window_ScreenCentered)
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
; CursorPosition = 24
; Folding = 6
; EnableXP