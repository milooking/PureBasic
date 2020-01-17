;***********************************
;迷路仟整理 2019.01.21
;启用窗体布局
;***********************************

Enumeration
   #winScreen
   #winChild
   #btnScreen1
   #btnScreen2
   #btnScreen3
   #btnScreen4
EndEnumeration

 
;UseGadgetList要可以用到线程中,也可以用到DLL,LIB中.
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "启用窗体布局", WindowFlags)

ButtonGadget(#btnScreen1, 010, 010, 150, 025, "按键1")      ; 这时布局句柄在#winScreen

If OpenWindow(#winChild, 0, 0, 300, 200, "子窗体", #PB_Window_SystemMenu|#PB_Window_WindowCentered, hWindow)   
   ButtonGadget(#btnScreen2, 010, 040, 150, 025, "按键2")   ; 这时布局句柄在#winChild
   OldGadgetList = UseGadgetList(WindowID(#winScreen))      ; 启用父窗体的布局,并返回子窗体的布局
EndIf 

ButtonGadget(#btnScreen3, 010, 070, 150, 025, "按键3")      ; 这时布局句柄在#winScreen
UseGadgetList(OldGadgetList)                                ; 启用子窗体的布局
ButtonGadget(#btnScreen4, 010, 100, 150, 025, "按键4")      ; 这时布局句柄在#winChild

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow 
         WindowID = EventWindow()
         If WindowID = #winScreen 
            IsExitWindow = #True 
         Else 
            CloseWindow(WindowID)
         EndIf 
         
      Case #PB_Event_Gadget 
         GadgetID = EventGadget()
         Debug "EventType = " + Str(GadgetType(GadgetID))
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 29
; FirstLine = 9
; Folding = -
; EnableXP