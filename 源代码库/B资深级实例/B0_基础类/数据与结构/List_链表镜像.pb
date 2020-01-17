;***********************************
;迷路仟整理 2019.02.02
;List_链表镜像
;***********************************
;List_链表镜像主要用于多线程间链表操作

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


;链表操作
NewList ListText$()        ;主体List对象
AddElement(ListText$()) : ListText$() = "中国"
AddElement(ListText$()) : ListText$() = "英国"
AddElement(ListText$()) : ListText$() = "韩国"
AddElement(ListText$()) : ListText$() = "日本"

*pResetList = ResetList(ListText$())           ;获取ListText$()表头地址指针
*pReset.__MCS_ResetListInfo = *pResetList-4


;【链表信息】
Debug "【链表信息】"
Debug "[原有] 0x" + Hex(*pResetList)
Debug "[镜像] 0x" + Hex(*pReset\pPointList\pResetList)

;【链表大小】
Debug "【链表大小】"
Debug "[原有] " + Str(ListSize(ListText$()))
Debug "[镜像] " + Str(MCS_ListSize(*pResetList))

;【选择元素】
Debug "【链表信息】"
*pElement = SelectElement(ListText$(), 1)
Debug "[原有] 0x" + Hex(*pElement)
*pElement = MCS_SelectElement(*pResetList, 1)
Debug "[镜像] 0x" + Hex(*pElement)

;【链表索引】
Debug "【链表索引】"
Debug "[原有] " + Str(ListIndex(ListText$()))
Debug "[镜像] " + Str(MCS_ListIndex(*pResetList))

;【当前元素】
Debug "【当前元素】"
Debug "[原有] " + Str(@ListText$())
Debug "[镜像] " + Str(MCS_CurrentElement(*pResetList))

;【首个元素】
Debug "【首个元素】"
Debug "[原有] " + Str(FirstElement(ListText$()))
Debug "[镜像] " + Str(MCS_FirstElement(*pResetList))

;【首个元素】
Debug "【首个元素】"
Debug "[原有] " + Str(LastElement(ListText$()))
Debug "[镜像] " + Str(MCS_LastElement(*pResetList))

;【历遍链表】
Debug "【历遍链表】"
ResetList(ListText$())
While NextElement(ListText$())
   Debug "[原有] " + ListText$()
Wend
Debug ""
*pElements.string = MCS_FirstElement(*pResetList)
While *pElements
   Debug "[镜像] " + *pElements\s
   *pElements = MCS_NextElement(*pResetList)
Wend













; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 33
; Folding = Ef-
; EnableXP