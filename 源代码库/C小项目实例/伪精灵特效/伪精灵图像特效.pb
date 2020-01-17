;***********************************
;迷路仟整理 2019.02.19
;伪精灵文本特效
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #imgScreen
   #tmrScreen
EndEnumeration

Structure __SpiritInfo
   Source.Point
   Target.Point
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

   If Alpha(SourceColor) 
      Color = AlphaBlend(SourceColor, TargetColor)
      AddElement(_ListSpirit())
      _ListSpirit()\Source\x = x
      _ListSpirit()\Source\y = y
      _ListSpirit()\Color = Color
      ProcedureReturn  Color
   Else 
      ProcedureReturn TargetColor
   EndIf 
EndProcedure


Procedure Redraw_SpecialEffect()

   If StartDrawing(CanvasOutput(#cvsScreen))
      Box(000, 000, 500, 300, $000000)
      Select _Main\Mode
         Case 1
            DrawingMode(#PB_2DDrawing_CustomFilter)      
            CustomFilterCallback(@Filter_Callback())
            DrawAlphaImage(ImageID(#imgScreen), 100, 005)
            ForEach _ListSpirit()
               With _ListSpirit()
                  \Target\x = Random(1000-1)-250
                  \Target\y = Random(800-1)-250
                  \OffsetX = \Target\x - \Source\x
                  \OffsetY = \Target\y - \Source\y 
               EndWith
             Next 
             Debug ListSize(_ListSpirit())
            _Main\Mode = 2
;             
         Case 2
            _Main\Index + 1 : Index = _Main\Index
            If _Main\Index >= 100 : Index = 100 : _Main\Mode = 3 : EndIf 
            
            ForEach _ListSpirit() 
               With _ListSpirit()
                  X = \Source\x + \OffsetX * Index / 100
                  Y = \Source\y + \OffsetY * Index / 100
                  Box(X, Y, 1, 1, \Color)
               EndWith
            Next 

         Case 3
            _Main\Index - 1 : Index = _Main\Index
            If _Main\Index <= 0 : Index = 0        : EndIf 
            If _Main\Index <= -20 : _Main\Mode = 2 : _Main\Index = 0 : EndIf 
            ForEach _ListSpirit() 
               With _ListSpirit()
                  X = \Source\x + \OffsetX * Index / 100
                  Y = \Source\y + \OffsetY * Index / 100
                  Box(X, Y, 1, 1, \Color)
               EndWith
            Next 
      EndSelect
      StopDrawing()
   EndIf
EndProcedure

UsePNGImageDecoder()
LoadImage(#imgScreen, "Apple.png")

If OpenWindow(#winScreen, 0, 0, 500, 300, "伪精灵文本特效", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 300)
   _Main\Mode = 1
   Redraw_SpecialEffect()
   AddWindowTimer(#winScreen, #tmrScreen, 50)
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
; CursorPosition = 37
; FirstLine = 15
; Folding = -
; EnableXP