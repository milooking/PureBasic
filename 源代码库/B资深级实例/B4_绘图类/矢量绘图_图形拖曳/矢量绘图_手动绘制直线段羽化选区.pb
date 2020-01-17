;***********************************
;迷路仟整理 2019.02.21
;矢量绘图_手动绘制直线段羽化选区
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #tmrScreen
   #fntScreen
EndEnumeration

#Feather = 50  ;羽化值

Structure __GraphicsInfo
   *pPoint.Point
   Offset.Point
   DynamicIndex.l
   List ListPoint.Point()
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
      DrawVectorText("左键添点描点,右键封闭多段直线!并对转角进行"+StrF(#Feather)+"单位的羽化")
           
      With _Graphics\ListPoint()
         ;绘制图形
         If _Graphics\IsClosePath = #True
            *pFirst.Point = FirstElement(_Graphics\ListPoint())
            *pPoint.Point = LastElement(_Graphics\ListPoint())
            
            X = *pPoint\x + (*pFirst\x-*pPoint\x) /2
            Y = *pPoint\y + (*pFirst\y-*pPoint\y) /2
            MovePathCursor(X, Y)          ;从第一段直线中间开始起画,防止第一段与最后一段直线接线处没有羽化
            ForEach _Graphics\ListPoint()
               AddPathArc(*pPoint\X, *pPoint\Y, \X, \Y, #Feather)
               *pPoint = _Graphics\ListPoint()
            Next
            AddPathArc(*pPoint\X, *pPoint\Y, *pFirst\X, *pFirst\Y, #Feather)  
            ClosePath()                   ;封闭第一段直线缺口                  
            Result$ = PathSegments()
            VectorSourceColor($FFFF8000)  
            StrokePath(1.5)
            AddPathSegments(Result$)
            VectorSourceColor($FF000000)
            DashPath(1.5, 10, #PB_Path_Default, _Graphics\DynamicIndex)

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
         If _Graphics\IsClosePath = #True 
            ClearList(_Graphics\ListPoint()) 
            _Graphics\pPoint = 0
            _Graphics\IsClosePath = #False
         EndIf 
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
         If _Graphics\IsClosePath = #True : ProcedureReturn : EndIf 
         If _Graphics\pPoint
            _Graphics\pPoint\x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX) - _Graphics\Offset\x
            _Graphics\pPoint\y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY) - _Graphics\Offset\y
            _Graphics\pPoint = 0
            Redraw_Graphics()
         EndIf
       
      Case #PB_EventType_MouseMove 
         If _Graphics\IsClosePath = #True : ProcedureReturn : EndIf 
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
If OpenWindow(#winScreen, 0, 0, 600, 450, "矢量绘图_手动绘制直线段羽化选区", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
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
; CursorPosition = 121
; FirstLine = 96
; Folding = -
; EnableXP