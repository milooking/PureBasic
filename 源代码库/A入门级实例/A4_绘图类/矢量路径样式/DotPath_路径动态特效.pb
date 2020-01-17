;***********************************
;迷路仟整理 2019.02.09
;DotPath_路径动态特效
;***********************************

#winScreen = 0
#cvsScreen = 0
#tmrScreen = 0


Global _StyleIndex.l

Procedure Functin_Drawing()
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor(RGBA(255, 255, 255, 255))
      FillVectorOutput()
      AddPathBox(050, 050, 250, 80)             ;添加一个矩形路径
      AddPathCircle(300, 100, 080)              ;添加一个圆形路径
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DotPath(2, 5, #PB_Path_Default, _StyleIndex)
      StopVectorDrawing()
   EndIf 
EndProcedure

If OpenWindow(#winScreen, 0, 0, 400, 250, "DotPath_路径动态特效", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   AddWindowTimer(#winScreen, #tmrScreen, 100)
   Functin_Drawing()
   Repeat
      WinEvent = WaitWindowEvent() 
      Select WinEvent 
         Case #PB_Event_CloseWindow : IsExitWindow = #True
         Case #PB_Event_Timer
            If EventTimer() = #tmrScreen
               _StyleIndex+1
               Functin_Drawing()
            EndIf 
      EndSelect
   Until IsExitWindow = #True
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 28
; FirstLine = 19
; Folding = -
; EnableXP