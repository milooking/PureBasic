;***********************************
;迷路仟整理 2019.01.17
;内容全选
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
   #btnScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "内容全选", WindowFlags)

EditorGadget (#rtxScreen, 005, 005, 390, 200)
SetGadgetText(#rtxScreen, "PureBasic 5.62版本"+#CRLF$+"欢迎使用[迷路PureBasic实例库工具]")
ButtonGadget (#btnScreen, 150, 210, 100, 030, "全选")  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen  
            Range.CHARRANGE
            Range\cpMin = 0  
            Range\cpMax = -1  
            SendMessage_(GadgetID(#rtxScreen),#EM_EXSETSEL,0,@Range)  
         EndIf  
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; Folding = -
; EnableXP