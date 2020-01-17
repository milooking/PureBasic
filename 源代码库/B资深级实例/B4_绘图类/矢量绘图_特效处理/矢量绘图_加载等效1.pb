;***********************************
;迷路仟整理 2019.01.15
;矢量绘图_加载等效1
;***********************************

#WinScreen = 0
#imgScreen = 1
#imgOutput = 2
#fntOutput = 3

#TIME_KILL_SYNCHRONOUS = $0100
#LineWidth = 10

LoadFont(#fntOutput, "", 12, #PB_Font_Bold)
Global Displaydot$ = #Empty$

Procedure Timer_Pulse(TimerID, uMsg, dwUser, dw1, dw2)
   Shared Progress.d, x.d, y.d
   CopyImage(#imgScreen, #imgOutput)
   Text$ = "加载中"+Displaydot$
   If StartVectorDrawing(ImageVectorOutput(#imgOutput))
      VectorFont(FontID(#fntOutput))
      VectorSourceColor(RGBA(128, 0, 255, 255))
      MovePathCursor(62,90)
      DrawVectorText(Text$)
      FillPath()
      
      VectorSourceLinearGradient(0,0,200,200)
      VectorSourceGradientColor(RGBA(255, 0, 0, 255), 0.0)
      VectorSourceGradientColor(RGBA(255, 255, 0, 255), 1.0)
      
      AddPathCircle(100, 100, 60, -90, Progress)
      
      Angle.d = PathPointAngle(PathLength())+90    
      x.d=PathCursorX()
      y.d=PathCursorY()
      
      StrokePath(#LineWidth)
      
      If Progress < 269 
         RotateCoordinates(x,y,Angle)
         MovePathCursor(x-#LineWidth,y)
         AddPathLine(x,y-#LineWidth*2)
         AddPathLine(x+#LineWidth,y)
         ClosePath()
         FillPath()
      EndIf
      StopVectorDrawing()
      Progress + 0.1
    
   EndIf
  
   hWindowDC = StartDrawing(ImageOutput(#imgOutput))
   If hWindowDC
      Size.SIZE
      Size\cx = ImageWidth (#imgOutput)
      Size\cy = ImageHeight(#imgOutput)
      ContextOffset.POINT
      BlendMode.BLENDFUNCTION
      BlendMode\SourceConstantAlpha = 255
      BlendMode\AlphaFormat = 1
      UpdateLayeredWindow_(WindowID(#WinScreen), 0, 0, Size, hWindowDC, ContextOffset, 0, BlendMode, 2)
      StopDrawing()
   EndIf
  
EndProcedure

Procedure GetShowDots(void)
   Repeat
      Delay(400): Displaydot$ = "" 
      Delay(400): Displaydot$ = "."
      Delay(100): Displaydot$= ".."
      Delay(100): Displaydot$= "..."
      Delay(100): Displaydot$="...."
   ForEver
EndProcedure

Flags = #PB_Window_BorderLess|#PB_Window_ScreenCentered|#PB_Window_Invisible
hWindow = OpenWindow(#WinScreen,0,0,200,200,"矢量绘图_加载等效1", Flags)
   SetWindowLongPtr_(hWindow, #GWL_EXSTYLE, #WS_EX_LAYERED|#WS_EX_TOOLWINDOW)
   StickyWindow(#WinScreen, 1)
   CreateImage(#imgScreen, 200,200, 32, $FFFFFFFF)
   
   Progress.d = -90.0 
   TimerID = timeSetEvent_(2, 1, @Timer_Pulse(), 0, #TIME_PERIODIC|#TIME_KILL_SYNCHRONOUS)
   HideWindow(#WinScreen, #False)
   ThreadID = CreateThread(@GetShowDots(),0)
   
   Repeat 
      WaitWindowEvent(1) 
   Until Progress > 270.0
   
   timeKillEvent_(TimerID)
   KillThread(ThreadID)
   WaitThread(ThreadID)
End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 37
; FirstLine = 29
; Folding = -
; EnableXP