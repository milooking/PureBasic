;***********************************************************
;************      ��·���ÿ�ģ��:����ģ��      ************
;************ ����: ��·Ǫ/Miloo [QQ:714095563] ************
;************        2019�� [2015.07.16]       *************
;***********************************************************
;������ֱ�ӱ���,��Դ�����ļ�Ϊ����ģ���ṩ����(����)֧��

; �����Ա�Ľṹ
Structure __MCS_ListElementInfo
   *pNextElement.__MCS_ListElementInfo
   *pPrevElement.__MCS_ListElementInfo
   *pElementContent
EndStructure

; ����ͷ���Ľṹ
Structure __MCS_ListHeaderInfo
   *pFirstElement.__MCS_ListElementInfo      ; ��һ��Ԫ�ص�ָ��
   *pLastElement.__MCS_ListElementInfo       ; ���һ��Ԫ�ص�ָ��
   *pCurrElement.__MCS_ListElementInfo       ; ��ǰԪ�ص�ָ��
   *pResetList.long                          ; ResetList()ֵ
   CountList.l                               ; Ԫ������
   ListIndex.l                               ; ��ǰԪ������
   Keep.l[4]
   ElementSize.l
   Alignment.l
EndStructure

; ����ResetList()�ṹ
Structure __MCS_ResetListInfo
   *pPointList.__MCS_ListHeaderInfo          ; ����ͷ��  ResetList()-4
   *pCurrElement.__MCS_ListElementInfo       ; ��ǰԪ��ָ��
EndStructure


;-====================================
; ��ȡ����Ĵ�С
Procedure MCS_ListSize(*pResetList)
   *pList.__MCS_ResetListInfo = *pResetList-4
   ProcedureReturn *pList\pPointList\CountList
EndProcedure

; ��ȡ����ǰԪ�ص�������
Procedure MCS_ListIndex(*pResetList)
   *pList.__MCS_ResetListInfo = *pResetList-4
   ProcedureReturn *pList\pPointList\ListIndex
EndProcedure

; ��ȡ����ǰԪ�ص����ݵ�ַ
Procedure MCS_CurrentElement(*pResetList)
   *pList.__MCS_ResetListInfo = *pResetList-4
   If *pList\pPointList\pCurrElement
      ProcedureReturn *pList\pPointList\pCurrElement+8
   Else 
      ProcedureReturn 0
   EndIf 
EndProcedure

;-
; ��ȡ�����һ��Ԫ��
Procedure MCS_FirstElement(*pResetList)
   *pList.__MCS_ResetListInfo = *pResetList-4
   *pElement = *pList\pPointList\pFirstElement
   CountList = *pList\pPointList\CountList
   If CountList And *pElement                         ; �����Ա����
      If *pElement <> *pList\pPointList\pCurrElement
         *pList\pPointList\ListIndex    = 0           ; ��������ǰԪ�ص�������
         *pList\pPointList\pCurrElement = *pElement   ; ��������ǰԪ�صĵ�ַ
         *pList\pCurrElement            = *pElement   ; ��������ǰԪ�صĵ�ַ
      EndIf 
      ProcedureReturn *pElement + 8
   Else 
      ProcedureReturn 0
   EndIf 
EndProcedure

; ��ȡ�������һ��Ԫ��
Procedure MCS_LastElement(*pResetList)
   *pList.__MCS_ResetListInfo = *pResetList-4
   *pElement = *pList\pPointList\pLastElement
   CountList = *pList\pPointList\CountList
   If CountList And *pElement                         ; �����Ա����
      If *pElement <> *pList\pPointList\pCurrElement
         *pList\pPointList\ListIndex    = CountList-1 ; ��������ǰԪ�ص�������
         *pList\pPointList\pCurrElement = *pElement   ; ��������ǰԪ�صĵ�ַ
         *pList\pCurrElement            = *pElement   ; ��������ǰԪ�صĵ�ַ
      EndIf 
      ProcedureReturn *pElement + 8
   Else 
      ProcedureReturn 0
   EndIf 
EndProcedure

; ��ȡ������һ��Ԫ��
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
   If *pElement       ; �����Ա����
      *pList\pPointList\ListIndex    = ListIndex+1    ; ��������ǰԪ�ص�������
      *pList\pPointList\pCurrElement = *pElement      ; ��������ǰԪ�صĵ�ַ
      *pList\pCurrElement            = *pElement      ; ��������ǰԪ�صĵ�ַ
      ProcedureReturn *pElement + 8
   Else 
      ProcedureReturn 0
   EndIf 
