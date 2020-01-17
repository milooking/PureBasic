;***********************************
;迷路仟整理 2019.01.20
;滚动列表行
;***********************************

Enumeration
   #WinScreen
   #lstScreen
   #txtScreen
   #btnScreen
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 260, "ListIconGadget_滚动列表行", WindowFlags)

StringGadget(#txtScreen, 160, 225, 050, 020, "30") 
ButtonGadget(#btnScreen, 230, 220, 080, 030, "跳到") 

hGadget = ListIconGadget(#lstScreen, 010, 010, 380, 200,"列-1",110, #PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection) 
AddGadgetColumn(#lstScreen, 1, "列-2",110)
AddGadgetColumn(#lstScreen, 2, "列-3",110)
For i = 1 To 100
   AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i))
Next

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen
            Row = Val(GetGadgetText(#txtScreen))
            SendMessage_(hGadget, #LVM_GETITEMPOSITION, Row, @Point1.POINT) 
            Index = SendMessage_(hGadget, #LVM_GETTOPINDEX, 0, 0) 
            SendMessage_(hGadget, #LVM_GETITEMPOSITION, Index, @Point2.POINT)  
            SendMessage_(hGadget, #LVM_SCROLL, 0, -(Point2\y - Point1\y)) 
            SetGadgetState(#lstScreen, Row)  
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 23
; FirstLine = 7
; Folding = -
; EnableXP