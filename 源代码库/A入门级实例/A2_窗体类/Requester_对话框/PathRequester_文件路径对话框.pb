;***********************************
;迷路仟整理 2019.01.24
;PathRequester_文件路径对话框
;***********************************


#winScreen = 0
#btnScreen = 1
#txtScreen = 2

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 500, 250, "文件路径对话框", WindowFlags)

StringGadget(#txtScreen, 010, 100, 480, 020, "") 
ButtonGadget(#btnScreen, 200, 130, 100, 030, "选择路径") 

FilePath$ = "C:\"
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen 
            TempPath$ = PathRequester("请选择文件夹", FilePath$)
            If TempPath$
               FilePath$ = TempPath$
               SetGadgetText(#txtScreen, TempPath$)
            EndIf
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; EnableXP