;***********************************
;迷路仟整理 2019.02.02
;List_多线程共享链表
;***********************************
;本方只适应用多线程间链表的历遍,多线程链表添删除,会导致出错

; 链表成员的结构
Structure __MCS_ListElementInfo
   *pNextElement.__MCS_ListElementInfo
   *pPrevElement.__MCS_ListElementInfo
   *pElementContent
EndStructure

; 链表头部的结构
Structure __MCS_ListHeaderInfo
   *pFirstElement.__MCS_ListElementInfo      ; 第一个元素的指针
   *pLastElement.__MCS_ListElementInfo       ; 最后一个元素的指针
   *pCurrElement.__MCS_ListElementInfo       ; 当前元素的指针
   *pResetList.long                          ; ResetList()值
   CountList.l                               ; 元素数量
   ListIndex.l                               ; 当前元素索引
   Keep.l[4]
   ElementSize.l
   Alignment.l
EndStructure

; 链表ResetList()结构
Structure __MCS_ResetListInfo
   *pPointList.__MCS_ListHeaderInfo          ; 索表头部  ResetList()-4
   *pCurrElement.__MCS_ListElementInfo       ; 当前元素指针
EndStructure

;-====================================
; 获取链表的大小
Procedure MCS_ListSize(*pResetList)
   *pList.__MCS_ResetListInfo = *pResetList-4
   ProcedureReturn *pList\pPointList\CountList
EndProcedure

; 获取链表当前元素的索引号
Procedure MCS_ListIndex(*pResetList)
   *pList.__MCS_ResetListInfo = *pResetList-4
   ProcedureReturn *pList\pPointList\ListIndex
EndProcedure

; 获取链表当前元素的内容地址
Procedure MCS_CurrentElement(*pResetList)
   *pList.__MCS_ResetListInfo = *pResetList-4
   If *pList\pPointList\pCurrElement
      ProcedureReturn *pList\pPointList\pCurrElement+8
   Else 
      ProcedureReturn 0
   EndIf 
EndProcedure

;-
; 获取链表第一个元素
Procedure MCS_FirstElement(*pResetList)
   *pList.__MCS_ResetListInfo = *pResetList-4
   *pElement = *pList\pPointList\pFirstElement
   CountList = *pList\pPointList\CountList
   If CountList And *pElement                         ; 如果成员存在
      If *pElement <> *pList\pPointList\pCurrElement
         *pList\pPointList\ListIndex    = 0           ; 设置链表当前元素的索引号
         *pList\pPointList\pCurrElement = *pElement   ; 设置链表当前元素的地址
         *pList\pCurrElement            = *pElement   ; 设置链表当前元素的地址
      EndIf 
      ProcedureReturn *pElement + 8
   Else 
      ProcedureReturn 0
   EndIf 
EndProcedure

; 获取链表最后一个元素
Procedure MCS_LastElement(*pResetList)
   *pList.__MCS_ResetListInfo = *pResetList-4
   *pElement = *pList\pPointList\pLastElement
   CountList = *pList\pPointList\CountList
   If CountList And *pElement                         ; 如果成员存在
      If *pElement <> *pList\pPointList\pCurrElement
         *pList\pPointList\ListIndex    = CountList-1 ; 设置链表当前元素的索引号
         *pList\pPointList\pCurrElement = *pElement   ; 设置链表当前元素的地址
         *pList\pCurrElement            = *pElement   ; 设置链表当前元素的地址
      EndIf 
      ProcedureReturn *pElement + 8
   Else 
      ProcedureReturn 0
   EndIf 
EndProcedure

; 获取链表下一个元素
Procedure MCS_NextElement(*pResetList) 
   *pList.__MCS_ResetListInfo = *pResetList-4
   ListIndex = *pList\pPointList\ListIndex
   If *pList\pPointList\CountList  = 0
      ProcedureReturn 0
   ElseIf *pList\pCurrElement = 0
      *pElement = *pList\pPointList\pFirstElement
   Else
      *pElement = *pList\pPointList\pCurrElement\pNextElement
   EndIf 
   If *pElement       ; 如果成员存在
      *pList\pPointList\ListIndex    = ListIndex+1    ; 设置链表当前元素的索引号
      *pList\pPointList\pCurrElement = *pElement      ; 设置链表当前元素的地址
      *pList\pCurrElement            = *pElement      ; 设置链表当前元素的地址
      ProcedureReturn *pElement + 8
   Else 
      ProcedureReturn 0
   EndIf 
EndProcedure

