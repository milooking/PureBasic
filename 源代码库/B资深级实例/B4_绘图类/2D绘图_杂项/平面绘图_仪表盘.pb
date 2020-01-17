;***********************************
;迷路仟整理 2019.02.20
;平面绘图_仪表盘
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #trkScreen
EndEnumeration


Procedure Window_RedowingScreen(Angle.f)
   If StartDrawing(CanvasOutput(#cvsScreen))
      W  = GadgetWidth(#cvsScreen)
      H = GadgetHeight(#cvsScreen)
      Box(0,0,W,H,$FFFFFF)
      
      For i = 0 To 720 Step 20
         X1 = W*0.5+Sin((i-360)/270)*(W*0.40)
         Y1 = H*0.8-Cos((i-360)/270)*(H*0.40)
         X2 = W*0.5+Sin((i-360)/270)*(W*0.45)
         Y2 = H*0.8-Cos((i-360)/270)*(H*0.45)       
         LineXY(X1, Y1, X2, Y2, $808080)
      Next
      LineXY(W*0.5,H*0.8,W*0.5+Sin(Angle/270)*(W*0.4),H*0.8-Cos(Angle/270)*(H*0.4),$0000FF)
      Circle(W*0.5,H*0.8, 3, $0000FF)
      StopDrawing()
   EndIf
EndProcedure


Procedure EventGadget_trkScreen()
   Angle = GetGadgetState(#trkScreen) - 360
   Window_RedowingScreen(Angle)
EndProcedure


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 400, "平面绘图_仪表盘", WindowFlags)
CanvasGadget  (#cvsScreen, 000, 000, 400, 350)
TrackBarGadget(#trkScreen, 020, 365, 360, 020, 000, 720) 
SetGadgetState(#trkScreen, 360)
Window_RedowingScreen(0)
BindGadgetEvent(#trkScreen, @EventGadget_trkScreen())
Repeat
   EventNum  = WindowEvent()
   GadgetID  = EventGadget()
   EventType = EventType()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_SizeWindow 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP
; EnableUnicode