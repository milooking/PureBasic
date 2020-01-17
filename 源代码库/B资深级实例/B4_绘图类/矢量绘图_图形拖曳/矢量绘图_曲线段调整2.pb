;***********************************
;迷路仟整理 2019.02.19
;矢量绘图_曲线段调整1: [数组+链表指针]方法
;***********************************
;[纯数组]方法,写EventGadget_cvsScreen()响应事件时比较麻烦,但容易理解.
;[纯链表]方法,写EventGadget_cvsScreen()响应事件时方便,但难以理解,但拓展性能强
;[数组+链表指针]方法,这种方法,方便程度和理解程度居中



Enumeration
   #winScreen
   #cvsScreen
EndEnumeration


Structure __GraphicsInfo
   *pPoint.Point
   Offset.Point
   List *pListPoint.Point()  ;指向数组的指针
EndStructure

Global _Graphics.__GraphicsInfo
Global Dim _DimPoint.Point(3)


;-
;动态的绘制几何图形
;动态的绘制几何图形
Procedure Redraw_Graphics()
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()

      ;获取曲线
      MovePathCursor(_DimPoint(0)\x, _DimPoint(0)\y)
      AddPathCurve(_DimPoint(1)\x, _DimPoint(1)\y, _DimPoint(2)\x, _DimPoint(2)\y, _DimPoint(3)\x, _DimPoint(3)\y)
      VectorSourceColor($FF0000FF)
      StrokePath(3)      
      
      ;画曲线辅助线
      MovePathCursor(_DimPoint(0)\x, _DimPoint(0)\y)
      AddPathLine(_DimPoint(1)\x, _DimPoint(1)\y) 
      MovePathCursor(_DimPoint(3)\x, _DimPoint(3)\y)
      AddPathLine(_DimPoint(2)\x, _DimPoint(2)\y)
      VectorSourceColor(RGBA(0, 0, 0, 255))
      DashPath(2, 5)   
          
      ;画曲线起始点和终点
      AddPathBox(_DimPoint(0)\x-8, _DimPoint(0)\y-8, 16, 16) 
      AddPathBox(_DimPoint(3)\x-8, _DimPoint(3)\y-8, 16, 16) 
      VectorSourceColor($FFFF0000)
      FillPath()          
          
      ;画曲线辅助点
      AddPathCircle(_DimPoint(1)\x, _DimPoint(1)\y, 8) 
      AddPathCircle(_DimPoint(2)\x, _DimPoint(2)\y, 8) 
      VectorSourceColor($FF808080)
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
         ForEach _Graphics\pListPoint()
            *pPoint.Point = _Graphics\pListPoint()
            If Sqr(Pow(*pPoint\X - X, 2) + Pow(*pPoint\Y - Y, 2)) < 8
               _Graphics\pPoint = *pPoint
               _Graphics\Offset\x = X-_Graphics\pPoint\x
               _Graphics\Offset\y = Y-_Graphics\pPoint\y
               Redraw_Graphics()
            EndIf 
         Next          

      Case #PB_EventType_LeftButtonUp
         If _Graphics\pPoint
            _Graphics\pPoint\x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX) - _Graphics\Offset\x
            _Graphics\pPoint\y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY) - _Graphics\Offset\y
            Redraw_Graphics()
            _Graphics\pPoint = 0
         EndIf 

      Case #PB_EventType_MouseMove
         If _Graphics\pPoint
            _Graphics\pPoint\x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX) - _Graphics\Offset\x
            _Graphics\pPoint\y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY) - _Graphics\Offset\y
            Redraw_Graphics()
         EndIf 

   EndSelect
EndProcedure


With _DimPoint(Index)
   \x = 300 : \y = 500 : AddElement(_Graphics\pListPoint()) : _Graphics\pListPoint() = _DimPoint(Index) : Index+1 
   \x = 675 : \y = 350 : AddElement(_Graphics\pListPoint()) : _Graphics\pListPoint() = _DimPoint(Index) : Index+1 
   \x = 300 : \y = 150 : AddElement(_Graphics\pListPoint()) : _Graphics\pListPoint() = _DimPoint(Index) : Index+1 
   \x = 350 : \y = 300 : AddElement(_Graphics\pListPoint()) : _Graphics\pListPoint() = _DimPoint(Index) : Index+1 
EndWith

If OpenWindow(#winScreen, 0, 0, 800, 600, "矢量绘图_曲线段调整1", #PB_Window_SystemMenu|#PB_Window_ScreenCentered)
   CanvasGadget(#cvsScreen, 0, 0, 800, 600, #PB_Canvas_ClipMouse)
   Redraw_Graphics() 
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
; CursorPosition = 84
; FirstLine = 60
; Folding = -
; EnableXP