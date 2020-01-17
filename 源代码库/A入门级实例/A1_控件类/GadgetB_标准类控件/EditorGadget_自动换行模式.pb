;***********************************
;迷路仟整理 2019.01.17
;自动换行模式
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
   #chkScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "自动换行模式", WindowFlags)

CheckBoxGadget(#chkScreen, 150, 180, 100, 030, "自动换行")
EditorGadget(#rtxScreen, 005, 005, 390, 120)

Text$ = "PureBasic 是一个兼容性广泛的编程语言,支持 AmigaOS (680x0 和 PowerPC) 和 Windows计算机系统. "+
        "这意味着同样的代码可以被编译为两种系统的本地代码而流畅运行.没有象虚拟机和解释器那样的瓶颈,"+
        "生成的代码是一个优化过的可执行程序.外部库是充分优化了的汇编程序,每个程序非常快,"+
        "命令常常比C/C++还快或等同。"
SetGadgetText(#rtxScreen, Text$)


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #chkScreen
            If GetGadgetState(#chkScreen)
               SetGadgetAttribute(#rtxScreen, #PB_Editor_WordWrap, #True)
            Else 
               SetGadgetAttribute(#rtxScreen, #PB_Editor_WordWrap, #False)
            EndIf 
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP