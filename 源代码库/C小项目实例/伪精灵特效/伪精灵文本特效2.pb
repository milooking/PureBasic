;***********************************
;迷路仟整理 2019.02.19
;伪精灵文本特效2
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
   LeaveX.f
   LeaveY.f
   EnterX.f 
   EnterY.f 
   Color.l
   Flags.l
EndStructure

Structure __MainScreenInfo
   Mode.l
   Index.l
   PartR1.l
   PartR2.l
EndStructure

Global NewList _ListSpirit.__SpiritInfo()
Global _Main.__MainScreenInfo

Procedure Filter_Callback(x, y, SourceColor, TargetColor)

   If SourceColor <> 0
      AddElement(_ListSpirit())
      With _ListSpirit()
         \Source\x = x
         \Source\y = y
         \Color = SourceColor
         \Flags = 0
         If X > _Main\PartR1 : \Flags = 1 : EndIf  
         If X > _Main\PartR2 : \Flags = 2 : EndIf  
      EndWith
      ProcedureReturn SourceColor
   Else 
      ProcedureReturn TargetColor
   EndIf 
EndProcedure


Procedure Redraw_SpecialEffect()
   Scale1.f = 0
   Scale2.f = 0
   Scale3.f = 0
   If StartDrawing(CanvasOutput(#cvsScreen))
      Box(000, 000, 500, 300, $000000)
      Select _Main\Mode
         Case 1
            DrawingMode(#PB_2DDrawing_CustomFilter)      
            CustomFilterCallback(@Filter_Callback())
            DrawAlphaImage(ImageID(#imgScreen), 0, 0, 0)
            ForEach _ListSpirit()
               With _ListSpirit()
                  Select \Flags
                     Case 0 : LeaveX = Random(0600, 500)-0650 : EnterX = Random(1100, 500)
                     Case 1 : LeaveX = Random(0800, 500)-0850 : EnterX = Random(0900, 500)
                     Case 2 : LeaveX = Random(1000, 500)-1050 : EnterX = Random(0700, 500)
                  EndSelect
                  LeaveY = Random(300)
                  EnterY = Random(300)
                  \LeaveX = LeaveX - \Source\x
                  \LeaveY = LeaveY - \Source\y 
                  \EnterX = EnterX - \Source\x
                  \EnterY = EnterY - \Source\y 
                  
               EndWith
             Next 
             Debug ListSize(_ListSpirit())
            _Main\Mode = 2
            
         Case 2
            _Main\Index + 1
            Scale1 = _Main\Index / 100
            Scale2 = (_Main\Index-05) / 100
            Scale3 = (_Main\Index-10) / 100
            If Scale1 < 0 : Scale1 = 0 : EndIf 
            If Scale2 < 0 : Scale2 = 0 : EndIf 
            If Scale3 < 0 : Scale3 = 0 : EndIf 
            ForEach _ListSpirit() 
               With _ListSpirit()
                  Select \Flags
                     Case 0
                        X = \Source\x + \LeaveX * Scale1 
                        Y = \Source\y + \LeaveY * Scale1
                     Case 1
                        X = \Source\x + \LeaveX * Scale2
                        Y = \Source\y + \LeaveY * Scale2 
                     Case 2
                        X = \Source\x + \LeaveX * Scale3 
                        Y = \Source\y + \LeaveY * Scale3
                  EndSelect
                  Box(X, Y, 1, 1, \Color)
               EndWith
            Next 
            If _Main\Index > 110 : _Main\Mode = 3 : EndIf 
            
         Case 3
            _Main\Index - 1
            Scale1 = (_Main\Index-10) / 100
            Scale2 = (_Main\Index-05) / 100
            Scale3 = (_Main\Index-00) / 100
            If Scale1 < 0 : Scale1 = 0 : EndIf 
            If Scale2 < 0 : Scale2 = 0 : EndIf 
            If Scale3 < 0 : Scale3 = 0 : EndIf 
            ForEach _ListSpirit() 
               With _ListSpirit()
                  Select \Flags
                     Case 0
                        X = \Source\x + \EnterX * Scale1 
                        Y = \Source\y + \EnterY * Scale1
                     Case 1
                        X = \Source\x + \EnterX * Scale2 
                        Y = \Source\y + \EnterY * Scale2
                     Case 2
                        X = \Source\x + \EnterX * Scale3 
                        Y = \Source\y + \EnterY * Scale3
                  EndSelect
                  Box(X, Y, 1, 1, \Color)
               EndWith
            Next 
            If _Main\Index < -10 : _Main\Mode = 2 : EndIf 
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
   DrawText(090, 080, "迷路仟")
   _Main\PartR1 = 90+TextWidth("迷")
   _Main\PartR2 = 90+TextWidth("迷路")
   StopDrawing()
EndIf


If OpenWindow(#winScreen, 0, 0, 500, 300, "伪精灵文本特效2", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
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
; CursorPosition = 150
; FirstLine = 126
; Folding = -
; EnableXP