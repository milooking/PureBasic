;***********************************
;迷路仟整理 2016.12.16
;DragList_拖放单元行
;***********************************

#winScreen = 0
#lstScreen1 = 1
#lstScreen2 = 2

#TVS_DISABLEDRAGDROP = $10 
#Drag_LeftMouse  = 1 
#Drag_RightMouse = 2 
#ListIcon = 3 

Global _DragGadgetID, _DragItem, _hDragImage

Procedure.l DragDropCallback(Window.l, Message.l, wParam.l, lParam.l) 

  result = #PB_ProcessPureBasicEvents 
  Select Message 
  
    Case #WM_NOTIFY
      *NML.NM_LISTVIEW = lParam
      If *NML\hdr\code =  #LVN_BEGINDRAG 
         If *NML\hdr\idFrom  =#lstScreen1
            _DragGadgetID = #lstScreen1
            _DragItem = *NML\iItem
            hWindow = GetParent_(*NML\hdr\hwndFrom)
            _hDragImage = SendMessage_(*NML\hdr\hwndFrom, #LVM_CREATEDRAGIMAGE, *NML\iItem, *NML\ptAction)
            SendMessage_(*NML\hdr\hwndFrom, #TVM_SELECTITEM, #TVGN_CARET, #Null) 
            ImageList_BeginDrag_(_hDragImage, 0, 0, 0)
            ImageList_DragEnter_(hWindow, *NML\ptAction\x, *NML\ptAction\y)        
            ImageList_DragShowNolock_(#True)
            SetCapture_ (hWindow) 
         EndIf 
      EndIf 
    
      Case #WM_MOUSEMOVE
         If  _hDragImage > 0
            DropX = PeekW(@lParam)
            DropY = PeekW(@lParam+2)
            ImageList_DragMove_(DropX, DropY+10)
         EndIf 
           
      Case #WM_LBUTTONUP   
         If _hDragImage
            GetCursorPos_(@Mouse.q)  
            If WindowFromPoint_(Mouse) = GadgetID(#lstScreen2)
               Text$ = GetGadgetItemText(#lstScreen1, _DragItem)
               AddGadgetItem(#lstScreen2, -1, Text$)
            EndIf 
            ImageList_EndDrag_()
            ReleaseCapture_()
            ImageList_Destroy_(_hDragImage)
            _hDragImage = 0
         EndIf 
  EndSelect 
  ProcedureReturn result 
EndProcedure 


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 500, 300, "DragList_拖放单元行", WindowFlags)

hGadget1 = ListIconGadget(#lstScreen1,000,000,250, 300, "文件名", 245, #PB_ListIcon_MultiSelect|#PB_ListIcon_FullRowSelect) 
hGadget2 = ListIconGadget(#lstScreen2,250,000,250, 300, "文件名", 245, #PB_ListIcon_MultiSelect|#PB_ListIcon_FullRowSelect) 

For k = 1 To 10
   AddGadgetItem(#lstScreen1, -1, "测试内容"+Str(k))
Next 

SetGadgetColor(#lstScreen1, #PB_Gadget_BackColor, $dfffff)
SetWindowCallback(@DragDropCallback())  
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
; CursorPosition = 6
; Folding = -
; EnableXP
; EnableUnicode