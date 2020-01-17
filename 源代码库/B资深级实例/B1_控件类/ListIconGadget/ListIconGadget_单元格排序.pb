;***********************************
;迷路仟整理 2015.07.06
;单元格按列排序,点击列标题可自动排序
;***********************************

#WinScreen = 0
#lstScreen = 0

Structure __LVW_FileInfo
   FileName$
   FileType$   
   FileSize$
   FileNote$
   DateTime$
   DateTime.l
   FileSize.l
EndStructure


Global NewList _ListShowFile.__LVW_FileInfo()
Global _SortType

Procedure LVW_ShowListFiles(GadgetID, ColIndex)
   
   With _ListShowFile()
      Select ColIndex
         Case 0 : SortStructuredList(_ListShowFile(), _SortType, OffsetOf(__LVW_FileInfo\FileName$), #PB_String)
         Case 1 : SortStructuredList(_ListShowFile(), _SortType, OffsetOf(__LVW_FileInfo\DateTime),  #PB_Long  )
         Case 2 : SortStructuredList(_ListShowFile(), _SortType, OffsetOf(__LVW_FileInfo\FileType$), #PB_String)
         Case 3 : SortStructuredList(_ListShowFile(), _SortType, OffsetOf(__LVW_FileInfo\FileSize),  #PB_Long  )
         Case 4 : SortStructuredList(_ListShowFile(), _SortType, OffsetOf(__LVW_FileInfo\FileNote$), #PB_String)
      EndSelect 
      _SortType = 1-_SortType 
      ClearGadgetItems(GadgetID)
      ForEach _ListShowFile()
         LineText$ = \FileName$+Chr(10)
         LineText$ + \DateTime$+Chr(10)
         LineText$ + \FileType$+Chr(10)
         LineText$ + \FileSize$+Chr(10)
         LineText$ + \FileNote$
         AddGadgetItem(GadgetID, -1, LineText$)
         SetGadgetItemData(GadgetID, Index, @_ListShowFile())
         Index+1
      Next 
   EndWith
EndProcedure


Procedure LVW_WinCallback(hWindow, uMsg, *wParam, *lParam)
   *NML.NM_LISTVIEW = *lParam
   Select uMsg
      Case #WM_NOTIFY 
         Select *NML\hdr\code
            Case #LVN_COLUMNCLICK   ;点击标题列
               LVW_ShowListFiles(*NML\hdr\idFrom, *NML\iSubItem)
         EndSelect 
   EndSelect
   ProcedureReturn #PB_ProcessPureBasicEvents 
EndProcedure 


Procedure$ LVW_FileSize(FileSize.q)
   If FileSize < 900 : ProcedureReturn Str(FileSize)+" B" : EndIf 
   FileSize / 1024
   If FileSize < 900 : ProcedureReturn Str(FileSize)+" K" : EndIf 
   FileSize / 1024
   If FileSize < 900 : ProcedureReturn Str(FileSize)+" M" : EndIf 
   FileSize / 1024
   If FileSize < 900 : ProcedureReturn Str(FileSize)+" G" : EndIf 
   FileSize / 1024
   If FileSize < 900 : ProcedureReturn Str(FileSize)+" T" : EndIf 
EndProcedure


WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 500, 300, "ListIconGadget_单元格排序", WindowFlags)

hGadget = ListIconGadget(#lstScreen,000,000,500, 300, "文件名", 100) 
AddGadgetColumn(#lstScreen, 1, "日期", 150) 
AddGadgetColumn(#lstScreen, 2, "类型", 60) 
AddGadgetColumn(#lstScreen, 3, "大小", 80) 
AddGadgetColumn(#lstScreen, 4, "备注", 80) 

SetWindowCallback(@LVW_WinCallback())  

With _ListShowFile()
   For k = 1 To 100
      AddElement(_ListShowFile())
      \FileName$ = "文件名 " + Str(k)+".png"
      \DateTime  = Date()-Random(100000)
      \FileSize  = Random(100000)
      \FileType$ = "PNG图像"
      \FileNote$ = "备注"+ Random(100)
      
      \FileSize$ = LVW_FileSize(\FileSize)
      \DateTime$ = FormatDate("%YYYY-%MM-%DD %HH:%II:%SS", \DateTime)
   Next 
EndWith
LVW_ShowListFiles(#lstScreen, 0)


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
; CursorPosition = 103
; FirstLine = 35
; Folding = x
; EnableXP
; EnableUnicode