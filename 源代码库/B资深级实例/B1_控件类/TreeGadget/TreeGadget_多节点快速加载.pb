;***********************************
;迷路仟整理 2019.02.20
;TreeGadget_多节点快速加载，通过分级加载，来实现快速加载
;***********************************
;优化速度的思路：
;1.只加载当前层节点,不加载次级节点
;2.为了让树型控件带+号功能,如果有次级节点,则自动产生一个临时节点
;3.当节点被展开(Window_Callback())时,自动检测节点时间会加载过,如果没有,则重复第1,2步进行.

Enumeration  
  #winScreen
  #wsbScreen  
  #tvwScreen  
EndEnumeration

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

Structure __MainInfo
   CountExamples.l
EndStructure

;-[Global]
Global _Main.__MainInfo
Global NewList _ListSource.__SourceInfo()



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
               _Main\CountExamples + 1
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

Procedure Thread_EnumSource(Index)
   _Main\CountExamples = 0
   ClearList(_ListSource())
   Time = mcsGetTime_()
   Funciton_EnumSource("..\..\..\", 0, 0)
   SortStructuredList(_ListSource(), 00, 00, #PB_String)
   ClearGadgetItems(#tvwScreen)
   EventGaget_ShowNode(0)  ;只显示一级节点，如果有二级节点，只加载一个临时节点
   StatusBarText(#wsbScreen, 1, "共枚举到 ["+Str(_Main\CountExamples)+"]个源代码实例!") 
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


;-
;-主程序

hWindow = OpenWindow(#winScreen, 000, 000, 400, 320, "TreeGadget_多节点快速加载",  #PB_Window_ScreenCentered|#PB_Window_SystemMenu)  
TreeGadget(#tvwScreen, 010, 010, 380, 280)
If CreateStatusBar(#wsbScreen, hWindow)
   AddStatusBarField(0100)
   AddStatusBarField(3999)
   StatusBarText(#wsbScreen, 0, " -加载实例- ", #PB_StatusBar_Center)
   StatusBarText(#wsbScreen, 1, "") 
EndIf
CreateThread(@Thread_EnumSource(), Index)
SetWindowCallback(@Window_Callback())
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 160
; FirstLine = 36
; Folding = k-
; EnableXP
; EnableUnicode