;***********************************
;迷路仟整理 2019.04.13
;图标绘制_几何运动1
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
      CenterX = GadgetWidth (#cvsScreen)/2
      CenterY = GadgetHeight(#cvsScreen)/2

      Radius  = 250
      AddPathCircle(CenterX, CenterY, Radius) 
      Length.f = PathLength()
      StrokePath(1)  

      Radian.d = Radian(_CurrAngle)
      X = CenterX + Radius * Cos(Radian)
      Y = CenterY ; Radius * Sin(Radian)
      AddPathCircle(X, Y, 10)
      FillPath()

      X = CenterX + Radius/2 * Cos(Radian)
      Y = CenterY + Radius/2 * Sin(Radian)
      AddPathCircle(X, Y, Radius/2)
      StrokePath(1)

      StopVectorDrawing()  

   EndIf 
EndProcedure


If OpenWindow(#winScreen, 0, 0, 800, 600, "图标绘制_几何运动1", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
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
; CursorPosition = 46
; FirstLine = 19
; Folding = -
; EnableXP