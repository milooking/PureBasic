;***********************************
;迷路仟整理 2019.01.17
;光标位置信息
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
   #lblScreen
EndEnumeration

Procedure Editor_GetCursorPos()  
   hGadget =  GadgetID(#rtxScreen)
   SendMessage_(hGadget,#EM_EXGETSEL,0,Range.CHARRANGE)  
   Row = SendMessage_(hGadget,#EM_EXLINEFROMCHAR,0,Range\cpMin)    ;获取行号
   Pos = SendMessage_(hGadget,#EM_LINEINDEX, Row, 0)               ;获取行的首列位置
   Col = Range\cpMax-Pos+1
   Pos = Range\cpMax
   Text$ =  "行: " + Str(Row) + " 列: "+ Str(Col) + " 位置: " + Str(Pos) 
   SetGadgetText(#lblScreen, Text$)
EndProcedure  

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "光标位置信息", WindowFlags)

EditorGadget (#rtxScreen, 005, 005, 390, 200)
SetGadgetText(#rtxScreen, "PureBasic 5.62版本"+#CRLF$+"欢迎使用[迷路PureBasic实例库工具]")
TextGadget   (#lblScreen, 100, 210, 200, 020, "")  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #WM_LBUTTONDOWN, #WM_MOUSEMOVE, #PB_Event_Gadget
         If EventGadget() = #rtxScreen  
            Editor_GetCursorPos() 
            Debug "xxxxxxxxxxx" 
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = 0
; EnableXP