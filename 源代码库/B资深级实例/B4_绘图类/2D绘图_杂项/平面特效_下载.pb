;***********************************
;迷路仟整理 2015.07.27
;平面绘图特效-涟漪效果
;***********************************

#WinScreen = 0
#cvsScreen = 0

Procedure DrawWaitting(Index, X, Y, FrontColor, BackColor)

   DrawingMode( #PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)

   BackColor (BackColor|$AA000000)
   FrontColor(BackColor|$FF000000)
   LinearGradient(X+310, Y+000, X+390+10, Y+51+10)
   RoundBox(X+310, Y+000, 30+10, 51+10, 3, 3)
   
   LinearGradient(X+000, Y+005, X+48+10, Y+30+12)
   RoundBox(X+000, Y+005, 48+10, 30+12, 3, 3)
   

   LinearGradient(X+005+48/2-5, Y+35+12, X+005+48/2-5+10, Y+30+12+10)
   Box(X+005+48/2-5, Y+35+12, 10, 10)
   Ellipse(X+005+48/2, Y+35+22, 22, 5) 

   DrawingMode( #PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)
   BackColor (FrontColor|$80000000)
   FrontColor(FrontColor|$FF000000)
   LinearGradient(X+310, Y+000, X+290+10, Y+51+10)
   Box(X+315, Y+005, 30, 51)
   
   LinearGradient(X+000, Y+005, X+48+10, Y+30+12)
   Box(X+005, Y+010, 48, 30)

   DrawingMode( #PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)
   Index = Index % 50
   Pos.f = 1-Index/50
   BackColor(FrontColor|$FF000000)   
   GradientColor(Pos, $FF00FA2C)
   FrontColor(FrontColor|$FF000000)
   LinearGradient(X+85-100, X+85, X+85+200+200, X+85)
   For K = X+85 To X+85+200 Step 25
      Circle(K, Y+20+12, 5) 
   Next 
EndProcedure


Procedure DrawScreen(Index)
   For k = 1 To 1000
      If StartDrawing(CanvasOutput(#cvsScreen))
         Box(0, 0, 600-0, 300-0, $FFFFFFFF)
         DrawWaitting(k, 050, 150-60, $FF8000, $404039)
         StopDrawing()
      EndIf
      Delay(20) 
   Next 
EndProcedure

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 600, 300, "平面绘图特效-下载", WindowFlags)
CanvasGadget(#cvsScreen, 0, 0, 600, 300)


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
; CursorPosition = 4
; Folding = -
; EnableXP
; EnableUnicode