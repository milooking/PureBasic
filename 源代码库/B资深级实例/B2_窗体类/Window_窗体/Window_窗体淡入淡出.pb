;***********************************
;迷路仟整理 2019.01.15
;淡入淡出窗体
;***********************************

#winScreen = 0
#btnScreen = 1
 
Procedure SetWinTransparency(WinHandle.l, Transparency_Level.l)  
   SetWindowLong_(WinHandle,#GWL_EXSTYLE, #WS_EX_LAYERED)           
   SetLayeredWindowAttributes_(WinHandle,0,Transparency_Level,2)   
EndProcedure  

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "淡入淡出窗体", WindowFlags)
For i = 1 To 255  
    SetWinTransparency(hWindow, i) 
    Delay(5) 
    While WindowEvent():Wend  
Next

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

For i = 255 To 0 Step -1  
    SetWinTransparency(hWindow, i) 
    Delay(5) 
    While WindowEvent():Wend  
Next 

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 32
; FirstLine = 1
; Folding = -
; EnableXP