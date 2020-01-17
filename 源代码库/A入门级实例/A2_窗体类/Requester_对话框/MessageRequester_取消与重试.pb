;***********************************
;迷路仟整理 2019.03.15
;MessageRequester_取消与重试
;***********************************


Enumeration
   #winScreen
   #btnScreen
EndEnumeration


; 返回值
; #PB_MessageRequester_Yes    = 6
; #PB_MessageRequester_No     = 7  
; #PB_MessageRequester_Cancel = 2
; #PB_MessageRequester_Retry  = 4

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "MessageRequester_取消与重试", WindowFlags)

ButtonGadget(#btnScreen, 120, 100, 150, 035, "对话框-取消与重试") 

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         Select EventGadget() 
            Case #btnScreen 
               Result = MessageRequester("提示", "本次操作无效,请是否重试?", #MB_RETRYCANCEL)
               Debug Result
         EndSelect
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 11
; Folding = -
; EnableXP