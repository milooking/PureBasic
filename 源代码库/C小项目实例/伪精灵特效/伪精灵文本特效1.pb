;***********************************
;迷路仟整理 2019.02.19
;伪精灵文本特效1
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #fntScreen
   #imgScreen
   #tmrScreen
EndEnumeration

Structure __SpiritInfo
   Source.Point
   OffsetX.f
   OffsetY.f
   Color.l
EndStructure

Structure __MainScreenInfo
   Mode.l
   Index.l
EndStructure

Global NewList _ListSpirit.__SpiritInfo()
Global _Main.__MainScreenInfo

Procedure Filter_Callback(x, y, SourceColor, TargetColor)

   If SourceColor <> 0
      AddElement(_ListSpirit())
      _ListSpirit()\Source\x = x
      _ListSpirit()\Source\y = y
      _ListSpirit()\Color = SourceColor
      ProcedureReturn SourceColor
   Else 
      ProcedureReturn TargetColor
   EndIf 
EndProcedure


Procedure Redraw_SpecialEffect()
   Index.f = 0
   If StartDrawing(CanvasOutput(#cvsScreen))
      Box(000, 000, 500, 300, $000000)
      Select _Main\Mode
         Case 1
            DrawingMode(#PB_2DDrawing_CustomFilter)      
            CustomFilterCallback(@Filter_Callback())
            DrawAlphaImage(ImageID(#imgScreen), 0, 0, 0)
            ForEach _ListSpirit()
               With _ListSpirit()
                  TargetX = Random(800-1)-150
                  TargetY = Random(600-1)-150
                  \OffsetX = TargetX - \Source\x
                  \OffsetY = TargetY - \Source\y 
               EndWith
             Next 
             Debug ListSize(_ListSpirit())
            _Main\Mode = 2
            
         Case 2
            _Main\Index + 1 : Index = _Main\Index
            If _Main\Index >= 100 : Index = 100 : _Main\Mode = 3 : EndIf 
            Index / 100
            ForEach _ListSpirit() 
               With _ListSpirit()
                  X = \Source\x + \OffsetX * Index
                  Y = \Source\y + \OffsetY * Index
                  Box(X, Y, 1, 1, \Color)
               EndWith
            Next 

         Case 3
            _Main\Index - 1 : Index = _Main\Index
            If _Main\Index <= 0 : Index = 0        : EndIf 
            If _Main\Index <= -20 : _Main\Mode = 2 : _Main\Index = 0 : EndIf 
            Index / 100
            ForEach _ListSpirit() 
               With _ListSpirit()
                  X = \Source\x + \OffsetX * Index
                  Y = \Source\y + \OffsetY * Index
                  Box(X, Y, 1, 1, \Color)
               EndWith
            Next 
      EndSelect
      StopDrawing()
   EndIf
EndProcedure

hFont = LoadFont(#fntScreen, "宋体", 80)
CreateImage(#imgScreen, 500, 300, 32)
If StartDrawing(ImageOutput(#imgScreen))
   DrawingMode(#PB_2DDrawing_AllChannels)  
   Box(000, 000, 500, 300, 0)
   DrawingFont(FontID(#fntScreen))
   DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_Transparent)  
   BackColor($0000FF)            ;前景色
   GradientColor(0.3, $00FFFF)   ;渐变插值
   GradientColor(0.7, $FF00FF)   ;渐变插值
   FrontColor($FFFF00)           ;背景色
   LinearGradient(080, 000, 420, 000)  
   DrawText(090, 080, "迷路仟", $0080FF)
   StopDrawing()
EndIf


If OpenWindow(#winScreen, 0, 0, 500, 300, "伪精灵文本特效1", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 300)
   _Main\Mode = 1
   Redraw_SpecialEffect()
   AddWindowTimer(#winScreen, #tmrScreen, 30)
   Repeat
      WinEvent = WaitWindowEvent() 
      Select WinEvent
         Case #PB_Event_CloseWindow : IsExitWindow = #True
         Case #PB_Event_Timer       : Redraw_SpecialEffect()
      EndSelect
   Until IsExitWindow = #True 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 101
; FirstLine = 79
; Folding = -
; EnableXP