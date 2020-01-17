;***********************************
;迷路仟整理 2015.07.27
;平面绘图特效-涟漪效果
;***********************************

#WinScreen = 0
#cvsScreen = 0

Procedure DrawWaitting(Index, X, Y, R, FrontColor, BackColor)
   Radius1  = (Index-R*0/3) % R 
   Radius2  = (Index-R*1/3) % R
   Radius3  = (Index-R*2/3) % R
   Tesxt$ =  Str(Radius3)+","+Str(Radius2)+","+Str(Radius1)
  
   If Radius1 < Radius2 : Radius = Radius1 : Radius1 = Radius2 : Radius2 = Radius : EndIf 
   If Radius1 < Radius3 : Radius = Radius1 : Radius1 = Radius3 : Radius3 = Radius : EndIf 
   If Radius2 < Radius3 : Radius = Radius2 : Radius2 = Radius3 : Radius3 = Radius : EndIf 
   
   DrawingMode( #PB_2DDrawing_Gradient)
   BackColor(FrontColor)
   FrontColor(BackColor)
   CircularGradient(X, Y, R-5) : Circle(X, Y, Radius1)
   DrawingMode( #PB_2DDrawing_Default)  : Circle(X, Y, Radius1-5)
   DrawingMode( #PB_2DDrawing_Gradient) : Circle(X, Y, Radius2)
   DrawingMode( #PB_2DDrawing_Default)  : Circle(X, Y, Radius2-5)
   DrawingMode( #PB_2DDrawing_Gradient) : Circle(X, Y, Radius3)
   DrawingMode( #PB_2DDrawing_Default)  : Circle(X, Y, Radius3-5)
EndProcedure

Procedure DrawScreen(Index)
   For k = 1 To 1000
      If StartDrawing(CanvasOutput(#cvsScreen))
         Box(0, 0, 400-0, 300-0, $FFFFFFFF)
         DrawWaitting(k, 200, 150, 75, $D5497D, $FFFFFFFF)
         StopDrawing()
      EndIf
      Delay(50) 
   Next 
EndProcedure

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 300, "平面绘图特效-涟漪", WindowFlags)
CanvasGadget(#cvsScreen, 0, 0, 400, 300)


CreateThread(@DrawScreen(), 0)
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
; CursorPosition = 41
; Folding = 9
; EnableXP
; EnableUnicode