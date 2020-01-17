;***********************************
;迷路仟整理 2019.01.31
;MouseEvent_点击事件
;***********************************


#winScreen = 0

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
       
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "鼠标中轮事件", WindowFlags)
Repeat
   WinEvent  = WindowEvent()
   Mouse = EventlParam() : *pMouse.Points = @Mouse
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #WM_MOUSEMOVE         : Debug "#WM_MOUSEMOVE        " + Hex(EventwParam())+":"+Hex(EventlParam()) + " : " + Str(*pMouse\x)+","+Str(*pMouse\y)  
      Case #WM_LBUTTONDBLCLK     : Debug "#WM_LBUTTONDBLCLK    " + Hex(EventwParam())+":"+Hex(EventlParam()) + " : " + Str(*pMouse\x)+","+Str(*pMouse\y)  
      Case #WM_LBUTTONDOWN       : Debug "#WM_LBUTTONDOWN      " + Hex(EventwParam())+":"+Hex(EventlParam()) + " : " + Str(*pMouse\x)+","+Str(*pMouse\y)    
      Case #WM_LBUTTONUP         : Debug "#WM_LBUTTONUP        " + Hex(EventwParam())+":"+Hex(EventlParam()) + " : " + Str(*pMouse\x)+","+Str(*pMouse\y)    
      Case #WM_RBUTTONDOWN       : Debug "#WM_RBUTTONDOWN      " + Hex(EventwParam())+":"+Hex(EventlParam()) + " : " + Str(*pMouse\x)+","+Str(*pMouse\y)    
      Case #WM_RBUTTONUP         : Debug "#WM_RBUTTONUP        " + Hex(EventwParam())+":"+Hex(EventlParam()) + " : " + Str(*pMouse\x)+","+Str(*pMouse\y)    
      Case #WM_MBUTTONDBLCLK     : Debug "#WM_MBUTTONDBLCLK    " + Hex(EventwParam())+":"+Hex(EventlParam()) + " : " + Str(*pMouse\x)+","+Str(*pMouse\y)    
      Case #WM_NCMOUSEMOVE       : Debug "#WM_NCMOUSEMOVE      " + Hex(EventwParam())+":"+Hex(EventlParam()) + " : " + Str(*pMouse\x)+","+Str(*pMouse\y)  
      Case #WM_NCLBUTTONDBLCLK   : Debug "#WM_NCLBUTTONDBLCLK  " + Hex(EventwParam())+":"+Hex(EventlParam()) + " : " + Str(*pMouse\x)+","+Str(*pMouse\y)    
      Case #WM_ACTIVATE          : Debug "#WM_ACTIVATE         " + Hex(EventwParam())+":"+Hex(EventlParam()) + " : " + Str(*pMouse\x)+","+Str(*pMouse\y)    
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; EnableXP
; EnableOnError