;***********************************
;迷路仟整理 2019.04.13
;图标绘制_几何运动2
;***********************************

#winScreen = 0
#cvsScreen = 0
#tmrScreen = 0

Global Dim _DimAngle(12)

Procedure Event_Redraw()

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

      For k = 0 To 11
         If _DimAngle(k) >= 360 : _DimAngle(k) = 0 : Else : _DimAngle(k) + 1 : EndIf 
         RotateCoordinates(CenterX, CenterY, 15)
         Radian.d = Radian(_DimAngle(k))
         X = CenterX + Radius * Cos(Radian)
         Y = CenterY ; Radius * Sin(Radian)
         AddPathCircle(X, Y, 10)
         FillPath()
      Next 
      StopVectorDrawing()  

   EndIf 
EndProcedure

For k = 1 To 11
   _DimAngle(k) = _DimAngle(k-1) + 15
Next 
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
; CursorPosition = 2
; Folding = -
; EnableXP