;***********************************
;迷路仟整理 2019.02.19
;矢量绘图_多曲线标准调整法4:树形链表法
;***********************************
;[纯数组]方法,写EventGadget_cvsScreen()响应事件时比较麻烦,但容易理解.
;[纯链表]方法,写EventGadget_cvsScreen()响应事件时方便,但难以理解,但拓展性能强
;[数组+链表指针]方法,这种方法,方便程度和理解程度居中
;[树形链表法],这种方法,方便程度和理解程度较佳，拓展性能强

Enumeration
   #winScreen
   #cvsScreen
EndEnumeration

; 链表成员的结构,通过这个结构进行上一个成员的快速读取,减少代码
Structure __ElementInfo
   DimPoint.Point[3]
EndStructure

Structure __GraphicsInfo
   *pPoint.Point
   Offset.Point
   List *pListPoint.Point()
   List ListElement.__ElementInfo()
EndStructure

Global _Graphics.__GraphicsInfo


;动态的绘制几何图形
Procedure Redraw_Graphics()

   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()
 
      With _Graphics\ListElement()
         ;绘制图形
         LastElement(_Graphics\pListPoint())
         *pPoint.Point = _Graphics\pListPoint()
         MovePathCursor(_Graphics\pListPoint()\X, _Graphics\pListPoint()\Y)
         ForEach _Graphics\ListElement()
            AddPathCurve(\DimPoint[0]\x, \DimPoint[0]\y, \DimPoint[1]\x, \DimPoint[1]\y, \DimPoint[2]\x, \DimPoint[2]\y)
         Next 
         VectorSourceColor($A00000FF)
         FillPath()

        ;绘制辅助线
         ForEach _Graphics\ListElement()
            MovePathCursor(*pPoint\x, *pPoint\y)
            AddPathLine(\DimPoint[0]\x, \DimPoint[0]\y) 
            *pPoint = \DimPoint[2]
            MovePathCursor(*pPoint\x, *pPoint\y)
            AddPathLine(\DimPoint[1]\x, \DimPoint[1]\y) 
         Next 
         VectorSourceColor($80000000)
         DashPath(1.5, 3)
         
        ;绘制辅助点
         ForEach _Graphics\ListElement()
            AddPathCircle(\DimPoint[0]\x,\DimPoint[0]\y,5)
            AddPathCircle(\DimPoint[1]\x,\DimPoint[1]\y,5)
            AddPathBox(\DimPoint[2]\x-5,\DimPoint[2]\y-5,10,10)
         Next 
         VectorSourceColor($FFFF8000)
         FillPath()

      EndWith
      StopVectorDrawing()
    EndIf
EndProcedure

;画布事件
Procedure EventGadget_cvsScreen()

   Select EventType()
      Case #PB_EventType_LeftButtonDown
         x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
         y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
         ForEach _Graphics\pListPoint()
            *pPoint.Point = _Graphics\pListPoint()
            If Sqr(Pow(*pPoint\X - X, 2) + Pow(*pPoint\Y - Y, 2)) < 10
               _Graphics\pPoint = *pPoint
               _Graphics\Offset\x = X-_Graphics\pPoint\x
               _Graphics\Offset\y = Y-_Graphics\pPoint\y
               Redraw_Graphics()
               Break
            EndIf
         Next
        
      Case #PB_EventType_LeftButtonUp
         If _Graphics\pPoint
            _Graphics\pPoint\x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX) - _Graphics\Offset\x
            _Graphics\pPoint\y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY) - _Graphics\Offset\y
            _Graphics\pPoint = 0
            Redraw_Graphics()
         EndIf
       
      Case #PB_EventType_MouseMove 
         IsButtonDown = GetGadgetAttribute(#cvsScreen, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton
         If IsButtonDown = 0 : ProcedureReturn : EndIf 
         If _Graphics\pPoint
            _Graphics\pPoint\x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX) - _Graphics\Offset\x
            _Graphics\pPoint\y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY) - _Graphics\Offset\y
            Redraw_Graphics()
         EndIf
  
   EndSelect 
EndProcedure

;注意这个第一组坐标数据（与123相比）置放到最后
Coordinate$ = "117,283, 252,350, 310,324, 348,309, 300,199, 351,219, 351,140, 133,139, 251,110, 103,109, 103,129, 134,212, "
; Coordinate$ = "117,283, 252,350, 310,324, 348,309, 300,199, 351,219, 351,140, 133,139, 134,212, "
Index = 1
Count = CountString(Coordinate$, ",") / 2
Count = Count / 3
For i = 1 To Count
   *pElement.__ElementInfo = AddElement(_Graphics\ListElement())
   For k = 0 To 2
      *pElement\DimPoint[k]\x = Val(StringField(Coordinate$,Index,",")) : Index+1
      *pElement\DimPoint[k]\y = Val(StringField(Coordinate$,Index,",")) : Index+1
      AddElement(_Graphics\pListPoint())
      _Graphics\pListPoint() = *pElement\DimPoint[k]
   Next 
Next


If OpenWindow(#winScreen, 0, 0, 600, 450, "矢量绘图_多曲线标准调整法3", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
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
; CursorPosition = 104
; FirstLine = 79
; Folding = -
; EnableXP