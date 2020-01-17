;***********************************
;迷路仟整理 2019.02.02
;快速加载文件列表
;***********************************
;采用分级显示到树型控制的方式

Enumeration
   #winScreen
   #tvwScreen
EndEnumeration

#SourcePath$ = "..\..\..\"
Structure __SourceInfo
   SortName$
   FileName$
   NodeName$
   PathName$
   FileType.l
   NodeFloor.l
   Count.l
   IsShow.l
   *pFloorElement.__SourceInfo
EndStructure

Global NewList _ListSource.__SourceInfo()

;-
;-[Thread]
Procedure Funciton_EnumSource(FilePath$, Floor, *pFloorElement)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File 
            If LCase(GetExtensionPart(FileName$)) = "pb"
               Count + 1
               FullName$ = FilePath$+FileName$
               *pElement.__SourceInfo = AddElement(_ListSource())
               *pElement\SortName$ = FilePath$+Chr($FF)+FileName$
               *pElement\FileName$ = FullName$
               *pElement\PathName$ = FilePath$
               *pElement\NodeName$ = FileName$
               *pElement\NodeFloor = Floor
               *pElement\FileType  = 1
               *pElement\pFloorElement = *pFloorElement
            EndIf 
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else   
            FullName$ = FilePath$+FileName$+"\"
            *pElement.__SourceInfo = AddElement(_ListSource())
            *pElement\SortName$ = FilePath$+FileName$+"\"
            *pElement\FileName$ = FullName$
            *pElement\PathName$ = FilePath$
            *pElement\NodeName$ = FileName$
            *pElement\NodeFloor = Floor
            *pElement\FileType  = 0
            *pElement\pFloorElement  = *pFloorElement
            FloorCount = Funciton_EnumSource(FullName$, Floor+1, *pElement)  
            *pElement\Count     = FloorCount
            Count + FloorCount
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure EventGaget_ShowNode(*pMemNode.__SourceInfo, Index=0)
   With _ListSource()
      If *pMemNode = 0 
         ForEach _ListSource()
            If \NodeFloor <> 0 : Continue : EndIf  
            If \FileType = 0
               AddGadgetItem(#tvwScreen, -1, \NodeName$, 0, \NodeFloor)
               SetGadgetItemData(#tvwScreen, Index, _ListSource())
               Index+1
               If \Count
                  AddGadgetItem(#tvwScreen, -1, "Temp-"+Str(\Count), 0, \NodeFloor+1)
                  SetGadgetItemData(#tvwScreen, Index, 0)
                  Index+1
               EndIf 
            Else 
               AddGadgetItem(#tvwScreen, -1, \NodeName$, 0, \NodeFloor)
               SetGadgetItemData(#tvwScreen, Index, _ListSource())
               Index+1
            EndIf
         Next 
         ProcedureReturn 
      EndIf
      If *pMemNode\IsShow = #True : ProcedureReturn : EndIf 
      ForEach _ListSource()
         If \pFloorElement <> *pMemNode : Continue : EndIf  
         If \FileType = 0
            Index+1
            If GetGadgetItemData(#tvwScreen, Index) = 0 
               RemoveGadgetItem(#tvwScreen, Index)
            EndIf  
            AddGadgetItem(#tvwScreen, Index, \NodeName$, 0, \NodeFloor)
            SetGadgetItemData(#tvwScreen, Index, _ListSource())
            If \Count
               Index+1
               AddGadgetItem(#tvwScreen, Index, "Temp-"+Str(\Count), 0, \NodeFloor+1)
               SetGadgetItemData(#tvwScreen, Index, 0)
            EndIf 
         Else 
            Index+1
            If GetGadgetItemData(#tvwScreen, Index) = 0 
               RemoveGadgetItem(#tvwScreen, Index)
            EndIf  
            AddGadgetItem(#tvwScreen, Index, \NodeName$, 0, \NodeFloor)
            SetGadgetItemData(#tvwScreen, Index, _ListSource())
         EndIf
      Next 
      *pMemNode\IsShow = #True
   EndWith
EndProcedure

Procedure EventGaget_tvwScreen()
   State = GetGadgetState(#tvwScreen)
   If State < 0 : ProcedureReturn : EndIf 
   Select EventType() 
      Case #PB_EventType_LeftDoubleClick
         *pSource.__SourceInfo = GetGadgetItemData(#tvwScreen, State) 
         If *pSource
            If *pSource\FileType = 0
               EventGaget_ShowNode(*pSource, State)
            EndIf 
         EndIf 
   EndSelect
EndProcedure

Procedure Thread_EnumSource(Index)
   ClearList(_ListSource())
   Funciton_EnumSource(#SourcePath$, 0, 0)
   SortStructuredList(_ListSource(), 00, 00, #PB_String)
   ClearGadgetItems(#tvwScreen)
   EventGaget_ShowNode(0)
   MessageRequester("提示", "加载完毕!")
EndProcedure

Procedure Window_Callback(hWindow, uMsg, *wParam, *lParam)
   *NMT.NM_TREEVIEW = *lParam
   Select uMsg
      Case #WM_NOTIFY 
         Select *NMT\hdr\code
            Case #TVN_ITEMEXPANDED
               GadgetID = *NMT\hdr\idFrom
               State = *NMT\itemNew\lParam
               If *NMT\action = 2
                  *pSource.__SourceInfo = GetGadgetItemData(GadgetID, State) 
                  If *pSource And *pSource\FileType = 0
                     EventGaget_ShowNode(*pSource, State)
                  EndIf 
               EndIf 
         EndSelect 
   EndSelect
   ProcedureReturn #PB_ProcessPureBasicEvents 
EndProcedure 


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "快速加载文件列表", WindowFlags)
TreeGadget(#tvwScreen, 010, 010, 380, 230)                                        
BindGadgetEvent(#tvwScreen,   @EventGaget_tvwScreen())
CreateThread(@Thread_EnumSource(), Index)
SetWindowCallback(@Window_Callback())
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
; CursorPosition = 140
; FirstLine = 15
; Folding = h+
; EnableXP