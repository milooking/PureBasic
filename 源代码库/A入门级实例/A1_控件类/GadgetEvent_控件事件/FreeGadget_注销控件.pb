;***********************************
;迷路仟整理 2019.01.21
;注销控件
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
   #btnScreen3
   #txtScreen
   #frmScreen
EndEnumeration

;注销控件
;1. 注销容器类控件,父控件一旦注销,其子控件自动注销
;2. 窗体被注销(实际上是Close), 其窗体内的控件自动注销
;3. 程序一旦结束,程序内所有的控件和窗体一律自动注销

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "注销控件", WindowFlags)

ButtonGadget  (#btnScreen1, 010, 010, 100, 030, "按键1") 
ButtonGadget  (#btnScreen2, 210, 010, 100, 030, "按键2") 

ContainerGadget(#frmScreen,  010, 050, 300, 100, #PB_Container_Raised)
   StringGadget(#txtScreen,  010, 015, 080, 024, "")
   ButtonGadget(#btnScreen3, 100, 015, 080, 024, "按键3")
CloseGadgetList()

FreeGadget(#btnScreen2)    
FreeGadget(#frmScreen)     


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         GadgetID = EventGadget()
         Debug "EventType = " + Str(GadgetType(GadgetID))
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP