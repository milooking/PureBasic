;***********************************
;迷路仟整理 2019.02.09
;矢量几何_波浪线演示
;***********************************


Enumeration
   #winScreen
   #cvsScreen
EndEnumeration

Structure __WaveInfo
   WaveStart.Point
   WaveToEnd.Point
EndStructure

Global Dim _DimWave.__WaveInfo(5)
Global Dim _DimPoint.point(5)


Procedure Drawing_Wave(X, Y, Index, Count, Color)
   Factor.f =Index/Count
   For i=0 To 3
      _DimPoint(i)\X = X+_DimWave(i)\WaveStart\x + _DimWave(i)\WaveToEnd\x * Factor
      _DimPoint(i)\Y = Y+_DimWave(i)\WaveStart\y + _DimWave(i)\WaveToEnd\y * Factor
   Next 
   MovePathCursor(_DimPoint(0)\x,_DimPoint(0)\y)
   AddPathCurve(_DimPoint(1)\x,_DimPoint(1)\y,_DimPoint(2)\x,_DimPoint(2)\y,_DimPoint(3)\x,_DimPoint(3)\y)
   VectorSourceColor(Color)
   StrokePath(1)
EndProcedure



hWindow = OpenWindow(#winScreen, 0, 0, 800, 350, "矢量几何_波浪线演示", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
CanvasGadget(#cvsScreen, 0, 0, 800, 350)
StartVectorDrawing(CanvasVectorOutput(#cvsScreen))

   ;绘制波浪线
   CopyMemory(?_BIN_Wave1, _DimWave(), 4*4*4)
   For i = 0 To 100
      Drawing_Wave(000, 000, i, 100, $10F9AA48)
   Next i
   
   ;加阴影
   CopyMemory(?_BIN_Wave2, _DimWave(), 4*4*4)
   For i = 0 To 050
      Drawing_Wave(000, 000, i, 050, $20F69924)
   Next
   
   
   ;绘制波浪线
   CopyMemory(?_BIN_Wave1, _DimWave(), 4*4*4)
   For i = 0 To 100
      Drawing_Wave(000, 150, i, 100, $101EDF76)
   Next i
   
   ;加阴影
   CopyMemory(?_BIN_Wave2, _DimWave(), 4*4*4)
   For i = 0 To 050
      Drawing_Wave(000, 150, i, 050, $2010D070)
   Next
   
StopVectorDrawing() 
Repeat
   WinEvent = WaitWindowEvent() 
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
         
   EndSelect    
Until IsExitWindow = #True

End

DataSection
   _BIN_Wave1:
      Data.l  100,100,020,050, 300,-100,050,000, 500,300,000,-15, 700,100,050,-50
   _BIN_Wave2:
      Data.l  100,100,-20,010, 300,-100,010,-30, 500,300,020,-35, 700,100,-50,050
EndDataSection

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 31
; FirstLine = 21
; Folding = -
; EnableXP