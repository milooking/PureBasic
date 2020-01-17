;***********************************
;迷路仟整理 2019.01.21
;设置/获取控件数据
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
   #btnScreen3
   #btnScreen4
   #btnScreen5
EndEnumeration

; SetGadgetData()/GetGadgetData()是非常有用的控件属性,可以用到存放控件的相关信息,
; 支持文本指针,或结构(Structure)指针,还支持链表(List)成员,映射(Map)成员,变量,函数指针等等
; 与之相关的还有SetGadgetItemData()/GetGadgetItemData()
; SetGadgetItemData()/SetGadgetItemData() 相当于简化版的 SetProp_()/GetProp_()

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 430, 250, "设置/获取控件数据", WindowFlags)

ButtonGadget(#btnScreen1, 010, 010, 200, 35, "按键1")
ButtonGadget(#btnScreen2, 010, 050, 200, 35, "按键2")
ButtonGadget(#btnScreen3, 010, 090, 200, 35, "按键3")
ButtonGadget(#btnScreen4, 220, 010, 200, 75, "按键4")
ButtonGadget(#btnScreen5, 220, 090, 200, 35, "按键5")

SetGadgetData(#btnScreen1, @"这个是[按键1]")
SetGadgetData(#btnScreen2, @"这个是[按键2]")
SetGadgetData(#btnScreen3, @"这个是[按键3]")
SetGadgetData(#btnScreen4, @"这个是[按键4]")
SetGadgetData(#btnScreen5, @"这个是[按键5]")


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         GadgetID = EventGadget()
         Select GadgetID
            Case #btnScreen1 To #btnScreen5
               *pString = GetGadgetData(GadgetID)
               Debug PeekS(*pString)      
         EndSelect
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP