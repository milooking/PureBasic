;***********************************
;迷路仟整理 2019.01.17
;滚动内容
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "滚动内容", WindowFlags)

hGadget = EditorGadget (#rtxScreen, 005, 005, 390, 200)

For i = 0 To 50  
   AddGadgetItem(#rtxScreen,-1, "子项 - " + RSet(Str(i),4,"0"))  
   SendMessage_(hGadget,#EM_LINESCROLL,0,1)  
   Delay(40)  
   While WindowEvent():Wend  
Next 

For i = 0 To 20  
   SendMessage_(hGadget,#EM_LINESCROLL,0,-1)  
   Delay(100)  
   While WindowEvent():Wend  
Next 
  
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
; CursorPosition = 26
; Folding = -
; EnableXP