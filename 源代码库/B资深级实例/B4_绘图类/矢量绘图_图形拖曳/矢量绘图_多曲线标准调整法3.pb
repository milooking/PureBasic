;***********************************
;迷路仟整理 2019.02.19
;矢量绘图_多曲线标准调整法3:纯链表方法
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
Structure __ListElementInfo
   *pNextElement.__ListElementInfo
   *pPrevElement.__ListElementInfo
   X.l
   Y.l
EndStructure

Structure __GraphicsInfo
   *pPoint.Point
   Offset.Point
   List ListPoint.Point()
EndStructure

Global _Graphics.__GraphicsInfo

;动态的绘制几何图形
Procedure Redraw_Graphics()
   *pLast.__ListElementInfo
   *pFirst.__ListElementInfo
   *pElement0.__ListElementInfo
   *pElement1.__ListElementInfo
   *pElement2.__ListElementInfo 
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)
      FillVectorOutput()
 
      ;绘制图形
      *pFirst = FirstElement(_Graphics\ListPoint()) - 8
      MovePathCursor(*pFirst\X, *pFirst\Y) 
      *pElement0 = *pFirst\pNextElement
      While *pElement0
         *pElement1 = *pElement0\pNextElement
         *pElement2 = *pElement1\pNextElement
         If *pElement2 = 0 
            *pElement2 = *pFirst
            AddPathCurve(*pElement0\x, *pElement0\y, *pElement1\x, *pElement1\y, *pElement2\x, *pElement2\y)
            *pElement0 = 0
         Else 
            AddPathCurve(*pElement0\x, *pElement0\y, *pElement1\x, *pElement1\y, *pElement2\x, *pElement2\y)
            *pElement0 = *pElement2\pNextElement
         EndIf 
      Wend    
      VectorSourceColor($A00000FF)
      FillPath()
      
      
      *pLast  = LastElement(_Graphics\ListPoint())  - 8
      *pElement0 = *pLast\pPrevElement
      While *pElement0
         *pElement1 = *pElement0\pPrevElement
         *pElement2 = *pElement1\pPrevElement
         If *pElement2 = 0 
            *pElement2 = *pLast
            *pPrevElement = 0
         Else 
            *pPrevElement = *pElement2\pPrevElement
         EndIf 
         
         MovePathCursor(*pElement0\x, *pElement0\y)
         AddPathLine(*pElement1\x, *pElement1\y) 
         AddPathLine(*pElement2\x, *pElement2\y)          
         VectorSourceColor(RGBA(0,0,0,100))
         StrokePath(1)

         AddPathBox(*pElement1\x-5,*pElement1\y-5,10,10)
         AddPathCircle(*pElement0\x, *pElement0\y,5)
         AddPathCircle(*pElement2\x, *pElement2\y,5)
         VectorSourceColor($FFFF8000)
         FillPath()              
         *pElement0 = *pPrevElement
      Wend 
      
      StopVectorDrawing()
    EndIf
EndProcedure


;画布事件
Procedure EventGadget_cvsScreen()

   Select EventType()
      Case #PB_EventType_LeftButtonDown
         x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
         y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
         ForEach _Graphics\ListPoint()
            *pPoint.Point = _Graphics\ListPoint()
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

Coordinate$ = "134,212, 117,283, 252,350, 310,324, 348,309, 300,199, 351,219, 351,140, 133,139, 251,110, 103,109, 103,129,"
Coordinate$ = "134,212, 117,283, 252,350, 310,324, 348,309, 300,199, 351,219, 351,140, 133,139, "
Index = 1
Count = CountString(Coordinate$, ",") / 2
Count = Count / 3 * 3
For i = 1 To Count
   *pPoint.Point = AddElement(_Graphics\ListPoint())
   *pPoint\x = Val(StringField(Coordinate$,Index,",")) : Index+1
   *pPoint\y = Val(StringField(Coordinate$,Index,",")) : Index+1
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
; CursorPosition = 118
; FirstLine = 99
; Folding = -
; EnableXP