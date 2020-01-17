;***********************************
;迷路仟整理 2019.01.24
;SaveFileRequester_保存文件对话框
;***********************************


#winScreen = 0
#btnScreen = 1
#txtScreen = 2

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 500, 250, "保存文件对话框", WindowFlags)

StringGadget(#txtScreen, 010, 100, 480, 020, "") 
ButtonGadget(#btnScreen, 200, 130, 100, 030, "保存文件") 

FileName$ = ""
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen 
            Pattern$ = "PureBasic源代码 (*.pb)"
            TempName$ = SaveFileRequester("请选择要保存的文件", FileName$, Pattern$, 0)
            If TempName$
               If LCase(GetExtensionPart(TempName$)) <> "pb" ;判断后辍是不是PB
                  TempName$+".pb"
               EndIf 
               FileName$ = TempName$
               SetGadgetText(#txtScreen, FileName$)
            EndIf
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; FirstLine = 12
; EnableXP