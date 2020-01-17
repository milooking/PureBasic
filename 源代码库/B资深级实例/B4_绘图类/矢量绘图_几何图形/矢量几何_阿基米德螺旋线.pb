;***********************************
;迷路仟整理 2019.02.10
;矢量几何_阿基米德螺旋线
;***********************************

#winScreen = 0
#cvsScreen = 0


If OpenWindow(#winScreen, 0, 0, 800, 600, "矢量几何_阿基米德螺旋线", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 800, 600)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      P1.f = ATan(1)*4 
      P2.f = ATan(1)*8
      Px = 400
      Py = 300
      Steps = 1000 
      Radius.f = 0 
      Index.f = P2
      While Index >= -50
         x.d = Px - Sin(Index+P1)*Radius
         y.d = Py - Cos(Index+P1)*Radius
         AddPathCircle(x, y, 1) 
         Radius + 0.025 
         Index - P2/Steps
      Wend 
      StrokePath(2)
      StopVectorDrawing()    

   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; FirstLine = 1
; EnableXP