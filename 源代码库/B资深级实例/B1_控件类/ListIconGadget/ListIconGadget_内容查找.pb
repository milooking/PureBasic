;***********************************
;迷路仟整理 2019.01.19
;ListIconGadget_内容查找
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #txtScreen
EndEnumeration



Procedure ListIcon_FindText(GadgetID, FindText$)
   Item.LVFINDINFO
   Item\flags = #LVFI_STRING 
   Item\psz = @FindText$
   hGadget = GadgetID(GadgetID)
   Row = SendMessage_(hGadget, #LVM_FINDITEM, -1, @Item)
   If Row <> -1
      SendMessage_(hGadget, #LVM_GETITEMPOSITION, Row, @Point1.POINT) 
      Index = SendMessage_(hGadget, #LVM_GETTOPINDEX, 0, 0) 
      SendMessage_(hGadget, #LVM_GETITEMPOSITION, Index, @Point2.POINT)  
      SendMessage_(hGadget, #LVM_SCROLL, 0, -(Point2\y - Point1\y)) 
      SetGadgetState(GadgetID, Row)  
   EndIf
EndProcedure



WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_固定列宽",WindowFlags) 

   StringGadget(#txtScreen, 400, 010, 090, 020, "")
   hGadget = ListIconGadget(#lstScreen,010,010,380,230,"内容",110, #PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_FullRowSelect) 
   For i = 1000 To 5000
      i+Random(5 , 1)
      AddGadgetItem (#lstScreen, -1, Str(i))
   Next
  
Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
         If EventGadget() = #txtScreen And EventType() = #PB_EventType_Change
            
            FindText$ = GetGadgetText(#txtScreen)
            Debug FindText$
            ListIcon_FindText(#lstScreen, FindText$)
         EndIf 
   EndSelect 
Until IsExitWindow = #True




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; FirstLine = 9
; Folding = -
; EnableXP
; EnableUnicode