;***********************************
;迷路仟整理 2019.01.26
;MouseMove_鼠标移动事件
;***********************************


#winScreen = 0
#lblScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "鼠标移动事件", WindowFlags)
TextGadget(#lblScreen, 130, 100, 140, 060, "")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_NCMOUSEMOVE
         SetGadgetText(#lblScreen, "鼠标位置 鼠标已离开!")
         Debug "鼠标位置 鼠标已离开!"
      Case #WM_MOUSEMOVE
      
         ;获取位置,方法一
         MouseX = WindowMouseX(#winScreen)
         MouseY = WindowMouseY(#winScreen)
         
         ;获取位置,方法二
         lParam = EventlParam() 
         *pMouse.POINTS = @lParam
   
         ;获取位置,方法三
         GetCursorPos_(Mouse.POINT)          ;这里获取到的鼠标位置是相于屏幕
         ScreenToClient_(hWindow, Mouse)     ;将鼠标位置换算成对应窗体的鼠标位置
         
         ;注意,结构POINTS和POINT是不一样的,POINTS是32位,POINT是64位的,
         SetGadgetText(#lblScreen, "鼠标位置 x: "+Str(MouseX)+", y: "+Str(MouseY))  
         Debug "鼠标位置 x: "+Str(MouseX)+", y: "+Str(MouseY) + " - " + Str(*pMouse\X)+","+Str(*pMouse\Y) + " - " +  Str(Mouse\X)+","+Str(Mouse\Y)
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 22
; FirstLine = 1
; EnableXP
; EnableOnError