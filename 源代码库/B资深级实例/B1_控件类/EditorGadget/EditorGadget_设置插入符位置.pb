;***********************************
;迷路仟整理 2019.01.17
;设置插入标位置
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
   #lblEditRow
   #txtEditRow
   #lblEditCol
   #txtEditCol  
   #btnScreen
EndEnumeration

#CFM_BACKCOLOR = $4000000  
#SCF_ALL = 4  

Procedure Editor_LocatePos(hGadget,Row, Col)  
   Pos    = SendMessage_(hGadget,#EM_LINEINDEX,Row-1,0)   ;获取行的首列位置
   Lenght = SendMessage_(hGadget,#EM_LINELENGTH, Pos, 0)  
   If Lenght >= Col-1  
      Pos + Col-1  
   EndIf  
   Range.CHARRANGE  
   Range\cpMin = Pos  
   Range\cpMax = Pos  
   SendMessage_(hGadget,#EM_EXSETSEL, 0, Range)  
EndProcedure  

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "设置插入标位置", WindowFlags)

EditorGadget (#rtxScreen, 005, 005, 390, 160)

Text$ = "PureBasic 是一个兼容性广泛的编程语言,"+#CRLF$+
        "支持 AmigaOS (680x0 和 PowerPC) 和 Windows计算机系统. "+#CRLF$+
        "这意味着同样的代码可以被编译为两种系统的本地代码而流畅运行."+#CRLF$+
        "没有象虚拟机和解释器那样的瓶颈,"+#CRLF$+
        "生成的代码是一个优化过的可执行程序."+#CRLF$+
        "外部库是充分优化了的汇编程序,"+#CRLF$+
        "每个程序非常快,"+#CRLF$+
        "命令常常比C/C++还快或等同。"
SetGadgetText(#rtxScreen, Text$)

TextGadget   (#lblEditRow, 140, 183, 020, 020, "行:")  
StringGadget (#txtEditRow, 160, 180, 030, 020, "3")  
TextGadget   (#lblEditCol, 200, 183, 020, 020, "行:")  
StringGadget (#txtEditCol, 220, 180, 030, 020, "1")  

ButtonGadget (#btnScreen, 150, 210, 100, 030, "查找")  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen  
            Row = Val(GetGadgetText(#txtEditRow))
            Col = Val(GetGadgetText(#txtEditCol))
            Editor_LocatePos(GadgetID(#rtxScreen),Row, Col) 
            SetActiveGadget(#rtxScreen) 
         EndIf  
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; FirstLine = 15
; Folding = 0
; EnableXP