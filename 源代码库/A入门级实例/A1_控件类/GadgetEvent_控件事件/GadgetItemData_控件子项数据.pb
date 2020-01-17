;***********************************
;迷路仟整理 2019.01.21
;获取控件子项数据
;***********************************

Enumeration
   #winScreen
   #lvwScreen
EndEnumeration

; SetGadgetItemData()/GetGadgetItemData()是非常有用的控件子项属性,可以用到存放控件子项的相关信息,
; 支持文本指针,或结构(Structure)指针,还支持链表(List)成员,映射(Map)成员,变量,函数指针等等
; 与之相关的还有SetGadgetItemData()/GetGadgetItemData()
; SetGadgetData()/SetGadgetData() 相当于简化版的 SetProp_()/GetProp_()

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 430, 250, "设置/获取控件子项数据", WindowFlags)

ListViewGadget(#lvwScreen, 10, 10, 380, 230)
For i = 1 To 20
   AddGadgetItem (#lvwScreen, -1, "子项 - " + Str(i))
   SetGadgetItemData(#lvwScreen, i-1, i)
Next
SetGadgetState(#lvwScreen, 5)


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #lvwScreen
            State = GetGadgetState(#lvwScreen)
            Debug "GetGadgetItemData = " + GetGadgetItemData(#lvwScreen, State)
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP