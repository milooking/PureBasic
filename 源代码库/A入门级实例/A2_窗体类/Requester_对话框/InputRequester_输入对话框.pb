;***********************************
;迷路仟整理 2019.01.24
;FontRequester_字体对话框
;***********************************


#winScreen = 0
#btnScreen = 1
#lblScreen = 2

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 500, 250, "输入对话框:点击控件可以输入内容", WindowFlags)


TextGadget  (#lblScreen, 010, 100, 480, 020, "", #PB_Text_Border) 
ButtonGadget(#btnScreen, 200, 130, 100, 030, "对话框") 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen 
           Input$ = InputRequester("心愿窗口", "我们的口号是什么? ", "没有驻牙!")
           If Input$
               SetGadgetText(#lblScreen, Input$)
           EndIf
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; FirstLine = 9
; EnableXP