;***********************************
;迷路仟整理 2019.02.21
;矢量绘图_手动绘制直线段填充选区
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #tmrScreen
   #fntScreen
EndEnumeration

Structure __SegmentsInfo
   Text$
   Color.l
EndStructure

Structure __GraphicsInfo
   *pPoint.Point
   Offset.Point
   DynamicIndex.l
   List ListPoint.Point()
   List ListSegments.__SegmentsInfo()
   IsClosePath.b
EndStructure

Global _Graphics.__GraphicsInfo


;动态的绘制几何图形
Procedure Redraw_Graphics()

   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()
      VectorFont(FontID(#fntScreen), 20)
      VectorSourceColor($FFFF8000)
      MovePathCursor(010, 010)
      DrawVectorText("左键添点描点,右键封闭多段直线!未封闭前可以整调描点!")
      ForEach _Graphics\ListSegments()
         AddPathSegments(_Graphics\ListSegments()\Text$)
         VectorSourceColor(_Graphics\ListSegments()\Color)
         FillPath()
      Next 
      
      With _Graphics\ListPoint()
         ;绘制图形
         If _Graphics\IsClosePath = #True
            LastElement(_Graphics\ListPoint())
            MovePathCursor(\X, \Y)
            ForEach _Graphics\ListPoint()
               AddPathLine(\X, \Y)
            Next
            Result$ = PathSegments()
            Color = RGBA(Random(255),Random(255),Random(255), 255)
            VectorSourceColor(Color)
            FillPath()
            AddElement(_Graphics\ListSegments())
            _Graphics\ListSegments()\Text$ = Result$
            _Graphics\ListSegments()\Color = Color
            ClearList(_Graphics\ListPoint()) 
            _Graphics\pPoint = 0
            _Graphics\IsClosePath = #False
            
         ElseIf ListSize(_Graphics\ListPoint()) 
            FirstElement(_Graphics\ListPoint())
            MovePathCursor(\X, \Y)
            While NextElement(_Graphics\ListPoint())
               AddPathLine(\X, \Y)
            Wend
            VectorSourceColor($A00000FF)
            StrokePath(1.5) 
   ;         绘制辅助点
            ForEach _Graphics\ListPoint()
               AddPathBox(\x-5, \y-5, 10, 10)
            Next             
            VectorSourceColor($FFFF8000)
            FillPath()     
         EndIf        
      EndWith
      StopVectorDrawing()
    EndIf
EndProcedure


;画布事件
Procedure EventGadget_cvsScreen()

   Select EventType()
      Case #PB_EventType_RightClick   
         X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)      
         _Graphics\IsClosePath = #True
         Redraw_Graphics()
         
      Case #PB_EventType_LeftButtonDown
         X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
         ForEach _Graphics\ListPoint()
            *pPoint.Point = _Graphics\ListPoint()
            If Sqr(Pow(*pPoint\X - X, 2) + Pow(*pPoint\Y - Y, 2)) < 10
               _Graphics\pPoint = *pPoint
               _Graphics\Offset\x = X-_Graphics\pPoint\x
               _Graphics\Offset\y = Y-_Graphics\pPoint\y
               Redraw_Graphics()
               ProcedureReturn
            EndIf
         Next
         AddElement(_Graphics\ListPoint())
         _Graphics\ListPoint()\x = X
         _Graphics\ListPoint()\y = Y
         Redraw_Graphics()
         
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


LoadFont(#fntScreen, "", 12)
If OpenWindow(#winScreen, 0, 0, 600, 450, "矢量绘图_手动绘制直线段填充选区", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 0, 0, 600, 450)
   Redraw_Graphics()
   AddWindowTimer(#winScreen, #tmrScreen, 100)
   Repeat
      WinEvent = WindowEvent()
      Select WinEvent 
         Case #PB_Event_CloseWindow : IsExitWindow = #True
         Case #PB_Event_Timer
            If EventTimer() = #tmrScreen : _Graphics\DynamicIndex+1 : Redraw_Graphics() : EndIf
         Case #PB_Event_Gadget
            Select EventGadget()
               Case #cvsScreen : EventGadget_cvsScreen()
            EndSelect
      EndSelect
   Until IsExitWindow = #True
EndIf

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 120
; FirstLine = 94
; Folding = -
; EnableXP