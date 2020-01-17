;***********************************
;迷路仟整理 2019.01.24
;CustomDashPath_自定义样式
;***********************************

#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 400, 250, "CustomDashPath_自定义样式", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
   
      MovePathCursor(40, 50)
      For i = 1 To 4                               ;画一段路径
         AddPathLine(80, 0, #PB_Path_Relative)
         AddPathLine(0, 40, #PB_Path_Relative)
      Next i
      
      VectorSourceColor(RGBA(255, 0, 0, 255))
      
      Dim DimStyle.d(7)
      DimStyle(0) = 20     ;线
      DimStyle(1) = 10     ;空
      DimStyle(2) = 00     ;点
      DimStyle(3) = 10     ;空
      DimStyle(4) = 00     ;点
      DimStyle(5) = 10     ;线
      DimStyle(6) = 20     ;空
      DimStyle(7) = 10     ;线
      CustomDashPath(5, DimStyle())

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; EnableXP