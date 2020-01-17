;***********************************
;迷路仟整理 2019.01.21
;设置/获取控件子项属性
;***********************************

Enumeration
   #winScreen
   #tvwScreen
   #imgScreen
EndEnumeration

;各种支持设置属性的控件及属性类型,具体说明要参考帮助文档
; ExplorerListGadget()  ;#PB_Explorer_ColumnWidth 
; ListIconGadget()      ;#PB_ListIcon_ColumnWidth 
; TreeGadget()          ;#PB_Tree_SubLevel, 只有GetGadgetItemAttribute(),没有SetGadgetItemAttribute()

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "设置/获取控件子项属性", WindowFlags)

TreeGadget(#tvwScreen, 010, 010, 380, 230)                                        
hImage = LoadImage(#imgScreen, "PureBasic.ico")

For k = 0 To 10
   AddGadgetItem(#tvwScreen, -1, "正常节点"+Str(k), 0, 0) 
   AddGadgetItem(#tvwScreen, -1, "父节点 "+Str(k), 0, 0)      
   AddGadgetItem(#tvwScreen, -1, "子节点 1", 0, 1)   
   AddGadgetItem(#tvwScreen, -1, "子节点 2", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子节点 3", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "子节点 4", 0, 1)
   AddGadgetItem(#tvwScreen, -1, "文件 "+Str(k), hImage) 
Next


Debug "ItemAttribute = " + GetGadgetItemAttribute(#tvwScreen, 0, #PB_Tree_SubLevel)
Debug "ItemAttribute = " + GetGadgetItemAttribute(#tvwScreen, 1, #PB_Tree_SubLevel)
Debug "ItemAttribute = " + GetGadgetItemAttribute(#tvwScreen, 2, #PB_Tree_SubLevel)
Debug "ItemAttribute = " + GetGadgetItemAttribute(#tvwScreen, 3, #PB_Tree_SubLevel)


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
; CursorPosition = 22
; Folding = -
; EnableXP