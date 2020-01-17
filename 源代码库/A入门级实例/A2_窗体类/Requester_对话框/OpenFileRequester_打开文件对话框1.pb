;***********************************
;迷路仟整理 2019.01.24
;OpenFileRequester_打开文件对话框-单文件
;***********************************


#winScreen = 0
#btnScreen = 1
#txtScreen = 2

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 500, 250, "打开文件对话框-单文件", WindowFlags)


StringGadget(#txtScreen, 010, 100, 480, 020, "") 
ButtonGadget(#btnScreen, 200, 130, 100, 030, "打开文件") 


FileName$ = ""
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen 
            Pattern$ = "文本文件 (*.txt)|*.txt;*.bat|PureBasic源代码 (*.pb)|*.pb|所有文件类型 (*.*)|*.*"
            Pattern = 0    ; 默认选择第一个
            TempFile$ = OpenFileRequester("请选择要打开的文件", FileName$, Pattern$, Pattern)
            If TempFile$
               FileName$ = TempFile$
               SetGadgetText(#txtScreen, FileName$)
            EndIf
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 34
; FirstLine = 14
; EnableXP