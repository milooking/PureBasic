;***********************************
;迷路仟整理 2019.01.15
;Clipboard_剪切板
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
   #imgScreen
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 200, "Clipboard_剪切板", WindowFlags)

ButtonGadget(#btnScreen1, 150, 050, 120, 030, "复制文本到剪切板")
ButtonGadget(#btnScreen2, 150, 100, 120, 030, "复制图像到剪切板")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget  
         Select EventGadget()
            Case #btnScreen1
               Index+1
               SetClipboardText("欢迎使用[迷路PureBasic实例库工具] - " +Str(Index) + #LF$)
            Case #btnScreen2
               hImage = CreateImage(#imgScreen, 100, 100)
               If hImage   ;一张黄色的图像
                  StartDrawing(ImageOutput(#imgScreen))
                  Box(0, 0, 100, 100, RGB(255, 255, 000))
                  StopDrawing()
                  SetClipboardImage(#imgScreen)
               EndIf
         EndSelect
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP