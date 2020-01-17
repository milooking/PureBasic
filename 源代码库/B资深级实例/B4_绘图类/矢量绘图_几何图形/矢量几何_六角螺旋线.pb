;***********************************
;迷路仟整理 2019.02.10
;矢量几何_六角螺旋线
;***********************************

#winScreen = 0
#cvsScreen = 0

Dim DimPoint.Point(5)

DimPoint(0)\x = 02 : DimPoint(0)\y = 00
DimPoint(1)\x = 01 : DimPoint(1)\y = 02
DimPoint(2)\x = -1 : DimPoint(2)\y = 02
DimPoint(3)\x = -2 : DimPoint(3)\y = 00
DimPoint(4)\x = -1 : DimPoint(4)\y = -2
DimPoint(5)\x = 01 : DimPoint(5)\y = -2


If OpenWindow(#winScreen, 0, 0, 800, 600, "矢量几何_六角螺旋线", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 800, 600)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      X = 400
      Y = 300 
      Interval.f = 10
      VectorSourceColor(RGBA(255, 0, 0, 255))
      MovePathCursor(x, y)
      For Line = 1 To 10
         X + DimPoint(4)\x * Interval
         Y + DimPoint(4)\y * Interval
         For K = 0 To 5
            For N = 1 To Line
               X + DimPoint(K)\x * Interval
               Y + DimPoint(K)\y * Interval
               AddPathLine(X, Y, #PB_Path_Default) 
            Next
         Next
      Next 
      StrokePath(3, #PB_Path_Preserve)
      StopVectorDrawing()    

   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; EnableXP