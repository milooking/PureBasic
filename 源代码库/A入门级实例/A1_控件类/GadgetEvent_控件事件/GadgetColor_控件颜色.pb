;***********************************
;迷路仟整理 2019.01.21
;设置/获取控件颜色
;***********************************

Enumeration
   #winScreen
   #lblScreen
   #txtScreen
   #rtxScreen
EndEnumeration

;各种支持设置颜色的控件及颜色类型
; CalendarGadget()      : #PB_Gadget_BackColor,#PB_Gadget_FrontColor,#PB_Gadget_TitleBackColor,#PB_Gadget_TitleFrontColor,#PB_Gadget_GrayTextColor
; ContainerGadget()     : #PB_Gadget_BackColor 
; DateGadget()          : #PB_Gadget_BackColor,#PB_Gadget_FrontColor,#PB_Gadget_TitleBackColor,#PB_Gadget_TitleFrontColor,#PB_Gadget_GrayTextColor
; EditorGadget()        : #PB_Gadget_BackColor,#PB_Gadget_FrontColor
; ExplorerListGadget()  : #PB_Gadget_BackColor,#PB_Gadget_FrontColor,#PB_Gadget_LineColor
; ExplorerTreeGadget()  : #PB_Gadget_BackColor,#PB_Gadget_FrontColor,#PB_Gadget_LineColor
; HyperLinkGadget()     : #PB_Gadget_BackColor,#PB_Gadget_FrontColor,#PB_Gadget_LineColor
; ListViewGadget()      : #PB_Gadget_BackColor,#PB_Gadget_FrontColor
; ListIconGadget()      : #PB_Gadget_BackColor,#PB_Gadget_FrontColor
; MDIGadget()           : #PB_Gadget_BackColor
; ProgressBarGadget()   : #PB_Gadget_BackColor,#PB_Gadget_FrontColor
; ScrollAreaGadget()    : #PB_Gadget_BackColor
; SpinGadget()          : #PB_Gadget_BackColor,#PB_Gadget_FrontColor
; StringGadget()        : #PB_Gadget_BackColor,#PB_Gadget_FrontColor
; TextGadget()          : #PB_Gadget_BackColor,#PB_Gadget_FrontColor
; TreeGadget()          : #PB_Gadget_BackColor,#PB_Gadget_FrontColor

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 430, 250, "设置/获取控件颜色", WindowFlags)

TextGadget  (#lblScreen, 010, 010, 380, 015, "标签控件")
StringGadget(#txtScreen, 010, 030, 380, 020, "文本框控件")
EditorGadget(#rtxScreen, 010, 060, 380, 050)

SetGadgetText(#rtxScreen, "编辑框控件")

SetGadgetColor(#lblScreen, #PB_Gadget_BackColor,  RGB(255,255,225))
SetGadgetColor(#lblScreen, #PB_Gadget_FrontColor, RGB(255,0,225))

SetGadgetColor(#txtScreen, #PB_Gadget_BackColor,  RGB(255,225,255))
SetGadgetColor(#txtScreen, #PB_Gadget_FrontColor, RGB(0,0,225))

SetGadgetColor(#rtxScreen, #PB_Gadget_BackColor,  RGB(225,225,255))
SetGadgetColor(#rtxScreen, #PB_Gadget_FrontColor, RGB(225,0,0))


Debug "BackColor  = $" + Hex(GetGadgetColor(#rtxScreen, #PB_Gadget_BackColor),  #PB_Long)
Debug "FrontColor = $" + Hex(GetGadgetColor(#rtxScreen, #PB_Gadget_FrontColor), #PB_Long)


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 43
; FirstLine = 29
; Folding = -
; EnableXP