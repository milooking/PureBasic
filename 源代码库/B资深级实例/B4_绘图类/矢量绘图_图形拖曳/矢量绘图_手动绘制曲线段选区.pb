;***********************************
;迷路仟整理 2019.02.21
;矢量绘图_手动绘制曲线段选区
;***********************************

;MovePathCursor是起点,AddPathCurveX3/Y3是终点, AddPathCurveX1/Y1,AddPathCurveX2/Y2是调节点

;-[Enumeration]
Enumeration
   #winScreen
   #cvsScreen
   #tmrScreen
   #fntScreen
EndEnumeration

;-[Structure]
Structure __PointInfo
   X.f
   Y.f
   *pSymmetry.__PointInfo
   *pOriginal.__PointInfo
EndStructure

Structure __BezierInfo
   CurrTrace.__PointInfo      ;描点:终点
   CurrLocus.__PointInfo      ;控点
   NextLocus.__PointInfo      ;控点   
EndStructure

Structure __GraphicsInfo
   *pPoint.__PointInfo
   *pPrevBezier.__GraphicsInfo
   Offset.Point
   List *pListPoint.__PointInfo()
   List ListBezier.__BezierInfo()
   DynamicIndex.l
   IsClosePath.b
   IsFinishPath.b
EndStructure


;-[Global]
Global _Graphics.__GraphicsInfo

