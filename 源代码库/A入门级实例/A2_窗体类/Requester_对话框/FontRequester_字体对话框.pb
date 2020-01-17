;***********************************
;迷路仟整理 2019.01.24
;FontRequester_字体对话框
;***********************************


#winScreen = 0
#cvsScreen = 1
#fntScreen = 2

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 500, 250, "字体对话框:点击控件可以修改字体", WindowFlags)

CanvasGadget(#cvsScreen,010, 010, 480, 230) 
If StartDrawing(CanvasOutput(#cvsScreen))
   DrawText(010,010, "欢迎使用PureBasic", $FF00FF, $FFFFFF)
   StopDrawing()
EndIf 
FontName$ = ""
FontSize  = 9
FontColor = $FF00FF
FontStyle = 0
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #cvsScreen And EventType() = #PB_EventType_LeftClick
           Result = FontRequester(FontName$, FontSize, #PB_FontRequester_Effects, FontColor, FontStyle)
           If Result
               If IsFont(#fntScreen) : FreeFont(#fntScreen) : EndIf 
               FontName$ = SelectedFontName()
               FontSize  = SelectedFontSize() 
               FontColor = SelectedFontColor() 
               FontStyle = SelectedFontStyle() 
               hFont = LoadFont(#fntScreen, FontName$, FontSize, FontStyle)
               If StartDrawing(CanvasOutput(#cvsScreen))
                  Box(000,000,480,250,$FFFFFF)
                  DrawingFont(hFont)
                  DrawText(010,010, "欢迎使用PureBasic", FontColor, $FFFFFF)
                  StopDrawing()
               EndIf 

           EndIf
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; EnableXP