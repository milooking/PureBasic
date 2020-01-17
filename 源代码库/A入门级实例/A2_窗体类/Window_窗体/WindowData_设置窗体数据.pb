;***********************************
;迷路仟整理 2019.01.21
;设置/获取窗体数据
;***********************************

#winScreen = 0
#btnScreen = 1

; 支持文本指针,或结构(Structure)指针,还支持链表(List)成员,映射(Map)成员,变量,函数指针等等
; 相当于简化版的 SetProp_()/GetProp_()


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "设置/获取窗体数据", WindowFlags)
ButtonGadget(#btnScreen, 150, 100, 100, 040, "获取窗体数据")

SetWindowData(#winScreen, @"这是一段文本类型的WindowData")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
         If EventGadget() = #btnScreen
            *pString = GetWindowData(#winScreen)
            Debug "GetWindowData = " + PeekS(*pString)     
         EndIf 
   EndSelect      
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; EnableXP