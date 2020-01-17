;***********************************
;迷路仟整理 2019.01.18
;视图控件
;***********************************

Enumeration
   #WinScreen
   #lblScreen1
   #lblScreen2
   #lblScreen3
   #lblScreen4
   #lblScreen5
   #lblScreen6
   
   
   #lstScreen1
   #lstScreen2
   #lstScreen3
   #lstScreen4
   #lstScreen5
   #lstScreen6
   
   #imgScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 640, 400, "视图控件", WindowFlags)

   TextGadget    (#lblScreen1,  010, 010, 300, 015, "标准控件", #PB_Text_Center)
   ListIconGadget(#lstScreen1,  010, 025, 300, 100, "列-1", 100)
   
   TextGadget    (#lblScreen2,  010, 140, 300, 015, "带选框", #PB_Text_Center)
   ListIconGadget(#lstScreen2,  010, 155, 300, 100, "列-1", 100, #PB_ListIcon_CheckBoxes)
   
   TextGadget    (#lblScreen3,  010, 270, 300, 015, "多选", #PB_Text_Center)
   ListIconGadget(#lstScreen3,  010, 285, 300, 100, "列-1", 100, #PB_ListIcon_MultiSelect)
   
   TextGadget    (#lblScreen4,  330, 010, 300, 015, "单元格",#PB_Text_Center)
   ListIconGadget(#lstScreen4,  330, 025, 300, 100, "列-1", 100, #PB_ListIcon_GridLines)
   
   TextGadget    (#lblScreen5,  330, 140, 300, 015, "整行&选中状态",#PB_Text_Center)
   ListIconGadget(#lstScreen5,  330, 155, 300, 100, "列-1", 100, #PB_ListIcon_FullRowSelect | #PB_ListIcon_AlwaysShowSelection)
   
   TextGadget    (#lblScreen6,  330, 270, 300, 015, "大图标",#PB_Text_Center)
   ListIconGadget(#lstScreen6,  330, 285, 300, 100, "",  0)
    
   For GadgetID = #lstScreen1 To #lstScreen5
      For Col = 2 To 4 
         AddGadgetColumn(GadgetID, Col, "列-" + Str(Col), 65)
      Next
      For Row = 0 To 2 
         AddGadgetItem(GadgetID, Row, "子项-1"+Chr(10)+"子项-2"+Chr(10)+"子项-3"+Chr(10)+"子项-4")
      Next
   Next

   hImage = LoadImage(#imgScreen, "PureBasic.bmp") 
   SetGadgetAttribute(#lstScreen6, #PB_ListIcon_DisplayMode, #PB_ListIcon_LargeIcon)
   AddGadgetItem(#lstScreen6, 1, "文件1", hImage)
   AddGadgetItem(#lstScreen6, 2, "文件2", hImage)

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
; CursorPosition = 2
; Folding = +
; EnableXP