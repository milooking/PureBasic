;***********************************
;迷路仟整理 2019.01.21
;设置/获取控件字体
;***********************************

Enumeration
   #winScreen
   #fntScreen1
   #fntScreen2
   #btnScreen1
   #btnScreen2
   #btnScreen3
   #btnScreen4
   #btnScreen5
EndEnumeration

hFont1 = LoadFont(#fntScreen1, "宋体", 16) ;加载字体
hFont2 = LoadFont(#fntScreen2, "宋体", 28)

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 430, 250, "设置/获取控件字体", WindowFlags)

hFontDefault = GetGadgetFont(#PB_Default) ; 默认字体

SetGadgetFont(#PB_Default, hFont1) ;设置全局控件为#fntScreen1的字体

ButtonGadget(#btnScreen1, 010, 010, 200, 35, "按键1")
ButtonGadget(#btnScreen2, 010, 050, 200, 35, "按键2")
ButtonGadget(#btnScreen3, 010, 090, 200, 35, "按键3")
ButtonGadget(#btnScreen4, 220, 010, 200, 75, "按键4")
ButtonGadget(#btnScreen5, 220, 090, 200, 35, "按键5")

SetGadgetFont(#btnScreen4, hFont2) ;设置控件#btnScreen4为#fntScreen2的字体

Debug "默认字体 = " + hFontDefault
Debug "hFont1 = " + hFont1
Debug "GetGadgetFont(#btnScreen1) = " +  GetGadgetFont(#btnScreen1)
Debug "GetGadgetFont(#btnScreen2) = " +  GetGadgetFont(#btnScreen2)
Debug "GetGadgetFont(#btnScreen3) = " +  GetGadgetFont(#btnScreen3)
Debug "GetGadgetFont(#btnScreen5) = " +  GetGadgetFont(#btnScreen5)
Debug ""
Debug "hFont2 = " + hFont2
Debug "GetGadgetFont(#btnScreen4) = " +  GetGadgetFont(#btnScreen4)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 

FreeFont(#fntScreen1)   ;注销字体
FreeFont(#fntScreen2)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 25
; FirstLine = 9
; Folding = -
; EnableXP