;***********************************
;迷路仟整理 2019.02.10
;矢量几何_四角螺旋线
;***********************************

#winScreen = 0
#cvsScreen = 0


If OpenWindow(#winScreen, 0, 0, 800, 600, "矢量几何_四角螺旋线", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 800, 600)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      x1 = 400
      y1 = 300 
      Interval.f = 3
      VectorSourceColor(RGBA(255, 0, 0, 255))
      MovePathCursor(x1, y1)
      For Line = 1 To 80
         nCount + 1
         Select nCount % 8
            Case 0 : x2 = x1 + Interval * nCount : y2 = y1
            Case 1 : x2 = x1 + Interval * nCount : y2 = y1
            Case 2 : y2 = y1 + Interval * nCount : x2 = x1
            Case 3 : y2 = y1 + Interval * nCount : x2 = x1  
            Case 4 : x2 = x1 - Interval * nCount : y2 = y1
            Case 5 : x2 = x1 - Interval * nCount : y2 = y1
            Case 6 : y2 = y1 - Interval * nCount : x2 = x1
            Case 7 : y2 = y1 - Interval * nCount : x2 = x1     
         EndSelect
         AddPathLine(x1, y1)
         x1 = x2 : y1 = y2
      Next 
      StrokePath(3)
      StopVectorDrawing()    

   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 12
; EnableXP