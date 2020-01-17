;***********************************
;迷路仟整理 2019.02.02
;加载文件列表
;***********************************

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
            FloorCount = Funciton_EnumSource(FullName$, Floor+1, *pElement)  
            Count + FloorCount
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure Thread_EnumSource(Index)
   ClearList(_ListSource())
   SetWindowTitle(#winScreen, "加载文件列表中....")
   Funciton_EnumSource(#SourcePath$, 0, 0)
   SortStructuredList(_ListSource(), 00, 00, #PB_String)
   ClearGadgetItems(#tvwScreen)

   ForEach _ListSource()
      AddGadgetItem(#tvwScreen, -1, _ListSource()\NodeName$, 0, _ListSource()\NodeFloor)
      SetGadgetItemData(#tvwScreen, Index, _ListSource())
      Index+1
   Next 
   SetWindowTitle(#winScreen, "加载文件列表")
   MessageRequester("提示", "加载完毕!")
EndProcedure


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "加载文件列表", WindowFlags)
TreeGadget(#tvwScreen, 010, 010, 380, 230)                                        

CreateThread(@Thread_EnumSource(), Index)

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
; CursorPosition = 3
; Folding = 6
; EnableXP