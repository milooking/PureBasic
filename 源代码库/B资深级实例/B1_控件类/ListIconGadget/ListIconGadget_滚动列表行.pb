;***********************************
;迷路仟整理 2019.01.17
;滚动列表行
;***********************************

Enumeration
   #WinScreen
   #lstScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "ListIconGadget_滚动列表行", WindowFlags)

hGadget = ListIconGadget(#lstScreen, 010, 010, 380, 230,"列-1",110) 
AddGadgetColumn(#lstScreen, 1, "列-2",110)
AddGadgetColumn(#lstScreen, 2, "列-3",110)
For i = 1 To 100
   AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i))
Next

For i = 1 To 90  
   SendMessage_(hGadget,#WM_VSCROLL,#SB_LINEDOWN,0)  
   Delay(30)  
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
; CursorPosition = 15
; Folding = -
; EnableXP