EndProcedure

; ��ȡ������һ��Ԫ��
Procedure MCS_PreviousElement(*pResetList) 
   *pList.__MCS_ResetListInfo = *pResetList-4
   *pElement = *pList\pPointList\pCurrElement\pPrevElement
   ListIndex = *pList\pPointList\ListIndex
   If *pList\pPointList\CountList And *pElement       ; �����Ա����
      *pList\pPointList\ListIndex    = ListIndex-1    ; ��������ǰԪ�ص�������
      *pList\pPointList\pCurrElement = *pElement      ; ��������ǰԪ�صĵ�ַ
      *pList\pCurrElement            = *pElement      ; ��������ǰԪ�صĵ�ַ
      ProcedureReturn *pElement + 8
   Else 
      ProcedureReturn 0
   EndIf 
EndProcedure

; ��������ѡ��һ��Ԫ��
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
         
      ElseIf Index < ListIndex                              ; �ڵ�ǰԪ��ǰ����
         If Index < ListIndex/2                             ; �ӵ�һ��Ԫ��������
            *pElement = \pFirstElement
            For k = 1 To Index            : *pElement = *pElement\pNextElement : Next 
         Else                                               ; �ӵ�ǰ������ǰ��
            *pElement = *pList\pPointList\pCurrElement\pPrevElement
            For k = Index To ListIndex    : *pElement = *pElement\pPrevElement : Next 
         EndIf 
      Else                                                  ; �ڵ�ǰԪ��������
         If Index > (CountList+ListIndex)/2                 ; �����һ��Ԫ��������
            *pElement = \pLastElement
            For k = CountList-1 To Index  : *pElement = *pElement\pPrevElement : Next 
         Else   
            *pElement =*pList\pPointList\pCurrElement\pNextElement
            For k = Index To ListIndex    : *pElement = *pElement\pNextElement : Next 
         EndIf 
      EndIf 
      \ListIndex           = Index          ; ��������ǰԪ�ص�������
      \pCurrElement        = *pElement      ; ��������ǰԪ�صĵ�ַ
      *pList\pCurrElement  = *pElement      ; ��������ǰԪ�صĵ�ַ
   EndWith
   ProcedureReturn *pElement+8
EndProcedure

;-
; ����һ����[A]��¡��ָ������������,��������ӵ��[A]�Ľṹ������
Procedure MCS_CopyResetList(*pNewResetList, *pInResetList)
   Global pmcsResetList.q
   MCS_LastElement(*pInResetList)
   CopyMemory_(@pmcsResetList,    *pNewResetList-04, 8) ;�����½���������Ϣ   
   ProcedureReturn CopyMemory_(*pNewResetList-04, *pInResetList-04,  8) ;ӳ�䵽������������
EndProcedure

; ��ԭ��¡����,���ڿ�¡�����ͷ�ǰ
Procedure MCS_FreeResetList(*pNewResetList)
   ProcedureReturn CopyMemory_(*pNewResetList-04, @pmcsResetList, 8)  ;��ԭ�½���������Ϣ     
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
;          *pElement\pPrevElement     = \pLastElement   ; ������Ԫ�ص���һ��Ԫ��Ϊ����ǰ�����һ��Ԫ��
;          *pElement\pNextElement     = 0               ; ������Ԫ�ص���һ��Ԫ��Ϊ��
;          \pLastElement\pNextElement = *pElement       ; ����ǰ�����һ��Ԫ�ص���һ��Ԫ��Ϊ����Ԫ��         
;          \ListIndex                 = \CountList      ; Ϊ����Ԫ������������
;          \CountList+1                                 ; �޸������Ԫ������
;          \pCurrElement              = *pElement       ; ��������ǰԪ�صĵ�ַ
;          *pList\pCurrElement        = *pElement       ; ��������ǰԪ�صĵ�ַ
;          \pLastElement              = *pElement       ; �������һ��Ԫ��
;       EndIf 
;    EndWith
;    ProcedureReturn *pElement+8
; EndProcedure
; 
; 
; ;-====================================
; ; ���Բ���
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