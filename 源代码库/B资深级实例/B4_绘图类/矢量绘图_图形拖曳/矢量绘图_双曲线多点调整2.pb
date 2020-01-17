;***********************************
;迷路仟整理 2019.02.19
;矢量绘图_双曲线多点调整2: [数组+链表指针]方法
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
Global Dim _DimPoint.Point(5)

;-
;动态的绘制几何图形
Procedure Redraw_Graphics(IsShow=#False)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()
      If ListSize(_Graphics\pListPoint())
      
         ;绘制图形
         MovePathCursor(_DimPoint(5)\x, _DimPoint(5)\y)
         AddPathCurve(_DimPoint(0)\x, _DimPoint(0)\y, _DimPoint(1)\x, _DimPoint(1)\y, _DimPoint(2)\x, _DimPoint(2)\y)
         AddPathCurve(_DimPoint(3)\x, _DimPoint(3)\y, _DimPoint(4)\x, _DimPoint(4)\y, _DimPoint(5)\x, _DimPoint(5)\y)

         If IsShow=#True
            Segments$ = PathSegments()       ;记录这种路径
            Debug "路径信息: " + Segments$
         EndIf 
         VectorSourceColor($FF4010C0)
         FillPath()
         
         ;绘制辅助点
         ForEach _Graphics\pListPoint()
            *pPoint.Point = _Graphics\pListPoint()
            If *pPoint = _Graphics\pPoint : Continue : EndIf 
            AddPathBox(*pPoint\x-5, *pPoint\y-5, 10, 10)
         Next
         VectorSourceColor($FF0080FF)
         FillPath()
         If _Graphics\pPoint
            AddPathBox(_Graphics\pPoint\x-5, _Graphics\pPoint\y-5, 10, 10)
            VectorSourceColor($FFFF8000)
            FillPath()  
         EndIf   
      EndIf   
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
            If x >= *pPoint\x-5 And x<=*pPoint\x-5+10 And y>=*pPoint\y-5 And y<=*pPoint\y-5+10
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
            Redraw_Graphics(#True)
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


Coordinate$ = "277,047, 304,131, 207,202, 111,115, 111,050, 200,106"
Index = 1
For i = 1 To 6
   _DimPoint(i-1)\X = Val(StringField(Coordinate$,Index,",")) : Index+1
   _DimPoint(i-1)\Y = Val(StringField(Coordinate$,Index,",")) : Index+1
   AddElement(_Graphics\pListPoint())
   _Graphics\pListPoint() = @_DimPoint(i-1)
Next

If OpenWindow(#winScreen, 0, 0, 400, 300, "矢量绘图_双曲线多点调整2", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
   CanvasGadget(#cvsScreen, 0, 0, 400, 300)
   Redraw_Graphics(#True)
   
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
; FirstLine = 63
; Folding = -
; EnableXP