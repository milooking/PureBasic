;***********************************
;迷路仟整理 2019.01.15
;TreeGadget-更换图标,注意节点打开和关闭的图标是不一样的.
;***********************************

Enumeration  
  #winScreen  
  #tvwScreen  
  #frmScreen  
  #picTreeNode1
  #picTreeNode2
EndEnumeration
  
Global _GadgetHooK
Global _WindowHooK


; 添加节点变更的图标
Procedure TVW_AddNodesImage(GadgetID, _hImage)
   hItem = AddGadgetItem(GadgetID, -1, "", _hImage) 
   TVItem.TV_ITEM 
   TVItem\hitem = hItem 
   TVItem\mask = #TVIF_IMAGE 
   SendMessage_(GadgetID(GadgetID), #TVM_GETITEM, 0, @TVItem) 
EndProcedure 

; 初始化节点图标
Procedure TVW_InitNodesImage(GadgetID, hImageNode1, hImageNode2)
   TVW_AddNodesImage(GadgetID, hImageNode1)
   TVW_AddNodesImage(GadgetID, hImageNode2)
   RemoveGadgetItem (GadgetID, 0) 
   RemoveGadgetItem (GadgetID, 0) 
EndProcedure
   

; 更换节点图标
Procedure TVW_HookWindow_ChangeIcon(*NMT.NM_TREEVIEW)
   If *NMT\itemNew\lParam < 0 : ProcedureReturn : EndIf    
   GadgetID = *NMT\hdr\idFrom
   Floor = GetGadgetItemAttribute(GadgetID, *NMT\itemNew\lParam, #PB_Tree_SubLevel)      
   SendMessage_(GadgetID(GadgetID), #TVM_GETITEM, 0, @TVItem.TV_ITEM) 
   TVItem\mask = #TVIF_IMAGE|#TVIF_HANDLE|#TVIF_SELECTEDIMAGE 
   TVItem\iImage         = *NMT\action ;1表示闭合节点，2表示展开节点
   TVItem\iSelectedImage = *NMT\action
   TVItem\hItem = GadgetItemID(GadgetID, *NMT\itemNew\lParam)

   SendMessage_(GadgetID(GadgetID), #TVM_SETITEM, 0, @TVItem)  
   
EndProcedure 


Procedure TVW_WinCallback(hWindow, uMsg, *wParam, *lParam)
   *NMT.NM_TREEVIEW = *lParam
   Select uMsg
      Case #WM_NOTIFY 
         Select *NMT\hdr\code
            Case #TVN_ITEMEXPANDED: TVW_HookWindow_ChangeIcon(*NMT)
         EndSelect 
   EndSelect
   ProcedureReturn #PB_ProcessPureBasicEvents 
EndProcedure 




;-
;-主程序
hImageNode1 = LoadImage(#picTreeNode1, ".\TreeNode1.ico")  
hImageNode2 = LoadImage(#picTreeNode2, ".\TreeNode2.ico")  
hWindow = OpenWindow(#winScreen, 000, 000, 500, 300, "TreeGadget-更换图标",  #PB_Window_ScreenCentered|#PB_Window_SystemMenu)  


hGadget = ContainerGadget(#frmScreen, 000, 000, 500, 300)
   TreeGadget(#tvwScreen, 010, 010, 480, 280)
CloseGadgetList() 
TVW_InitNodesImage(#tvwScreen, hImageNode1, hImageNode2)
SetWindowCallback(@TVW_WinCallback())

For X = 1 To 5
   AddGadgetItem(#tvwScreen, -1, "1级文件夹"+Str(X), hImageNode1, 0)
   For Y = 1 To 4
      AddGadgetItem(#tvwScreen, -1, "2级文件夹"+Str(X)+"-"+Str(Y), hImageNode1, 1)
      For Z = 1 To 3
         AddGadgetItem(#tvwScreen, -1, "3级文件夹"+Str(X)+"-"+Str(Y)+"-"+Str(Z), hImageNode1, 2)
      Next    
   Next                                           
Next 
SetGadgetItemState(#tvwScreen, 0, #PB_Tree_Expanded)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 65
; FirstLine = 39
; Folding = 6
; EnableXP
; EnableUnicode