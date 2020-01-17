;***********************************
;迷路仟整理 2019.02.19
;矢量绘图_多曲线标准调整法1: [纯数组]方法
;***********************************
;[纯数组]方法,写EventGadget_cvsScreen()响应事件时比较麻烦,但容易理解.
;[纯链表]方法,写EventGadget_cvsScreen()响应事件时方便,但难以理解,但拓展性能强
;[数组+链表指针]方法,这种方法,方便程度和理解程度居中
;[树形链表法],这种方法,方便程度和理解程度较佳，拓展性能强

Enumeration
   #winScreen
   #cvsScreen
EndEnumeration

Structure __GraphicsInfo
   *pPoint.Point
   Offset.Point
EndStructure

Global _Graphics.__GraphicsInfo
Global Dim _DimPoint.Point(1)


;动态的绘制几何图形
Procedure Redraw_Graphics()

   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()
 
      ;绘制图形
      MovePathCursor(_DimPoint(0)\X, _DimPoint(0)\Y)
      Count = ArraySize(_DimPoint())-1
      For k = 1 To Count Step 3
         U = k+0 : V = k+1 : W = k+2 
         If W > Count : W = 0 : EndIf 
         AddPathCurve(_DimPoint(U)\x, _DimPoint(U)\y, _DimPoint(V)\x, _DimPoint(V)\y, _DimPoint(W)\x, _DimPoint(W)\y)
      Next 
      VectorSourceColor($A00000FF)
      FillPath()
      
      ;绘制辅助线和辅助点
      For k = Count-1 To 0 Step -3
         U = k+0 : V = k-1 : W = k-2 
         If W < 0 : W = Count : EndIf 
         MovePathCursor(_DimPoint(U)\x, _DimPoint(U)\y)
         AddPathLine(_DimPoint(V)\x, _DimPoint(V)\y) 
         AddPathLine(_DimPoint(W)\x, _DimPoint(W)\y)          
         VectorSourceColor($80000000)
         DashPath(1.5, 3)
         
         AddPathBox(_DimPoint(V)\x-5,_DimPoint(V)\y-5,10,10)
         AddPathCircle(_DimPoint(U)\x, _DimPoint(U)\y,5)
         AddPathCircle(_DimPoint(W)\x, _DimPoint(W)\y,5)
         VectorSourceColor($FFFF8000)
         FillPath() 
      Next 
      StopVectorDrawing()
    EndIf
EndProcedure


;画布事件
Procedure EventGadget_cvsScreen()

   Select EventType()
      Case #PB_EventType_LeftButtonDown
         x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
         y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
         For k = 0 To ArraySize(_DimPoint())-1
            If Sqr(Pow(_DimPoint(k)\X - X, 2) + Pow(_DimPoint(k)\Y - Y, 2)) < 10
               _Graphics\pPoint = _DimPoint(k)
               _Graphics\Offset\x = X-_Graphics\pPoint\x
               _Graphics\Offset\y = Y-_Graphics\pPoint\y
               Redraw_Graphics()
               Break
            EndIf
         Next
        
      Case #PB_EventType_LeftButtonUp
         If _Graphics\pPoint
            _Graphics\pPoint\x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)-_Graphics\Offset\x
            _Graphics\pPoint\y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)-_Graphics\Offset\y
            _Graphics\pPoint = 0
            Redraw_Graphics()
         EndIf
       
      Case #PB_EventType_MouseMove 
         IsButtonDown = GetGadgetAttribute(#cvsScreen, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton
         If IsButtonDown = 0 : ProcedureReturn : EndIf 
         If _Graphics\pPoint
            _Graphics\pPoint\x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)-_Graphics\Offset\x
            _Graphics\pPoint\y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)-_Graphics\Offset\y
            Redraw_Graphics()
         EndIf
  
   EndSelect 
EndProcedure

; Coordinate$ = "134,212, 117,283, 252,350, 310,324, 348,309, 300,199, 351,219, 351,140, 133,139, 251,110, 103,109, 103,129,"
Coordinate$ = "134,212, 117,283, 252,350, 310,324, 348,309, 300,199, 351,219, 351,140, 133,139, "
Index = 1
Count = CountString(Coordinate$, ",") / 2
Count = Count / 3 * 3
ReDim _DimPoint.Point(Count)
For i = 0 To Count-1
   _DimPoint(i)\x = Val(StringField(Coordinate$,Index,",")) : Index+1
   _DimPoint(i)\y = Val(StringField(Coordinate$,Index,",")) : Index+1
Next


If OpenWindow(#winScreen, 0, 0, 600, 450, "矢量绘图_多曲线标准调整法1", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 0, 0, 600, 450)
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
; CursorPosition = 95
; FirstLine = 60
; Folding = -
; EnableXP