;- **************************
;-[Redraw]
;完成曲线,建立选区
Procedure Redraw_Graphics_FinishPath()
   With _Graphics\ListBezier()
      ;绘制多段曲线组成的选区
      *pFirstBezier.__BezierInfo = FirstElement(_Graphics\ListBezier())
      *pBezier.__BezierInfo = *pFirstBezier
      While NextElement(_Graphics\ListBezier())
         MovePathCursor(*pBezier\CurrTrace\x, *pBezier\CurrTrace\y)
         AddPathCurve(*pBezier\NextLocus\x, *pBezier\NextLocus\y, \CurrLocus\x, \CurrLocus\y, \CurrTrace\x, \CurrTrace\y)
         *pBezier = _Graphics\ListBezier()
      Wend
      FirstElement(_Graphics\ListBezier())
      AddPathCurve(*pBezier\NextLocus\x, *pBezier\NextLocus\y, \CurrLocus\x, \CurrLocus\y, \CurrTrace\x, \CurrTrace\y)
      
      ;为选区边线间线并做动态处理
      Result$ = PathSegments()
      VectorSourceColor($FFFF8000)  
      StrokePath(1.5)
      AddPathSegments(Result$)
      VectorSourceColor($FF000000)
      DashPath(1.5, 10, #PB_Path_Default, _Graphics\DynamicIndex)
   EndWith
EndProcedure

;封闭曲线段
Procedure Redraw_Graphics_ClosePath()
   With _Graphics\ListBezier()
      ;绘制多段曲线组成的形状
      *pFirstBezier.__BezierInfo = FirstElement(_Graphics\ListBezier())
      *pBezier.__BezierInfo = *pFirstBezier
      While NextElement(_Graphics\ListBezier())
         MovePathCursor(*pBezier\CurrTrace\x, *pBezier\CurrTrace\y)
         AddPathCurve(*pBezier\NextLocus\x, *pBezier\NextLocus\y, \CurrLocus\x, \CurrLocus\y, \CurrTrace\x, \CurrTrace\y)
         *pBezier = _Graphics\ListBezier()
      Wend
      FirstElement(_Graphics\ListBezier())
      AddPathCurve(*pBezier\NextLocus\x, *pBezier\NextLocus\y, \CurrLocus\x, \CurrLocus\y, \CurrTrace\x, \CurrTrace\y)
      VectorSourceColor($A00000FF)
      StrokePath(1.5) 
      
      ;绘制辅助线
      ForEach _Graphics\ListBezier()
         MovePathCursor(\CurrTrace\x, \CurrTrace\y)
         AddPathLine(\CurrLocus\x, \CurrLocus\y) 
         MovePathCursor(\CurrTrace\x, \CurrTrace\y)
         AddPathLine(\NextLocus\x, \NextLocus\y)                
      Next
      VectorSourceColor($80000000)
      DashPath(1.5, 3) 

      ;绘制辅助点
      ForEach _Graphics\ListBezier()
         AddPathBox   (\CurrTrace\x-6, \CurrTrace\y-6, 12, 12)
         AddPathCircle(\NextLocus\x+0, \NextLocus\y+0, 05) 
         AddPathCircle(\CurrLocus\x+0, \CurrLocus\y+0, 05) 
      Next
      VectorSourceColor($FF808080)
      FillPath()  
   EndWith
   With *pBezier    
      ;绘制当前选中点   
      If _Graphics\pPoint
         *pBezier = _Graphics\pPoint\pOriginal
         AddPathBox   (\CurrTrace\x-6, \CurrTrace\y-6, 12, 12)
         AddPathCircle(\NextLocus\x+0, \NextLocus\y+0, 05) 
         AddPathCircle(\CurrLocus\x+0, \CurrLocus\y+0, 05) 
      EndIf 
      VectorSourceColor($FFFF8000)
      FillPath()          
   EndWith
EndProcedure

;添加曲线段
Procedure Redraw_Graphics_AddPath()

   With _Graphics\ListBezier()
      ;绘制多段曲线组成的形状
      *pFirstBezier.__BezierInfo = FirstElement(_Graphics\ListBezier())
      *pBezier.__BezierInfo = *pFirstBezier
      While NextElement(_Graphics\ListBezier())
         MovePathCursor(*pBezier\CurrTrace\x, *pBezier\CurrTrace\y)
         AddPathCurve(*pBezier\NextLocus\x, *pBezier\NextLocus\y, \CurrLocus\x, \CurrLocus\y, \CurrTrace\x, \CurrTrace\y)
         *pBezier = _Graphics\ListBezier()
      Wend
      VectorSourceColor($A00000FF)
      StrokePath(1.5) 
      
      ;绘制辅助线
      *pBezier = FirstElement(_Graphics\ListBezier())
      MovePathCursor(*pBezier\CurrTrace\x, *pBezier\CurrTrace\y)
      AddPathLine(*pBezier\NextLocus\x, *pBezier\NextLocus\y) 
      While NextElement(_Graphics\ListBezier())
         MovePathCursor(\CurrTrace\x, \CurrTrace\y)
         AddPathLine(\CurrLocus\x, \CurrLocus\y) 
         MovePathCursor(\CurrTrace\x, \CurrTrace\y)
         AddPathLine(\NextLocus\x, \NextLocus\y)                
      Wend
      VectorSourceColor($80000000)
      DashPath(1.5, 3) 

      ;绘制辅助点
      *pBezier = FirstElement(_Graphics\ListBezier())
      AddPathBox   (*pBezier\CurrTrace\x-6, *pBezier\CurrTrace\y-6, 12, 12)
      AddPathCircle(\NextLocus\x+0, \NextLocus\y+0, 05) 
      While NextElement(_Graphics\ListBezier())
         AddPathBox   (\CurrTrace\x-6, \CurrTrace\y-6, 12, 12)
         AddPathCircle(\NextLocus\x+0, \NextLocus\y+0, 05) 
         If _Graphics\ListBezier() <> *pFirstBezier
            AddPathCircle(\CurrLocus\x+0, \CurrLocus\y+0, 05) 
         EndIf 
         *pBezier = _Graphics\ListBezier()
      Wend
      VectorSourceColor($FF808080)
      FillPath()  
   EndWith  
    
   With *pBezier 
      ;绘制当前选中点       
      If _Graphics\pPoint
         *pBezier = _Graphics\pPoint\pOriginal
         AddPathBox   (\CurrTrace\x-6, \CurrTrace\y-6, 12, 12)
         AddPathCircle(\NextLocus\x+0, \NextLocus\y+0, 05) 
         If *pBezier <> *pFirstBezier
            AddPathCircle(\CurrLocus\x+0, \CurrLocus\y+0, 05) 
         EndIf 
      EndIf 
      VectorSourceColor($FFFF8000)
      FillPath()          
   EndWith

EndProcedure

;动态的绘制几何图形
Procedure Redraw_Graphics()
   *pBezier.__BezierInfo
   *pFirstBezier.__BezierInfo
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()
      VectorFont(FontID(#fntScreen), 20)
      VectorSourceColor($FFFF8000)
      MovePathCursor(010, 010)
      DrawVectorText("左键添点描点,右键单击封闭多段曲线! --- 左键双击建立选区,右键双击清空曲线段!")
      Count = ListSize(_Graphics\ListBezier())
      If Count
         If _Graphics\IsFinishPath = #True
            Redraw_Graphics_FinishPath()
         ElseIf _Graphics\IsClosePath = #True
            Redraw_Graphics_ClosePath()
         Else 
            Redraw_Graphics_AddPath()
         EndIf 
      EndIf 
      StopVectorDrawing()
    EndIf
EndProcedure

;- **************************
;-[EventGadget]
Procedure EventGadget_AddPoint(*pPoint.__PointInfo, X, Y, *pOriginal, *pSymmetry)
   *pPoint\X = X 
   *pPoint\Y = Y 
   *pPoint\pSymmetry = *pSymmetry
   *pPoint\pOriginal = *pOriginal
   AddElement(_Graphics\pListPoint())
   _Graphics\pListPoint() = *pPoint
EndProcedure

Procedure EventGadget_cvsScreen_RightClick()
   If _Graphics\IsClosePath = #False 
      *pLastBezier.__BezierInfo  = LastElement(_Graphics\ListBezier())
      *pFirstBezier.__BezierInfo = FirstElement(_Graphics\ListBezier())
      If *pFirstBezier = 0 : ProcedureReturn : EndIf 
      With *pFirstBezier
         X = \CurrTrace\x * 2 - \NextLocus\x
         Y = \CurrTrace\y * 2 - \NextLocus\y
         EventGadget_AddPoint(\CurrLocus, X, Y, \CurrTrace, \NextLocus)
         \NextLocus\pSymmetry = \CurrLocus    
         _Graphics\pPoint = \CurrLocus 
         _Graphics\pPrevBezier = *pFirstBezier
         Redraw_Graphics()
      EndWith
      _Graphics\IsClosePath = #True
      Redraw_Graphics()
   EndIf 
EndProcedure

Procedure EventGadget_cvsScreen_LeftButtonDown()

   If _Graphics\IsFinishPath = #True 
      ClearList(_Graphics\pListPoint()) 
      ClearList(_Graphics\ListBezier()) 
      _Graphics\pPoint = 0
      _Graphics\IsClosePath  = #False
      _Graphics\IsFinishPath = #False
   EndIf 
   X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
   Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
   ;判断光标落点
   ForEach _Graphics\pListPoint()
      *pPoint.__PointInfo = _Graphics\pListPoint()
      If Sqr(Pow(*pPoint\X - X, 2) + Pow(*pPoint\Y - Y, 2)) < 10
         _Graphics\pPoint = *pPoint
         _Graphics\Offset\x = X-_Graphics\pPoint\x
         _Graphics\Offset\y = Y-_Graphics\pPoint\y
         Redraw_Graphics()
         ProcedureReturn
      EndIf
   Next
   If _Graphics\IsClosePath = #True
      ProcedureReturn 
   EndIf
   *pBezier.__BezierInfo = AddElement(_Graphics\ListBezier())
   With *pBezier
      ;如果是曲线起点
      If _Graphics\pPrevBezier = 0
         EventGadget_AddPoint(\NextLocus, X, Y, \CurrTrace, 0)
         EventGadget_AddPoint(\CurrTrace, X, Y, \CurrTrace, 0)
         _Graphics\pPoint = \NextLocus 
      ;如果是曲线续画
      Else 
         EventGadget_AddPoint(\CurrLocus, X, Y, \CurrTrace, \NextLocus)
         EventGadget_AddPoint(\NextLocus, X, Y, \CurrTrace, \CurrLocus)
         EventGadget_AddPoint(\CurrTrace, X, Y, \CurrTrace, 0)
         _Graphics\pPoint = \NextLocus 
      EndIf 
      _Graphics\pPrevBezier = *pBezier
      Redraw_Graphics()
   EndWith

EndProcedure

Procedure EventGadget_cvsScreen_LeftButtonUp()
   If _Graphics\IsFinishPath = #True : ProcedureReturn : EndIf 
   If _Graphics\pPoint
      _Graphics\pPoint\x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX) - _Graphics\Offset\x
      _Graphics\pPoint\y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY) - _Graphics\Offset\y
      _Graphics\pPoint = 0
      Redraw_Graphics()
   EndIf
EndProcedure

Procedure EventGadget_cvsScreen_MouseMove()
   If _Graphics\IsFinishPath = #True : ProcedureReturn : EndIf 
   IsButtonDown = GetGadgetAttribute(#cvsScreen, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton
   If IsButtonDown = 0 : ProcedureReturn : EndIf 
   If _Graphics\pPoint
      With _Graphics\pPoint
         x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)-_Graphics\Offset\x
         y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)-_Graphics\Offset\y
         If _Graphics\pPoint = \pOriginal
            dx = x - \x
            dy = y - \y
            *pBezier.__BezierInfo = \pOriginal
            If *pBezier\CurrLocus
               *pBezier\CurrLocus\x + dx
               *pBezier\CurrLocus\y + dy
            EndIf 
            *pBezier\NextLocus\x + dx
            *pBezier\NextLocus\y + dy
         ElseIf \pSymmetry
            \pSymmetry\x = \pOriginal\x * 2 - x
            \pSymmetry\y = \pOriginal\y * 2 - y
         EndIf 
         \x = x
         \y = y
      EndWith
      Redraw_Graphics()
   EndIf
