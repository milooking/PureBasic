;***********************************
;迷路仟整理 2019.01.21
;获取控件句柄
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
EndEnumeration

;在PureBasic帮助文件中 #Gadget表示控件编号, GadgetID表示控件句柄
;但在实际编程应用时,采和#和ID,不太实现,因此,惯性用#和ID来表示控件编号, hGadget来表示控件句柄
;控件编号: 是PureBasic程序内部环境下有效,自定义的范围为0-5000, #PB_Any返回值,都大于5000,所以不会产生混淆
;控件句柄: 是整个系统环境下,进程间共享的,由GadgetID(#Gadget)获取.也可以由创建控件时获取
;在DLL编程时,可以采用GetProp_(hGadget, "#PB_ID")来获取控件编号.

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "获取控件句柄", WindowFlags)

hButton1 = ButtonGadget(#btnScreen1, 010, 010, 150, 025, "按键1")
hButton2 = ButtonGadget(#btnScreen2, 010, 040, 150, 025, "按键2")
ButtonID = ButtonGadget(#PB_Any,     010, 070, 150, 025, "按键3")     

Debug "#btnScreen1 的句柄  : "+ hButton1
Debug "#btnScreen2 的句柄  : "+ hButton2
Debug "ButtonID    的句柄  : "+ GadgetID(ButtonID)
Debug ""
Debug "#btnScreen1 的值: "+ #btnScreen1
Debug "#btnScreen2 的值: "+ #btnScreen2
Debug "hButton1  的编号: "+ GetProp_(hButton1, "PB_ID")
Debug "hButton2  的编号: "+ GetProp_(hButton2, "PB_ID")


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
; CursorPosition = 7
; Folding = -
; EnableXP