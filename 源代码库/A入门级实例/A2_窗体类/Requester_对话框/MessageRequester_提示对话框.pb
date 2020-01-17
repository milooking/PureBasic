;***********************************
;迷路仟整理 2019.01.24
;MessageRequester_提示对话框
;***********************************


Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
   #btnScreen3
   #btnScreen4
   #btnScreen5
   #btnScreen6
   #btnScreen7
   #btnScreen8
EndEnumeration


; 返回值
; #PB_MessageRequester_Yes    = 6
; #PB_MessageRequester_No     = 7  
; #PB_MessageRequester_Cancel = 2

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 500, 250, "提示对话框", WindowFlags)

ButtonGadget(#btnScreen1, 100, 030, 100, 035, "对话框-提示") 
ButtonGadget(#btnScreen2, 100, 080, 100, 035, "对话框-注意") 
ButtonGadget(#btnScreen3, 100, 130, 100, 035, "对话框-警告") 
ButtonGadget(#btnScreen4, 100, 180, 100, 035, "对话框-出错") 

ButtonGadget(#btnScreen5, 300, 030, 100, 035, "对话框-确认") 
ButtonGadget(#btnScreen6, 300, 080, 100, 035, "对话框-咨询") 
ButtonGadget(#btnScreen7, 300, 130, 100, 035, "对话框-询问") 
ButtonGadget(#btnScreen8, 300, 180, 100, 035, "对话框-警告") 

Text1$ = "我们的口号是什么? "+#LF$+"-- 没有驻牙! -- "
Text2$ = "我们的口号是[没有驻牙]! "
Text3$ = "我们的口号是不是[没有驻牙]? "
Text4$ = "我们的口号要修改为[没有驻牙]吗? "
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         Select EventGadget() 
            Case #btnScreen1 
               MessageRequester("提示", Text1$)
               
            Case #btnScreen2 
               MessageRequester("注意", Text1$, #PB_MessageRequester_Info)
               
            Case #btnScreen3
               MessageRequester("警告", Text1$, #PB_MessageRequester_Warning)
               
            Case #btnScreen4
               MessageRequester("出错", Text1$, #PB_MessageRequester_Error)               
               
            Case #btnScreen5 
               MessageRequester("确认", Text2$, #PB_MessageRequester_Ok)
               
            Case #btnScreen6
               Result = MessageRequester("咨询", Text3$, #PB_MessageRequester_YesNo)
               Debug "Result = " + Result
               
            Case #btnScreen7
               Result = MessageRequester("询问", Text4$, #PB_MessageRequester_YesNoCancel)
               Debug "Result = " + Result
               
            Case #btnScreen8
               Result = MessageRequester("询问", Text4$, #PB_MessageRequester_YesNoCancel|#PB_MessageRequester_Warning)
               Debug "Result = " + Result
                  
         EndSelect
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP