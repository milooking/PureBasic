;***********************************
;迷路仟整理 2015.06.28
;单元格对齐
;***********************************

#WinScreen = 0
#lstScreen = 0

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 300, "ListIconGadget_单元格对齐", WindowFlags)

hGadget = ListIconGadget(#lstScreen,000,000,400, 300, "左对齐", 100) 
AddGadgetColumn(#lstScreen, 1, "居中",   80) 
AddGadgetColumn(#lstScreen, 2, "右对齐", 80) 


lstStyle.LV_COLUMN 
lstStyle\mask = #LVCF_FMT 
lstStyle\fmt = #LVCFMT_CENTER    ; 居中对齐
SendMessage_(hGadget, #LVM_SETCOLUMN, 1, @lstStyle)

lstStyle\fmt = #LVCFMT_RIGHT     ; 右对齐
SendMessage_(hGadget, #LVM_SETCOLUMN, 2, @lstStyle)
AddGadgetItem(#lstScreen,  -1,  "左左左" + Chr(10) + "中中中" + Chr(10) + "右右右") 
AddGadgetItem(#lstScreen,  -1,  "左左左" + Chr(10) + "中中中" + Chr(10) + "右右右") 
AddGadgetItem(#lstScreen,  -1,  "左左左" + Chr(10) + "中中中" + Chr(10) + "右右右") 


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_SizeWindow 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 26
; FirstLine = 5
; EnableXP
; EnableUnicode