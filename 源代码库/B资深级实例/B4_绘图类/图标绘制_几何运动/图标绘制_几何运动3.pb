;***********************************
;迷路仟整理 2019.04.13
;图标绘制_几何运动2
;***********************************

#winScreen = 0
#cvsScreen = 0
#tmrScreen = 0

Global _CurrAngle

Procedure Event_Redraw()
   If _CurrAngle >= 360 : _CurrAngle = 0 : Else : _CurrAngle + 1 : EndIf 
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor(RGBA(255, 255, 255, 255))
      FillVectorOutput()
      VectorSourceColor(RGBA(255, 0, 128, 255))
      CenterX.d = GadgetWidth (#cvsScreen)/2
      CenterY.d = GadgetHeight(#cvsScreen)/2
      Radius.d  = 250
      Angle.d   = 6
      AddPathCircle(CenterX, CenterY, Radius) 
      StrokePath(1)  
      For k = 0 To 360/Angle-1 
         Distance.d = Radius * Sin(Radian(_CurrAngle+k*Angle))
         Radian.d   = Radian(k*Angle)
         X = Distance * Cos(Radian) 
         Y = Distance * Sin(Radian) 
         AddPathCircle(CenterX+X, CenterY+Y, 10)
         FillPath()
      Next 
      StopVectorDrawing()  
   EndIf 
EndProcedure

If OpenWindow(#winScreen, 0, 0, 800, 600, "图标绘制_几何运动2", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 800, 600)
   AddWindowTimer(#winScreen, #tmrScreen, 1)
   Event_Redraw()
   Repeat
      WinEvent = WaitWindowEvent() 
      Select WinEvent
         Case #PB_Event_CloseWindow : IsExitWindow = #True
         Case #PB_Event_Timer       : Event_Redraw()
      EndSelect
   Until IsExitWindow = #True
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 20
; FirstLine = 6
; Folding = -
; EnableXP