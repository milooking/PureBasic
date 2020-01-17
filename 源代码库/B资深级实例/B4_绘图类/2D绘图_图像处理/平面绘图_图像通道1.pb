;***********************************
;迷路仟整理 2019.02.06
;平面绘图_图像通道1(纯通道模式)
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #chkAlphaR
   #chkAlphaG
   #chkAlphaB
   #imgScreen
EndEnumeration

Structure __MainScreen
   R.b
   G.b
   B.b
   Mode.b
EndStructure

Global _Main.__MainScreen

Procedure Filter_Callback(x, y, SourceColor, TargetColor)
   If _Main\R = #True : R = Red  (SourceColor) : EndIf 
   If _Main\G = #True : G = Green(SourceColor) : EndIf 
   If _Main\B = #True : B = Blue (SourceColor) : EndIf 
   ProcedureReturn RGB(R,G,B)
EndProcedure

Procedure Window_RadowingScreen()
   If StartDrawing(CanvasOutput(#cvsScreen))
      Box(0, 0, 400, 250, $FFFFFFFF)
      DrawingMode(#PB_2DDrawing_CustomFilter)      
      CustomFilterCallback(@Filter_Callback())
      DrawImage(ImageID(#imgScreen), 0, 0)
      StopDrawing()
   EndIf
EndProcedure

hImage = LoadImage(#imgScreen, "..\Background.bmp")
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 480, 250, "平面绘图_图像通道1", WindowFlags)
CanvasGadget(#cvsScreen, 000, 000, 400, 250)
CheckBoxGadget(#chkAlphaR, 410, 020, 060, 020, "R通道")
CheckBoxGadget(#chkAlphaG, 410, 040, 060, 020, "G通道")
CheckBoxGadget(#chkAlphaB, 410, 060, 060, 020, "B通道")

_Main\R = #True 
_Main\G = #True 
_Main\B = #True 
SetGadgetState(#chkAlphaR, #True)
SetGadgetState(#chkAlphaG, #True)
SetGadgetState(#chkAlphaB, #True)
Window_RadowingScreen()

Repeat
   EventNum  = WindowEvent()
   GadgetID  = EventGadget()
   EventType = EventType()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_SizeWindow 
      Case #PB_Event_Gadget 
         Select EventGadget()
            Case #chkAlphaR : _Main\R = GetGadgetState(#chkAlphaR) : Window_RadowingScreen()
            Case #chkAlphaG : _Main\G = GetGadgetState(#chkAlphaG) : Window_RadowingScreen()
            Case #chkAlphaB : _Main\B = GetGadgetState(#chkAlphaB) : Window_RadowingScreen()
         EndSelect
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP
; EnableUnicode