; 获取链表上一个元素
Procedure MCS_PreviousElement(*pResetList) 
   *pList.__MCS_ResetListInfo = *pResetList-4
   *pElement = *pList\pPointList\pCurrElement\pPrevElement
   ListIndex = *pList\pPointList\ListIndex
   If *pList\pPointList\CountList And *pElement       ; 如果成员存在
      *pList\pPointList\ListIndex    = ListIndex-1    ; 设置链表当前元素的索引号
      *pList\pPointList\pCurrElement = *pElement      ; 设置链表当前元素的地址
      *pList\pCurrElement            = *pElement      ; 设置链表当前元素的地址
      ProcedureReturn *pElement + 8
   Else 
      ProcedureReturn 0
   EndIf 
EndProcedure

; 在链表中选择一个元素
Procedure MCS_SelectElement(*pResetList, Index)
   *pList.__MCS_ResetListInfo = *pResetList-4
   *pElement.__MCS_ListElementInfo
   With *pList\pPointList
      ListIndex = \ListIndex
      CountList = \CountList
      If Index < 0 Or Index > CountList Or CountList = 0
         ProcedureReturn 0
         
      ElseIf ListIndex = Index          
         ProcedureReturn *pList\pPointList\pCurrElement+8
         
      ElseIf Index < ListIndex                              ; 在当前元素前面找
         If Index < ListIndex/2                             ; 从第一个元素往后找
            *pElement = \pFirstElement
            For k = 1 To Index            : *pElement = *pElement\pNextElement : Next 
         Else                                               ; 从当前玩素往前找
            *pElement = *pList\pPointList\pCurrElement\pPrevElement
            For k = Index To ListIndex    : *pElement = *pElement\pPrevElement : Next 
         EndIf 
      Else                                                  ; 在当前元素向面找
         If Index > (CountList+ListIndex)/2                 ; 从最后一个元素往后找
            *pElement = \pLastElement
            For k = CountList-1 To Index  : *pElement = *pElement\pPrevElement : Next 
         Else   
            *pElement =*pList\pPointList\pCurrElement\pNextElement
            For k = Index To ListIndex    : *pElement = *pElement\pNextElement : Next 
         EndIf 
      EndIf 
      \ListIndex           = Index          ; 设置链表当前元素的索引号
      \pCurrElement        = *pElement      ; 设置链表当前元素的地址
      *pList\pCurrElement  = *pElement      ; 设置链表当前元素的地址
   EndWith
   ProcedureReturn *pElement+8
EndProcedure

;-
; 从另一链表*pInResetList克隆到指定的新链表*pNewResetList中,让新链表共享原链表的结构和数据
Procedure MCS_CopyResetList(*pNewResetList, *pInResetList)
   Protected *pMemListBackup = AllocateMemory(24)
   *pInReset  = PeekL(*pInResetList -4)
   *pNewReset = PeekL(*pNewResetList-4) 
   CopyMemory(*pNewReset, *pMemListBackup, 24) 
   CopyMemory(*pInReset, *pNewReset,   24) 
   PokeL(*pNewReset+12, *pNewResetList) 
   ProcedureReturn *pMemListBackup
EndProcedure

; 还原克隆链表,用于克隆链表释放前
Procedure MCS_FreeResetList(*pListBackup, *pNewResetList)
   *pNewReset = PeekL(*pNewResetList-4)
   CopyMemory (*pListBackup, *pNewReset, 24)    ;还原克隆体
   FreeMemory(*pListBackup)
EndProcedure



;-




;链表操作
Global NewList ListText$()        ;主体List对象


Procedure Thread_SharedListEnum(Index)
   NewList ListShared$()
   *pListText   = ResetList(ListText$()) 
   *pListShared = ResetList(ListShared$()) 
   *pListBackup = MCS_CopyResetList(*pListShared, *pListText)
   Flags$ = "[线程-"+Str(Index)+"] " + RSet("", Index, "-") + " "
   
;    方法1
   *pElements.string = MCS_FirstElement(*pListShared)
   While *pElements
      Debug Flags$ + *pElements\s
      *pElements = MCS_NextElement(*pListShared)
      Delay(1)
   Wend
   
;    ;方法2
;    ForEach ListText$()
;       Debug Flags$ + ListText$()
;       Delay(1)
;    Next 
   MCS_FreeResetList(*pListBackup, *pListShared)
EndProcedure

#winScreen = 0
#rtxScreen = 1

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget 
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "主窗体", WindowFlags)
EditorGadget(#rtxScreen, 0, 0, 400, 250)


For k = 1 To 50
   AddElement(ListText$()) : ListText$() = Str(k)
Next 
CreateThread(@Thread_SharedListEnum(), 1)
CreateThread(@Thread_SharedListEnum(), 2)
CreateThread(@Thread_SharedListEnum(), 3)
CreateThread(@Thread_SharedListEnum(), 4)
CreateThread(@Thread_SharedListEnum(), 5)

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
; CursorPosition = 267
; FirstLine = 227
; Folding = ---
; EnableThread
; EnableXP