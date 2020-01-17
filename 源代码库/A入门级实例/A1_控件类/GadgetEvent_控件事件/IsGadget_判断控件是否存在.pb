;***********************************
;迷路仟整理 2019.01.21
;判断控件是否存在
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "判断控件是否存在", WindowFlags)

ButtonGadget(#btnScreen1, 010, 010, 150, 025, "按键1")
ButtonGadget(#btnScreen2, 010, 040, 150, 025, "按键2")
ButtonID = ButtonGadget(#PB_Any, 010, 070, 150, 025, "按键3")     

FreeGadget(#btnScreen2)    ;注销控件

Debug "#btnScreen1 的否存在: "+ IsGadget(#btnScreen1)
Debug "ButtonID    的否存在: "+ IsGadget(ButtonID)
Debug "#btnScreen2 的否存在: "+ IsGadget(#btnScreen2)
Debug ""
Debug "#btnScreen1 的句柄  : "+ GadgetID(#btnScreen1)
Debug "ButtonID    的句柄  : "+ GadgetID(ButtonID)
Debug ""
Debug "IsGadget和句柄的关系: "+ Str(PeekL(IsGadget(#btnScreen1)))+":"+Str(GadgetID(#btnScreen1))   ;IsGadget是控件句柄的指针
Debug "IsGadget和句柄的关系: "+ Str(PeekL(IsGadget(ButtonID)))   +":"+Str(GadgetID(ButtonID))      ;IsGadget是控件句柄的指针

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
; FirstLine = 5
; Folding = -
; EnableXP