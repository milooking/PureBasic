;***********************************
;迷路仟整理 2019.01.17
;设置行高
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
   #trkScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "设置行高", WindowFlags)

EditorGadget(#rtxScreen, 005, 005, 390, 200)

TrackBarGadget(#trkScreen, 005, 210, 380, 030, 30, 1000)  
Text$ = "PureBasic 5.62版本"+#CRLF$+
        "欢迎使用[迷路PureBasic实例库工具]"+#CRLF$+
        "PureBasic 5.62版本"+#CRLF$+
        "欢迎使用[迷路PureBasic实例库工具]"
SetGadgetText (#rtxScreen, Text$)
        
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #trkScreen  
            hGadget = GadgetID(#rtxScreen)
            Value = GetGadgetState(#trkScreen)  
            Format.CHARFORMAT  
            Format\cbSize=SizeOf(CHARFORMAT) 
            SendMessage_(hGadget,#EM_GETCHARFORMAT,#SCF_ALL,Format)  
            Format\yOffset = Value         ;设置行高
            SendMessage_(hGadget,#EM_SETCHARFORMAT,#SCF_ALL,Format)  
         EndIf  
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; Folding = -
; EnableXP