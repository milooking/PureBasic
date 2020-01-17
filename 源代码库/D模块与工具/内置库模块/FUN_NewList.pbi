;***********************************************************
;************      迷路内置库模块:链表模块      ************
;************ 作者: 迷路仟/Miloo [QQ:714095563] ************
;************        2019版 [2015.07.16]       *************
;***********************************************************
;不参与直接编译,此源代码文件为其它模块提供代码(包含)支持

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
      *pElement = *pList\pCurrElement\pNextElement
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
; 从另一链表[A]克隆到指定的新链表中,让新链表拥有[A]的结构和数据
Procedure MCS_CopyResetList(*pNewResetList, *pInResetList)
   Global pmcsResetList.q
   MCS_LastElement(*pInResetList)
   CopyMemory_(@pmcsResetList,    *pNewResetList-04, 8) ;备份新建的链表信息   
   ProcedureReturn CopyMemory_(*pNewResetList-04, *pInResetList-04,  8) ;映射到传入的链表操作
EndProcedure

; 还原克隆链表,用于克隆链表释放前
Procedure MCS_FreeResetList(*pNewResetList)
   ProcedureReturn CopyMemory_(*pNewResetList-04, @pmcsResetList, 8)  ;还原新建的链表信息     
EndProcedure























; 
; ProcedureDLL mcmAddElement_(*pResetList)
;    *pList.__MCM_ResetListInfo = *pResetList-4
;    ElementSize = (*pList\pPointList\ElementSize + Alignment)/4*4
;    *pElement.__MCM_ListElementInfo = AllocateMemory(ElementSize)
;    With *pList\pPointList
;       If \CountList = 0 
;          
;          
;       Else
;          *pElement\pPrevElement     = \pLastElement   ; 设置新元素的上一个元素为新增前的最后一个元素
;          *pElement\pNextElement     = 0               ; 设置新元素的下一个元素为空
;          \pLastElement\pNextElement = *pElement       ; 新增前的最后一个元素的下一个元素为新增元素         
;          \ListIndex                 = \CountList      ; 为新增元素设置索引号
;          \CountList+1                                 ; 修改链表的元素数量
;          \pCurrElement              = *pElement       ; 设置链表当前元素的地址
;          *pList\pCurrElement        = *pElement       ; 设置链表当前元素的地址
;          \pLastElement              = *pElement       ; 设置最后一个元素
;       EndIf 
;    EndWith
;    ProcedureReturn *pElement+8
; EndProcedure
; 
; 
; ;-====================================
; ; 测试部分
; NewList ListTest$()
; NewList ListTest2$()
; NewList ListTest3$()
; NewList ListTest4$()
; NewList ListTest5$()
; NewList ListTest6$()
; 
; *pResetList = ResetList(ListTest$())
; For k = 0 To 30
;   Debug  AddElement(ListTest$()) : ListTest$() = "XXX" + Str(010101 * k)
; Next 
; 
; 
; ; Debug "FirstElement 1 = 0x" + Hex(mcmFirstElement_(*pResetList)) + " : " + ListTest$()
; Debug "FirstElement 2 = 0x" + Hex(FirstElement(ListTest$()))     + " : " + ListTest$()
; Debug ""
; Debug "LastElement 1 = 0x" + Hex(mcmLastElement_(*pResetList)) + " : " + ListTest$()
; Debug "LastElement 2 = 0x" + Hex(LastElement(ListTest$()))     + " : " + ListTest$()
; Debug ""
; Debug "SelectElement 1 = 0x" + Hex(mcmSelectElement_(*pResetList, 55)) + " : " + ListTest$()
; Debug "SelectElement 2 = 0x" + Hex(SelectElement(ListTest$(), 55))     + " : " + ListTest$()
; Debug ""
; Debug "ListSize 1 = " + Str(mcmListSize_(*pResetList))
; Debug "ListSize 2 = " + Str(ListSize(ListTest$()))
; 
; Debug ""
; Debug "ListIndex 1 = " + Str(mcmListIndex_(*pResetList))
; Debug "ListIndex 2 = " + Str(ListIndex(ListTest$()))
; Debug "====================="
; mcmSelectElement_(*pResetList, 35)
; Debug "NextElement 1 = 0x" + Hex(mcmNextElement_(*pResetList)) + " : " + ListTest$()
; Debug "ListIndex 1 = " + Str(mcmListIndex_(*pResetList))
; Debug ""
; SelectElement(ListTest$(), 35)
; Debug "NextElement 2 = 0x" + Hex(NextElement(ListTest$()))     + " : " + ListTest$()
; Debug "ListIndex 2 = " + Str(ListIndex(ListTest$()))
; Debug "====================="
; mcmSelectElement_(*pResetList, 90)
; Debug "NextElement 1 = 0x" + Hex(mcmPreviousElement_(*pResetList)) + " : " + ListTest$()
; Debug "ListIndex 1 = " + Str(mcmListIndex_(*pResetList))
; Debug ""
; SelectElement(ListTest$(), 90)
; Debug "NextElement 2 = 0x" + Hex(PreviousElement(ListTest$()))     + " : " + ListTest$()
; Debug "ListIndex 2 = " + Str(ListIndex(ListTest$()))
; 
; *p = mcmAddElement_(*pResetList) : ListTest$() = "xxxxxxxxxxxxxxxxxxxx"
; Debug mcmAddElement_(*pResetList) : ListTest$() = "YYYYYYYYYYYYYYYYYYY"

; ForEach ListTest$()
;    Debug ListTest$()
; Next 

; FreeList(ListTest$())









; IDE Options = PureBasic 5.62 (Windows - x86)
; ExecutableFormat = Shared dll
; CursorPosition = 5
; Folding = Aw-
; EnableXP
; Constant = #MCS_Test=5