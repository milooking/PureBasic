;***********************************
;迷路仟整理 2019.01.17
;字体缩放
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
   #trkScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "字体缩放", WindowFlags)

EditorGadget(#rtxScreen, 005, 005, 390, 200)
SetGadgetText (#rtxScreen, "PureBasic 5.62版本"+#CRLF$+"欢迎使用[迷路PureBasic实例库工具]")
TrackBarGadget(#trkScreen, 005, 210, 380, 030, 5, 100)  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #trkScreen  
            Value = GetGadgetState(#trkScreen)  
            SendMessage_(GadgetID(#rtxScreen), #EM_SETZOOM, Value, 5)  
         EndIf  
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; Folding = -
; EnableXP