EndProcedure

;画布事件
Procedure EventGadget_cvsScreen()

   Select EventType()
      Case #PB_EventType_LeftDoubleClick
         If _Graphics\IsClosePath = #True
            _Graphics\IsFinishPath = #True
            Redraw_Graphics()      
         EndIf 
      Case #PB_EventType_RightDoubleClick
         ClearList(_Graphics\pListPoint()) 
         ClearList(_Graphics\ListBezier()) 
         _Graphics\pPoint = 0
         _Graphics\IsClosePath  = #False
         _Graphics\IsFinishPath = #False
         Redraw_Graphics() 
      
      Case #PB_EventType_RightClick  
         EventGadget_cvsScreen_RightClick()
      Case #PB_EventType_LeftButtonDown
         EventGadget_cvsScreen_LeftButtonDown()
      Case #PB_EventType_LeftButtonUp
         EventGadget_cvsScreen_LeftButtonUp()
      Case #PB_EventType_MouseMove 
         EventGadget_cvsScreen_MouseMove()
   EndSelect 
   
EndProcedure

;- **************************
;-[Main]
LoadFont(#fntScreen, "", 12)
If OpenWindow(#winScreen, 0, 0, 800, 550, "矢量绘图_手动绘制曲线段选区", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 0, 0, 800, 550)
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
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 254
; FirstLine = 46
; Folding = Iw0
; EnableXP