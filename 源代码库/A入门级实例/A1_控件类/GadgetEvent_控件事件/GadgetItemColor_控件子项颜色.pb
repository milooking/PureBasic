;***********************************
;迷路仟整理 2019.01.21
;设置/获取控件子项颜色
;***********************************

Enumeration
   #winScreen
   #tvwScreen
   #lstScreen
EndEnumeration

;各种支持设置颜色的控件及颜色类型
; ListIconGadget()      : #PB_Gadget_BackColor,#PB_Gadget_FrontColor
; TreeGadget()          : #PB_Gadget_BackColor,#PB_Gadget_FrontColor

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 430, 250, "设置/获取控件子项颜色", WindowFlags)

TreeGadget    (#tvwScreen, 010, 10, 185, 230)                                        
ListIconGadget(#lstScreen, 205, 10, 185, 230, "内容", 100) 

For Row = 0 To 10
   AddGadgetItem(#tvwScreen, -1, "正常节点"+Str(Row), 0, 0) 
   AddGadgetItem(#tvwScreen, -1, "父节点 "+Str(Row), 0, 0)      
   AddGadgetItem(#tvwScreen, -1, "子节点 1", 0, 1)   
   AddGadgetItem(#tvwScreen, -1, "子节点 2", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子节点 3", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子节点 4", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "文件 "+Str(Row))
   AddGadgetItem(#lstScreen, Row, "子项-"+Str(Row))
   SetGadgetItemColor(#tvwScreen, Row*7, #PB_Gadget_BackColor,  RGB(Random(255,200),Random(255,200),Random(255,200)))
   SetGadgetItemColor(#tvwScreen, Row*7, #PB_Gadget_FrontColor, RGB(Random(100,000),Random(100,000),Random(100,000)))
   
   SetGadgetItemColor(#lstScreen, Row*1, #PB_Gadget_BackColor,  RGB(Random(255,200),Random(255,200),Random(255,200)))
   SetGadgetItemColor(#lstScreen, Row*1, #PB_Gadget_FrontColor, RGB(Random(100,000),Random(100,000),Random(100,000)))
Next

Debug "ItemBackColor  = $" + Hex(GetGadgetItemColor(#lstScreen, 5, #PB_Gadget_BackColor),  #PB_Long)
Debug "ItemFrontColor = $" + Hex(GetGadgetItemColor(#lstScreen, 5, #PB_Gadget_FrontColor), #PB_Long)


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
; CursorPosition = 19
; Folding = -
; EnableXP