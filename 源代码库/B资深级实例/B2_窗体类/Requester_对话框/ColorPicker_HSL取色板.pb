;***********************************
;迷路仟整理 2019.02.11
;ColorPicker_HSL取色板
;***********************************

Enumeration
   #winScreen
   #cvsGradient
   #cvsSpectrum
   #lblCurColor
   #lblColorR
   #lblColorG
   #lblColorB
   #txtCurColor
   #txtColorR
   #txtColorG
   #txtColorB

   #imgSpectrum
   #imgGradient
EndEnumeration

Structure __MainInfo
   Spectrum.l
   Index.l
   CurColor.l
   X.l
   Y.l
   IsDown.b
EndStructure

Global _Main.__MainInfo

_Main\Spectrum = $0000FF
_Main\CurColor = $0000FF
_Main\x = 255+10
_Main\y = 0+10
_Main\Index = 10



Procedure Create_Spectrum()
   If StartDrawing(ImageOutput(#imgSpectrum))
      Box(000, 000, 025, 256, _Main\Spectrum)
      DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)      
      BackColor ($FFFFFFFF)
      FrontColor($00FFFFFF)
      LinearGradient(0, 0, 0, 128)    
      Box(0, 0, 025, 128)
      BackColor ($00000000)
      FrontColor($FF000000)
      LinearGradient(0, 129, 0, 256)    
      Box(0, 129, 025, 128)      
      StopDrawing()
   EndIf 
EndProcedure

Procedure Redraw_Spectrum(Pos)
   If StartDrawing(CanvasOutput(#cvsSpectrum))
      Box(0, 0, 045, 276, $F0F0F0)
      DrawImage(ImageID(#imgSpectrum), 10, 10)
      If Pos >= 10 And Pos <= 255+10 
         _Main\CurColor = Point(30, Pos)
         _Main\Index = Pos
         SetGadgetColor(#lblCurColor, #PB_Gadget_BackColor, _Main\CurColor)
         SetGadgetText(#txtCurColor, "0x"+RSet(Hex(_Main\CurColor), 6, "0"))
         SetGadgetText(#txtColorR, Str(Red(_Main\CurColor)))
         SetGadgetText(#txtColorG, Str(Green(_Main\CurColor)))
         SetGadgetText(#txtColorB, Str(Blue(_Main\CurColor)))
      EndIf 
      DrawingMode(#PB_2DDrawing_Outlined)
      Box (10-1, 10-1, 25+2, 256+2, $808080)

      LineXY(10-2, _Main\Index-0, 10-6, _Main\Index-4, $000000)
      LineXY(10-2, _Main\Index-0, 10-6, _Main\Index+4, $000000)
      LineXY(10-8, _Main\Index-4, 10-6, _Main\Index-4, $000000)
      LineXY(10-8, _Main\Index+4, 10-6, _Main\Index+4, $000000)
      LineXY(10-9, _Main\Index-3, 10-9, _Main\Index+3, $000000)

      LineXY(34+2, _Main\Index-0, 34+6, _Main\Index-4, $000000)
      LineXY(34+2, _Main\Index-0, 34+6, _Main\Index+4, $000000)
      LineXY(34+8, _Main\Index-4, 34+6, _Main\Index-4, $000000)
      LineXY(34+8, _Main\Index+4, 34+6, _Main\Index+4, $000000)
      LineXY(34+9, _Main\Index-3, 34+9, _Main\Index+3, $000000)
      StopDrawing()
   EndIf 
EndProcedure

Procedure Event_cvsSpectrum()
   Select EventType()
      Case #PB_EventType_LeftButtonDown
         Y = GetGadgetAttribute(#cvsSpectrum, #PB_Canvas_MouseY)
         _Main\IsDown = #True
         If Y >= 10 And Y<=255+10
            Redraw_Spectrum(Y)
         EndIf 
      Case #PB_EventType_LeftButtonUp
         _Main\IsDown = #False
      Case #PB_EventType_MouseMove
         If _Main\IsDown = #True
            Y = GetGadgetAttribute(#cvsSpectrum, #PB_Canvas_MouseY)
            If Y >= 10 And Y<=255+10
               Redraw_Spectrum(Y)
            EndIf 
         EndIf 
   EndSelect
EndProcedure


Procedure Create_Gradient()
   If StartDrawing(ImageOutput(#imgGradient))
      Box(000, 000, 256, 256, $F0F0F0)
      For B = 0 To 255 Step 6
         Line(X, 0, 1, 256, RGB(255, 000, B)) : X+1
      Next 
      For R = 255 To 0 Step -6
         Line(X, 0, 1, 256, RGB(R, 000, 255)) : X+1
      Next 
      For G = 0 To 255 Step 6
         Line(X, 0, 1, 256, RGB(000, G, 255)) : X+1
      Next 
      For B = 255 To 0 Step -6
         Line(X, 0, 1, 256, RGB(000, 255, B)) : X+1
      Next 
      For R = 0 To 255 Step 6
         Line(X, 0, 1, 256, RGB(R, 255, 000)) : X+1
      Next 
      For G = 255 To 0 Step -6
         Line(X, 0, 1, 256, RGB(255, G, 000)) : X+1
      Next 
  
      ;上下透明度渐变
      DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)      
      BackColor ($00000000)
      FrontColor($FF808080)
      LinearGradient(0, 0, 0, 255)    
      Box(0, 0, 256, 256)
      StopDrawing()
   EndIf 
EndProcedure

Procedure Redraw_Gradient()
   If StartDrawing(CanvasOutput(#cvsGradient))
      Box(000, 000, 400, 400, $F0F0F0)
      DrawImage(ImageID(#imgGradient), 10, 10)
      ;取色点
      DrawingMode(#PB_2DDrawing_Outlined)      
      If _Main\x >= 10 And  _Main\x <= 255+10  And _Main\y >= 10 And _Main\y <= 255+10
         Circle(_Main\x, _Main\y, 08, $FFFFFF)
         Circle(_Main\x, _Main\y, 09, $000000)      
         _Main\Spectrum = Point(_Main\x, _Main\y)
      EndIf 
      StopDrawing()
      Create_Spectrum()
      Redraw_Spectrum(_Main\Index)
   EndIf 
EndProcedure

Procedure Event_cvsGradient()
   Select EventType()
      Case #PB_EventType_LeftButtonDown
         X = GetGadgetAttribute(#cvsGradient, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsGradient, #PB_Canvas_MouseY)
         If X >= 10 And X <= 255+10 : _Main\X = X : EndIf 
         If Y >= 10 And Y <= 255+10 : _Main\Y = Y : EndIf 
         _Main\IsDown = #True
         Redraw_Gradient()
      Case #PB_EventType_LeftButtonUp
         _Main\IsDown = #False
         
      Case #PB_EventType_MouseMove
         If _Main\IsDown = #True
            X = GetGadgetAttribute(#cvsGradient, #PB_Canvas_MouseX)
            Y = GetGadgetAttribute(#cvsGradient, #PB_Canvas_MouseY)
            If X >= 10 And X <= 255+10 : _Main\X = X : EndIf 
            If Y >= 10 And Y <= 255+10 : _Main\Y = Y : EndIf 
            Redraw_Gradient()
         EndIf 
   EndSelect
EndProcedure

CreateImage(#imgGradient, 256, 256)
CreateImage(#imgSpectrum, 025, 256)
Create_Gradient()
Create_Spectrum()

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 500, 286, "ColorPicker_HSL取色板", WindowFlags)
CanvasGadget(#cvsGradient, 005, 005, 276, 276, #PB_Canvas_ClipMouse) 
CanvasGadget(#cvsSpectrum, 290, 005, 045, 276, #PB_Canvas_ClipMouse) 
TextGadget  (#lblCurColor, 350, 010, 080, 030, "", #PB_Text_Border) 
StringGadget(#txtCurColor, 350, 050, 080, 020, "0x000000") 

TextGadget  (#lblColorR, 350, 085, 020, 020, "R:") 
StringGadget(#txtColorR, 370, 080, 060, 020, "0") 
TextGadget  (#lblColorG, 350, 110, 020, 020, "G:") 
StringGadget(#txtColorG, 370, 105, 060, 020, "0") 
TextGadget  (#lblColorB, 350, 135, 020, 020, "B:") 
StringGadget(#txtColorB, 370, 130, 060, 020, "0") 


Redraw_Gradient()
Redraw_Spectrum(0)
BindGadgetEvent(#cvsGradient, @Event_cvsGradient())
BindGadgetEvent(#cvsSpectrum, @Event_cvsSpectrum())

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 53
; FirstLine = 37
; Folding = H9
; EnableXP