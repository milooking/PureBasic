;***********************************
;迷路仟整理 2019.02.20
;TreeGadget_多节点加载实例，通过线程调用，防止窗体卡死．
;***********************************

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
   Count = ListSize(_ListSource())
   ForEach _ListSource()
      AddGadgetItem(#tvwScreen, -1, _ListSource()\NodeName$, 0, _ListSource()\NodeFloor)
      SetGadgetItemData(#tvwScreen, Index, _ListSource())
      Index+1
      StatusBarText(#wsbScreen, 1, "显示节点中: " + Str(Index)+"/"+Str(Count)) 
   Next 
   StatusBarText(#wsbScreen, 1, "共枚举到 ["+Str(_Main\CountExamples)+"]个源代码实例!") 
EndProcedure

;-
;-主程序

hWindow = OpenWindow(#winScreen, 000, 000, 400, 320, "TreeGadget_多节点加载实例",  #PB_Window_ScreenCentered|#PB_Window_SystemMenu)  
TreeGadget(#tvwScreen, 010, 010, 380, 280)
If CreateStatusBar(#wsbScreen, hWindow)
   AddStatusBarField(0100)
   AddStatusBarField(3999)
   StatusBarText(#wsbScreen, 0, " -加载实例- ", #PB_StatusBar_Center)
   StatusBarText(#wsbScreen, 1, "") 
EndIf
CreateThread(@Thread_EnumSource(), Index)

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 90
; FirstLine = 5
; Folding = k
; EnableXP
; EnableUnicode