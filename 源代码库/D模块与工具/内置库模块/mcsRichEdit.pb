;��ע���Լ���TBManager���������ģ��(LIB),
;      ��[McsRichEdit]���Ƶ�[..\PureBasic-5.62-x86\PureLibraries\UserLibraries\]Ŀ¼��
;***********************************************************
;************  ��·PB�ؼ���[mcsRichEditGadget]  ************
;************ ����: ��·Ǫ/Miloo [QQ:714095563] ************
;************        2019�� [2019.01.13]       *************
;***********************************************************
; V0.09: �޸�ѡ��BUG;���Ʒ�������ַ���ѡ����� 2015.11.24
; V0.08: ���ģ�Ż�����,����ȫ�ı���ɨ�����,�޸��۵��е�BUG,�Ż��������ݽṹ, ����������22���ظ�Ϊ19����
; V0.07: ���PB���ڿؼ�������.��ӳ����ı���ʽ,������PB�ı���ʽ.
; V0.06: �Ż�����,������۵��и���,�����۵�������.
; V0.05: ����۵����۵�������
; V0.04: ��ӹؼ�����ɫ����, ���ѡ�д���ɫ����
; V0.03: ���ȫѡ����;�Ż��ı��ػ����,�������ػ��Ϊ�����ػ�,Ϊ�ؼ�����ɫ��׼��.
; V0.02: ��������;ѡ��������
; V0.01: �ؼ�PB������,��ӹ���������ش���.
;**********************************************************
; ע��˵��: []��ʾ�ؼ�/����, <>��ʾ�¼�/����, ()ע������ 
; ��������Ʒ���: 
; 1.��ǰ��ɫ�ͱ���ɫ������״̬�鹹������.����,���Ըı�������
; 2.��������Minimum=0, �Ҳ������Maximum===�ı�����, �ײ�������Maximum===����ı��п��.
; ��ʾ����Ʒ���: 
; [�༭��]:mcsRichEditGadget,[�༭��]:VeiwArea�������������ı���,[������]:ViewArea��ʾ�ı�����
; [�ı�������]���ڼ�¼ȫ���ı���,[����������]���ڼ�¼���۵�������
; ÿ���ı���,�Դ��ַ���Ϣ��,���ڼ�¼ȫ�ı��з������,��ʾʱ,�ٽ��ж��η���,��ӵ�ǰ��״̬,ѡ��״̬,ѡ�д�״̬��

;Callback(*this.Gadget, Window, Message, wParam, lParam)
;FreeGadget(*this.Gadget)
;GetGadgetState(*this.Gadget)
;SetGadgetState(*this.Gadget, State)
;GetGadgetText(*this.Gadget, PreviousStringPosition)
;SetGadgetText(*this.Gadget, *Text)
;AddGadgetItem2(*this.Gadget, Position, *Text, *Image)
;AddGadgetItem3(*this.Gadget, Position, *Text, *Image, Flags)
;RemoveGadgetItem(*this.Gadget, Item)
;ClearGadgetItemList(*this.Gadget)
;ResizeGadget(*this.Gadget, x, y, width, height)
;CountGadgetItems(*this.Gadget)
;GetGadgetItemState(*this.Gadget, Item)
;SetGadgetItemState(*this.Gadget, Item, State)
;GetGadgetItemText(*this.Gadget, Item, Column, PreviousStringPosition)
;SetGadgetItemText(*this.Gadget, Item, *Text, Column)
;OpenGadgetList2(*this.Gadget, Item)
;GadgetX(*this.Gadget)
;GadgetY(*this.Gadget)
;GadgetWidth(*this.Gadget)
;GadgetHeight(*this.Gadget)
;HideGadget(*this.Gadget, State)
;AddGadgetColumn(*this.Gadget, Item, *Text, Column)
;RemoveGadgetColumn(*this.Gadget, Position)
;GetGadgetAttribute(*this.Gadget, Attribute)
;SetGadgetAttribute(*this.Gadget, Attribute, Value)
;GetGadgetItemAttribute2(*this.Gadget, Item, Attribute, Column)
;SetGadgetItemAttribute2(*this.Gadget, Item, Attribute, Value, Column)
;SetGadgetColor(*this.Gadget, ColorType, Color)
;GetGadgetColor(*this.Gadget, ColorType)
;SetGadgetItemColor2(*this.Gadget, Item, ColorType, Color, Column)
;GetGadgetItemColor2(*this.Gadget, Item, ColorType, Column)
;SetGadgetItemData(*this.Gadget, Item, Value)
;GetGadgetItemData(*this.Gadget, Item)
;GetRequiredSize(*this.Gadget, *Width.integer, *Height.integer)
;SetActiveGadget(*this.Gadget)
;GetGadgetFont(*this.Gadget)
;SetGadgetFont(*this.Gadget, hFont)
;SetGadgetItemImage(*this.Gadget, hImage)

;- Import
Import ""
   PB_Object_GetOrAllocateID(Objects.i,ID.i)
   PB_Gadget_RegisterGadget(ID.i,*Gadget,hwnd.i,*GadgetVT)
   PB_Object_GetThreadMemory(MemoryID)
   SYS_GetOutputBuffer(StringLength, PreviousPosition)
   PB_Gadget_SendGadgetCommand(Gadget,Event)
   PB_Gadget_Globals.i
   PB_Gadget_Objects.i
EndImport

;{ ����
#GadgetClass_RichEdit$  = "mcsRichEdit"
#PB_GadgetType_RichEdit = 35
#Timer_Refresh_Flags  = 1   : #Timer_Refresh_Timer = 0001   ;����ˢ�µĴ���
#Timer_Scrolls_Flags  = 2   : #Timer_Scrolls_Timer = 0500   ;����ˢ�µĴ���
#Timer_AddItem_Flags  = 3   : #Timer_AddItem_Timer = 0010   ;����ˢ�µĴ���
#Timer_LDChick_Flags  = 4   : #Timer_LDChick_Timer = 500   ;����ˢ�µĴ���,˫����ʱ��־

#FoldState_Start   = $01    ; �۵��п�ʼ���ڵ�,
#FoldState_ToEnd   = $02    ; �۵��н������ڵ�
#FoldState_IsHide  = $10    ; �۵�������״̬
#FoldState_Closed  = $20    ; �۵��нڵ�ر�״̬

 
#Redraw_NotEvent   = $00   ; ��ʾû�ж���
#Redraw_SetCaret   = $01   ; ��ʾ������
#Redraw_ViewArea   = $02   ; ��ʾ�ػ滭��
#Redraw_FullArea   = $03   ; ��ʾ�ػ滭�沢���ù����


#EditState_EmptyText     = $0100   ; [�༭��]�����Ƿ�Ϊ��
#EditState_CaretVisible  = $0200   ; [��ʾ��]�Ƿ�Ϊ����״̬
#EditState_FoldVisible   = $0400   ; �Ƿ���ʾ[�۵���]

#FormatType_Common  = $00
#FormatType_PB      = $01
#FormatType_LUA     = $02
#FormatType_XML     = $03
#FormatType         = $FF

#Symbol_Space    = $00   ; �ո��
#Symbol_Number   = $01   ; ���ַ�
#Symbol_Letter   = $02   ; ��ĸ��, ����_, ����
#Symbol_Operator = $04   ; �����
#Symbol_Logical  = $08   ; �����
#Symbol_Define   = $10   ; �����,��".","[","]"�ȵ�
#Symbol_Special  = $20  
#Symbol_TabChar  = $40   
#Symbol_Other    = $80   ; ��ֵ��ʶ��, $

#Symbol_String   = $03

#Event_MouseOnTop = $10000    ;<�������>
#Event_MouseLDown = $20000    ;<�������>
#Event_MouseLToUp = $40000    ;<����ͷ�>
#Event_MouseMoveOn = #Event_MouseOnTop
#Event_MouseLClick = #Event_MouseMoveOn|#Event_MouseLDown

#Event_MarkArea  = $0100    ;[������]��ʶ
#Event_FoldArea  = $0200    ;[�۵���]��ʶ
#Event_VScroll   = $0410    ;[�Ҳ������]��ʶ
#Event_HScroll   = $0420    ;[�ײ�������]��ʶ
#Event_EditArea  = $0800    ;[������]��ʶ

#Event_MarkArea_OnTop = #Event_MouseMoveOn|#Event_MarkArea   ;[������]<�������>
#Event_MarkArea_LDown = #Event_MouseLClick|#Event_MarkArea   ;[������]<��갴��>
#Event_FoldArea_OnTop = #Event_MouseMoveOn|#Event_FoldArea   ;[�۵���]<�������>
#Event_FoldArea_LDown = #Event_MouseLClick|#Event_FoldArea   ;[�۵���]<��갴��>
#Event_EditArea_OnTop = #Event_MouseMoveOn|#Event_EditArea   ;[�ı���]<�������>
#Event_EditArea_LDown = #Event_MouseLClick|#Event_EditArea   ;[�ı���]<��갴��>
#Event_EditArea_OTSelected = #Event_MouseLClick|#Event_EditArea|1   ;[�ı���]<���ѡ������>


#Event_VScrollM_OnTop = #Event_MouseMoveOn|$410   ;[�Ҳ������|��Ƭ����]<�������>
#Event_VScrollT_OnTop = #Event_MouseMoveOn|$411   ;[�Ҳ������|�ϼʰ���]<�������>
#Event_VScrollB_OnTop = #Event_MouseMoveOn|$412   ;[�Ҳ������|�¼ʰ���]<�������>
#Event_VScrollW_OnTop = #Event_MouseMoveOn|$413   ;[�Ҳ������|���ư���]<�������>
#Event_VScrollS_OnTop = #Event_MouseMoveOn|$414   ;[�Ҳ������|���ư���]<�������>

#Event_VScrollM_LDown = #Event_MouseLClick|$410   ;[�Ҳ������|��Ƭ����]<��갴��>
#Event_VScrollT_LDown = #Event_MouseLClick|$411   ;[�Ҳ������|�ϼʰ���]<��갴��>
#Event_VScrollB_LDown = #Event_MouseLClick|$412   ;[�Ҳ������|�¼ʰ���]<��갴��>
#Event_VScrollW_LDown = #Event_MouseLClick|$413   ;[�Ҳ������|���ư���]<��갴��>
#Event_VScrollS_LDown = #Event_MouseLClick|$414   ;[�Ҳ������|���ư���]<��갴��>

#Event_HScrollM_OnTop = #Event_MouseMoveOn|$420   ;[�ײ�������|��Ƭ����]<�������>
#Event_HScrollL_OnTop = #Event_MouseMoveOn|$421   ;[�ײ�������|��ʰ���]<�������>
#Event_HScrollR_OnTop = #Event_MouseMoveOn|$422   ;[�ײ�������|�Ҽʰ���]<�������>
#Event_HScrollA_OnTop = #Event_MouseMoveOn|$423   ;[�ײ�������|���ư���]<�������>
#Event_HScrollD_OnTop = #Event_MouseMoveOn|$424   ;[�ײ�������|���ư���]<�������>

#Event_HScrollM_LDown = #Event_MouseLClick|$420   ;[�ײ�������|��Ƭ����]<��갴��>
#Event_HScrollL_LDown = #Event_MouseLClick|$421   ;[�ײ�������|��ʰ���]<��갴��>
#Event_HScrollR_LDown = #Event_MouseLClick|$422   ;[�ײ�������|�Ҽʰ���]<��갴��>
#Event_HScrollA_LDown = #Event_MouseLClick|$423   ;[�ײ�������|���ư���]<��갴��>
#Event_HScrollD_LDown = #Event_MouseLClick|$424   ;[�ײ�������|���ư���]<��갴��>
;}

Enumeration
   #FoldStart
   #FoldToEnd
   #KeyWord01
   #KeyWord02
   #KeyWord03
   #KeyWord04
   #KeyWord05
   #KeyWordCount
EndEnumeration

Enumeration 1
   #MCS_RichEdit_Format       ; �ؼ����ı���������
   #MCS_RichEdit_FoldBar      ; �ؼ����۵���
   #MCS_RichEdit_FoldStart
   #MCS_RichEdit_FoldToEnd
   #MCS_RichEdit_KeyWord01
   #MCS_RichEdit_KeyWord02
   #MCS_RichEdit_KeyWord03
   #MCS_RichEdit_KeyWord04
   #MCS_RichEdit_KeyWord05
   #PB_Gadget_FontStlye = 3
   #PB_Gadget_FontColor = #PB_Gadget_FrontColor
EndEnumeration

; �ַ���ʽ
Enumeration
   ;=================
   #Format_ViewArea  ; ����ʽ
   #Format_Comments  ; ע���ı���ʽ
   #Format_Constant  ; ������ʽ
   #Format_DQString  ; ˫���Ÿ�ʽ
   #Format_SQString  ; �����Ÿ�ʽ
   #Format_Special1  ; �����ʽ
   #Format_Special2  ; �����ʽ
   #Format_Operator  ; �����
   #Format_FoldWord  ; �۵��ʸ�ʽ
   #Format_KeyWord1  ; �ؼ��ʸ�ʽ
   #Format_KeyWord2
   #Format_KeyWord3
   #Format_KeyWord4
   #Format_KeyWord5
   #Format_Function  ; ������ʽ
   #Format_TipWords  ; ѡ�дʸ�ʽ
   ;=================
   #Format_Selected  ; ѡ����ʽ
   #Format_CaretRow  ; ����и�ʽ         
   #Format_MarkArea  ; �з���|�۵�����ʽ   
   #Format_NScroll   ;������<����״̬>
   #Format_MScroll   ;������<����״̬>
   #Format_DScroll   ;������<��ס״̬>
   #Format_Count
EndEnumeration

;- Structure
;{ 
; PB�Դ�������ṹ
Structure __PBGadgetCommand
  GadgetType.l   
  SizeOf.l       
  GadgetCallback.i
  FreeGadget.i
  GetGadgetState.i
  SetGadgetState.i
  GetGadgetText.i
  SetGadgetText.i
  AddGadgetItem2.i
  AddGadgetItem3.i
  RemoveGadgetItem.i
  ClearGadgetItems.i
  ResizeGadget.i
  CountGadgetItems.i
  GetGadgetItemState.i
  SetGadgetItemState.i
  GetGadgetItemText.i
  SetGadgetItemText.i
  OpenGadgetList2.i
  GadgetX.i
  GadgetY.i
  GadgetWidth.i
  GadgetHeight.i
  HideGadget.i
  AddGadgetColumn.i
  RemoveGadgetColumn.i
  GetGadgetAttribute.i
  SetGadgetAttribute.i
  GetGadgetItemAttribute2.i
  SetGadgetItemAttribute2.i
  SetGadgetColor.i
  GetGadgetColor.i
  SetGadgetItemColor2.i
  GetGadgetItemColor2.i
  SetGadgetItemData.i
  GetGadgetItemData.i
  ;====================
   GetRequiredSize.i
   SetActiveGadget.i
   GetGadgetFont.i
   SetGadgetFont.i
   SetGadgetItemImage.i
EndStructure

; PB�ؼ���ָ��ṹ
Structure __PBGadgetPointer
   Gadget.i
   *pCommand.__PBGadgetCommand
   UserData.i
   OldCallback.i
   Daten.l[4]
EndStructure




; [�༭��]�Ĺ��
Structure __RichEdit_Cursor
   hARROW.i    ; [��ʽ��ͷ���]���
   hIBEAM.i    ; [�����ͷ���]���
   hRMARK.i    ; [����״̬���]���
   Row.l       ; ��ʾ����������
   RealRow.l   ; ʵ��������(�ַ�),���ı�������
   RealCol.l   ; ʵ����λ��(�ַ�)
   Col.w       ; ��ʾ����������
   IsInFold.b  ; �Ƿ�������۵�������
   IsLDChick.b ; ˫��ѡ����ʱ��־
EndStructure

; [�༭��]���ַ���ʽ
Structure __RichEdit_Format
   FontColor.l       ;����ɫ/ǰ��ɫ
   BackColor.l       ;����ɫ
   FontStyle.b       ;�����־:0=����,1=����,2=б��,3=����|б��
   KeepB.b[3]        ;�����ռ�,�Զ����ֽ�
EndStructure

; [�༭��]���ַ���ʽ
Structure __RichEdit_FontInfo
   ID.l[4]     ;����ID: 0=����,1=����,2=б��,3=����|б��
   hFont.l
   Name$    ;��������
   Size.a   ;�����С
   TapCount.a
   TapWith.w   
   H.w      ;����߶�
   W.w      ;����������
EndStructure

; [�༭��]�Ĺ�������Ϣ
Structure __RichEdit_Scroll
   SetpScale.f       ; [��Ƭ]�Ĳ���ֵ
   VanePos.w         ; [��Ƭ]��ǰλ��     
   VaneSize.w        ; [��Ƭ]��С 
   MouseDownPos.w    ; [��Ƭ]<����>ʱ�����X/Y����ֵ
   RecordingPos.w    ; [��Ƭ]<����>ʱ��[��Ƭ]X/Y����ֵ
   PageLine.l        ; [��Ƭ]<����>ʱ��[��Ƭ]��ҳ�Ľ�����
   VaneLast.l        ; [��Ƭ]������λ��
EndStructure

; [�༭��]�ĵ��ַ���Ϣ
Structure __RichEdit_EditChar
   Format.a       ; �ؼ���ʽ����
   Symbol.b       ; �ַ������ʶ
EndStructure

; [�༭��]�ĵ��ַ���Ϣ
Structure __RichEdit_ViewChar
   X.l
   W.l               ;�ַ��Ŀ��
   iFontStyle.a      ;�����־:0=����,1=����,2=б��,3=����|б��
   iFontColor.a      ;�ַ���ʽ:����ʲô����ɫ
   iBackColor.a      ;�ַ���ʽ:����ʲô����ɫ
   CharSymbol.b      ;�ַ������ʶ
EndStructure

; [�༭��]���ı�����Ϣ
Structure __RichEdit_TextLine
   ItemData.i        ; Set/GetGadgetItemData()����
   LineText$         ; ���ı�����
   LineWidth.l       ; ���ı��Ŀ��[����ʱ,������С,�ֽ�*�Ӵ�������,��ʾ��,��ʵ�ʿ�ȼ�]
   CountChars.w      ; ���ı��ַ�����[����ʱ,���ӵ�˫�ֽ�,��ʾ��,��ʵ���ֽڼ�]
   FoldFloor.a       ; �۵����Ĳ���
   FoldState.b       ; �۵�����״̬,
   HideState.b
   Keep.b[3]
   *pMemEditChar     ; [�ı���]�ڴ��(__RichEdit_EditChar)
EndStructure

; [�༭��]�ķ��۵��е��ı�����Ϣ
Structure __RichEdit_EditLine
   LineIndex.l       ; [�ı���]��������
   LastCursorX.w   ; ��β�Ĺ��λ��
   CurrCursorX.w   
   *pElement.__RichEdit_TextLine
EndStructure

; [������]����ʾ����Ϣ[�����ؼ�]
Structure __RichEdit_Gadget
   X.w   ; [�༭��]���:<ResizeGadget>ʱˢ��
   Y.w   ; [�༭��]�Ҽ�:<ResizeGadget>ʱˢ�� 
   R.w   ; [�༭��]�Ҽ�:<ResizeGadget>ʱˢ��   
   B.w   ; [�༭��]�¼�:<ResizeGadget>ʱˢ��     
   W.w   ; [�༭��]���:<ResizeGadget>ʱˢ��  
   H.w   ; [�༭��]�߶�:<ResizeGadget>ʱˢ��   
EndStructure

; [������]����ʾ����Ϣ[���ַ���]
Structure __RichEdit_Viewer
   X.w         ; [������|�༭��|����]��� 
   Y.w         ; [������|�༭��|����]�ϼ�:<SetGadgetFont>ʱˢ��
   W.w         ; [������|�༭��|����]��� 
   H.w         ; [������|�༭��|����]�߶�
;    LimitPos.l  ; [������|�ַ�]���ڿ�����������λ��   
   ;========================
   Row.l       ; [������|�ַ�]�ϼ�  
   Col.w       ; [������|�ַ�]��� 
   MarkW.w     ; [�з���|����]���     
   HoldRows.w  ; [������|�ַ�]���ɵ�����  
   HoldCols.w  ; [������|�ַ�]���ɵ�����
   LastLine.l  ; [������|�ַ�]�����һ������
;    LastChar.l  ; [������|�ַ�]�����һ������
EndStructure

; [ѡ����]��Ϣ
Structure __RichEdit_FoldArea
   StartRow.l       
   ToEndRow.l 
   W.w         ; [�۵���|����]���:<SetGadgetFont>ʱˢ��  
   Size.a      ; [�۵���|����]�۵����Ĵ�С
   Floor.a     ; [�۵���]�۵�����
EndStructure

; [ѡ����]��Ϣ
Structure __RichEdit_Record
   Row.l       ; ��¼ѡ����������
   RealRow.l   ; ʵ��������(�ַ�),���ı�������
   RealCol.l   ; ʵ����λ��(�ַ�)
   Col.w       ; ��¼ѡ����������
   IsInFold.b  ; �Ƿ�������۵�������
   Keep.b 
EndStructure

;}

; �ؼ���Ϣ
Structure __RichEditInfo
   GadgetID.i        ; �ؼ�ID
   hGadget.i         ; �ؼ����
   hBrushBack.i      ; ����ˢ[����ͼƬ]
   hGadgetFont.i     ; ��ǰ��������
   CurrEvnetHook.i   ; ��ǰ��HOOK�¼���ʶ
   PrevEvnetHook.i   ; ��һ����HOOK�¼���ʶ
   hMouseHook.i      ; ��ǰ��������
   ;=================
   EditState.l  
   FormatType.l     ;
   DelayTime.l   
   AddLineWidth.l 
   FlagsWord$
   KeyWord$[#KeyWordCount]
   ;=================
   VScroll.__RichEdit_Scroll  ; [�Ҳ������]
   HScroll.__RichEdit_Scroll  ; [�ײ�������] 
   Cursor.__RichEdit_Cursor   ; [���]��Ϣ
   Record.__RichEdit_Record   ; [ѡ��]��¼��Ϣ
   Gadget.__RichEdit_Gadget   ; [�ؼ�]�����Ϣ
   Viewer.__RichEdit_Viewer   ; [������]��Ϣ
   Fold.__RichEdit_FoldArea   ; [�۵���]��Ϣ
   Font.__RichEdit_FontInfo   ; [�ؼ�]�ַ���Ϣ   
   Format.__RichEdit_Format[#Format_Count]   ; �ؼ���ʽ
   *pMemViewChar                             ; [������]�ڴ��(__RichEdit_ViewChar)
   *pMaxTextLine.__RichEdit_TextLine         ; �ı�����,�����п����ָ��
   List ListTextLine.__RichEdit_TextLine()   ; ��¼ȫ�����ı���
   List ListEditLine.__RichEdit_EditLine()   ; ��¼���۵����ı�����Ϣ
   
EndStructure

#RichEdit_EditCharSize = SizeOf(__RichEdit_EditChar)
#RichEdit_ViewCharSize = SizeOf(__RichEdit_ViewChar)      ; �ṹ�Ĵ�С
#RichEdit_MaxLineChars = 1024    ;�����п�
#RichEdit_MaxShowLines = 300     ;ÿ�����300��
#RichEdit_FullRowBytes = #RichEdit_MaxLineChars * #RichEdit_ViewCharSize 

Global *pCurrRichEdit.__RichEditInfo
Global *pPrevRichEdit.__RichEditInfo

;- =======================
; ��ȡ����ֵ
Procedure RichEdit_Limit(Value, LowerLimit, UpperLimit)
   If Value < LowerLimit
      ProcedureReturn LowerLimit
   ElseIf Value > UpperLimit
      ProcedureReturn UpperLimit
   Else 
      ProcedureReturn Value
   EndIf 
EndProcedure 

;- ***********************
; ���ÿؼ��Ľ�����ʽ,Ĭ����: ����/PB/LUA/XML[δ��ɺ�����]
Procedure RichEdit_SetFormatType(*pRichEdit.__RichEditInfo, FormatType=0)
   With *pRichEdit  
      \FormatType = FormatType
      Select FormatType
         Case #FormatType_Common  
            CopyMemory_(\Format, ?_Bin_FormatOfCommon, #Format_Count*SizeOf(__RichEdit_Format))
            \KeyWord$[#FoldStart] = ""  ; �۵���[��ʼ����]
            \KeyWord$[#FoldToEnd] = ""  ; �۵���[��������]
            \KeyWord$[#KeyWord01] = ""  ; �ж�/ѡ��/ѭ���Ƚṹ
            \KeyWord$[#KeyWord02] = ""  ; ����/����
            \KeyWord$[#KeyWord03] = ""  ; ������/����
            \KeyWord$[#KeyWord04] = ""  ; Ԥ�����û��������
            \KeyWord$[#KeyWord05] = ""  ; Ԥ�����û��������
            
         Case #FormatType_PB 

            \EditState | #EditState_FoldVisible
            CopyMemory_(\Format, ?_Bin_FormatOfPB, #Format_Count*SizeOf(__RichEdit_Format))
            ;�۵���[��ʼ����]
            \KeyWord$[#FoldStart] = " Enumeration Structure StructureUnion Procedure Procedure$ ProcedureDLL ProcedureCDLL Interface"
            \KeyWord$[#FoldStart] + " DeclareModule UseModule CompilerIf CompilerSelect"
            \KeyWord$[#FoldStart] + " Module Import ImportC Macro DataSection ;{ "
            
            ;�۵���[��������]
            \KeyWord$[#FoldToEnd] = " EndEnumeration EndStructure EndStructureUnion EndProcedure EndInterface"
            \KeyWord$[#FoldToEnd] + " EndDeclareModule UnuseModule CompilerEndIf CompilerEndSelect"
            \KeyWord$[#FoldToEnd] + " EndModule EndImport EndImportC EndMacro EndDataSection ;} "
            
            ;�ж�/ѡ��/ѭ���Ƚṹ
            \KeyWord$[#KeyWord01] = " If Else ElseIf EndIf Select Case Default EndSelect"      
            \KeyWord$[#KeyWord01] + " For To Step ForEach Next While Wend Repeat Until ForEver With EndWith"      
            \KeyWord$[#KeyWord01] + " ProcedureReturn Break Continue Gosub Return Swap Goto End Runtime Threaded "
            ;����/����
            \KeyWord$[#KeyWord02] = " IncludeFile XIncludeFile IncludeBinary IncludePath "      
            \KeyWord$[#KeyWord02] + " Declare DeclareC DeclareCDLL DeclareDLL"
            \KeyWord$[#KeyWord02] + " Global Define Protected Shared Static Prototype Pseudotype"
            \KeyWord$[#KeyWord02] + " Extends NewList List NewMap Map Dim ReDim Array Data Restore Read "
            ; ������/����
            \KeyWord$[#KeyWord03] = " Debug DebugLevel DisableDebugger CallDebugger EnableDebugger"
            \KeyWord$[#KeyWord03] + " CompilerElse CompilerElseIf"
            \KeyWord$[#KeyWord03] + " CompilerCase CompilerWarning CompilerError"
            \KeyWord$[#KeyWord03] + " CompilerError EnableExplicit DisableExplicit EnableASM DisableASM "
            
         Case #FormatType_LUA  
            \EditState  | #EditState_FoldVisible
            CopyMemory_(\Format, ?_Bin_FormatOfLUA, #Format_Count*SizeOf(__RichEdit_Format))
            \KeyWord$[#FoldStart] = " --{ function if while for foreach repeat do "           ; �۵���[��ʼ����]
            \KeyWord$[#FoldToEnd] = " --} end "           ; �۵���[��������]
            \KeyWord$[#KeyWord01] = " then else elseif return in break "                      ; �ж�/ѡ��/ѭ���Ƚṹ
            \KeyWord$[#KeyWord02] = " local type require setmetatable _index __newindex "     ; ����/����
            \KeyWord$[#KeyWord03] = " and or xor not "    ; �߼������
            \KeyWord$[#KeyWord04] = " nil true false "    ; ����
            \KeyWord$[#KeyWord05] = ""                    ; Ԥ�����û��������
            
         Case #FormatType_XML    
            ;��ǰû�д���XML�Ĵ���,�������߱�д
            \EditState  | #EditState_FoldVisible
            CopyMemory_(\Format, ?_Bin_FormatOfCommon, #Format_Count*SizeOf(__RichEdit_Format))
            \KeyWord$[#FoldStart] = ""  ; �۵���[��ʼ����]
            \KeyWord$[#FoldToEnd] = ""  ; �۵���[��������]
            \KeyWord$[#KeyWord01] = ""  ; �ж�/ѡ��/ѭ���Ƚṹ
            \KeyWord$[#KeyWord02] = ""  ; ����/����
            \KeyWord$[#KeyWord03] = ""  ; ������/����
            \KeyWord$[#KeyWord04] = ""  ; Ԥ�����û��������
            \KeyWord$[#KeyWord05] = ""  ; Ԥ�����û��������
            
      EndSelect
   EndWith
EndProcedure

; ���ÿؼ��Ľ�����ʽ PB
Procedure RichEdit_ParserEditChar_Com(*pRichEdit.__RichEditInfo, Index)
   With *pRichEdit
      *pEditChar.__RichEdit_EditChar   ; �ַ���Ϣָ��:��־ÿ���ַ��ĸ�ʽ���ַ�����
      *pFindChar.__RichEdit_EditChar   ; �ַ���Ϣָ��
      *pTextLine.__RichEdit_TextLine   ; �ı���ָ��
      \pMaxTextLine = FirstElement(\ListTextLine())
      *pTextLine = SelectElement(\ListTextLine(), Index)
      While *pTextLine
         *pEditChar = *pTextLine\pMemEditChar
         CurrFormat = #Format_ViewArea
         NextFormat = #Format_ViewArea
         PrevSymbol = #Symbol_Space
         CurrSymbol = #Symbol_Space
         BuildWord$ = #Null$
         For Index = 1 To *pTextLine\CountChars
            CurrChar$ = Mid(*pTextLine\LineText$, Index, 1)
            iCurrChar = Asc(CurrChar$)
            Select iCurrChar
               Case $41 To $5A               : CurrSymbol = #Symbol_Letter      ; ��д��ĸ
               Case $61 To $7A               : CurrSymbol = #Symbol_Letter      ; Сд��ĸ/�»���
               Case $30 To $39               : CurrSymbol = #Symbol_Number      ; ���ַ���
               Case $25,$2B,$2D,$2F,$2A      : CurrSymbol = #Symbol_Operator    ; �����[%+-/*]
               Case $21,$26,$5E,$7C,$7E,$5F  : CurrSymbol = #Symbol_Operator    ; �����[!&^|~_]                  
               Case $3C To $3E               : CurrSymbol = #Symbol_Operator    ; �����[<=>]
               Case $2E                      : CurrSymbol = #Symbol_Define      ; ������[.]
               Case $09                      : CurrSymbol = #Symbol_TabChar     ; 
               Case $3F,$40,$22,$27,$23,$24  : CurrSymbol = #Symbol_Other       ; ����[?@"'#$]
               Case $2C,$3A,$3B,$5C,$60      : CurrSymbol = #Symbol_Other       ; ����[,:;\`]
               Case $28,$29,$5B,$5D,$7B,$7D  : CurrSymbol = #Symbol_Other       ; ����[()[]{}]
               Case $20                      : CurrSymbol = #Symbol_Space    
               Default                       : CurrSymbol = #Symbol_Letter
            EndSelect
            ; ******************************
            ; ������ʵ���ʽ
            ;============================== ע������
            If CurrSymbol & #Symbol_String 
               BuildWord$+CurrChar$ : WordSymbol | CurrSymbol
            ElseIf BuildWord$ <> #Null$ 
               IsGotoFind = #True 
            EndIf 
            
            FindFormat = #Null
            If IsGotoFind = #True Or (Index = *pTextLine\CountChars And BuildWord$ <> #Null$)
               If WordSymbol & #Symbol_Operator = 0 And CurrSymbol & #Symbol_Special = 0
                  FindWord$ = " " + BuildWord$ + " "
                  If     FindString(\KeyWord$[#FoldStart], FindWord$, 1) : FindFormat = #Format_FoldWord : StartFold = #True
                  ElseIf FindString(\KeyWord$[#FoldToEnd], FindWord$, 1) : FindFormat = #Format_FoldWord : ToEndFold = #True
                  ElseIf FindString(\KeyWord$[#KeyWord01], FindWord$, 1) : FindFormat = #Format_KeyWord1
                  ElseIf FindString(\KeyWord$[#KeyWord02], FindWord$, 1) : FindFormat = #Format_KeyWord2
                  ElseIf FindString(\KeyWord$[#KeyWord03], FindWord$, 1) : FindFormat = #Format_KeyWord3
                  ElseIf FindString(\KeyWord$[#KeyWord04], FindWord$, 1) : FindFormat = #Format_KeyWord4
                  ElseIf FindString(\KeyWord$[#KeyWord05], FindWord$, 1) : FindFormat = #Format_KeyWord5
                  EndIf 
                  If FindFormat <> #Null 
                     *pFindChar = *pEditChar
                     If IsGotoFind = #True : *pFindChar - #RichEdit_EditCharSize : EndIf
                     EndFindPos = Index-Len(BuildWord$)+1
                     For x = Index To EndFindPos Step - 1
                        *pFindChar\Format = FindFormat
                        *pFindChar - #RichEdit_EditCharSize
                     Next 
                     If Index = *pTextLine\CountChars And CurrSymbol & #Symbol_String 
                        CurrFormat = FindFormat 
                     EndIf 
                  EndIf 
               EndIf 
               IsGotoFind = #False
               WordSymbol = #Null
               BuildWord$ = #Null$
            EndIf 
            *pEditChar\Format = CurrFormat
            *pEditChar\Symbol = CurrSymbol
            *pEditChar + #RichEdit_EditCharSize
            CurrFormat = NextFormat
            PrevSymbol = CurrSymbol
         Next 
         
         If StartFold = #True And ToEndFold = #True
            StartFold = #False : ToEndFold = #False
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #Null
         ElseIf StartFold = #True 
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #FoldState_Start   ; �۵��п�ʼ���ڵ�
            FoldFloor + 1 : CountFold + 1 : StartFold = #False
         ElseIf ToEndFold = #True And CountFold > 0
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #FoldState_ToEnd   ; �۵��н������ڵ�
            CountFold - 1 : FoldFloor - 1 : ToEndFold = #False
         Else 
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #Null
         EndIf  
         *pTextLine = NextElement(*pRichEdit\ListTextLine())
         LineIndex+1
         If \pMaxTextLine And \pMaxTextLine\LineWidth < \ListTextLine()\LineWidth
            \pMaxTextLine = *pTextLine           ; ���������ı���
         EndIf 
      Wend 
   EndWith
EndProcedure

; ���ÿؼ��Ľ�����ʽ LUA
Procedure RichEdit_ParserEditChar_PB(*pRichEdit.__RichEditInfo, Index)
   With *pRichEdit
      *pEditChar.__RichEdit_EditChar   ; �ַ���Ϣָ��:��־ÿ���ַ��ĸ�ʽ���ַ�����
      *pFindChar.__RichEdit_EditChar   ; �ַ���Ϣָ��
      *pTextLine.__RichEdit_TextLine   ; �ı���ָ��
      \pMaxTextLine = FirstElement(\ListTextLine())
      *pTextLine = SelectElement(\ListTextLine(), Index)
      While *pTextLine
         *pEditChar = *pTextLine\pMemEditChar
         CurrFormat = #Format_ViewArea
         NextFormat = #Format_ViewArea
         PrevSymbol = #Symbol_Space
         CurrSymbol = #Symbol_Space
         BuildWord$ = #Null$
         For Index = 1 To *pTextLine\CountChars
            CurrChar$ = Mid(*pTextLine\LineText$, Index, 1)
            iCurrChar = Asc(CurrChar$)
            Select iCurrChar
               Case $41 To $5A               : CurrSymbol = #Symbol_Letter      ; ��д��ĸ
               Case $61 To $7A               : CurrSymbol = #Symbol_Letter      ; Сд��ĸ/�»���
               Case $30 To $39               : CurrSymbol = #Symbol_Number      ; ���ַ���
               Case $25,$2B,$2D,$2F          : CurrSymbol = #Symbol_Operator    ; �����[%+-/]
               Case $21,$26,$5E,$7C,$7E      : CurrSymbol = #Symbol_Operator    ; �����[!&^|~]                  
               Case $3C To $3E               : CurrSymbol = #Symbol_Operator    ; �����[<=>]
               Case $2E                      : CurrSymbol = #Symbol_Define      ; ������[.]
               Case $09                      : CurrSymbol = #Symbol_TabChar     ; 
               Case $3F,$40,$22,$27          : CurrSymbol = #Symbol_Other       ; ����[?@"']
               Case $2C,$3A,$3B,$5C,$60      : CurrSymbol = #Symbol_Other       ; ����[,:;\`]
               Case $28,$29,$5B,$5D,$7B,$7D  : CurrSymbol = #Symbol_Other       ; ����[()[]{}]
               Case $20                      : CurrSymbol = #Symbol_Space    
               Case $23                      : CurrSymbol = #Symbol_Special|#Symbol_Number   ; ����[#]
               Case $24                      : CurrSymbol = #Symbol_Other|#Symbol_String     ; ����[$]
               Case $2A, $5F                 : CurrSymbol = #Symbol_Operator|#Symbol_String  ; ����[*]
               Default                       : CurrSymbol = #Symbol_Letter
            EndSelect
            ; ******************************
            ; ������ʵ���ʽ
            ;============================== ע������
            
            If CurrFormat = #Format_Comments  
            ElseIf CurrFormat = #Format_Special1 And CurrSymbol & #Symbol_String And CurrSymbol & #Symbol_Operator = 0
            ElseIf CurrFormat = #Format_Constant And CurrSymbol & #Symbol_String 
               If CurrSymbol & #Symbol_Special : NextFormat = #Format_ViewArea : EndIf     
            ElseIf CurrFormat = #Format_DQString                          
               If iCurrChar = '"' : NextFormat = #Format_ViewArea : EndIf                
            ElseIf CurrFormat = #Format_SQString 
               If CurrChar$ = "'" : NextFormat = #Format_ViewArea : EndIf 
            ;============================== ;����NextFormat
            ElseIf CurrChar$ = ";" 
               If Mid(*pTextLine\LineText$, Index, 2) = ";{"
                  StartFold = #True
               ElseIf Mid(*pTextLine\LineText$, Index, 2) = ";}"
                  ToEndFold = #True               
               EndIf
               CurrFormat = #Format_Comments : NextFormat = #Format_Comments
                
            ElseIf CurrChar$ = "#" 
               CurrFormat = #Format_Constant : NextFormat = #Format_Constant                 
            ElseIf iCurrChar = '"' 
               CurrFormat = #Format_DQString : NextFormat = #Format_DQString
            ElseIf CurrChar$ = "'"
               CurrFormat = #Format_SQString : NextFormat = #Format_SQString 
            ElseIf CurrChar$ = "$" And BuildWord$ = #Null$
               CurrFormat = #Format_Special1 : NextFormat = #Format_Special1
            ;============================== 
            
            ElseIf CurrChar$ = " " Or CurrChar$ = "." Or iCurrChar = 09
               CurrFormat = #Format_ViewArea : NextFormat = #Format_ViewArea : IsGotoFind = #True 
            ElseIf CurrChar$ = "(" 
               CurrFormat = #Format_ViewArea : NextState = #Format_ViewArea  : IsFunction = #True 

            Else 
               CurrFormat = #Format_ViewArea : NextFormat = #Format_ViewArea
            EndIf 
            
            If CurrFormat = #Format_ViewArea And CurrSymbol & #Symbol_String And CurrSymbol & #Symbol_Special = 0
               BuildWord$+CurrChar$ : WordSymbol | CurrSymbol
            ElseIf IsGotoFind = #True 
               If BuildWord$ = #Null$ : IsGotoFind = #False  : EndIf
            Else 
               BuildWord$ = #Null$ : WordSymbol = #Null
            EndIf 
            
            FindFormat = #Null
            If IsFunction = #True
               *pFindChar = *pEditChar - #RichEdit_EditCharSize
               IsFindFunc = #False
               For x = Index To 0 Step - 1
                  If IsFindFunc = #False And *pFindChar\Symbol & #Symbol_String  
                     ItemToEnd = x : IsFindFunc = #True  
                  ElseIf IsFindFunc = #True And *pFindChar\Symbol & #Symbol_Define  
                     IsFindFunc = #False   
                  ElseIf IsFindFunc = #True And *pFindChar\Symbol & #Symbol_String = 0  
                     ItemStart = x : Break  
                  EndIf 
                  *pFindChar - #RichEdit_EditCharSize
               Next 

               ; ����ҵ������� 
               If IsFindFunc = #True
                   *pFindChar + #RichEdit_EditCharSize
                  For x = ItemStart+1 To ItemToEnd
                     *pFindChar\Format = #Format_Function
                     *pFindChar + #RichEdit_EditCharSize
                  Next  
                  IsFindFunc = #False
               EndIf 
               IsFunction = #False
               WordSymbol = #Null
               BuildWord$ = #Null$
               
            ElseIf IsGotoFind = #True Or (Index = *pTextLine\CountChars And BuildWord$ <> #Null$)
               If WordSymbol & #Symbol_Operator = 0 And CurrSymbol & #Symbol_Special = 0
                  FindWord$ = " " + BuildWord$ + " "
                  If     FindString(\KeyWord$[#FoldStart], FindWord$, 1) : FindFormat = #Format_FoldWord : StartFold = #True
                  ElseIf FindString(\KeyWord$[#FoldToEnd], FindWord$, 1) : FindFormat = #Format_FoldWord : ToEndFold = #True
                  ElseIf FindString(\KeyWord$[#KeyWord01], FindWord$, 1) : FindFormat = #Format_KeyWord1
                  ElseIf FindString(\KeyWord$[#KeyWord02], FindWord$, 1) : FindFormat = #Format_KeyWord2
                  ElseIf FindString(\KeyWord$[#KeyWord03], FindWord$, 1) : FindFormat = #Format_KeyWord3
                  ElseIf FindString(\KeyWord$[#KeyWord04], FindWord$, 1) : FindFormat = #Format_KeyWord4
                  ElseIf FindString(\KeyWord$[#KeyWord05], FindWord$, 1) : FindFormat = #Format_KeyWord5
                  EndIf 
                  If FindFormat <> #Null 
                     *pFindChar = *pEditChar
                     If IsGotoFind = #True : *pFindChar - #RichEdit_EditCharSize : EndIf 
                     EndFindPos = Index-Len(BuildWord$)+1
                     For x = Index To EndFindPos Step - 1
                        *pFindChar\Format = FindFormat
                        *pFindChar - #RichEdit_EditCharSize
                     Next 
                     If Index = *pTextLine\CountChars And CurrSymbol & #Symbol_String 
                        CurrFormat = FindFormat 
                     EndIf 
                  EndIf 
               EndIf 
               IsGotoFind = #False
               WordSymbol = #Null
               BuildWord$ = #Null$
            EndIf 
             *pEditChar\Format = CurrFormat
            *pEditChar\Symbol = CurrSymbol
            *pEditChar + #RichEdit_EditCharSize
            CurrFormat = NextFormat
            PrevSymbol = CurrSymbol
         Next 
         
         If StartFold = #True And ToEndFold = #True
            StartFold = #False : ToEndFold = #False
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #Null
         ElseIf StartFold = #True 
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #FoldState_Start   ; �۵��п�ʼ���ڵ�
            FoldFloor + 1 : CountFold + 1 : StartFold = #False
         ElseIf ToEndFold = #True And CountFold > 0
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #FoldState_ToEnd   ; �۵��н������ڵ�
            CountFold - 1 : FoldFloor - 1 : ToEndFold = #False
         Else 
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #Null
         EndIf  
         *pTextLine = NextElement(*pRichEdit\ListTextLine())
         LineIndex+1
         If \pMaxTextLine And \pMaxTextLine\LineWidth < \ListTextLine()\LineWidth
            \pMaxTextLine = *pTextLine           ; ���������ı���
         EndIf 
      Wend 
   EndWith
EndProcedure

; ���ÿؼ��Ľ�����ʽ XML
Procedure RichEdit_ParserEditChar_LUA(*pRichEdit.__RichEditInfo, Index)
   With *pRichEdit
      *pEditChar.__RichEdit_EditChar   ; �ַ���Ϣָ��:��־ÿ���ַ��ĸ�ʽ���ַ�����
      *pFindChar.__RichEdit_EditChar   ; �ַ���Ϣָ��
      *pTextLine.__RichEdit_TextLine   ; �ı���ָ��
      
      \pMaxTextLine = FirstElement(\ListTextLine())
      *pTextLine = SelectElement(\ListTextLine(), Index)
      While *pTextLine
         *pEditChar = *pTextLine\pMemEditChar
         If IsComments = #False 
            CurrFormat = #Format_ViewArea
            NextFormat = #Format_ViewArea
         EndIf 
         PrevSymbol = #Symbol_Space
         CurrSymbol = #Symbol_Space
         BuildWord$ = #Null$
         CommtWord$ = #Null$
         PrevChar$  = #Null$
         iPrevChar  = 0

         For Index = 1 To *pTextLine\CountChars
            CurrChar$ = Mid(*pTextLine\LineText$, Index, 1)
            iCurrChar = Asc(CurrChar$)
            Select iCurrChar
               Case $41 To $5A               : CurrSymbol = #Symbol_Letter      ; ��д��ĸ
               Case $61 To $7A               : CurrSymbol = #Symbol_Letter      ; Сд��ĸ/�»���
               Case $30 To $39               : CurrSymbol = #Symbol_Number      ; ���ַ���
               Case $25,$2B,$2F,$2A          : CurrSymbol = #Symbol_Operator    ; �����[%+-/*]
               Case $21,$26,$5E,$7C,$7E      : CurrSymbol = #Symbol_Logical     ; �����[!&^|]                  
               Case $3C To $3E               : CurrSymbol = #Symbol_Logical     ; �����[<=>]
               Case $2E                      : CurrSymbol = #Symbol_Define      ; ������[.]
               Case $09                      : CurrSymbol = #Symbol_TabChar     ; 
               Case $3F,$40,$22,$27,$24,$23  : CurrSymbol = #Symbol_Other       ; ����[?@"'$#]
               Case $2C,$3A,$3B,$5C,$60      : CurrSymbol = #Symbol_Other       ; ����[,:;\`]
               Case $28,$29,$7B,$7D          : CurrSymbol = #Symbol_Other       ; ����[(){}]
               Case $20                      : CurrSymbol = #Symbol_Space    
               Case $5F                      : CurrSymbol = #Symbol_Other|#Symbol_Letter ; ����[_]   
               Case $2D,$5B,$5D              : CurrSymbol = #Symbol_Special     ; ����[-[]]
               Default                       : CurrSymbol = #Symbol_Letter
            EndSelect
            ; ******************************
            ; ������ʵ���ʽ
            ;============================== ע������
            
            If CurrSymbol & #Symbol_Special  
               CommtWord$ + CurrChar$
            Else 
               CommtWord$ = #Null$
            EndIf 
            
            If CurrFormat = #Format_Comments  
               If CommtWord$ = "--[[" : IsComments = #True : CommtWord$ = #Null$ 
               ElseIf CommtWord$ = "--]]" : IsComments = #False : CommtWord$ = #Null$ : EndIf 
            ElseIf CurrFormat = #Format_DQString                          
               If iCurrChar = '"' : NextFormat = #Format_ViewArea : EndIf                
            ElseIf CurrChar$ = "-" And PrevChar$ = "-"
               *pFindChar = *pEditChar - #RichEdit_EditCharSize
               *pFindChar\Format = #Format_Comments
               CurrFormat = #Format_Comments : NextFormat = #Format_Comments
          
            ElseIf CurrSymbol = #Symbol_Logical And CurrChar$ = "=" And PrevSymbol = #Symbol_Logical 
               *pFindChar = *pEditChar - #RichEdit_EditCharSize
               *pFindChar\Format = #Format_Operator
               CurrFormat = #Format_Operator : NextFormat = #Format_ViewArea
               
            ElseIf CurrSymbol = #Symbol_Logical And CurrChar$ <> "="
               CurrFormat = #Format_Operator : NextFormat = #Format_ViewArea
            ElseIf iCurrChar = '"' 
               CurrFormat = #Format_DQString : NextFormat = #Format_DQString
            ;============================== 
            ElseIf CurrChar$ = " " Or CurrChar$ = "." Or iCurrChar = 09
               CurrFormat = #Format_ViewArea : NextFormat = #Format_ViewArea : IsGotoFind = #True
            ElseIf CurrChar$ = "(" 
               CurrFormat = #Format_ViewArea : NextFormat = #Format_ViewArea  : IsFunction = #True 
            Else 
               CurrFormat = #Format_ViewArea : NextFormat = #Format_ViewArea
            EndIf 
            
            If CurrFormat = #Format_ViewArea And CurrSymbol & #Symbol_String And CurrSymbol & #Symbol_Special = 0
               BuildWord$+CurrChar$ : WordSymbol | CurrSymbol
            ElseIf IsGotoFind = #True Or IsFunction = #True 
               If BuildWord$ = #Null$ : IsGotoFind = #False : EndIf
            Else 
               BuildWord$ = #Null$ : WordSymbol = #Null
            EndIf 
            
            FindFormat = #Null
            FindFormat = #Null
            If IsFunction = #True
               *pFindChar = *pEditChar - #RichEdit_EditCharSize
               IsFindFunc = #False
                          
               For x = Index To 0 Step - 1
                  If IsFindFunc = #False And *pFindChar\Symbol & #Symbol_String  
                     ItemToEnd = x : IsFindFunc = #True  
                  ElseIf IsFindFunc = #True And *pFindChar\Symbol & #Symbol_Define  
                     IsFindFunc = #False   
                  ElseIf IsFindFunc = #True And *pFindChar\Symbol & #Symbol_String = 0  
                     ItemStart = x : Break  
                  EndIf 
                  *pFindChar - #RichEdit_EditCharSize
               Next 

               ; ����ҵ������� 
               If IsFindFunc = #True
                 
                   *pFindChar + #RichEdit_EditCharSize
                  For x = ItemStart+1 To ItemToEnd
                     *pFindChar\Format = #Format_Function
                     *pFindChar + #RichEdit_EditCharSize
                  Next  
                  IsFindFunc = #False
               EndIf 
               IsFunction = #False
               WordSymbol = #Null
               BuildWord$ = #Null$
               
            ElseIf IsGotoFind = #True Or (Index = *pTextLine\CountChars And BuildWord$ <> #Null$ And CurrFormat <> #Format_Comments)
               If WordSymbol & #Symbol_Operator = 0 And CurrSymbol & #Symbol_Special = 0
                  FindWord$ = " " + BuildWord$ + " "
                  If     FindString(\KeyWord$[#FoldStart], FindWord$, 1) : FindFormat = #Format_FoldWord : StartFold = #True
                  ElseIf FindString(\KeyWord$[#FoldToEnd], FindWord$, 1) : FindFormat = #Format_FoldWord : ToEndFold = #True
                  ElseIf FindString(\KeyWord$[#KeyWord01], FindWord$, 1) : FindFormat = #Format_KeyWord1
                  ElseIf FindString(\KeyWord$[#KeyWord02], FindWord$, 1) : FindFormat = #Format_KeyWord2
                  ElseIf FindString(\KeyWord$[#KeyWord03], FindWord$, 1) : FindFormat = #Format_KeyWord3
                  ElseIf FindString(\KeyWord$[#KeyWord04], FindWord$, 1) : FindFormat = #Format_KeyWord4
                  ElseIf FindString(\KeyWord$[#KeyWord05], FindWord$, 1) : FindFormat = #Format_KeyWord5
                  EndIf 
                  If FindFormat <> #Null 
                     *pFindChar = *pEditChar
                     If IsGotoFind = #True : *pFindChar - #RichEdit_EditCharSize : EndIf 
                     EndFindPos = Index-Len(BuildWord$)+1
                     For x = Index To EndFindPos Step - 1
                        *pFindChar\Format = FindFormat
                        *pFindChar - #RichEdit_EditCharSize
                     Next 
                     If Index = *pTextLine\CountChars : CurrFormat = FindFormat : EndIf 
                  EndIf 
               EndIf 
               IsGotoFind = #False
               WordSymbol = #Null
               BuildWord$ = #Null$
            EndIf 
            *pEditChar\Format = CurrFormat
            *pEditChar\Symbol = CurrSymbol
            *pEditChar + #RichEdit_EditCharSize
            CurrFormat = NextFormat
            PrevSymbol = CurrSymbol
            PrevChar$  = CurrChar$
            iPrevChar  = iCurrChar
         Next 
         
         If StartFold = #True And ToEndFold = #True
            StartFold = #False : ToEndFold = #False
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #Null
         ElseIf StartFold = #True 
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #FoldState_Start   ; �۵��п�ʼ���ڵ�
            FoldFloor + 1 : CountFold + 1 : StartFold = #False
         ElseIf ToEndFold = #True And CountFold > 0
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #FoldState_ToEnd   ; �۵��н������ڵ�
            CountFold - 1 : FoldFloor - 1 : ToEndFold = #False
         Else 
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #Null
         EndIf  
         *pTextLine = NextElement(*pRichEdit\ListTextLine())
         LineIndex+1
         If \pMaxTextLine And \pMaxTextLine\LineWidth < \ListTextLine()\LineWidth
            \pMaxTextLine = *pTextLine           ; ���������ı���
         EndIf 
      Wend 
   EndWith
EndProcedure

;- ***********************
; ����ȫ�ı����ַ���ʽ/��ʽ
Procedure RichEdit_ParserEditChar(*pRichEdit.__RichEditInfo, Index=0)
   With *pRichEdit
      Select \FormatType
         Case #FormatType_Common : RichEdit_ParserEditChar_Com(*pRichEdit, Index)
         Case #FormatType_PB     : RichEdit_ParserEditChar_PB (*pRichEdit, Index)
         Case #FormatType_LUA    : RichEdit_ParserEditChar_LUA(*pRichEdit, Index)
         Case #FormatType_XML    : RichEdit_ParserEditChar_Com(*pRichEdit, Index)  ;��ǰû�д���XML�Ĵ���,�������߱�д
      EndSelect
   EndWith
EndProcedure

; ����[������]�ַ���ʽ/��ʽ/ѡ�д�
Procedure RichEdit_ParserViewChar(*pRichEdit.__RichEditInfo)
   With *pRichEdit
      CurrIndex = \Viewer\Row             ; ��ǰ��,���ڽ�������ʱ,������ 
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��                       
      *pViewChar.__RichEdit_ViewChar      ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditChar.__RichEdit_EditChar      ; [������|������]�ڴ���ַ�ָ�� 
      *pEditLine = SelectElement(\ListEditLine(), \Viewer\Row) ; ��ȡ[������]�����е�ָ��
      While *pEditLine And CurrIndex <= \Viewer\LastLine
         *pViewLine = \pMemViewChar + ViewIndex * #RichEdit_FullRowBytes
         *pViewChar = *pViewLine
         SelectElement(\ListTextLine(), *pEditLine\LineIndex)
         *pEditChar = \ListTextLine()\pMemEditChar
         For k = 1 To *pEditLine\pElement\CountChars
            CurrChar$ = Mid(*pEditLine\pElement\LineText$, k, 1)
            *pViewChar\iBackColor = *pEditChar\Format    ; ��[�ı���]�����ַ���ʽ��[������]
            *pViewChar\iFontColor = *pEditChar\Format
            *pViewChar\iFontStyle = *pEditChar\Format
            *pViewChar\CharSymbol = *pEditChar\Symbol    ; ��[�ı���]�����ַ���ʶ��[������]
            *pEditChar + #RichEdit_EditCharSize          ; ����[������|������]�ַ�ָ��
            *pViewChar + #RichEdit_ViewCharSize          ; ����[������|�༭��]�ַ�ָ��       
         Next 
         ; �ж�[�ı���]�Ƿ���[ѡ�д�],�����,������ʶ����
         If \FlagsWord$ <> #Null$
            LenWord = Len(\FlagsWord$)
            Pos = FindString(\ListTextLine()\LineText$, \FlagsWord$, Pos+1)   ; ����[ѡ�д�]
            While Pos                                                ; ����һ��ѭ���������Ƿ���[ѡ�д�]
               *pViewChar = *pViewLine+(Pos-2) * #RichEdit_ViewCharSize
               StartBool  = *pViewChar\CharSymbol & #Symbol_String   ; �ж��������ǰһ�ַ��Ƿ�Ϊ�ı���ʶ
               *pViewChar = *pViewLine+(Pos+LenWord-1) * #RichEdit_ViewCharSize
               ToEndBool  = *pViewChar\CharSymbol & #Symbol_String   ; �ж����������һ�ַ��Ƿ�Ϊ�ı���ʶ
               If StartBool = #Null And ToEndBool = #Null           ; ����������ǰ�󶼲�Ϊ�ı���ʶ,����Ϊ�Ϸ�[ѡ�д�]
                  For k = Pos To Pos+LenWord-1                      ; �����������,�����ַ���ʶΪ[ѡ�д�]״̬
                     *pViewChar = *pViewLine + (k-1) * #RichEdit_ViewCharSize
                     *pViewChar\iBackColor = #Format_TipWords        ; ��ʶ�ַ�Ϊ[ѡ�д�]״̬
                  Next 
               EndIf
               Pos = FindString(\ListTextLine()\LineText$, \FlagsWord$, Pos+1) ;��������,ֱ���鲻��Ϊֹ
            Wend   
         EndIf     
         CurrIndex + 1 : ViewIndex + 1                ; ��������
         *pEditLine = NextElement(\ListEditLine())    ; ����[������|������]ָ�� 
      Wend
   EndWith
EndProcedure

; ����[�۵���]
Procedure RichEdit_ParserFoldArea(*pRichEdit.__RichEditInfo, RealFoldRow)
   With *pRichEdit
      *pTextLine.__RichEdit_TextLine                           ; [������|�༭��]�ڴ����ָ��         
      *pTextLine = SelectElement(\ListTextLine(), RealFoldRow) ; ѡ��[������|�ı���]
      If *pTextLine = 0                                        ; ����в�����,�˳�
         \Fold\StartRow = 0 : \Fold\ToEndRow = 0 : \Fold\Floor = 0
         ProcedureReturn
      EndIf 
      ; ���ѡ���д���[�۵���]����[�۵���]��ʼ��,���ҳ�[�۵���]�Ŀ�ʼ�кͽ�����
      If *pTextLine\FoldFloor Or *pTextLine\FoldState & #FoldState_Start
         ; ����[�۵���]�Ŀ�ʼ��
         If *pTextLine\FoldState & #FoldState_Start   ; ����պ�[�۵���]��ʼ��, FoldFloor+1
            FoldFloor = *pTextLine\FoldFloor+1
            StartRow  = RealFoldRow                   ; ��ʶ��ʼ��Ϊ��ǰ��
         Else 
            FoldFloor = *pTextLine\FoldFloor          ; ���ѡ���в��ǿ�ʼ��,������ʼ��
            StartRow  = RealFoldRow
            While PreviousElement(\ListTextLine())    ; ���ϲ���[�ı���],
               StartRow-1                             ; �����ݼ�
               If \ListTextLine()\FoldFloor = FoldFloor-1 And \ListTextLine()\FoldState & #FoldState_Start
                  Break
               EndIf 
            Wend
         EndIf 
         ; ����[�۵���]�Ľ�����
         SelectElement(\ListTextLine(), RealFoldRow)  ; ѡ��[������|�ı���]
         If *pTextLine\FoldFloor = FoldFloor And *pTextLine\FoldState & #FoldState_ToEnd
            ToEndRow  = RealFoldRow                   ; ����պ���[�۵���]������, ��ʶ������Ϊ��ǰ��
         Else 
            ToEndRow  = RealFoldRow                   ; ��ʶ������Ϊ��ǰ��,Ȼ����жϱߵ���,ֱ�����ҽ�����Ϊֹ
            While NextElement(\ListTextLine())
               If \ListTextLine()\FoldFloor < FoldFloor : Break : EndIf 
               ToEndRow+1                             ; ��������
            Wend
         EndIf 
         \Fold\Floor = FoldFloor                      ; ����[�۵���]��ǰ�Ĳ�,���ڻ���[�۵���]ʱ����
         If \Fold\StartRow <> StartRow : \Fold\StartRow = StartRow : IsRedraw=#True : EndIf 
         If \Fold\ToEndRow <> ToEndRow : \Fold\ToEndRow = ToEndRow : IsRedraw=#True : EndIf 
      Else                                            ; ѡ����û������[�۵���]��ʱ,�����������
         \Fold\StartRow = 0 : \Fold\ToEndRow = 0 : \Fold\Floor = 0
      EndIf 
   EndWith 
   ProcedureReturn IsRedraw
EndProcedure

; ����[�༭��]
Procedure RichEdit_ParserEditArea(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit 
      *pViewChar.__RichEdit_ViewChar                  ; [������|�༭��]�ڴ���ַ�ָ��
      ;==========================                   
      ; ��ȡ���������     
      CurrRow = (*pMouse\y-\Viewer\Y) /\Font\H        ; ��ȡ��ǰ[�����]���λ��
      *pViewChar  = \pMemViewChar + CurrRow * #RichEdit_FullRowBytes
      CurrRow + \Viewer\Row                           ; ��ȡ��ǰ[�����]����λ��
      ; ���[�༭��]������,���˳�[��갴ס��ҷ]ʱ,������������(Խ��)
      If CurrRow < 0 : ProcedureReturn #False : EndIf  
      *pElement = SelectElement(\ListEditLine(), CurrRow)
      ; ���[�༭��]������,���˳�[��갴ס��ҷ]ʱ,������������(Խ��)
      If *pElement = 0 : ProcedureReturn #False : EndIf  
      ;==========================                   
      ; ���������¼�
      If *pMouse\Y < \Viewer\Y And \Viewer\Row > 0
         \Viewer\Row - 1 : IsRedraw = #True  
      ElseIf *pMouse\Y > \Gadget\H-20 And \Viewer\Row < \Viewer\LastLine
         \Viewer\Row + 1 : IsRedraw = #True 
      EndIf       
      ;==========================  
      ; ���������¼�      
      RealRow    = \ListEditLine()\LineIndex                   ; ��ȡ������
      CountChars = (\ListEditLine()\pElement\LineWidth+\Font\W-1)/\Font\W  ; �����е��ַ���,
      ; ֮���Բ�����\pElement\CountChars,��Ϊ�˷�ֹ�ı����в��õ������ֵȷǱ�׼����ʱ��TAB,��ɵ��п�仯
      MaxChars   = CountChars-\Viewer\HoldCols                 ; ����ҷʱ,�����޶�
      If CountChars < \Viewer\HoldCols : MaxChars = CountChars : EndIf 
      If *pMouse\X >= \Viewer\W  And \Viewer\Col < MaxChars
         \Viewer\Col+3 : IsRedraw = #True 
      ElseIf *pMouse\X <= \Viewer\X  And \Viewer\Col > 0
         \Viewer\Col-3 : IsRedraw = #True 
      EndIf 
      ;==========================
      ; ��ȡ���������
      If *pMouse\X <= \Viewer\X  And \Viewer\Col <= 0          ; ����Ѿ����������,�����������Ϊ0
         \Viewer\Col = 0                                       ; �˴�����,��Ҫ��Ϊ�˷�ֹ�������ҷ�������ʱ,�����������Ҳ��BUG.
      Else 
         CurrCol = \ListEditLine()\pElement\CountChars         ; Ĭ�Ϲ�����������е����Ҳ�
         For k = 0 To \ListEditLine()\pElement\CountChars-1    ; ѭ���ж�ÿ���ַ��Ƿ�Ϊ�����㴦
            If *pViewChar\X <= *pMouse\X And *pMouse\X < *pViewChar\X+*pViewChar\W 
               CurrCol = k : Break                             ; �����,���˳�.
            ElseIf *pViewChar\X =0 And *pViewChar\W = 0        ; ��������е����Ҳ�,���˳�,��ʱ,��㴦Ϊ���Ҳ�
                Break
            EndIf 
            *pViewChar+ #RichEdit_ViewCharSize                  ; �����ַ�ָ��
         Next  
      EndIf 
      ;==========================
      ; ���õ�ǰ����[�۵���],���ж�ѡ���Ƿ����Ϊѡ�д�
      If \Cursor\Col <> CurrCol Or \Cursor\Row <> CurrRow
         \Cursor\Col = CurrCol : \Cursor\Row = CurrRow : \Cursor\RealRow = RealRow
         RichEdit_ParserFoldArea(*pRichEdit, RealRow)                            ; ����[�۵���]��Ϣ
         ; ������ѡ�д��ж�
         \FlagsWord$ = #Null$                                  
         If \Cursor\Row <> \Record\Row : ProcedureReturn #True : EndIf      ; ���ѡ���Ƕ���,���˳�
         *pViewChar.__RichEdit_ViewChar
         *pViewLine  = \pMemViewChar + (\Cursor\Row-\Viewer\Row) * #RichEdit_FullRowBytes
         ; �ж�ѡ���Ƿ����Ϊ[ѡ�д�],�����,������ʶ����
         If \Cursor\Col < \Record\Col                                            ; ��ѡ���д��ڹ���е����
            *pViewChar   = *pViewLine+(\Cursor\Col-1) * #RichEdit_ViewCharSize   ; �ж�ѡ��ǰһ�ַ��Ƿ�Ϊ�ı���ʶ
            If *pViewChar\CharSymbol & #Symbol_String : ProcedureReturn #True : EndIf 
            *pViewChar   = *pViewLine+(\Record\Col) * #RichEdit_ViewCharSize     ; �ж�ѡ����һ�ַ��Ƿ�Ϊ�ı���ʶ
            If *pViewChar\CharSymbol & #Symbol_String : ProcedureReturn #True : EndIf 
            StartPos = \Cursor\Col : ToEndPos = \Record\Col                      ; ������ʼλ�úͽ���λ��,���ڱ�ʶ
         ElseIf \Cursor\Col > \Record\Col                                        ; ��ѡ����С�ڹ���е����
            *pViewChar   = *pViewLine+(\Record\Col-1) * #RichEdit_ViewCharSize   ; �ж�ѡ��ǰһ�ַ��Ƿ�Ϊ�ı���ʶ
            If *pViewChar\CharSymbol & #Symbol_String : ProcedureReturn #True : EndIf 
            *pViewChar   = *pViewLine+(\Cursor\Col) * #RichEdit_ViewCharSize     ; �ж�ѡ����һ�ַ��Ƿ�Ϊ�ı���ʶ
            If *pViewChar\CharSymbol & #Symbol_String : ProcedureReturn #True : EndIf 
            StartPos=\Record\Col : ToEndPos=\Cursor\Col                          ; ������ʼλ�úͽ���λ��,���ڱ�ʶ
         Else                                                                    ; ���������ѡ��,���˳�
            ProcedureReturn #True
         EndIf 
         *pViewChar = *pViewLine + StartPos * #RichEdit_ViewCharSize             ; ��ȡ[ѡ�д�]��ʼ�����ַ�ָ��
         For k = StartPos To ToEndPos-1                                          ; ѭ��[ѡ�д�]��ÿ���ַ�
            ; ���[ѡ��]���ַ��ı��ַ�,���˳� 
            If *pViewChar\CharSymbol & #Symbol_String : Else : ProcedureReturn #True : EndIf    
            *pViewChar + #RichEdit_ViewCharSize                                  ; �����ַ�ָ��
         Next 
         ; ����[ѡ�д�]
         \FlagsWord$ = Mid(\ListEditLine()\pElement\LineText$, StartPos+1, ToEndPos-StartPos)    
      EndIf 
   EndWith 
   ProcedureReturn IsRedraw
EndProcedure


;- =======================
; ע���ؼ�
Procedure RichEdit_FreeGadget(*pRichEdit.__RichEditInfo, hGadget)
   With *pRichEdit
      If *pRichEdit
         DestroyCursor_(\Cursor\hRMARK)    ; ע��[��ʽ��ͷ���]
         DestroyCursor_(\Cursor\hARROW)    ; ע��[�����ͷ���]
         DestroyCursor_(\Cursor\hIBEAM)    ; ע��[����״̬���]
         DestroyCaret_()                   ; ע��[�ı���ʾ�����]
         If \hBrushBack : DeleteObject_(\hBrushBack) : EndIf   ; ע��[����ˢ]
         For k = 0 To 3 : FreeFont(\Font\ID[k]) : Next         ; �ͷ�����
         ForEach \ListTextLine()                               ; ѭ��[�ı���],�ͷ�ÿ���ı��е��ڴ�
            FreeMemory(\ListTextLine()\pMemEditChar)
         Next 
         FreeMemory(*pRichEdit\pMemViewChar)          ; �ͷ�[������]���ڴ�
         FreeList(*pRichEdit\ListTextLine())          ; �ͷ�[�༭��]������
         FreeList(*pRichEdit\ListEditLine())          ; �ͷ�[�ı���]������
         FreeStructure(*pRichEdit)                    ; �ͷſؼ���Ϣ�ṹ
         RemoveProp_(hGadget, #GadgetClass_RichEdit$) ; ɾ���ؼ���Ϣ��¼
         DestroyWindow_(hGadget)                      ; �ͷ������ؼ�
      EndIf 
   EndWith 
EndProcedure

; ��������
Procedure RichEdit_SetGadgetFont(*pRichEdit.__RichEditInfo)
   With *pRichEdit\Font
      For k = 0 To 3
         If IsFont(\ID[k]) : FreeFont(\ID[k]) : EndIf    
      Next 
      \ID[0] = LoadFont(#PB_Any, \Name$, \Size)                   ; ������������
      \ID[1] = LoadFont(#PB_Any, \Name$, \Size, #PB_Font_Bold)    ; �����Ӵ�����
      \ID[2] = LoadFont(#PB_Any, \Name$, \Size, #PB_Font_Italic)  ; ����б������
      \ID[3] = LoadFont(#PB_Any, \Name$, \Size, #PB_Font_Bold|#PB_Font_Italic) ; ��������|б������
      ;��ȡ�豸�����������
      hDC = GetDC_(hGadget)
      hObject = SelectObject_(hDC, FontID(\ID[0]))
      GetTextExtentPoint32_(hDC, @"99999", 5, FontStyle.SIZE)
      \W = FontStyle\cx/5        ; ��ȡ����������
      \H = FontStyle\cy          ; ��ȡ��������߶�
      SelectObject_(hDC, hObject)
      ReleaseDC_(hGadget, hDC)
      \TapWith = \TapCount * \W
      If *pRichEdit\pMaxTextLine
         *pRichEdit\pMaxTextLine\LineWidth = *pRichEdit\pMaxTextLine\CountChars * \W
      EndIf 
      DestroyCaret_()  
      CreateCaret_(*pRichEdit\hGadget, #Null, 1, \H)
      *pRichEdit\EditState & ~#EditState_CaretVisible
   EndWith  
EndProcedure

; <�����ؼ���С>
Procedure RichEdit_ResizeGadget(*pRichEdit.__RichEditInfo, X, Y, Width, Height)
   ;��ȡ�ؼ���Ϣ
   With *pRichEdit
      If X = #PB_Ignore      : X = GadgetX(\GadgetID) : EndIf 
      If Y = #PB_Ignore      : Y = GadgetY(\GadgetID) : EndIf 
      If Width  = #PB_Ignore : W = GadgetWidth (\GadgetID) : EndIf 
      If Height = #PB_Ignore : H = GadgetHeight(\GadgetID) : EndIf 
      MoveWindow_(\hGadget, X, Y, Width, Height, #True)
      ; [�༭��]�ļ�
      \Gadget\X = X : \Gadget\W = Width  : \Gadget\R = X+Width
      \Gadget\Y = Y : \Gadget\H = Height : \Gadget\B = Y+Height
      ;========================
      KillTimer_(\hGadget, #Timer_Refresh_Flags) 
      SetTimer_ (\hGadget, #Timer_Refresh_Flags, #Timer_Refresh_Timer, #Null)
   EndWith
EndProcedure

;- ***********************
; ����[�з���|�۵���]
Procedure RichEdit_RedrawMarkArea (*pRichEdit.__RichEditInfo)   
   With *pRichEdit
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��   
      DrawingFont(FontID(\Font\ID[0])) 
      ; ����[�з���]
      Box(000, 000, \Viewer\MarkW, \Gadget\H, \Format[#Format_MarkArea]\BackColor)   ; [�з���]����ɫ
      MaxChar   = Len(Str(\ListEditLine()\LineIndex))                   ; �����з����ֽ���      
      *pEditLine = SelectElement(\ListEditLine(), \Viewer\Row)          ; [������]����
      CurrIndex = \Viewer\Row             ; ���û���������ʼ������,�����ڽ�����ʱ,������
      CurrLineY = \Viewer\Y               ; ���û���������ʼ������,���ڲ���
      While *pEditLine And CurrIndex <= \Viewer\LastLine               ; ѭ�������е�[�༭��]
         LineIndex$ = RSet(Str(*pEditLine\LineIndex+1), MaxChar, " ")   ; �з����и�ʽ������
         DrawText(04, CurrLineY, LineIndex$, \Format[#Format_MarkArea]\FontColor, \Format[#Format_MarkArea]\BackColor)
         CurrLineY + \Font\H : CurrIndex+1                              ; ����������������
         *pEditLine = NextElement(\ListEditLine())                      ; ��ת����һ��[�༭��]
      Wend
      ;======================= 
;       If \EditState & #EditState_FoldVisible = 0 : ProcedureReturn : EndIf 
      ; ����[�۵���]
      Box(\Viewer\MarkW, 000, \Fold\W, \Gadget\H, \Format[#Format_MarkArea]\BackColor)  ;[�۵���]����ɫ    
      *pEditLine = SelectElement(\ListEditLine(), \Viewer\Row)           ; [������]����
      CurrIndex = \Viewer\Row             ; ���û���������ʼ������,�����ڽ�����ʱ,������
      CurrLineY = \Viewer\Y               ; ���û���������ʼ������,���ڲ���
      CurrCaseX = \Viewer\MarkW           ; [�۵���]"��"�ַ������
      CurrLineX = CurrCaseX+\Fold\Size/2  ; [�۵���]"|"�ַ������
      CenterPos = (\Font\H-\Fold\Size)/2  ; [�۵���]�ľ���λ��
      While *pEditLine And CurrIndex <= \Viewer\LastLine               ; ѭ�������е�[�༭��]
         BoolIndex = Bool(*pEditLine\LineIndex >= \Fold\StartRow And *pEditLine\LineIndex<= \Fold\ToEndRow)
         If \Fold\Floor > 0 And BoolIndex                              ; �������д���[�۵���]
            FontColor = \Format[#Format_CaretRow]\FontColor             ; ���ø�����ɫ
         Else   
            FontColor = \Format[#Format_MarkArea]\FontColor             ;����Ĭ����ɫ
         EndIf 
         If *pEditLine\pElement\FoldState & #FoldState_Start            ; �۵��п�ʼ���ڵ�
            ;=======================
            ; �۵���ʼ��
            CurrCaseY = CurrLineY + CenterPos
            If \Fold\Size < 9                                           ; ����ߴ�̫С,ת���ɵ���߶�
               If *pEditLine\pElement\FoldState & #FoldState_Closed     ; �۵����պ�ʱ,Ϊ��,����Ϊ�߶�
                  Circle(CurrLineX, CurrCaseY+\Fold\Size/2, \Fold\Size/2, FontColor)
               Else 
                  Box(CurrCaseX, CurrCaseY+\Fold\Size/2, \Fold\Size, 02, FontColor)
               EndIf 
            Else 
               DrawingMode(#PB_2DDrawing_Outlined)                      ; ��������       
               Box(CurrCaseX, CurrCaseY, \Fold\Size, \Fold\Size, FontColor)
               DrawingMode(#PB_2DDrawing_Default)
               If \Fold\Size < 13 : W = 2 : Else : W = 3 : EndIf
               Line(CurrCaseX+W, CurrCaseY+\Fold\Size/2, \Fold\Size-W*2, 01, FontColor)
               If *pEditLine\pElement\FoldState & #FoldState_Closed     ; �۵����պ�ʱ+����Ϊ-
                  Line(CurrCaseX+\Fold\Size/2, CurrCaseY+W, 01, \Fold\Size-W*2, FontColor)
               EndIf
               ; Ҫ�����ϼ���: ������߼��ж����Ѷ� 
               If *pEditLine\pElement\FoldFloor And *pEditLine\pElement\FoldFloor+1 = \Fold\Floor 
                  Line(CurrLineX, CurrLineY, 1, CenterPos, \Format[#Format_MarkArea]\FontColor)
               ElseIf *pEditLine\pElement\FoldFloor 
                  Line(CurrLineX, CurrLineY, 1, CenterPos, FontColor)
               EndIf 
               ; Ҫ�����¼���: ������߼��ж����Ѷ� 
               If *pEditLine\pElement\FoldFloor Or *pEditLine\pElement\FoldState & #FoldState_Closed = 0  
                  If *pEditLine\pElement\FoldFloor+1 = \Fold\Floor And *pEditLine\pElement\FoldState & #FoldState_Closed
                     Line(CurrLineX, CurrCaseY+\Fold\Size, 1, CenterPos+1, \Format[#Format_MarkArea]\FontColor)
                  Else 
                     Line(CurrLineX, CurrCaseY+\Fold\Size, 1, CenterPos+1, FontColor)
                  EndIf 
               EndIf    
            EndIf
         ;=======================     
         ; �۵�������
         ElseIf *pEditLine\pElement\FoldState & #FoldState_ToEnd   ; �۵��н������ڵ�
            Line(CurrLineX, CurrLineY, 01, \Font\H/2, FontColor)
            ; ������Ӽ�������,Ҫ�����¼���: ������߼��ж����Ѷ� 
            If *pEditLine\pElement\FoldFloor > 1 And *pEditLine\pElement\FoldFloor <= \Fold\Floor 
               Line(CurrLineX, CurrLineY+\Font\H/2, 01, \Font\H/2, \Format[#Format_MarkArea]\FontColor)
            ElseIf *pEditLine\pElement\FoldFloor > 1               ; ������Ӽ�������,Ҫ�����¼���
               Line(CurrLineX, CurrLineY+\Font\H/2, 01, \Font\H/2, FontColor)
            EndIf 
            Line(CurrLineX, CurrLineY+\Font\H/2, \Fold\Size/2+1, 01, FontColor)
         ;======================= 
         ; �۵��м���
         ElseIf *pEditLine\pElement\FoldFloor > 0 
            Line(CurrLineX, CurrLineY, 01, \Font\H, FontColor)
         EndIf 
         CurrLineY + \Font\H : CurrIndex+1         ; ����������������
         *pEditLine = NextElement(\ListEditLine()) ; ��ת����һ��[�༭��]
      Wend
   EndWith
EndProcedure

; �ػ�[ѡ��]
Procedure RichEdit_RedrawSelected(*pRichEdit.__RichEditInfo, *pViewChar.__RichEdit_ViewChar, CurrIndex, Index)
   With *pRichEdit
      If \Cursor\RealRow = CurrIndex And *pViewChar\iBackColor <> #Format_TipWords
         *pViewChar\iBackColor = #Format_CaretRow        ; �������ʾ����,�������ʾ���еĵ�ɫ
      EndIf 
      
      ;���ѡ��������,ֱ������.
      If \Record\RealRow = \Cursor\RealRow And \Record\Col = \Cursor\Col ;û��ѡ��
      ;[��ʼ��=������]���ѡ����ʼ�о��ǵ�ǰ��,������Ҳ�ǵ�ǰ��,�൱���жα�ѡ״̬
      ElseIf \Record\RealRow = CurrIndex And \Cursor\RealRow = CurrIndex 
         If \Record\Col < \Cursor\Col And \Record\Col+1 <= Index And Index < \Cursor\Col+1
            *pViewChar\iFontColor = #Format_Selected
            *pViewChar\iBackColor = #Format_Selected
         ElseIf \Record\Col > \Cursor\Col And \Record\Col+1 > Index And Index >= \Cursor\Col+1
            *pViewChar\iFontColor = #Format_Selected
            *pViewChar\iBackColor = #Format_Selected
         EndIf 
      ;[��ʼ��<������]���ѡ����ʼ��С�ڵ�ǰ��,�����о��ǵ�ǰ��,�൱��ǰ�˱�ѡ״̬
      ElseIf \Record\RealRow < CurrIndex And \Cursor\RealRow = CurrIndex And Index < \Cursor\Col+1
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected
      ;[��ʼ��<������]���ѡ����ʼ��С�ڵ�ǰ��,�����о��ǵ�ǰ��,�൱�ں�˱�ѡ״̬
      ElseIf \Record\RealRow = CurrIndex And \Cursor\RealRow > CurrIndex And Index >= \Record\Col+1
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected 
         IsAddEnter = #True
      ;[��ʼ��<������]���ѡ����ʼ��С�ڵ�ǰ��,�����д��ڵ�ǰ��,�൱��ȫ�б�ѡ״̬
      ElseIf \Record\RealRow < CurrIndex And \Cursor\RealRow > CurrIndex
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected
         IsAddEnter = #True
      ;[��ʼ��<������]���ѡ����ʼ�о͵�ǰ��,������С�ڵ�ǰ��,�൱��ǰ�˱�ѡ״̬
      ElseIf \Record\RealRow = CurrIndex And \Cursor\RealRow < CurrIndex And Index < \Record\Col+1
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected
      ;[��ʼ��>������]���ѡ����ʼ�о��ǵ�ǰ��,������С�ڵ�ǰ��,�൱�ں�˱�ѡ״̬
      ElseIf \Record\RealRow > CurrIndex And \Cursor\RealRow = CurrIndex And Index >= \Cursor\Col+1
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected
         IsAddEnter = #True
      ;[��ʼ��>������]���ѡ����ʼ��С�ڵ�ǰ��,�����д��ڵ�ǰ��,�൱��ȫ�б�ѡ״̬
      ElseIf \Record\RealRow > CurrIndex And \Cursor\RealRow < CurrIndex
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected
         IsAddEnter = #True
      EndIf
   EndWith
   ProcedureReturn IsAddEnter
EndProcedure

; ����[������]
Procedure RichEdit_RedrawViewArea (*pRichEdit.__RichEditInfo)   
   With *pRichEdit
      Box(\Viewer\X-4, 000, \Gadget\W, \Gadget\H, \Format[#Format_ViewArea]\BackColor)  ;[������]����ɫ 
      RichEdit_ParserViewChar(*pRichEdit)                      ; ˢ��[������]�ڴ�
      CurrIndex = \Viewer\Row                                  ; ��ǰ��,���ڽ�������ʱ,������             
      CurrLineY = \Viewer\Y                                    ; �ַ����Ƶ�Y����,������
      *pEditLine.__RichEdit_EditLine                           ; [������|�༭��]�ڴ����ָ��
      *pViewChar.__RichEdit_ViewChar                           ; [������|������]�ڴ���ַ�ָ�� 
      *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row) ; [������]����
      If \Cursor\IsInFold = #False
         HightLightY = CurrLineY + (\Cursor\Row-\Viewer\Row) * \Font\H    ; ��ǰ������
         If HightLightY > 0 And HightLightY < \Gadget\H-21-\Font\H
            Box(\Viewer\X-4, HightLightY, \Viewer\W+4, \Font\H, \Format[#Format_CaretRow]\BackColor) 
         EndIf 
      EndIf 
      *pEditLine = SelectElement(\ListEditLine(), \Viewer\Row)    ; [������]����
      ;=======================
      DrawingFont(FontID(\Font\ID[FontIndex]))                    ; ����Ĭ���ַ�
      ClipOutput(\Viewer\X, CurrLineY, \Viewer\W, \Viewer\H)      ; [�༭��]���Ƶķ�Χ
      While *pEditLine And CurrIndex <= \Viewer\LastLine
         If Left(*pEditLine\pElement\LineText$, 25) = "; IDE Options = PureBasic"
            Break
         EndIf 
      
         *pViewChar = \pMemViewChar + ViewIndex * #RichEdit_FullRowBytes   ;[������]�ڴ���ַ�ָ��  
         CurrCharX = \Viewer\X-\Viewer\Col * \Font\W              ; �����ַ������
    
         CountWidth = 0
         IsAddEnter = #False
         ; �����ַ�ǰ���ж϶���
         If *pEditLine\pElement\CountChars = 0                    ; ���û���ֽڴ���,����ı�����Ϣ
            FillMemory(*pViewChar, #RichEdit_FullRowBytes)
            ;���ѡ��������,ֱ������.
            If \Cursor\RealRow < *pEditLine\LineIndex And *pEditLine\LineIndex < \Record\RealRow
               IsAddEnter = #True                                 ; �����س���
            ElseIf \Cursor\RealRow > *pEditLine\LineIndex And *pEditLine\LineIndex > \Record\RealRow
               IsAddEnter = #True                                 ; �����س���
            EndIf
         Else 
            For k = 1 To *pEditLine\pElement\CountChars           ; ѭ���ַ�
               IsAddEnter = RichEdit_RedrawSelected(*pRichEdit, *pViewChar, *pEditLine\LineIndex, K)
               CurrChar$ = Mid(*pEditLine\pElement\LineText$,k,1) ; ���ν�ȡ�����ַ�            
               FontStyle = \Format[*pViewChar\iFontStyle]\FontStyle
               If FontIndex <> FontStyle                          ; ����������ֱ仯,������
                  FontIndex = FontStyle : DrawingFont(FontID(\Font\ID[FontIndex]))
                  FontIndex = FontStyle : DrawingFont(FontID(\Font\ID[FontIndex]))
               EndIf 
               If *pViewChar\CharSymbol = #Symbol_TabChar         ; �������TAB,����ַ�����ǿ�ƶ���
                  NewCountWidth = CountWidth/\Font\TapWith * \Font\TapWith + \Font\TapWith
                  *pViewChar\W = NewCountWidth-CountWidth         ; �����ַ��Ķ�����
                  BackColor = \Format[*pViewChar\iBackColor]\BackColor
                  Box(CurrCharX, CurrLineY, *pViewChar\W, \Font\H, BackColor)
               Else
                  If CurrChar$ = " "
                     *pViewChar\W = \Font\W                       ; ����ǿո�,ǿ��ʹ��Ĭ������Ŀ��
                  Else 
                     *pViewChar\W = TextWidth(CurrChar$)          ; �����ַ��Ŀ��
                  EndIf     
                  If CurrCharX+\Font\W >= \Viewer\X And CurrCharX <= \Viewer\W+\Viewer\X
                     FontColor = \Format[*pViewChar\iFontColor]\FontColor
                     BackColor = \Format[*pViewChar\iBackColor]\BackColor
                     DrawText(CurrCharX, CurrLineY, CurrChar$, FontColor, BackColor)
                  EndIf 
               EndIf 
               *pViewChar\X = CurrCharX
               CountWidth + *pViewChar\W                          ; ͳ���е������
               CurrCharX  + *pViewChar\W                          ; �����ַ����
               *pViewChar + #RichEdit_ViewCharSize                ; ָ����һ�ַ�����Ϣ
               If \Cursor\RealRow = *pEditLine\LineIndex And k = \Cursor\Col+1
                  \Cursor\RealCol = CountWidth /\Font\W           ; ����ʵ���е�����
               EndIf    
               If \Record\RealRow = *pEditLine\LineIndex And k = \Record\Col+1
                  \Record\RealCol = CountWidth /\Font\W           ; ����ʵ���е�����
               EndIf           
            Next
            *pViewChar\X = CurrCharX
            *pViewChar\W = 0
            *pViewChar + #RichEdit_ViewCharSize                ; ָ����һ�ַ�����Ϣ
            FillSize = #RichEdit_FullRowBytes - (*pEditLine\pElement\CountChars+1) * #RichEdit_ViewCharSize
            FillMemory(*pViewChar, FillSize)

         EndIf 
         If CurrCharX+\Font\W >= \Viewer\X And CurrCharX <= \Viewer\W+\Viewer\X        
            If IsAddEnter = #True                                 ; �����س���
               If FontIndex <> 0 : FontIndex = 0 : DrawingFont(FontID(\Font\ID[0])) : EndIf 
               FontColor = \Format[#Format_Selected]\FontColor
               BackColor = \Format[#Format_Selected]\BackColor
               DrawText(CurrCharX, CurrLineY, " ", FontColor, BackColor)
            EndIf  
         EndIf 
         *pEditLine\LastCursorX = CurrCharX
         CurrLineY + \Font\H : CurrIndex+1 : ViewIndex+1          ; ������
         *pEditLine\pElement\LineWidth = CountWidth
         *pEditLine = NextElement(\ListEditLine())                ; ָ����һ[�༭��]
      Wend
      UnclipOutput()                                              ; ȡ������������
   EndWith
EndProcedure

; ����[������]
Procedure RichEdit_RedrawScrollBar(*pRichEdit.__RichEditInfo)  
   With *pRichEdit
      W = \Gadget\W : H = \Gadget\H
      FontColor = \Format[#Format_NScroll]\FontColor
      BackColor = \Format[#Format_NScroll]\BackColor
      NFontColor = \Format[#Format_NScroll]\FontColor  ;����״̬
      NBackColor = \Format[#Format_NScroll]\BackColor
      MFontColor = \Format[#Format_MScroll]\FontColor  ;�������
      MBackColor = \Format[#Format_MScroll]\BackColor
      DFontColor = \Format[#Format_DScroll]\FontColor  ;�������
      DBackColor = \Format[#Format_DScroll]\BackColor
      ;�����ֵ��ɫ
      NFaceColor = RGB(Red(NFontColor)*0.5, Green(NFontColor)*0.5, Blue(NFontColor)*0.5)   
      MFaceColor = RGB(Red(MFontColor)*0.5, Green(MFontColor)*0.5, Blue(MFontColor)*0.5)   
      DFaceColor = RGB(Red(DFontColor)*0.5, Green(DFontColor)*0.5, Blue(DFontColor)*0.5)   
      ;********** ********** ********** ********** ********** **********
      ; ��ȡ��ֱ����������
      CountLines = ListSize(\ListEditLine())
      If CountLines <= \Viewer\HoldRows
         \VScroll\VaneSize  = H-57        ; ����[��Ƭ]�Ĵ�С
         \VScroll\VanePos   = 0           ; ����[��Ƭ]��λ��
         \VScroll\VaneLast  = 0           ; ����[��Ƭ]������λ��
         \VScroll\SetpScale = 1           ; ����[��Ƭ]�Ĳ���ֵ
      Else
         HideLines = CountLines-\Viewer\HoldRows
         VaneSize  = H-58-HideLines * \Font\H         ; ����[��Ƭ]�Ĵ�С
         If VaneSize <= 22 : VaneSize = 22 : EndIf 
         SetpScale.f = (H-58-VaneSize) / HideLines
         If \Viewer\Row >= HideLines 
            \Viewer\Row = HideLines 
            VanePos = H-57-VaneSize                   ; ����[��Ƭ]��λ��
         Else
            VanePos = \Viewer\Row * SetpScale         ; ����[��Ƭ]��λ��
         EndIf 
         \VScroll\VaneSize  = VaneSize    ; ����[��Ƭ]�Ĵ�С
         \VScroll\VanePos   = VanePos     ; ����[��Ƭ]��λ��
         \VScroll\VaneLast  = HideLines   ; ����[��Ƭ]������λ��
         \VScroll\SetpScale = SetpScale   ; ����[��Ƭ]�Ĳ���ֵ
      EndIf 
      VY = \VScroll\VanePos  : VM = \VScroll\VanePos + \VScroll\VaneSize/2 
      VH = \VScroll\VaneSize : VB = \VScroll\VanePos + \VScroll\VaneSize
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_VScrollT_OnTop
         FontColor = MFontColor : BackColor = MBackColor : FaceColor = MFaceColor
      ElseIf \CurrEvnetHook  = #Event_VScrollT_LDown
         FontColor = DFontColor : BackColor = DBackColor : FaceColor = DFaceColor
      Else 
         FontColor = NFontColor : BackColor = NBackColor : FaceColor = NFaceColor
      EndIf
      DrawingMode(#PB_2DDrawing_Gradient)
      BackColor(FontColor)          : FrontColor(BackColor) 
      LinearGradient(W-30,0,W-17,0) : Box(W-20,1,19,19)     ; �ϼʰ���[����]
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(W-25,0,W+80,0) : Box(W-17,4,6,13)      ; �ϼʰ���[��ͼ���]
      LinearGradient(W-35,0,W+60,0) : Box(W-11,4,7,13)      ; �ϼʰ���[��ͼ�Ҳ�]  
      BackColor(FaceColor) : FrontColor(BackColor) : LinearGradient(W-23,0,W,0)
      For k=1 To 5 : LineXY(W-10-k,7+k,W-12+k,7+k) : Next  ; �ϼʰ���[С��ͷ]
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(W-19,02,17,17,1,1,FontColor)                 ; �ϼʰ���[��߿�]
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_VScrollB_OnTop
         FontColor = MFontColor : BackColor = MBackColor : FaceColor = MFaceColor
      ElseIf \CurrEvnetHook  = #Event_VScrollB_LDown
         FontColor = DFontColor : BackColor = DBackColor : FaceColor = DFaceColor
      Else 
         FontColor = NFontColor : BackColor = NBackColor : FaceColor = NFaceColor
      EndIf
      DrawingMode(#PB_2DDrawing_Gradient)
      BackColor(FontColor)          : FrontColor(BackColor) 
      LinearGradient(W-30,0,W-17,0) : Box(W-20,H-39,19,19)           ; �¼ʰ���[����]
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(W-25,0,W+80,0) : Box(W-17,H-36,6,13)            ; �¼ʰ���[��ͼ���]
      LinearGradient(W-35,0,W+60,0) : Box(W-11,H-36,7,13)            ; �¼ʰ���[��ͼ�Ҳ�]   
      BackColor(FaceColor) : FrontColor(BackColor) : LinearGradient(W-23,0,W,0)
      For k = 1 To 5 : LineXY(W-10-k,H-27-k,W-12+k,H-27-k) : Next   ; �¼ʰ���[С��ͷ]
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(W-19,H-38,17,17,1,1,FontColor)                        ; �¼ʰ���[��߿�]
      ;========== ========== ========== ========== ========== ==========
      DrawingMode(#PB_2DDrawing_Gradient)
      If \CurrEvnetHook  = #Event_VScrollW_OnTop
         BackColor(MFontColor) : FrontColor(MBackColor) 
      ElseIf \CurrEvnetHook  = #Event_VScrollW_LDown
         BackColor(DFontColor) : FrontColor(DBackColor) 
      Else 
         BackColor(NFontColor) : FrontColor(NBackColor) 
      EndIf
      LinearGradient(W-30,0,W-17,0) : Box(W-20,20,19,VY)             ; ���ư���[����]  
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_VScrollS_OnTop
         BackColor(MFontColor) : FrontColor(MBackColor) 
      ElseIf \CurrEvnetHook  = #Event_VScrollS_LDown
         BackColor(DFontColor) : FrontColor(DBackColor) 
      Else 
         BackColor(NFontColor) : FrontColor(NBackColor) 
      EndIf
      LinearGradient(W-30,0,W-17,0) : Box(W-20,19+VB,19,H-58-VB)     ; ���ư���[����]   
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_VScrollM_OnTop
         FontColor = MFontColor : BackColor = MBackColor : FaceColor = MFaceColor
      ElseIf \CurrEvnetHook  = #Event_VScrollM_LDown
         FontColor = DFontColor : BackColor = DBackColor : FaceColor = DFaceColor
      Else 
         FontColor = NFontColor : BackColor = NBackColor : FaceColor = NFaceColor
      EndIf
      BackColor(FontColor)          : FrontColor(BackColor) 
      LinearGradient(W-30,0,W-17,0) : Box(W-20,19+VY,19,VH)          ; ��Ƭ����[����]   
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(W-25,0,W+80,0) : Box(W-17,22+VY,6,VH-6)         ; ��Ƭ����[��ͼ���]
      LinearGradient(W-35,0,W+60,0) : Box(W-11,22+VY,7,VH-6)         ; ��Ƭ����[��ͼ�Ҳ�]
      BackColor(FaceColor)          : FrontColor(BackColor) 
      LinearGradient(W-23,0,W,0)    : LineXY(W-14,18+VM,W-9,18+VM)   ; ��Ƭ����[������]
      LineXY(W-14,15+VM,W-09,15+VM) : LineXY(W-14,21+VM,W-9,21+VM)   ; ��Ƭ����[������] 
      LinearGradient(W-63,0,W,0)    : LineXY(W-14,19+VM,W-9,19+VM)   ; ��Ƭ����[��������Ӱ] 
      LineXY(W-14,16+VM,W-09,16+VM) : LineXY(W-14,22+VM,W-9,22+VM)   ; ��Ƭ����[��������Ӱ]  
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(W-19,20+VY,17,VH-2,1,1,FontColor)                     ; ��Ƭ����[��߿�] 
      ;********** ********** ********** ********** ********** **********
      CountWidth = \pMaxTextLine\LineWidth+\AddLineWidth+\Font\W
      If CountWidth <= \Viewer\W
         \HScroll\VaneSize  = W-57        ; ����[��Ƭ]�Ĵ�С
         \HScroll\VanePos   = 0           ; ����[��Ƭ]��λ��
         \HScroll\VaneLast  = 0           ; ����[��Ƭ]������λ��
         \HScroll\SetpScale = 1           ; ����[��Ƭ]�Ĳ���ֵ
      Else
         HideWith = CountWidth-\Viewer\W
         HideChar = HideWith / \Font\W + 1         ;������ַ���
         VaneSize  = W-58-HideWith                 ; ����[��Ƭ]�Ĵ�С
         If VaneSize <= 22 : VaneSize = 22 : EndIf 
         SetpScale.f = (W-58-VaneSize)/HideChar    ; ����[��Ƭ]��λ��
         If \Viewer\Col * \Font\W >= HideWith - 1
            \Viewer\Col = HideChar 
            VanePos = W-57-VaneSize                ; ����[��Ƭ]��λ��
         Else
            VanePos = \Viewer\Col * SetpScale      ; ����[��Ƭ]��λ��
         EndIf 
         \HScroll\VaneSize  = VaneSize    ; ����[��Ƭ]�Ĵ�С
         \HScroll\VanePos   = VanePos     ; ����[��Ƭ]��λ��
         \HScroll\VaneLast  = HideChar    ; ����[��Ƭ]������λ��
         \HScroll\SetpScale = SetpScale   ; ����[��Ƭ]�Ĳ���ֵ
      EndIf
      HX = \HScroll\VanePos  : HM = \HScroll\VanePos + \HScroll\VaneSize/2 
      HW = \HScroll\VaneSize : HR = \HScroll\VanePos + \HScroll\VaneSize
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_HScrollL_OnTop
         FontColor = MFontColor : BackColor = MBackColor : FaceColor = MFaceColor
      ElseIf \CurrEvnetHook  = #Event_HScrollL_LDown
         FontColor = DFontColor : BackColor = DBackColor : FaceColor = DFaceColor
      Else 
         FontColor = NFontColor : BackColor = NBackColor : FaceColor = NFaceColor
      EndIf
      DrawingMode(#PB_2DDrawing_Gradient)
      BackColor(FontColor)          : FrontColor(BackColor) 
      LinearGradient(0,H-30,0,H-17) : Box(01,H-20,19,19)             ; ��ʰ���[����]
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(0,H-25,0,H+80) : Box(04,H-17,13,6)              ; ��ʰ���[��ͼ�ϲ�]
      LinearGradient(0,H-35,0,H+60) : Box(04,H-11,13,7)              ; ��ʰ���[��ͼ�²�]  
      BackColor(FaceColor) : FrontColor(BackColor) : LinearGradient(0,H-23,0,H)
      For k = 1 To 5 : LineXY(7+k,H-10-k,07+k,H-12+k) : Next        ; ��ʰ���[С��ͷ]
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(02,H-19,17,17,1,1,FontColor)                          ; ��ʰ���[��߿�]
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_HScrollR_OnTop
         FontColor = MFontColor : BackColor = MBackColor : FaceColor = MFaceColor
      ElseIf \CurrEvnetHook  = #Event_HScrollR_LDown
         FontColor = DFontColor : BackColor = DBackColor : FaceColor = DFaceColor
      Else 
         FontColor = NFontColor : BackColor = NBackColor : FaceColor = NFaceColor
      EndIf
      DrawingMode(#PB_2DDrawing_Gradient)
      BackColor(FontColor)          : FrontColor(BackColor) 
      LinearGradient(0,H-30,0,H-17) : Box(W-39,H-20,19,19)          ; �Ҽʰ���[����]
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(0,H-25,0,H+80) : Box(W-36,H-17,13,6)           ; �Ҽʰ���[��ͼ�ϲ�]
      LinearGradient(0,H-35,0,H+60) : Box(W-36,H-11,13,7)           ; �Ҽʰ���[��ͼ�²�]  
      BackColor(FaceColor) : FrontColor(BackColor) : LinearGradient(0,H-23,0,H)
      For k = 1 To 5 : LineXY(W-27-k,H-10-k,W-27-k,H-12+k) : Next  ; �Ҽʰ���[С��ͷ]
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(W-38,H-19,17,17,1,1,FontColor)                       ; �Ҽʰ���[��߿�]
      ;========== ========== ========== ========== ========== ==========      
      DrawingMode(#PB_2DDrawing_Gradient)
      If \CurrEvnetHook  = #Event_HScrollA_OnTop
         BackColor(MFontColor) : FrontColor(MBackColor)
      ElseIf \CurrEvnetHook  = #Event_HScrollA_LDown
         BackColor(DFontColor) : FrontColor(DBackColor) 
      Else 
         BackColor(NFontColor) : FrontColor(NBackColor) 
      EndIf
      LinearGradient(0,H-30,0,H-17) : Box(20,H-20,HX,19)             ; ���ư���[����]   
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_HScrollD_OnTop
         BackColor(MFontColor) : FrontColor(MBackColor) 
      ElseIf \CurrEvnetHook  = #Event_HScrollD_LDown
         BackColor(DFontColor) : FrontColor(DBackColor) 
      Else 
         BackColor(NFontColor) : FrontColor(NBackColor) 
      EndIf
      LinearGradient(0,H-30,0,H-17) : Box(19+HR,H-20,W-58-HR,19)     ; ���ư���[����]   
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_HScrollM_OnTop
         FontColor = MFontColor : BackColor = MBackColor : FaceColor = MFaceColor
      ElseIf \CurrEvnetHook  = #Event_HScrollM_LDown
         FontColor = DFontColor : BackColor = DBackColor : FaceColor = DFaceColor
      Else 
         FontColor = NFontColor : BackColor = NBackColor : FaceColor = NFaceColor
      EndIf 
      BackColor(FontColor)          : FrontColor(BackColor) 
      LinearGradient(0,H-30,0,H-17) : Box(19+HX,H-20,HW,19)          ; ��Ƭ����[����]   
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(0,H-25,0,H+80) : Box(22+HX,H-17,HW-6,6)         ; ��Ƭ����[��ͼ�ϲ�]
      LinearGradient(0,H-35,0,H+60) : Box(22+HX,H-11,HW-6,7)         ; ��Ƭ����[��ͼ�²�]
      BackColor(FaceColor)          : FrontColor(BackColor) 
      LinearGradient(0,H-23,0,H)    : LineXY(18+HM,H-14,18+HM,H-9)   ; ��Ƭ����[������]
      LineXY(15+HM,H-14,15+HM,H-9)  : LineXY(21+HM,H-14,21+HM,H-9)   ; ��Ƭ����[������] 
      LinearGradient(0,H-63,0,H)    : LineXY(19+HM,H-14,19+HM,H-9)   ; ��Ƭ����[��������Ӱ] 
      LineXY(16+HM,H-14,16+HM,H-9)  : LineXY(22+HM,H-14,22+HM,H-9)   ; ��Ƭ����[��������Ӱ]  
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(20+HX,H-19,HW-2,17,1,1,FontColor)                     ; ��Ƭ����[��߿�] 
      ;********** ********** ********** ********** ********** **********
      DrawingMode(#PB_2DDrawing_Gradient)
      BackColor (NFontColor) : FrontColor(NBackColor)
      LinearGradient(W-80, H-80, W-1, H-1) : Box(W-20, H-20, 19, 19) ; ��ͼ  
      BackColor(NFaceColor) : FrontColor(NBackColor) 
      LinearGradient(W-23,H-23,W-1,H-1)
      Circle(W-06,H-6,1) : Circle(W-10,H-6,1) : Circle(W-6,H-10,1)
      Circle(W-14,H-6,1) : Circle(W-6,H-14,1) : Circle(W-10,H-10,1)
   EndWith
EndProcedure

; ����[������ʾ�����]
Procedure RichEdit_RedrawSetCaret(*pRichEdit.__RichEditInfo)
   With *pRichEdit
      If GetFocus_() <> *pRichEdit\hGadget : ProcedureReturn : EndIf 
      *pViewChar.__RichEdit_ViewChar                           ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine                           ; [������|������]�ڴ����ָ��  
      CaretY = \Viewer\Y+(\Cursor\Row-\Viewer\Row) * \Font\H   ; �������ʾ�����������Y����
      *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row) ; ��ȡ��ǰ�����ָ��

      If CaretY >= 0 And CaretY < \Gadget\H-20-\Font\H And *pEditLine\LineIndex = \Cursor\RealRow
         ; �������������������,�򽫹��λ����Ϊ�������Ĺ��λ��
         If \Cursor\Col >= #RichEdit_MaxLineChars Or \Cursor\Col >= *pEditLine\pElement\CountChars
            CaretX = *pEditLine\LastCursorX
         Else                                                  ; ���������λ��
            *pViewChar = \pMemViewChar+ (\Cursor\Row-\Viewer\Row) * #RichEdit_FullRowBytes
            *pViewChar + \Cursor\Col * #RichEdit_ViewCharSize
            CaretX = *pViewChar\X               
         EndIf 
         If CaretX >= \Viewer\X And CaretX <= \Viewer\X+\Viewer\W
            SetCaretPos_(CaretX,  CaretY)                      ; ���ù���λ��
            If \EditState & #EditState_CaretVisible = #Null    ; ����������,����ʾ��
               ShowCaret_(\hGadget) : \EditState | #EditState_CaretVisible
            EndIf 
         ElseIf \EditState & #EditState_CaretVisible          ; ���������,��������
            HideCaret_(\hGadget) : \EditState & ~#EditState_CaretVisible
         EndIf 
      ElseIf \EditState & #EditState_CaretVisible             ; ���������,��������
         HideCaret_(\hGadget) : \EditState & ~#EditState_CaretVisible
      EndIf 
   EndWith
EndProcedure

; �ػ������ؼ�
Procedure RichEdit_RedrawGadget(*pRichEdit.__RichEditInfo)
   With *pRichEdit
      ; ��������[������]����Ϣ
      \Viewer\Y        = (\Font\H-\Font\Size)/2       ; [������]���ϼ�   
      \Viewer\H        = \Gadget\H-\Viewer\Y-20       ; [������]���¼�   
      \Viewer\HoldRows = \Viewer\H /\Font\H           ; [������]���ɵ�����  
;       If \EditState & #EditState_FoldVisible
         \Fold\Size  = \Font\H/2*2+1                  ; [�۵���]���۵����Ĵ�С   
         If \Font\H >= 15 : \Fold\Size = 15 : EndIf     
         \Fold\W  = \Fold\Size+6                      ; [�۵���]�Ŀ��              
;       Else 
;          \Fold\Size = 0  : \Fold\W = 0     
;       EndIf 
    
      CountLines       = ListSize(\ListEditLine())    ; ���۵��е�����
      MaxLines         = CountLines-\Viewer\HoldRows
      If CountLines < \Viewer\HoldRows : MaxLines = CountLines : EndIf 
      \Viewer\Row      = RichEdit_Limit(\Viewer\Row, 0, MaxLines)
      \Viewer\LastLine = \Viewer\Row+\Viewer\HoldRows ; [������]�¼���ʾ������
      If \Viewer\LastLine > CountLines-1 : \Viewer\LastLine = CountLines-1 : EndIf 
      SelectElement(\ListEditLine(), \Viewer\LastLine); ѡ��[������]���һ��
      MaxChar = Len(Str(\ListEditLine()\LineIndex))   ; �����з����ֽ���
      \Viewer\MarkW    = MaxChar * \Font\W + 10       ; [�з���]�Ŀ��
      \Viewer\X        = \Viewer\MarkW+\Fold\W        ; [������]�����
      \Viewer\W        = \Gadget\W-\Viewer\X-20       ; [������]�����
      \Viewer\HoldCols = \Viewer\W /\Font\W           ; [������]���ɵ�����  
      CountChars       = (\pMaxTextLine\LineWidth+\AddLineWidth)/\Font\W+1
      MaxChars         = CountChars-\Viewer\HoldCols
      If CountChars < \Viewer\HoldCols : MaxChars = CountChars : EndIf 
      \Viewer\Col      = RichEdit_Limit(\Viewer\Col, 0, MaxChars)
      
      ; �ػ�[������]ͼ��
      ImageID = CreateImage(#PB_Any, \Gadget\W, \Gadget\H)
      If ImageID = 0 : ProcedureReturn : EndIf 
      If StartDrawing(ImageOutput(ImageID))
         RichEdit_RedrawMarkArea (*pRichEdit)         ; ����[�з���]
         RichEdit_RedrawViewArea (*pRichEdit)         ; ����[������]
         RichEdit_RedrawScrollBar(*pRichEdit)         ; ����[������]
         DrawingMode(#PB_2DDrawing_Outlined)
         Box(000, 000, \Gadget\W, \Gadget\H, $888888)
         StopDrawing()
         ; ���ñ���ˢ,��ˢ�¿ؼ�
         If \hBrushBack : DeleteObject_(\hBrushBack) : EndIf 
         \hBrushBack = CreatePatternBrush_(ImageID(ImageID)) : FreeImage(ImageID) 
         SetClassLong_(\hGadget, #GCL_HBRBACKGROUND, \hBrushBack)
         InvalidateRect_(\hGadget, #Null, #True)      ;����ˢ����
         UpdateWindow_(\hGadget)                      ;ˢ�¿ؼ�
         RichEdit_RedrawSetCaret(*pRichEdit)          ;����������ʾ�����
      EndIf 
   EndWith
EndProcedure

;- ***********************
; ��ݼ�[Shift|�������]
Procedure RichEdit_GadgetHook_KeyDown_TOUP(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��   
      ; <Shift>�����,��������״̬
      If IsKeyDownShift And \Cursor\Row > 0
         \Cursor\Row     = \Cursor\Row - 1  
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex 
         RedrawType = #Redraw_FullArea
      ; <Shift>�����,������,û��ѡ��
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <Shift>�����,��ѡ���л��������״̬, �������A
      ElseIf \Cursor\Row < \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <Shift>�����,��ѡ���л��������״̬, ˳�����B
      ElseIf \Cursor\Row > \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea    
      ; <Shift>�����,��ѡ���л��������״̬, �������C,ע:�˴�������(�������A)�ϲ�  
      ElseIf \Cursor\Col < \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <Shift>�����,��ѡ���л��������״̬, ˳�����D,ע:�˴�������(�������B)�ϲ� 
      ElseIf \Cursor\Col > \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea  
      ; ������״̬         
      ElseIf \Cursor\Row > 0
         \Cursor\Row - 1
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex : \Record\Row = \Cursor\Row
         \Record\RealRow = \Cursor\RealRow      : \Record\Col = \Cursor\Col
         RedrawType = #Redraw_FullArea 
      EndIf  
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; ��ݼ�[Shift|�������]
Procedure RichEdit_GadgetHook_KeyDown_DOWN(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��   
      ; <Shift>�����,��������״̬
      If IsKeyDownShift And \Cursor\Row < ListSize(\ListEditLine())-1
         \Cursor\Row     = \Cursor\Row + 1  
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex 
         RedrawType      = #Redraw_FullArea
      ; <Shift>�����,������,û��ѡ��
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <Shift>�����,��ѡ���л��������״̬, �������A
      ElseIf \Cursor\Row < \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <Shift>�����,��ѡ���л��������״̬, ˳�����B
      ElseIf \Cursor\Row > \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea    
      ; <Shift>�����,��ѡ���л��������״̬, �������C,ע:�˴�������(�������A)�ϲ�  
      ElseIf \Cursor\Col < \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <Shift>�����,��ѡ���л��������״̬, ˳�����D,ע:�˴�������(�������B)�ϲ� 
      ElseIf \Cursor\Col > \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea  
      ; ������״̬         
      ElseIf \Cursor\Row < ListSize(\ListEditLine())-1
         \Cursor\Row + 1
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex : \Record\Col = \Cursor\Col
         \Record\RealRow = \Cursor\RealRow      : \Record\Row = \Cursor\Row      
         RedrawType      = #Redraw_FullArea 
      EndIf  
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; ��ݼ�[Shift|�������] 
Procedure RichEdit_GadgetHook_KeyDown_LEFT (*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��   
      ; <Shift>�����,��������״̬
      If IsKeyDownShift And \Cursor\Col = 0 And \Cursor\Row > 0
         \Cursor\Row     = \Cursor\Row - 1  
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\Col     = *pEditLine\pElement\CountChars
         \Cursor\RealRow = *pEditLine\LineIndex 
         \Cursor\RealCol = *pEditLine\pElement\LineWidth / \Font\W
         RedrawType = #Redraw_FullArea
      ; <Shift>�����,������״̬
      ElseIf IsKeyDownShift And \Cursor\Col > 0
         \Cursor\Col - 1 : \Cursor\RealCol - 1 : RedrawType = #Redraw_FullArea
      ; <Shift>�����,������,û��ѡ��
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <��Shift>�����,��ѡ���л��������״̬, �������A
      ElseIf \Cursor\Row < \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <��Shift>�����,��ѡ���л��������״̬, ˳�����B
      ElseIf \Cursor\Row > \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea    
      ; <��Shift>�����,��ѡ���л��������״̬, �������C,ע:�˴�������(�������A)�ϲ�  
      ElseIf \Cursor\Col < \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <��Shift>�����,��ѡ���л��������״̬, ˳�����D,ע:�˴�������(�������B)�ϲ� 
      ElseIf \Cursor\Col > \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea  
      ; <��Shift>�����,��������״̬
      ElseIf \Cursor\Col = 0 And \Cursor\Row > 0
         \Cursor\Row = \Cursor\Row - 1  
         If \Cursor\Row < \Viewer\Row And \Viewer\Row > 0 : \Viewer\Row - 1 : EndIf 
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\Col     = *pEditLine\pElement\CountChars
         \Cursor\RealRow = *pEditLine\LineIndex 
         \Cursor\RealCol = *pEditLine\pElement\LineWidth / \Font\W
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea    
      ; <��Shift>�����,������״̬         
      ElseIf \Cursor\Col > 0
         \Cursor\Col - 1 : \Record\Col - 1 : \Cursor\RealCol - 1
         RedrawType = #Redraw_SetCaret 
      EndIf 
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; ��ݼ�[Shift|�������] 
Procedure RichEdit_GadgetHook_KeyDown_RIGHT(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   ;���[�����]����[������]��,Ӧ�ȴ����괦����[������]
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��  
      *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row)   
      ; <Shift>�����,��������״̬
      If IsKeyDownShift And \Cursor\Col = *pEditLine\pElement\CountChars And \Cursor\Row < ListSize(\ListEditLine())-2
         \Cursor\Row = \Cursor\Row + 1  
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row) 
         \Cursor\Col     = 0 
         \Cursor\RealRow = *pEditLine\LineIndex 
         \Cursor\RealCol = 0 
         RedrawType = #Redraw_FullArea
      ; <Shift>�����,������״̬
      ElseIf IsKeyDownShift And \Cursor\Col < *pEditLine\pElement\CountChars
         \Cursor\Col + 1 : \Cursor\RealCol + 1 : RedrawType = #Redraw_FullArea
      ; <Shift>�����,������,û��ѡ��
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <��Shift>�����,��ѡ���л��������״̬, �������A
      ElseIf \Cursor\Row < \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <��Shift>�����,��ѡ���л��������״̬, ˳�����B
      ElseIf \Cursor\Row > \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea    
      ; <��Shift>�����,��ѡ���л��������״̬, �������C,ע:�˴�������(�������A)�ϲ�  
      ElseIf \Cursor\Col < \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <��Shift>�����,��ѡ���л��������״̬, ˳�����D,ע:�˴�������(�������B)�ϲ� 
      ElseIf \Cursor\Col > \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea  
      ; <��Shift>�����,��������״̬
      ElseIf \Cursor\Col = *pEditLine\pElement\CountChars And \Cursor\Row < ListSize(\ListEditLine())-1
         \Cursor\Row     = \Cursor\Row + 1 
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row) 
         \Cursor\Col     = 0
         \Cursor\RealRow = *pEditLine\LineIndex 
         \Cursor\RealCol = 0
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea  
      ; <��Shift>�����,������״̬         
      ElseIf \Cursor\Col < *pEditLine\pElement\CountChars
         \Cursor\Col + 1 : \Record\Col + 1 : \Record\RealCol + 1
         RedrawType = #Redraw_SetCaret 
      EndIf 
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; ��ݼ�[Shift|��ҳ��PageUp]
Procedure RichEdit_GadgetHook_KeyDown_PREV(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��   
      ; <Shift>�����,��������״̬
      If IsKeyDownShift And \Cursor\Row > 0
         \Cursor\Row     = \Cursor\Row - \Viewer\HoldRows
         If \Cursor\Row < 0 : \Cursor\Row = 0 : EndIf 
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex 
         RedrawType      = #Redraw_FullArea
         
      ; <Shift>�����,������,û��ѡ��
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <Shift>�����,��ѡ���л��������״̬, �������A
      ElseIf \Cursor\Row < \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType  = #Redraw_FullArea 
      ; <Shift>�����,��ѡ���л��������״̬, ˳�����B
      ElseIf \Cursor\Row > \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType  = #Redraw_FullArea    
      ; <Shift>�����,��ѡ���л��������״̬, �������C,ע:�˴�������(�������A)�ϲ�  
      ElseIf \Cursor\Col < \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType  = #Redraw_FullArea 
      ; <Shift>�����,��ѡ���л��������״̬, ˳�����D,ע:�˴�������(�������B)�ϲ� 
      ElseIf \Cursor\Col > \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType  = #Redraw_FullArea  
      ; ������״̬         
      ElseIf \Cursor\Row > 0
         \Cursor\Row     = \Cursor\Row - \Viewer\HoldRows
         If \Cursor\Row < 0 : \Cursor\Row = 0 : EndIf 
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex : \Record\Col = \Cursor\Col
         \Record\RealRow = \Cursor\RealRow      : \Record\Row = \Cursor\Row
         RedrawType      = #Redraw_FullArea 
      EndIf  
      
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; ��ݼ�[Shift|��ҳ��PageDown]
Procedure RichEdit_GadgetHook_KeyDown_NEXT(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��   
      ; <Shift>�����,��������״̬
      If IsKeyDownShift And \Cursor\Row < ListSize(\ListEditLine())-1
         \Cursor\Row     = \Cursor\Row + \Viewer\HoldRows
         If \Cursor\Row > ListSize(\ListEditLine())-1 : \Cursor\Row = ListSize(\ListEditLine()) - 1 : EndIf 
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex 
         RedrawType      = #Redraw_FullArea
         
      ; <Shift>�����,������,û��ѡ��
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <��Shift>�����,��ѡ���л��������״̬, �������A
      ElseIf \Cursor\Row < \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <��Shift>�����,��ѡ���л��������״̬, ˳�����B
      ElseIf \Cursor\Row > \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea    
      ; <��Shift>�����,��ѡ���л��������״̬, �������C,ע:�˴�������(�������A)�ϲ�  
      ElseIf \Cursor\Col < \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <��Shift>�����,��ѡ���л��������״̬, ˳�����D,ע:�˴�������(�������B)�ϲ� 
      ElseIf \Cursor\Col > \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea  
      ; ������״̬         
      ElseIf \Cursor\Row < ListSize(\ListEditLine())-1
         \Cursor\Row     = \Cursor\Row + \Viewer\HoldRows
         If \Cursor\Row > ListSize(\ListEditLine())-1 : \Cursor\Row = ListSize(\ListEditLine()) - 1 : EndIf 
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex : \Record\Col = \Cursor\Col
         \Record\RealRow = \Cursor\RealRow      : \Record\Row = \Cursor\Row
         RedrawType = #Redraw_FullArea 
      EndIf  
      
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; ��ݼ�[Shift|��ҳ��Home]
Procedure RichEdit_GadgetHook_KeyDown_Home(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��   
      ; <Shift>�����,��������״̬
      If IsKeyDownShift And \Cursor\Col > 0
         \Cursor\Col = 0 : \Cursor\RealCol = 0 : RedrawType = #Redraw_FullArea
      ; <Shift>�����,������,û��ѡ��
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <��Shift>�����,��ѡ���л��������״̬, �������A
      ElseIf \Cursor\Row < \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <��Shift>�����,��ѡ���л��������״̬, ˳�����B
      ElseIf \Cursor\Row > \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea    
      ; <��Shift>�����,��ѡ���л��������״̬, �������C,ע:�˴�������(�������A)�ϲ�  
      ElseIf \Cursor\Col < \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <��Shift>�����,��ѡ���л��������״̬, ˳�����D,ע:�˴�������(�������B)�ϲ� 
      ElseIf \Cursor\Col > \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea  
      ; <��Shift>�����,������״̬         
      ElseIf \Cursor\Col > 0
         \Cursor\Col = 0 : \Cursor\RealCol = 0
         \Record\Col = 0 : \Record\RealCol = 0
         RedrawType = #Redraw_SetCaret 
      EndIf 
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; ��ݼ�[Shift|��ҳ��End]
Procedure RichEdit_GadgetHook_KeyDown_END(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��  
      *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row)    
      ; <Shift>�����,��������״̬
      If IsKeyDownShift And \Cursor\Col < *pEditLine\pElement\CountChars
         \Cursor\Col     = *pEditLine\pElement\CountChars
         \Cursor\RealCol = *pEditLine\pElement\LineWidth / \Font\W
         RedrawType = #Redraw_FullArea
      ; <Shift>�����,������,û��ѡ��
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <��Shift>�����,��ѡ���л��������״̬, �������A
      ElseIf \Cursor\Row < \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <��Shift>�����,��ѡ���л��������״̬, ˳�����B
      ElseIf \Cursor\Row > \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea    
      ; <��Shift>�����,��ѡ���л��������״̬, �������C,ע:�˴�������(�������A)�ϲ�  
      ElseIf \Cursor\Col < \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <��Shift>�����,��ѡ���л��������״̬, ˳�����D,ע:�˴�������(�������B)�ϲ� 
      ElseIf \Cursor\Col > \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea  
      ; <��Shift>�����,������״̬         
      ElseIf \Cursor\Col > 0
         \Cursor\Col     = *pEditLine\pElement\CountChars
         \Cursor\RealCol = *pEditLine\pElement\LineWidth / \Font\W
         \Record\Col     = \Cursor\Col
         \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_SetCaret 
      EndIf 
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; ��ݼ�[Ctrl+A]��<ȫѡ�¼�>
Procedure RichEdit_GadgetHook_KeyDown_SELA(*pRichEdit.__RichEditInfo, IsKeyDownCtrl)
   With *pRichEdit
      If IsKeyDownCtrl = 0 : ProcedureReturn : EndIf 
      *pViewChar.__RichEdit_ViewChar      ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��  
      *pEditLine = LastElement(\ListEditLine())  
      \Cursor\Col     = 0 : \Cursor\RealRow = 0
      \Cursor\Row     = 0 : \Cursor\RealCol = 0      
      \Record\Col     = *pEditLine\pElement\CountChars-1
      \Record\Row     = ListSize(\ListEditLine())-2
      \Record\RealRow = ListSize(\ListTextLine())-1
      \Record\RealCol = *pEditLine\pElement\LineWidth / \Font\W
      RedrawType = #Redraw_FullArea  
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; ��ݼ�[Ctrl+C]
Procedure RichEdit_GadgetHook_KeyDown_COPY(*pRichEdit.__RichEditInfo, IsKeyDownCtrl)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine      ; [������|������]�ڴ����ָ��  
      If IsKeyDownCtrl = 0 : ProcedureReturn : EndIf 
      If \Cursor\Row < \Record\Row
         *pElement =  SelectElement(\ListTextLine(), \Cursor\RealRow) 
         CopyText$ = Mid(\ListTextLine()\LineText$, \Cursor\Col+1)+ #CRLF$
         *pElement = NextElement(\ListTextLine()) 
         TextLine = ListIndex(\ListTextLine())
         While *pElement
            If TextLine > \Record\RealRow 
               Break
            ElseIf TextLine = \Record\RealRow 
               CopyText$ + Left(\ListTextLine()\LineText$, \Record\Col)
               Break
            EndIf 
            CopyText$ + \ListTextLine()\LineText$+ #CRLF$
            *pElement = NextElement(\ListTextLine()) 
            TextLine+1
         Wend
         SetClipboardText(CopyText$) 
         
      ElseIf \Cursor\Row > \Record\Row
         SelectElement(\ListTextLine(), \Record\RealRow) 
         CopyText$ = Mid(\ListTextLine()\LineText$, \Record\Col+1)+ #CRLF$
         *pElement = NextElement(\ListTextLine())
         TextLine  = ListIndex(\ListTextLine())
         While *pElement
            If TextLine > \Cursor\RealRow 
               Break
            ElseIf TextLine = \Cursor\RealRow 
               CopyText$ + Left(\ListTextLine()\LineText$, \Cursor\Col)
               Break
            EndIf 
            CopyText$ + \ListTextLine()\LineText$+ #CRLF$
            *pElement = NextElement(\ListTextLine())
            TextLine+1 
         Wend
         SetClipboardText(CopyText$) 

      ElseIf \Cursor\Col < \Record\Col
         SelectElement(\ListTextLine(), \Cursor\RealRow) 
         CopyText$ = Mid(\ListTextLine()\LineText$, \Cursor\Col+1, \Record\Col-\Cursor\Col)
         SetClipboardText(CopyText$) 
      ElseIf \Cursor\Col > \Record\Col
         SelectElement(\ListTextLine(), \Cursor\RealRow) 
         CopyText$ = Mid(\ListTextLine()\LineText$, \Record\Col+1, \Cursor\Col-\Record\Col)
         SetClipboardText(CopyText$) 
      EndIf 
   EndWith
   ProcedureReturn #Redraw_NotEvent
EndProcedure

; �����̰���������ʱ
Procedure RichEdit_GadgetHook_KeyDown(*pRichEdit.__RichEditInfo, KeyValue)
   With *pRichEdit
      IsKeyDownCtrl  = GetKeyState_(#VK_CONTROL) & $80
      IsKeyDownShift = GetKeyState_(#VK_SHIFT)   & $80
      *pViewChar.__RichEdit_ViewChar                           ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine                           ; [������|������]�ڴ����ָ��  
      Select KeyValue
         Case #VK_UP          ;[�ı���|�������]
            RedrawType = RichEdit_GadgetHook_KeyDown_TOUP (*pRichEdit, IsKeyDownShift)
         Case #VK_DOWN       ;[�ı���|�������]
            RedrawType = RichEdit_GadgetHook_KeyDown_DOWN (*pRichEdit, IsKeyDownShift)
         Case #VK_LEFT        ;[�ı���|�������] 
            RedrawType = RichEdit_GadgetHook_KeyDown_LEFT (*pRichEdit, IsKeyDownShift)
         Case #VK_RIGHT       ;[�ı���|�������] 
            RedrawType = RichEdit_GadgetHook_KeyDown_RIGHT(*pRichEdit, IsKeyDownShift)
         ;=======================
         Case #VK_PRIOR       ;[�ı���|��ҳ��PageUp]
            RedrawType = RichEdit_GadgetHook_KeyDown_PREV (*pRichEdit, IsKeyDownShift)
         Case #VK_NEXT        ;[�ı���|��ҳ��PageDown]
            RedrawType = RichEdit_GadgetHook_KeyDown_NEXT (*pRichEdit, IsKeyDownShift)
         Case #VK_HOME        ;[�ı���|��ҳ��Home]
            RedrawType = RichEdit_GadgetHook_KeyDown_HOME (*pRichEdit, IsKeyDownShift)
         Case #VK_END         ;[�ı���|��ҳ��End]
            RedrawType = RichEdit_GadgetHook_KeyDown_END  (*pRichEdit, IsKeyDownShift)
         ;======================= 
         Case #VK_A           ;[[�ı���|A��]<ȫѡ�¼�>
            RedrawType = RichEdit_GadgetHook_KeyDown_SELA (*pRichEdit, IsKeyDownCtrl)
         Case #VK_C           ;[[�ı���|C��]<�����¼�>
            RichEdit_GadgetHook_KeyDown_COPY (*pRichEdit, IsKeyDownCtrl)  
            ProcedureReturn 
      EndSelect
      ;=======================
      If RedrawType
         ; �жϹ���Ƿ���[������],�����ƶ�[������]ʹ�ù��ɼ�
         If \Cursor\Row >= \Viewer\Row+\Viewer\HoldRows 
            \Viewer\Row = \Cursor\Row - \Viewer\HoldRows+1
            RedrawType = #Redraw_FullArea 
         ElseIf \Cursor\Row <= \Viewer\Row
            \Viewer\Row = \Cursor\Row-1
            RedrawType = #Redraw_FullArea 
         EndIf 
         If \Viewer\Col <= \Cursor\RealCol+\Viewer\HoldCols
            \Viewer\Col = \Cursor\RealCol-\Viewer\HoldCols+1
            RedrawType = #Redraw_FullArea 
         ElseIf \Viewer\Col >= \Cursor\RealCol
            \Viewer\Col = \Cursor\RealCol-1
            RedrawType = #Redraw_FullArea 
         EndIf 
      EndIf 
      Select RedrawType
         Case #Redraw_SetCaret   ; ��ʾ������
            RichEdit_RedrawSetCaret(*pRichEdit)
         Case #Redraw_ViewArea   ; ��ʾ�ػ滭��
            RichEdit_ParserFoldArea(*pRichEdit, \Cursor\RealRow) 
         Case #Redraw_FullArea   ; ��ʾ�ػ滭�沢���ù����
            RichEdit_ParserFoldArea(*pRichEdit, \Cursor\RealRow) 
            SelectElement(\ListTextLine(), \Cursor\RealRow)                   ; ѡ�й�괦��[�ı���]
            \Cursor\IsInFold = \ListTextLine()\FoldState & #FoldState_IsHide  ; �����۵�״̬         
            RichEdit_RedrawGadget(*pRichEdit)
      EndSelect
   EndWith
EndProcedure
   
;- ***********************
; <HOOK|�������>�¼�
Procedure RichEdit_GadgetHook_MouseOnTop(*pRichEdit.__RichEditInfo, *pMouse.Points)
   Shared  *pCurrRichEdit.__RichEditInfo
   Shared  *pPrevRichEdit.__RichEditInfo
   *pCurrRichEdit = *pRichEdit   ; ��<MouseHook>�¼����ݵ�ǰ�ؼ���Ϣ,ʵ��Խ���϶�
   If *pPrevRichEdit <> *pCurrRichEdit
      *pPrevRichEdit = *pCurrRichEdit : SetActiveGadget(*pRichEdit\GadgetID)
   EndIf 

   With *pRichEdit   
      If *pMouse\x >= \Gadget\W-20 And *pMouse\y >= \Gadget\H-20 
         hCursor = \Cursor\hARROW                  ; �л�Ϊ[�����ͷ���]
      ;========== ========== ========== ========== ========== ==========
      ElseIf *pMouse\x >= \Gadget\W-20            ; [�Ҳ������]
         hCursor = \Cursor\hARROW                  ; �л�Ϊ[�����ͷ���]
         If *pMouse\y < 20
            \CurrEvnetHook = #Event_VScrollT_OnTop ; [�Ҳ������|�ϼʰ���]
         ElseIf *pMouse\y > \Gadget\H - 40  
            \CurrEvnetHook = #Event_VScrollB_OnTop ; [�Ҳ������|�¼ʰ���]
         ElseIf *pMouse\y < \VScroll\VanePos + 20
            \CurrEvnetHook = #Event_VScrollW_OnTop ; [�Ҳ������|���ư���]
         ElseIf *pMouse\y > \VScroll\VanePos + \VScroll\VaneSize + 20
            \CurrEvnetHook = #Event_VScrollS_OnTop ; [�Ҳ������|���ư���]
         Else 
            \CurrEvnetHook = #Event_VScrollM_OnTop ; [�Ҳ������|��Ƭ����]
         EndIf 
      ;========== ========== ========== ========== ========== ==========
      ElseIf *pMouse\y >= \Gadget\H-20             ; [�ײ�������]
         hCursor = \Cursor\hARROW                  ; �л�Ϊ[�����ͷ���]
         If *pMouse\x < 20
            \CurrEvnetHook = #Event_HScrollL_OnTop ; [�ײ�������|��ʰ���]<�������>
         ElseIf *pMouse\x > \Gadget\W - 40  
            \CurrEvnetHook = #Event_HScrollR_OnTop ; [�ײ�������|�Ҽʰ���]<�������>
         ElseIf *pMouse\x < \HScroll\VanePos + 20
            \CurrEvnetHook = #Event_HScrollA_OnTop ; [�ײ�������|���ư���]<�������>
         ElseIf *pMouse\x > \HScroll\VanePos + \HScroll\VaneSize + 20
            \CurrEvnetHook = #Event_HScrollD_OnTop ; [�ײ�������|���ư���]<�������>
         Else 
            \CurrEvnetHook = #Event_HScrollM_OnTop ;[�ײ�������|��Ƭ����]<�������>
         EndIf
      ;========== ========== ========== ========== ========== ==========
      ElseIf *pMouse\x <= \Viewer\MarkW           ; [�з���]
         hCursor = \Cursor\hRMARK                  ; �л�Ϊ[��ʽ��ͷ���]
         \CurrEvnetHook = #Event_MarkArea_OnTop
      ;========== ========== ========== ========== ========== ==========
      ElseIf *pMouse\x <= \Viewer\X               ; [�۵���]
         hCursor = \Cursor\hRMARK                  ; �л�Ϊ[��ʽ��ͷ���]
         \CurrEvnetHook = #Event_FoldArea_OnTop
         *pElement = SelectElement(\ListEditLine(), (*pMouse\y-\Viewer\Y)/\Font\H+\Viewer\Row)
         If *pElement <= 0 : ProcedureReturn : EndIf 
         IsRedraw = RichEdit_ParserFoldArea(*pRichEdit, \ListEditLine()\LineIndex)
      ;========== ========== ========== ========== ========== ==========
      Else 
         CursorRow = (*pMouse\y-\Viewer\Y)/\Font\H+\Viewer\Row
         If (CursorRow >= \Cursor\Row And CursorRow <= \Record\Row) Or (CursorRow <= \Cursor\Row And CursorRow >= \Record\Row)
            If (CursorCol >= \Cursor\Col And CursorCol < \Record\Col) Or (CursorCol < \Cursor\Col And CursorCol >= \Record\Col)
               IsOnSelect = #True
            EndIf 
         EndIf 
         If IsOnSelect = #True
            hCursor = \Cursor\hARROW               ;�л�Ϊ[��ʾ�����]
            \CurrEvnetHook = #Event_EditArea_OTSelected
         Else 
            hCursor = \Cursor\hIBEAM               ;�л�Ϊ[��ʾ�����]
            \CurrEvnetHook = #Event_EditArea_OnTop
         EndIf 
      EndIf 
      If \CurrEvnetHook <> #Event_FoldArea_OnTop And \PrevEvnetHook = #Event_FoldArea_OnTop
         IsRedraw = RichEdit_ParserFoldArea(*pRichEdit, \Cursor\RealRow)
      EndIf 
      If GetCursor_() <> hCursor            
         SetClassLong_(\hGadget, #GCL_HCURSOR, hCursor) 
      EndIf      
      If \PrevEvnetHook <> \CurrEvnetHook Or IsRedraw=#True
         \PrevEvnetHook = \CurrEvnetHook
;          RichEdit_RedrawGadget(*pRichEdit)
         KillTimer_(\hGadget,#Timer_Refresh_Flags)
         SetTimer_ (\hGadget,#Timer_Refresh_Flags, #Timer_Refresh_Timer, #Null)
      EndIf 
   EndWith 
EndProcedure


; <HOOK|�������>�¼�
Procedure RichEdit_GadgetHook_MouseLDown(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit          
      If \CurrEvnetHook & #Event_MouseLDown
         Result = #True
         Select \CurrEvnetHook 
            Case #Event_MarkArea_LDown       ;[�з���]<��ס�з�|ѡ���ı�> 
               CursorRow = (*pMouse\y-\Viewer\Y) / \Font\H + \Viewer\Row
               SelectElement(\ListEditLine(), CursorRow) 
               \Cursor\RealRow = \ListEditLine()\LineIndex
               If \Cursor\Row <> CursorRow : \Cursor\Row = CursorRow : IsRedraw = #True : EndIf 
               RichEdit_ParserFoldArea(*pRichEdit, \Cursor\RealRow)
            Case #Event_EditArea_LDown       ;[�༭��]<��ס�ƶ�|ѡ���ı�>
               IsRedraw = RichEdit_ParserEditArea(*pRichEdit, *pMouse)
               
            Case #Event_VScrollM_LDown       ;[�Ҳ������|��Ƭ����]<��ס�ƶ�>
               VanePos = \VScroll\RecordingPos + *pMouse\y - \VScroll\MouseDownPos
               VanePos = RichEdit_Limit(VanePos, 0, \VScroll\VaneLast*\VScroll\SetpScale)    ; ����[��Ƭ]�µľ���λ�� 
               ViewRow = RichEdit_Limit(VanePos/\VScroll\SetpScale, 0, \VScroll\VaneLast)    ; ����[��Ƭ]�µ���λ��
               If \Viewer\Row <> ViewRow : \Viewer\Row = ViewRow : IsRedraw = #True : EndIf ; ���[��Ƭ]λ�ò�ͬ,ˢ�½���
            Case #Event_HScrollM_LDown       ;[�ײ�������|��Ƭ����]<��ס�ƶ�>
               VanePos = \HScroll\RecordingPos + *pMouse\x - \HScroll\MouseDownPos
               VanePos = RichEdit_Limit(VanePos, 0, \HScroll\VaneLast * \HScroll\SetpScale)    ; ����[��Ƭ]�µľ���λ�� 
               ViewCol = RichEdit_Limit(VanePos/\HScroll\SetpScale, 0, \HScroll\VaneLast)    ; ����[��Ƭ]�µ���λ��
               If \Viewer\Col <> ViewCol : \Viewer\Col = ViewCol : IsRedraw = #True : EndIf ; ���[��Ƭ]λ�ò�ͬ,ˢ�½���
            Default
               Result = #False
         EndSelect 
         
      EndIf    
      If \PrevEvnetHook <> \CurrEvnetHook Or IsRedraw = #True
         \PrevEvnetHook = \CurrEvnetHook
;          RichEdit_RedrawGadget(*pRichEdit)
         KillTimer_(\hGadget,#Timer_Refresh_Flags)
         SetTimer_ (\hGadget,#Timer_Refresh_Flags, #Timer_Refresh_Timer, #Null)
      EndIf 
   EndWith 
   ProcedureReturn Result
EndProcedure

; <HOOK|�ƶ����>�¼�
Procedure RichEdit_GadgetHook_MouseMove(*pRichEdit.__RichEditInfo, *pMouse.Points, CompositeKey)
   If *pMouse = 0 : ProcedureReturn : EndIf 
   With *pRichEdit          
      Select CompositeKey
         Case 0 : RichEdit_GadgetHook_MouseOnTop(*pRichEdit, *pMouse) ; �������
         Case 1 : RichEdit_GadgetHook_MouseLDown(*pRichEdit, *pMouse) ; ����϶�
      EndSelect  
   EndWith 
EndProcedure

;- -----------------------
; [�Ҳ������]<HOOK|�������>�¼�
Procedure RichEdit_GadgetHook_LDownVScroll(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit   
      \CurrEvnetHook | #Event_MouseLDown
      Select \CurrEvnetHook
         Case #Event_VScrollM_LDown    ;[�Ҳ������|��Ƭ����]<��갴��>
            If \PrevEvnetHook <> #Event_VScrollM_LDown
               \VScroll\MouseDownPos = *pMouse\y         ; ��¼��갴�µ�λ��
               \VScroll\RecordingPos = \VScroll\VanePos  ; ��¼����ʱ[��Ƭ]��λ��
            EndIf 
         Case #Event_VScrollT_LDown    ;[�Ҳ������|�ϼʰ���]<��갴��>
            If \Viewer\Row > 0
               \Viewer\Row-1 : \DelayTime = #Timer_Scrolls_Timer
               SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
            EndIf  
         Case #Event_VScrollB_LDown    ;[�Ҳ������|�¼ʰ���]<��갴��>
            If \Viewer\Row < \VScroll\VaneLast
               \Viewer\Row+1 : \DelayTime = #Timer_Scrolls_Timer
               SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
            EndIf 
            
         Case #Event_VScrollW_LDown    ;[�Ҳ������|���ư���]<��갴��>
            If \Viewer\Row > 0
               LastPageLine = (*pMouse\y-20-\VScroll\VaneSize/2)/\VScroll\SetpScale
               \VScroll\PageLine = RichEdit_Limit(LastPageLine, 0, \VScroll\VaneLast) 
               \Viewer\Row-\Viewer\HoldRows : \DelayTime = #Timer_Scrolls_Timer
               If \Viewer\Row<\VScroll\PageLine 
                  \Viewer\Row=\VScroll\PageLine : \CurrEvnetHook = 0
               Else
                  SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
               EndIf
            EndIf  
         
         Case #Event_VScrollS_LDown    ;[�Ҳ������|���ư���]<��갴��>  
            If \Viewer\Row < \VScroll\VaneLast
               LastPageLine = (*pMouse\y-20-\VScroll\VaneSize/2)/\VScroll\SetpScale 
               \VScroll\PageLine = RichEdit_Limit(LastPageLine, 0, \VScroll\VaneLast) 
               \Viewer\Row+\Viewer\HoldRows : \DelayTime = #Timer_Scrolls_Timer
               If \Viewer\Row>\VScroll\PageLine                   
                  \Viewer\Row=\VScroll\PageLine : \CurrEvnetHook = 0
               Else
                  SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
               EndIf
            EndIf  
      EndSelect 
   EndWith 
EndProcedure

; [�ײ�������]<HOOK|�������>�¼�
Procedure RichEdit_GadgetHook_LDownHScroll(*pRichEdit.__RichEditInfo, *pMouse.Points)
  
   With *pRichEdit   
      \CurrEvnetHook | #Event_MouseLDown
      Select \CurrEvnetHook
         Case #Event_HScrollM_LDown    ;[�ײ�������|��Ƭ����]<��갴��>
            If \PrevEvnetHook <> #Event_HScrollM_LDown
               \HScroll\MouseDownPos = *pMouse\x
               \HScroll\RecordingPos = \HScroll\VanePos 
            EndIf 
         Case #Event_HScrollL_LDown    ;[�ײ�������|��ʰ���]<��갴��>
            If \Viewer\Col > 0
               \Viewer\Col-1 : \DelayTime = #Timer_Scrolls_Timer
               SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
            EndIf  
         Case #Event_HScrollR_LDown    ;[�ײ�������|�Ҽʰ���]<��갴��>
            If \Viewer\Col < \HScroll\VaneLast
               \Viewer\Col+1 : \DelayTime = #Timer_Scrolls_Timer
               SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
            ElseIf \Viewer\Col  < 1024 -\Viewer\HoldCols
               \AddLineWidth+\Font\W : \Viewer\Col+1 : \DelayTime = #Timer_Scrolls_Timer
               SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
            EndIf 
         Case #Event_HScrollA_LDown    ;[�ײ�������|���ư���]<��갴��>
            If \Viewer\Col > 0
               LastPageLine = (*pMouse\x-20-\HScroll\VaneSize/2)/\HScroll\SetpScale
               \HScroll\PageLine = RichEdit_Limit(LastPageLine, 0, \HScroll\VaneLast) 
               \Viewer\Col-20 : \DelayTime = #Timer_Scrolls_Timer
               If \Viewer\Col<\HScroll\PageLine 
                  \Viewer\Col=\HScroll\PageLine : \CurrEvnetHook = 0
               Else
                  SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
               EndIf
            EndIf  
         Case #Event_HScrollD_LDown    ;[�Ҳ������|���ư���]<��갴��>  
            If \Viewer\Col < \HScroll\VaneLast
               LastPageLine = (*pMouse\x-20-\HScroll\VaneSize/2)/\HScroll\SetpScale
               \HScroll\PageLine = RichEdit_Limit(LastPageLine, 0, \HScroll\VaneLast) 
               \Viewer\Col+20: \DelayTime = #Timer_Scrolls_Timer
               If \Viewer\Col>\HScroll\PageLine                   
                  \Viewer\Col=\HScroll\PageLine : \CurrEvnetHook = 0
               Else
                  SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
               EndIf
            EndIf  
      EndSelect 
   EndWith 
EndProcedure

; [�۵���]<HOOK|�������>�¼�
Procedure RichEdit_GadgetHook_LDownFoldBar(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit  
      \CurrEvnetHook | #Event_MouseLDown
      CursorY = (*pMouse\y-\Viewer\Y-1) / \Font\H + \Viewer\Row
      *pEditLine.__RichEdit_EditLine
      *pTextLine.__RichEdit_TextLine
      ; ���۵������д���
      *pEditLine = SelectElement(\ListEditLine(), CursorY)
      If *pEditLine <= 0 : ProcedureReturn : EndIf 
      *pTextLine = SelectElement(\ListTextLine(), *pEditLine\LineIndex)
      If *pTextLine <= 0 : ProcedureReturn : EndIf 
      FoldFloor = *pEditLine\pElement\FoldFloor
      ; �����[�۵��нڵ�]
      If *pEditLine\pElement\FoldState  & #FoldState_Start 
         ; ��[�۵��нڵ�]Ϊ�պ�״̬ʱ
         If *pEditLine\pElement\FoldState & #FoldState_Closed
            *pEditLine\pElement\FoldState & ~#FoldState_Closed
            LineIndex  = *pEditLine\LineIndex+1             ; ��ʼɨ���������
            *pEditLine = NextElement(\ListEditLine())       ; ������ָ��ָ����һ���༭��
            *pTextLine = NextElement(\ListTextLine())       ; ������ָ��ָ����һ���ı���
            LastIndex  = *pEditLine\LineIndex               ; ����ɨ���������
            While *pTextLine And LineIndex < LastIndex     ; ѭ��ɨ���ı���
               ;����ı��и�Ŀ���еĲ�һ��,���ɨ���ڵ���ʱ,FoldFloorҪ����,��ɨ��������ʱ,FoldFloorҪ�ݼ�
               ; ע��: �˴��߼���Щ����.
               If *pTextLine\FoldFloor = FoldFloor+1     
                  IsAddElement = #False
                  If *pTextLine\FoldState & #FoldState_Start And IsHideLine = #Null                                    ; ���
                     IsAddElement = #True : FoldFloor + 1                     ; FoldFloor����, �ڵ�ɨ���Ӳ�,����ӵ��༭��
                     IsHideLine = *pTextLine\FoldState & #FoldState_Closed    ; ����ڵ����Ǳպϵ�,������ӵ��༭��
                  ElseIf *pTextLine\FoldState & #FoldState_ToEnd
                     If IsHideLine = #Null : IsAddElement = #True : EndIf 
                     FoldFloor - 1 : IsHideLine = #Null                       ; FoldFloor�ݼ�, ���ظ���ɨ��
                  ElseIf IsHideLine = #Null : IsAddElement = #True           ; ������ڵ���չ����,����ӵ��༭��
                  EndIf 
                  If IsAddElement = #True                         
                     *pEditLine = InsertElement(\ListEditLine())  ; ����༭�� 
                     *pEditLine\LineIndex = LineIndex             ; ���ñ༭�ж�Ӧ���ı���������
                     *pEditLine\pElement  = *pTextLine            ; ָ���ı���Ԫ�ص�ָ��
                     *pTextLine\FoldState & ~#FoldState_IsHide
                     NextElement(\ListEditLine())                 ; ���������е���һ��
                  EndIf 
               EndIf 
               LineIndex+1
               *pTextLine = NextElement(\ListTextLine())          ; ��ת����һ���ı���
            Wend
            IsRedraw = #True
         ; ��[�۵��нڵ�]Ϊչ��״̬ʱ   
         Else 
            *pEditLine\pElement\FoldState | #FoldState_Closed
            *pEditLine = NextElement(\ListEditLine())
            While *pEditLine
               If *pEditLine\pElement\FoldFloor > FoldFloor       ; ����ı��еĲ������ڽڵ���,ȫ��ɾ��
                  *pEditLine\pElement\FoldState | #FoldState_IsHide
                  DeleteElement(\ListEditLine())
               ElseIf *pEditLine\pElement\FoldFloor <= FoldFloor  ; �۵���Χ����ʱ,�˳�ɾ���¼�
                  Break
               EndIf 
               *pEditLine = NextElement(\ListEditLine())          ; ��ת����һ���ı���
            Wend
            IsRedraw = #True
         EndIf 
      ; ������۵��������
      ElseIf *pEditLine\pElement\FoldState  & #FoldState_ToEnd
         *pEditLine = PreviousElement(\ListEditLine())            ; ��ת����һ���ı���        
         While *pEditLine 
            If *pEditLine\pElement\FoldFloor < FoldFloor
               ViewRow = ListIndex(\ListEditLine())
               If ViewRow > 0 : ViewRow - 1 : EndIf 
               If ViewRow < \Viewer\Row : \Viewer\Row = ViewRow : EndIf 
               Break
            EndIf 
            *pEditLine = PreviousElement(\ListEditLine())
         Wend 
         IsRedraw = #True
      EndIf 
      ; =======================                                   ;��ȡ������۵�������ʼ�ͽ���λ��
      *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row)
      CursorRow = \Cursor\Row
      ; �����ǰ�в�����,���ʾ�۵���,�������λ���Ѿ����ݵ��ı���֮��
      If *pEditLine = 0          
         *pEditLine = LastElement(\ListEditLine())
         CursorRow = ListIndex(\ListEditLine())
         While *pEditLine                                         ; �������������
            If \ListEditLine()\LineIndex = \Cursor\RealRow        ; ͨ�����������������,
               \Cursor\Row = CursorRow : Break                    ; �������л���ɹ����λ��
            ElseIf \ListEditLine()\LineIndex < \Cursor\RealRow    ; �������б��������۵�����,���������       
               Break
            EndIf  
            CursorRow-1 
            *pEditLine = PreviousElement(\ListEditLine())         ; ������һ��[�༭��]
         Wend 
         
      ; ����Ǳպ��۵��¼�
      ElseIf *pEditLine\LineIndex < \Cursor\RealRow
         While NextElement(\ListEditLine())                       ; ������һ��[�༭��]
            CursorRow+1              
            If \ListEditLine()\LineIndex = \Cursor\RealRow        ; ͨ�����������������,
               \Cursor\Row = CursorRow : Break                    ; �������л���ɹ����λ��
            ElseIf \ListEditLine()\LineIndex > \Cursor\RealRow    ; �������б��������۵�����,���������  
               Break
            EndIf  
         Wend
         
      ; �����չ���۵��¼�
      ElseIf *pEditLine\LineIndex > \Cursor\RealRow
         While PreviousElement(\ListEditLine())                   ; ������һ��[�༭��]
            CursorRow-1             
            If \ListEditLine()\LineIndex = \Cursor\RealRow        ; ͨ�����������������,
               \Cursor\Row = CursorRow : Break                    ; �������л���ɹ����λ��
            ElseIf \ListEditLine()\LineIndex < \Cursor\RealRow    ; �������б��������۵�����,���������  
               Break
            EndIf  
         Wend 
      EndIf
      SelectElement(\ListTextLine(), \Cursor\RealRow)                   ; ѡ�й�괦��[�ı���]
      \Cursor\IsInFold = \ListTextLine()\FoldState & #FoldState_IsHide  ; �����۵�״̬
   EndWith
   ProcedureReturn IsRedraw
EndProcedure

; [�༭��]<HOOK|�������>�¼� 
Procedure RichEdit_GadgetHook_LDownEditArea(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit 
      \CurrEvnetHook | #Event_MouseLDown  
;       If \EditState & #EditState_FoldVisible = 0 : ProcedureReturn : EndIf 
      *pViewChar.__RichEdit_ViewChar                  ; [������|�༭��]�ڴ���ַ�ָ��
      CurrRow = (*pMouse\y-\Viewer\Y) /\Font\H        ; ���㵱ǰ��괦�����λ��
      *pViewChar = \pMemViewChar+ CurrRow * #RichEdit_FullRowBytes
      CurrRow + \Viewer\Row                           ; ���õ�ǰ��괦�е�λ��
      \FlagsWord$ = #Null$                            ; ���ѡ�д�����
      *pElement = SelectElement(\ListEditLine(), CurrRow) ; ����[������]����Ԫ��

      If *pElement <= 0 : ProcedureReturn : EndIf 
      RealRow = \ListEditLine()\LineIndex             ; ��ȡ������λ��
      CurrCol = #RichEdit_MaxLineChars                ; Ĭ��Ϊ���е����һ���ַ�
      CurrCol = \ListEditLine()\pElement\CountChars   ; Ĭ��Ϊ���е����һ���ַ�
      For k = 0 To \ListEditLine()\pElement\CountChars-1
         If *pViewChar\X <= *pMouse\X And *pMouse\X < *pViewChar\X+*pViewChar\W 
            CurrCol = k : Break 
         ElseIf *pViewChar\X =0 And *pViewChar\W = 0 
             Break
         EndIf 
         *pViewChar+ #RichEdit_ViewCharSize
      Next  

      ; ���<����>�¼�����˫����ʱʱ���ڽ��е�ǰѡ�дʵĵ��,����Ϊѡ��ȫ��         
      If \Cursor\Row = CurrRow And \Record\Row = \Cursor\Row
         If \Record\Col = \Cursor\Col                 ; �����ı���λ�õ����,�����ػ����
            NoRedraw = #True
         ElseIf \Cursor\Col >= CurrCol And \Record\Col < CurrCol And \Cursor\IsLDChick = #True
            IsFullLine = #True : \Cursor\IsLDChick = #False
         ElseIf \Cursor\Col < CurrCol And \Record\Col >= CurrCol And \Cursor\IsLDChick = #True
            IsFullLine = #True : \Cursor\IsLDChick = #False            
         EndIf 
      EndIf  
      ;=======================
      If IsFullLine = #True                           ; ���<����|ѡ��ȫ��>ʱ,����ѡ����
         \Record\Col = 0            : \Cursor\Col = #RichEdit_MaxLineChars
         \Record\Row = CurrRow      : \Cursor\Row = CurrRow
         \Record\RealRow = RealRow  : \Cursor\RealRow = RealRow
         \Record\RealRow = RealRow  : \Cursor\RealRow = RealRow
      Else                                            ; ����<����>λ��
         \Record\Col = CurrCol      : \Cursor\Col = CurrCol
         \Record\Row = CurrRow      : \Cursor\Row = CurrRow
         \Record\RealRow = RealRow  : \Cursor\RealRow = RealRow
      EndIf 

      ; ���ֻ�Ǹı�������ʾ��,��ֻ����ʾ��λ��,����[�༭��]�����ػ�
      If NoRedraw = #True 
         RichEdit_RedrawSetCaret(*pRichEdit) : ProcedureReturn
      Else
         RichEdit_ParserFoldArea(*pRichEdit, RealRow) 
      EndIf  
      SelectElement(\ListTextLine(), \Cursor\RealRow)                   ; ѡ�й�괦��[�ı���]
      \Cursor\IsInFold = \ListTextLine()\FoldState & #FoldState_IsHide  ; �����۵�״̬
   EndWith
   ProcedureReturn IsRedraw
EndProcedure

; <HOOK|�������>�¼�
Procedure RichEdit_GadgetHook_LButtonDown(*pRichEdit.__RichEditInfo, *pMouse.Points)
   Shared  *pCurrRichEdit.__RichEditInfo
   Shared  *pPrevRichEdit.__RichEditInfo
   *pCurrRichEdit = *pRichEdit   ; ��<MouseHook>�¼����ݵ�ǰ�ؼ���Ϣ,ʵ��Խ���϶�
   If *pPrevRichEdit <> *pCurrRichEdit
      *pPrevRichEdit = *pCurrRichEdit : SetActiveGadget(*pRichEdit\GadgetID)
   EndIf 
   
   If *pMouse = 0 : ProcedureReturn : EndIf 
   With *pRichEdit          
      SetActiveGadget(\GadgetID)
      If \CurrEvnetHook & #Event_VScroll = #Event_VScroll
         IsRedraw = RichEdit_GadgetHook_LDownVScroll(*pRichEdit, *pMouse) ; [�Ҳ������]<HOOK|�������>�¼�
      ElseIf \CurrEvnetHook & #Event_HScroll = #Event_HScroll 
         IsRedraw = RichEdit_GadgetHook_LDownHScroll(*pRichEdit, *pMouse) ; [�ײ�������]<HOOK|�������>�¼�         
      ElseIf \CurrEvnetHook & #Event_FoldArea = #Event_FoldArea    
         IsRedraw = RichEdit_GadgetHook_LDownFoldBar(*pRichEdit, *pMouse) ; [�۵���]<HOOK|�������>�¼�
      ElseIf \CurrEvnetHook & #Event_EditArea = #Event_EditArea
         IsRedraw = RichEdit_GadgetHook_LDownEditArea(*pRichEdit, *pMouse); [�༭��]<HOOK|�������>�¼�     
      ElseIf \CurrEvnetHook & #Event_MarkArea = #Event_MarkArea         
         \CurrEvnetHook | #Event_MouseLDown
         CurrRow = (*pMouse\y-\Viewer\Y) / \Font\H + \Viewer\Row
         *pElement = SelectElement(\ListEditLine(), CurrRow)
         If *pElement <= 0 : ProcedureReturn : EndIf 
         RealRow   = \ListEditLine()\LineIndex
         \Record\Col = 0            : \Cursor\Col = #RichEdit_MaxLineChars
         \Record\Row = CurrRow      : \Cursor\Row = CurrRow
         \Record\RealRow = RealRow  : \Cursor\RealRow = RealRow
         SelectElement(\ListTextLine(), \Cursor\RealRow)                   ; ѡ�й�괦��[�ı���]
         \Cursor\IsInFold = \ListTextLine()\FoldState & #FoldState_IsHide  ; �����۵�״̬
         RichEdit_ParserFoldArea(*pRichEdit, \Cursor\RealRow)
      EndIf 
      If \PrevEvnetHook <> \CurrEvnetHook Or IsRedraw = #True
         \PrevEvnetHook = \CurrEvnetHook : RichEdit_RedrawGadget(*pRichEdit)
      EndIf   
   EndWith 
EndProcedure

;- -----------------------
; <HOOK|˫�����>�¼�[�༭��]
Procedure RichEdit_GadgetHook_LBDChick_EditArea(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit  
      \CurrEvnetHook | #Event_MouseLDown 
      ; ����˫��ѡ���¼�
      *pViewChar.__RichEdit_ViewChar            ; [������|�༭��]�ڴ���ַ�ָ��
      *pEditLine.__RichEdit_EditLine            ; [������|������]�ڴ����ָ��    
      RecordCol  = \Cursor\Col                  ; ��¼��ǰ������,���ڱȽ��õ�
      *pViewLine = \pMemViewChar+ (\Cursor\Row-\Viewer\Row) * #RichEdit_FullRowBytes
      *pViewChar = *pViewLine + RecordCol * #RichEdit_ViewCharSize
      CharSymbol = *pViewChar\CharSymbol        ; ��ȡ��ǰ��괦���ַ���ʶ
     
      ; ������ı����ʶ,��ѡ��ȫ��Ϊ�ı����ʶ���ַ�
      If CharSymbol & #Symbol_String            
         For Col = \Cursor\Col To 0 Step -1    ; ����ɨ��Ϊ�ı����ʶ���ַ�
            If *pViewChar\CharSymbol & #Symbol_String 
               \Record\Col = Col
            ElseIf *pViewChar\CharSymbol & #Symbol_String = 0 
               Break 
            EndIf 
            *pViewChar-#RichEdit_ViewCharSize   ; ���󲽽��ַ�ָ��
         Next 
         *pViewChar = *pViewLine + RecordCol * #RichEdit_ViewCharSize
         *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row)
         For Col = \Cursor\Col To *pEditLine\pElement\CountChars-1   ; ����ɨ��Ϊ�ı����ʶ���ַ� 
            If *pViewChar\CharSymbol & #Symbol_String 
               \Cursor\Col = Col+1    
            ElseIf *pViewChar\CharSymbol & #Symbol_String = 0
               Break 
            EndIf 
            *pViewChar+#RichEdit_ViewCharSize   ; ���Ҳ����ַ�ָ��
         Next 
         \FlagsWord$ = Mid(*pEditLine\pElement\LineText$, \Record\Col+1, \Cursor\Col-\Record\Col)
      
      ; ����Ƿ��ı����ʶ,��ѡ��ͬһ���ʶ���ַ�
      Else 
         For Col = \Cursor\Col To 0 Step -1    ; ����ɨ���ַ�
            If *pViewChar\CharSymbol = CharSymbol
               \Record\Col = Col
            ElseIf *pViewChar\CharSymbol <> CharSymbol
               Break 
            EndIf 
            *pViewChar-#RichEdit_ViewCharSize   ; ���󲽽��ַ�ָ��
         Next 
         *pViewChar = *pViewLine + RecordCol * #RichEdit_ViewCharSize
         *pEditLine.__RichEdit_EditLine
         *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row)
         For Col = \Cursor\Col To *pEditLine\pElement\CountChars-1   ; ����ɨ���ַ�
            If *pViewChar\CharSymbol = CharSymbol
               \Cursor\Col = Col+1    
            ElseIf *pViewChar\CharSymbol <> CharSymbol
               Break 
            EndIf 
            *pViewChar+#RichEdit_ViewCharSize   ; ���Ҳ����ַ�ָ��
         Next 
         \FlagsWord$ = #Null$
      EndIf 
      ; ��ȡ��������λ�ü���˫����ʱ����,
      ; ˫����ʱ����Ч��: ˫��ʱ,ѡ��,�������#Timer_LDChick_Timerʱ����,�ٵ���,��ѡ��ȫ���ı�
      If RecordCol <> \Cursor\Col
         \Cursor\IsLDChick = #True                 ; ˫��ѡ����ʱ����
         SetTimer_(\hGadget,#Timer_LDChick_Flags, #Timer_LDChick_Timer, #Null)
      EndIf
      RichEdit_RedrawGadget(*pRichEdit)
   EndWith 
EndProcedure

; <HOOK|˫�����>�¼�
Procedure RichEdit_GadgetHook_LButtonDChick(*pRichEdit.__RichEditInfo, *pMouse.Points)
   If *pMouse = 0 : ProcedureReturn : EndIf 
   With *pRichEdit          
      If \CurrEvnetHook & #Event_MarkArea = #Event_MarkArea          ; <HOOK|˫�����>�¼�[�з���] 
         \CurrEvnetHook | #Event_MouseLDown
         \Record\Row = 0 : \Cursor\Row = ListSize(\ListEditLine())-1
         \Record\Col = 0 : \Cursor\Col = #RichEdit_MaxLineChars
         RichEdit_RedrawGadget(*pRichEdit)
      ElseIf \CurrEvnetHook & #Event_EditArea = #Event_EditArea      ; <HOOK|˫�����>�¼�[�༭��]
         RichEdit_GadgetHook_LBDChick_EditArea(*pRichEdit, *pMouse)
      EndIf 
   EndWith 
EndProcedure

;- =======================
; <HOOK|����ͷ�>�¼�
Procedure RichEdit_GadgetHook_LButtonUp(*pRichEdit.__RichEditInfo, *pMouse.Points)
   If *pMouse = 0 : ProcedureReturn : EndIf 
   With *pRichEdit     
      \CurrEvnetHook & ~#Event_MouseLDown 
      If \PrevEvnetHook <> \CurrEvnetHook
         \PrevEvnetHook = \CurrEvnetHook
         KillTimer_(\hGadget,#Timer_Scrolls_Flags)
         RichEdit_RedrawGadget(*pRichEdit)
      EndIf 
   EndWith 
EndProcedure

; <Callback|�ƶ�����>�¼�
Procedure RichEdit_GadgetHook_MouseWHeel(*pRichEdit.__RichEditInfo, wParam)
   With *pRichEdit
      x.w = ((wParam>>16)&$FFFF) : Event = -(x/120)  
      If wParam & $FFFF = 8      ; ��������
         If Event < 0 And \Font\Size < 120
            \Font\Size  + 3 : IsRedraw = #True : RichEdit_SetGadgetFont(*pRichEdit)         
         ElseIf Event > 0 And \Font\Size  > 3 
            \Font\Size  - 3 : IsRedraw = #True : RichEdit_SetGadgetFont(*pRichEdit)
         EndIf 
      ElseIf wParam & $FFFF = 0  ; ����ҳ��
         If Event < 0 And \Viewer\Row > 0 : \Viewer\Row - 3 : IsRedraw = #True
         ElseIf Event > 0 And \Viewer\Row < \VScroll\VaneLast : \Viewer\Row + 3 : IsRedraw = #True
         EndIf
      EndIf
      If IsRedraw = #True : RichEdit_RedrawGadget(*pRichEdit) : EndIf 
   EndWith 
EndProcedure

; <HOOK|��ʱ��>�¼�
Procedure RichEdit_GadgetHook_Timer(*pRichEdit.__RichEditInfo, Flags)
   With *pRichEdit
      Select Flags
         Case #Timer_Refresh_Flags
            KillTimer_(\hGadget, #Timer_Refresh_Flags)
            RichEdit_RedrawGadget(*pRichEdit) 
            
         Case #Timer_LDChick_Flags
            \Cursor\IsLDChick = #False
            KillTimer_(\hGadget, #Timer_LDChick_Timer)
            
         Case #Timer_AddItem_Flags
            KillTimer_(\hGadget,#Timer_AddItem_Flags)
            RichEdit_ParserEditChar(*pRichEdit, 0)
            RichEdit_RedrawGadget  (*pRichEdit)
            
            
         Case #Timer_Scrolls_Flags
       
            Select \CurrEvnetHook
               Case #Event_VScrollT_LDown    ;[�Ҳ������|�ϼʰ���]<��갴��>
                  If \Viewer\Row> 0 : \Viewer\Row-5 : Else : \CurrEvnetHook=0 : EndIf 
               Case #Event_VScrollB_LDown    ;[�²������|�ϼʰ���]<��갴��>
                  If \Viewer\Row < \VScroll\VaneLast : \Viewer\Row+5 : Else : \CurrEvnetHook=0 : EndIf 
                Case #Event_VScrollW_LDown   ;[�Ҳ������|���ư���]<��갴��>
                  If \Viewer\Row>\VScroll\PageLine : \Viewer\Row-\Viewer\HoldRows : Else : \CurrEvnetHook=0 : EndIf 
                  If \Viewer\Row<\VScroll\PageLine : \Viewer\Row=\VScroll\PageLine : EndIf 
               Case #Event_VScrollS_LDown    ;[�Ҳ������|���ư���]<��갴��> 
                  If \Viewer\Row<\VScroll\PageLine : \Viewer\Row+\Viewer\HoldRows : Else : \CurrEvnetHook=0 : EndIf 
                  If \Viewer\Row>\VScroll\PageLine : \Viewer\Row=\VScroll\PageLine : EndIf
               ;========== ========== ========== ========== ========== ==========  
               Case #Event_HScrollL_LDown    ;[�ײ�������|��ʰ���]<��갴��>
                  If \Viewer\Col> 0 : \Viewer\Col-5 : Else : \CurrEvnetHook=0 : EndIf 
               Case #Event_HScrollR_LDown    ;[�ײ�������|�Ҽʰ���]<��갴��>
                  If \Viewer\Col < \HScroll\VaneLast : \Viewer\Col+5 
                  ElseIf \AddLineWidth = 0 : \CurrEvnetHook=0 
                  Else : \AddLineWidth+\Font\W*5 : \Viewer\Col+5
                  EndIf 
               Case #Event_HScrollA_LDown    ;[�ײ�������|���ư���]<��갴��>
                  If \Viewer\Col>\HScroll\PageLine : \Viewer\Col-20 : Else : \CurrEvnetHook=0 : EndIf 
                  If \Viewer\Col<\HScroll\PageLine : \Viewer\Col=\HScroll\PageLine : EndIf 
               Case #Event_HScrollD_LDown    ;[�ײ�������|���ư���]<��갴��>
                  If \Viewer\Col<\HScroll\PageLine : \Viewer\Col+20 : Else : \CurrEvnetHook=0 : EndIf 
                  If \Viewer\Col>\HScroll\PageLine : \Viewer\Col=\HScroll\PageLine : EndIf
               Default 
                  KillTimer_(\hGadget,#Timer_Scrolls_Flags)
                  ProcedureReturn
            EndSelect 
            If \DelayTime = #Timer_Scrolls_Timer
               \DelayTime = #Timer_Scrolls_Timer/10
               KillTimer_(\hGadget,#Timer_Scrolls_Flags)
               SetTimer_ (\hGadget,#Timer_Scrolls_Flags, \DelayTime, #Null)
            EndIf 
            RichEdit_RedrawGadget(*pRichEdit)
      EndSelect
   EndWith 
EndProcedure

; ���ؼ���ȡ����ʱ
Procedure RichEdit_GadgetHook_SetFocus(*pRichEdit.__RichEditInfo)
   ;����[�ı���������]
   DestroyCaret_()  
   *pRichEdit\EditState & ~#EditState_CaretVisible
   CreateCaret_(*pRichEdit\hGadget, #Null, 1, *pRichEdit\Font\H);
   RichEdit_RedrawGadget(*pRichEdit)
EndProcedure

; <GadgetHook>�¼�
Procedure RichEdit_GadgetHook(hGadget, uMsg, wParam, lParam) 
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit ;And GetFocus_() = *pRichEdit\hGadget 
      With *pRichEdit
         Select uMsg 
            Case #WM_SETFOCUS       : RichEdit_GadgetHook_SetFocus(*pRichEdit)
            Case #WM_KILLFOCUS 
;             Case #WM_ACTIVATE       : HideCaret_(\hGadget) : \EditState & ~#EditState_CaretVisible
            Case #WM_CHAR           : ;���汾û�����빦��
            Case #WM_KEYDOWN        : RichEdit_GadgetHook_KeyDown       (*pRichEdit, wParam)
            Case #WM_TIMER          : RichEdit_GadgetHook_Timer         (*pRichEdit, wParam) 
            Case #WM_MOUSEMOVE      : RichEdit_GadgetHook_MouseMove     (*pRichEdit, @lParam, wParam) 
            Case #WM_LBUTTONDOWN    : RichEdit_GadgetHook_LButtonDown   (*pRichEdit, @lParam) 
            Case #WM_LBUTTONUP      : RichEdit_GadgetHook_LButtonUp     (*pRichEdit, @lParam)
            Case #WM_LBUTTONDBLCLK  : RichEdit_GadgetHook_LButtonDChick (*pRichEdit, @lParam)
            Case #WM_MOUSEWHEEL     : RichEdit_GadgetHook_MouseWHeel    (*pRichEdit, wParam) 
            Case #WM_DESTROY        : RichEdit_FreeGadget               (*pRichEdit, hGadget)
            Default
         EndSelect 
      EndWith
   EndIf 
   hGadgetHook = GetWindowLong_(hGadget,#GWL_USERDATA) 
   If hGadgetHook       ; ʹ��CallWindowProc_()��,ĳЩuMsg�������Ч,�����Ϊʲô.
      ProcedureReturn CallWindowProc_(hGadgetHook, hGadget, uMsg, wParam, lParam) 
   Else 
      ProcedureReturn DefWindowProc_(hGadget, uMsg, wParam, lParam) 
   EndIf 
EndProcedure 

;- ***********************
; <HOOK|�������>�¼�
Procedure RichEdit_MouseHook_LDown(*pRichEdit.__RichEditInfo, nCode, wParam, *pMouse.MOUSEHOOKSTRUCT)
   GetWindowRect_(*pRichEdit\hGadget, @Area.RECT) 
   EditMouse.Points 
   VBool = Bool(*pMouse\pt\x >= Area\left And *pMouse\pt\x <= Area\right)
   HBool = Bool(*pMouse\pt\y >= Area\top  And *pMouse\pt\y <= Area\bottom)
   If VBool And HBool : ProcedureReturn 0 : EndIf 
   
   EditMouse\x = *pMouse\pt\x - Area\left
   EditMouse\y = *pMouse\pt\y - Area\top 
   If RichEdit_GadgetHook_MouseLDown(*pRichEdit, @EditMouse) = #False
      If *pRichEdit\CurrEvnetHook
         EditMouse\x = *pMouse\pt\x - Area\left
         EditMouse\y = *pMouse\pt\y - Area\top 
         *pRichEdit\CurrEvnetHook = 0
         *pRichEdit\PrevEvnetHook = 0
         RichEdit_RedrawGadget(*pRichEdit)
      EndIf 
      *pCurrRichEdit = 0
   Else 
      Result = CallNextHookEx_(0, nCode, wParam, *pMouse) 
   EndIf 
   ProcedureReturn Result
EndProcedure

; <HOOK|����ͷ�>�¼�
Procedure RichEdit_MouseHook_LToUp(*pRichEdit.__RichEditInfo, nCode, wParam, *pMouse.MOUSEHOOKSTRUCT)
   Shared  *pCurrRichEdit.__RichEditInfo
   GetWindowRect_(*pRichEdit\hGadget, @Area.RECT) 
   EditMouse.Points 
   VBool = Bool(*pMouse\pt\x >= Area\left And *pMouse\pt\x <= Area\right)
   HBool = Bool(*pMouse\pt\y >= Area\top  And *pMouse\pt\y <= Area\bottom)
   If VBool And HBool : ProcedureReturn 0 : EndIf 
   EditMouse\x = *pMouse\pt\x - Area\left
   EditMouse\y = *pMouse\pt\y - Area\top 
   *pRichEdit\CurrEvnetHook = 0
   *pRichEdit\PrevEvnetHook = 0
   RichEdit_RedrawGadget(*pRichEdit)
   *pCurrRichEdit = 0
EndProcedure

; <MouseHook>�¼�
Procedure RichEdit_MouseHook(nCode, wParam, *pMouse.MOUSEHOOKSTRUCT) 
   Shared  *pCurrRichEdit.__RichEditInfo
   Shared  *pPrevRichEdit.__RichEditInfo
   Debug "*pCurrRichEdit = " + *pCurrRichEdit
   If *pCurrRichEdit
      If GetFocus_() = *pCurrRichEdit\hGadget 
         Select wParam
            Case #WM_MOUSEMOVE      : Result = RichEdit_MouseHook_LDown(*pCurrRichEdit, nCode, wParam, *pMouse)
            Case #WM_LBUTTONDBLCLK  : SetActiveGadget(*pCurrRichEdit\GadgetID)
;             Case #WM_LBUTTONDOWN    : RichEdit_GadgetHook_LButtonDown(*pCurrRichEdit, *pMouse)
            Case #WM_LBUTTONUP      : Result = RichEdit_MouseHook_LToUp(*pCurrRichEdit, nCode, wParam, *pMouse)
            Case #WM_MOUSEWHEEL     : 
         EndSelect
      EndIf  
   ElseIf *pPrevRichEdit 
      HideCaret_(*pPrevRichEdit\hGadget) : *pPrevRichEdit\EditState & ~#EditState_CaretVisible     
   EndIf       
   ProcedureReturn Result 
EndProcedure 

;- ***********************
; �����ı��ļ����ؼ�
Procedure RichEdit_LoadFile(*pRichEdit.__RichEditInfo, FileID, Flags)
   With *pRichEdit
      ; ���[�ı���]������ڴ�
      ForEach \ListTextLine() : FreeMemory(\ListTextLine()\pMemEditChar) : Next 
      ClearList(\ListTextLine())    ;���[�ı���]����
      ClearList(\ListEditLine())    ;���[�༭��]����
      ;��λ���/ѡ��/[������]
      \Viewer\Row=0 : \Cursor\Row=0 : \Record\Row=0 : \Cursor\RealRow=0 : \Record\RealRow=0 
      \Viewer\Col=0 : \Cursor\Col=0 : \Record\Col=0 : \Cursor\RealCol=0 : \Record\RealCol=0 
      ; ��ʼ�����ı���
      While Eof(FileID) = 0     
         LineText$ = ReadString(FileID, Flags) 
         If Left(LineText$, 25) = "; IDE Options = PureBasic"
            Break
         EndIf 
         *pElement = AddElement(\ListTextLine())

         ; ����[�ı���]�ַ���Ϣ�ڴ��,��16�ֽ����¶���,�������ΪԤ���ռ�
         MemorySize = (Len(LineText$)/16*16+16) *  #RichEdit_EditCharSize
         LineWidth  = StringByteLength(LineText$, #PB_Ascii) * \Font\W
         \ListTextLine()\LineText$    = LineText$
         \ListTextLine()\CountChars   = Len(LineText$) 
         \ListTextLine()\LineWidth    = LineWidth                 
         \ListTextLine()\pMemEditChar = AllocateMemory(MemorySize) 

         AddElement(\ListEditLine())            ; ���[�༭��]
         \ListEditLine()\pElement  = *pElement
         \ListEditLine()\LineIndex = LineIndex
         LineIndex + 1
      Wend
      CloseFile(FileID)
      \EditState & ~ #EditState_EmptyText       ; ���ÿؼ�Ϊ�ǿ��ı�״̬      
      ; ������ص��ļ�Ϊ��.����λ�ı���
      Result = ListSize(\ListTextLine())        ; ����ֵ
      If Result = 0
         \pMaxTextLine = AddElement(\ListTextLine())
         \ListTextLine()\pMemEditChar = AllocateMemory($10) 
         AddElement(\ListEditLine()) 
         \ListEditLine()\LineIndex = 0
         \ListEditLine()\pElement  = \pMaxTextLine
         \EditState | #EditState_EmptyText
      EndIf 
      RichEdit_ParserEditChar(*pRichEdit)
      RichEdit_RedrawGadget  (*pRichEdit)
   EndWith
   ProcedureReturn Result
EndProcedure

;- =======================
; <�����ؼ���С>
Procedure RichEdit_Event_ResizeGadget(GadgetID, X, Y, Width, Height)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      RichEdit_ResizeGadget(*pRichEdit, X, Y, Width, Height)
   EndIf 
EndProcedure

; <ע���ؼ�>
Procedure RichEdit_Event_FreeGadget(GadgetID)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   RichEdit_FreeGadget(*pRichEdit, hGadget)
EndProcedure

; <��տؼ��ı�>
Procedure RichEdit_Event_ClearGadgetItems(GadgetID)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   With *pRichEdit
      If *pRichEdit
         ; ���[�ı���]������ڴ�
         ForEach \ListTextLine() : FreeMemory(\ListTextLine()\pMemEditChar) : Next 
         ClearList(\ListTextLine())    ;���[�ı���]����
         ClearList(\ListEditLine())    ;���[�༭��]����
         ;��λ���/ѡ��/[������]
         \Viewer\Row=0 : \Cursor\Row=0 : \Record\Row=0 : \Cursor\RealRow=0 : \Record\RealRow=0 
         \Viewer\Col=0 : \Cursor\Col=0 : \Record\Col=0 : \Cursor\RealCol=0 : \Record\RealCol=0 
         \Fold\StartRow = 0
         \Fold\ToEndRow = 0
         \Fold\Floor    = 0
         ; ��ʼ��
         \pMaxTextLine = AddElement(\ListTextLine())
         \ListTextLine()\pMemEditChar = AllocateMemory($10) 
         AddElement(\ListEditLine()) 
         \ListEditLine()\LineIndex = 0
         \ListEditLine()\pElement  = \pMaxTextLine
         \EditState = #EditState_EmptyText
         RichEdit_ParserEditChar(*pRichEdit)
         RichEdit_RedrawGadget  (*pRichEdit)
      EndIf 
      ProcedureReturn #True
   EndWith 
EndProcedure

; <��ȡ�ؼ��ı�����>
Procedure RichEdit_Event_CountGadgetItems(GadgetID)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      Result = ListSize(*pRichEdit\ListTextLine())
   EndIf 
   ProcedureReturn Result
EndProcedure

; <����ؼ��ı���>
Procedure RichEdit_Event_AddGadgetItem(GadgetID, Index, LineText$,  ImageID=0, Flags=0)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      With *pRichEdit
         CountList = ListSize(\ListTextLine())
         If \EditState & #EditState_EmptyText
            \EditState & ~#EditState_EmptyText
            *pElement = FirstElement(\ListTextLine())
            \ListTextLine()\LineText$  = LineText$
            \ListTextLine()\CountChars = Len(LineText$)
            ; ����[�ı���]�ַ���Ϣ�ڴ��,��16�ֽ����¶���,�������ΪԤ���ռ�
            MemorySize = (Len(LineText$)/16*16+16) *  #RichEdit_EditCharSize
            LineWidth  = StringByteLength(LineText$, #PB_Ascii) * \Font\W
            \ListTextLine()\pMemEditChar = AllocateMemory(MemorySize) 
            \ListTextLine()\LineWidth    = LineWidth
            KillTimer_(\hGadget,#Timer_AddItem_Flags)  
            SetTimer_ (\hGadget,#Timer_AddItem_Flags, #Timer_AddItem_Timer, #Null)

         ElseIf Index = -1 Or Index >= CountList
            *pElement = LastElement(\ListTextLine())
            *pElement = AddElement(\ListTextLine())
            \ListTextLine()\LineText$  = LineText$
            \ListTextLine()\CountChars = Len(LineText$)
            ; ����[�ı���]�ַ���Ϣ�ڴ��,��16�ֽ����¶���,�������ΪԤ���ռ�
            MemorySize = (Len(LineText$)/16*16+16) *  #RichEdit_EditCharSize
            LineWidth  = StringByteLength(LineText$, #PB_Ascii) * \Font\W
            \ListTextLine()\pMemEditChar = AllocateMemory(MemorySize) 
            \ListTextLine()\LineWidth    = LineWidth
            LastElement(\ListEditLine())           ; ���[�༭��]
            AddElement(\ListEditLine())            ; ���[�༭��]
            \ListEditLine()\pElement  = *pElement
            \ListEditLine()\LineIndex = ListIndex(\ListTextLine())
            ClearList(\ListEditLine())
            ForEach  \ListTextLine()
               AddElement(\ListEditLine())            ; ���[�༭��]
               \ListEditLine()\pElement  = @\ListTextLine()
               \ListEditLine()\LineIndex = ListIndex(\ListTextLine())            
            Next 
            KillTimer_(\hGadget,#Timer_AddItem_Flags)  
            SetTimer_ (\hGadget,#Timer_AddItem_Flags, #Timer_AddItem_Timer, #Null)
   
         ElseIf Index >= 0 And Index < CountList
            SelectElement(\ListTextLine(), Index)
            *pElement = InsertElement(\ListTextLine())
            \ListTextLine()\LineText$  = LineText$
            \ListTextLine()\CountChars = Len(LineText$)
            ; ����[�ı���]�ַ���Ϣ�ڴ��,��16�ֽ����¶���,�������ΪԤ���ռ�
            MemorySize = (Len(LineText$)/16*16+16) *  #RichEdit_EditCharSize
            LineWidth  = StringByteLength(LineText$, #PB_Ascii) * \Font\W
            \ListTextLine()\pMemEditChar = AllocateMemory(MemorySize) 
            \ListTextLine()\LineWidth    = LineWidth
            If \pMaxTextLine And \pMaxTextLine\LineWidth < LineWidth
               \pMaxTextLine = *pElement              ; ���������ı���
            EndIf
            ClearList(\ListEditLine())
            ForEach  \ListTextLine()
               AddElement(\ListEditLine())            ; ���[�༭��]
               \ListEditLine()\pElement  = @\ListTextLine()
               \ListEditLine()\LineIndex = ListIndex(\ListTextLine())            
            Next 
            KillTimer_(\hGadget,#Timer_AddItem_Flags)  
            SetTimer_ (\hGadget,#Timer_AddItem_Flags, #Timer_AddItem_Timer, #Null)
         EndIf 
      EndWith
   EndIf 
   ProcedureReturn *pElement
EndProcedure

; <ɾ���ؼ��ı���>
Procedure RichEdit_Event_RemoveGadgetItem(GadgetID, Index)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      With *pRichEdit
         CountList = ListSize(\ListTextLine())
         If \EditState & #EditState_EmptyText

         ElseIf CountList = 1
            \EditState | #EditState_EmptyText
            FillMemory(\ListTextLine()\pMemEditChar, \ListTextLine()\CountChars+1)
            \ListTextLine()\CountChars = 0
            \ListTextLine()\LineWidth  = 0
            \ListTextLine()\FoldFloor  = 0
            \ListTextLine()\FoldState  = 0
            \ListTextLine()\ItemData   = 0
            \ListTextLine()\LineText$  = #Null$
            
         ElseIf Index >= 0 And Index < CountList
            *pElement = SelectElement(\ListTextLine(), Index)
            FreeMemory(\ListTextLine()\pMemEditChar)
            DeleteElement(\ListTextLine())
            ClearList(\ListEditLine())
            ForEach  \ListTextLine()
               AddElement(\ListEditLine())            ; ���[�༭��]
               \ListEditLine()\pElement  = @\ListTextLine()
               \ListEditLine()\LineIndex = ListIndex(\ListTextLine())            
            Next 
            KillTimer_(hGadget,#Timer_AddItem_Flags)  
            SetTimer_ (hGadget,#Timer_AddItem_Flags, #Timer_AddItem_Timer, #Null)
         EndIf 
      EndWith
   EndIf 
   ProcedureReturn *pElement
EndProcedure

; <���ÿؼ��ı�����>
Procedure RichEdit_Event_SetGadgetText(GadgetID, Text$)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      With *pRichEdit
         FullText$ = ReplaceString(Text$, Chr(10), "")
         LineCount = CountString(FullText$, Chr(13))
         ; ���[�ı���]������ڴ�
         ForEach \ListTextLine() : FreeMemory(\ListTextLine()\pMemEditChar) : Next 
         ClearList(\ListTextLine())    ;���[�ı���]����
         ClearList(\ListEditLine())    ;���[�༭��]����
         ;��λ���/ѡ��/[������]
         \Viewer\Row=0 : \Cursor\Row=0 : \Record\Row=0 : \Cursor\RealRow=0 : \Record\RealRow=0 
         \Viewer\Col=0 : \Cursor\Col=0 : \Record\Col=0 : \Cursor\RealCol=0 : \Record\RealCol=0 
         
         For LineIndex = 1 To LineCount 
            *pElement = AddElement(\ListTextLine())
            LineText$  = StringField(FullText$, LineIndex, Chr(13))
            MemorySize = (Len(LineText$)/16*16+16) *  #RichEdit_EditCharSize
            LineWidth  = StringByteLength(LineText$, #PB_Ascii) * \Font\W
            \ListTextLine()\LineText$    = LineText$            
            \ListTextLine()\CountChars   = Len(LineText$)
            \ListTextLine()\LineWidth    = LineWidth
            \ListTextLine()\pMemEditChar = AllocateMemory(MemorySize)
            AddElement(\ListEditLine())            ; ���[�༭��]
            \ListEditLine()\pElement  = *pElement
            \ListEditLine()\LineIndex = LineIndex-1
         Next 
         \EditState & ~ #EditState_EmptyText       ; ���ÿؼ�Ϊ�ǿ��ı�״̬      
         ; ������ص��ļ�Ϊ��.����λ�ı���
         Result = ListSize(\ListTextLine())        ; ����ֵ
         If Result = 0
            \pMaxTextLine = AddElement(\ListTextLine())
            \ListTextLine()\pMemEditChar = AllocateMemory($10) 
            AddElement(\ListEditLine()) 
            \ListEditLine()\LineIndex = 0
            \ListEditLine()\pElement  = \pMaxTextLine
            \EditState | #EditState_EmptyText
         EndIf 
         RichEdit_ParserEditChar(*pRichEdit)
         RichEdit_RedrawGadget  (*pRichEdit)
      EndWith
   EndIf 
   ProcedureReturn Result
EndProcedure

; <��ȡ�ؼ��ı�����>
Procedure RichEdit_Event_GetGadgetText(GadgetID, PreviousStringPosition)

   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      Text$ = ""
      ForEach *pRichEdit\ListTextLine()
         Text$ + *pRichEdit\ListTextLine()\LineText$ + #CRLF$
      Next 
   EndIf 
   StringLength = StringByteLength(Text$)
   *pOutput = SYS_GetOutputBuffer(StringLength, PreviousStringPosition)
   CopyMemory(@Text$, *pOutput, StringLength)
   PokeC(*pOutput + StringLength, 0)
   ProcedureReturn
EndProcedure

; <���ÿؼ���ǰ������> 
Procedure RichEdit_Event_SetGadgetState(GadgetID, State)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      With *pRichEdit
         ForEach \ListEditLine()
            If \ListEditLine()\LineIndex = State
               \Cursor\Row = Index
               \Record\Row = Index
               Result = Index : Break :
            ElseIf \ListEditLine()\LineIndex > State
               Break
            EndIf  
            Index + 1
         Next 
         SelectElement(\ListTextLine(), State) 
         \Cursor\RealCol = 0
         \Cursor\RealRow = State
         \Record\RealCol = 0
         \Record\RealRow = State
      EndWith
      RichEdit_RedrawGadget(*pRichEdit)
   EndIf 
   ProcedureReturn Result
EndProcedure

; <��ȡ�ؼ���ǰ������λ��> 
Procedure RichEdit_Event_GetGadgetState(GadgetID)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit : Result = *pRichEdit\Cursor\RealRow : EndIf 
   ProcedureReturn Result
EndProcedure

; <���ÿؼ�����>
Procedure RichEdit_Event_SetGadgetFont(GadgetID, hFont)
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit  ;���ÿؼ���ʽ
      GetObject_(hFont, SizeOf(LOGFONT), @FontInfo.LOGFONT)
      *pRichEdit\Font\hFont = hFont      
      *pRichEdit\Font\Name$ = PeekS(@FontInfo\lfFaceName)        ;��ȡĬ�����������
      *pRichEdit\Font\Size  = (-FontInfo\lfHeight*3+0.3)/4       ;��������Ĭ�ϸ߶�,��������Ĵ�С
      RichEdit_SetGadgetFont(*pRichEdit)
      RichEdit_RedrawGadget (*pRichEdit)
   EndIf 
   ProcedureReturn @*pRichEdit\Font
EndProcedure

; <��ȡ�ؼ�����>
Procedure RichEdit_Event_GetGadgetFont(GadgetID)
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      ProcedureReturn *pRichEdit\Font\hFont   
   EndIf 
EndProcedure

; <��ȡ�ؼ���ɫ> : ����PB���ÿؼ��ĺ���[�������òο�SetGadgetItemColor()]
Procedure RichEdit_Event_SetGadgetColor(GadgetID, ColorType, Color)
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      Select ColorType
         Case #PB_Gadget_FrontColor 
            For Index = #Format_ViewArea To #Format_TipWords
               *pRichEdit\Format[Index]\FontColor = Color
            Next 
            KillTimer_(hGadget,#Timer_Refresh_Flags)  
            SetTimer_ (hGadget,#Timer_Refresh_Flags, #Timer_Refresh_Timer, #Null)
            *pResult = @*pRichEdit\Format[#Format_ViewArea]
         Case #PB_Gadget_BackColor   
            For Index = #Format_ViewArea To #Format_TipWords
               *pRichEdit\Format[Index]\BackColor = Color
            Next 
            KillTimer_(hGadget,#Timer_Refresh_Flags)  
            SetTimer_ (hGadget,#Timer_Refresh_Flags, #Timer_Refresh_Timer, #Null)
            *pResult = @*pRichEdit\Format[#Format_ViewArea]
            
         Case #PB_Gadget_LineColor 
            *pRichEdit\Format[#Format_CaretRow]\BackColor = Color
            KillTimer_(hGadget,#Timer_Refresh_Flags)  
            SetTimer_ (hGadget,#Timer_Refresh_Flags, #Timer_Refresh_Timer, #Null)
            *pResult = @*pRichEdit\Format[#Format_CaretRow]
            
         Case #PB_Gadget_TitleFrontColor 
            *pRichEdit\Format[#Format_MarkArea]\FontColor = Color
            KillTimer_(hGadget,#Timer_Refresh_Flags)  
            SetTimer_ (hGadget,#Timer_Refresh_Flags, #Timer_Refresh_Timer, #Null)
            *pResult = @*pRichEdit\Format[#Format_MarkArea]  
            
         Case #PB_Gadget_TitleBackColor 
            *pRichEdit\Format[#Format_MarkArea]\BackColor = Color
            RichEdit_RedrawGadget (*pRichEdit) 
            KillTimer_(hGadget,#Timer_Refresh_Flags)  
            SetTimer_ (hGadget,#Timer_Refresh_Flags, #Timer_Refresh_Timer, #Null)
            *pResult = @*pRichEdit\Format[#Format_MarkArea]  
            
      EndSelect
   EndIf 
   ProcedureReturn *pResult
EndProcedure

; <��ȡ�ؼ���ɫ> : ����PB���ÿؼ��ĺ��� 
Procedure RichEdit_Event_GetGadgetColor(GadgetID, ColorType)
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      Select ColorType
         Case #PB_Gadget_FrontColor       : Color = *pRichEdit\Format[#Format_ViewArea]\FontColor 
         Case #PB_Gadget_BackColor        : Color = *pRichEdit\Format[#Format_ViewArea]\BackColor
         Case #PB_Gadget_LineColor        : Color = *pRichEdit\Format[#Format_CaretRow]\BackColor
         Case #PB_Gadget_TitleFrontColor  : Color = *pRichEdit\Format[#Format_MarkArea]\FontColor
         Case #PB_Gadget_TitleBackColor   : Color = *pRichEdit\Format[#Format_MarkArea]\BackColor
      EndSelect
      ProcedureReturn Color
   EndIf 
EndProcedure


; <���ÿؼ�������> ; ��������Ϣ��ָ��
Procedure RichEdit_Event_SetGadgetItemData(GadgetID, Index, Value)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      CountList = ListSize(*pRichEdit\ListTextLine())
      If Index >= 0 And Index < CountList
         *pElement = SelectElement(*pRichEdit\ListTextLine(), Index)
         *pRichEdit\ListTextLine()\ItemData = Value
      EndIf 
   EndIf 
   ProcedureReturn *pElement
EndProcedure

; <��ȡ�ؼ�������>
Procedure RichEdit_Event_GetGadgetItemData(GadgetID, Index)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      CountList = ListSize(*pRichEdit\ListTextLine())
      If Index >= 0 And Index < CountList
         SelectElement(*pRichEdit\ListTextLine(), Index)
         Result = *pRichEdit\ListTextLine()\ItemData
      EndIf 
   EndIf 
   ProcedureReturn Result
EndProcedure

; <��ȡ�ؼ�ϸ�ڵ���ɫ> : 
Procedure RichEdit_Event_SetGadgetItemColor(GadgetID, Item, ColorType, Color, Column=0)
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      If Item >= 0 And Item < #Format_Count
         Select ColorType
            Case #PB_Gadget_FontColor : *pRichEdit\Format[Item]\FontColor = Value : RichEdit_RedrawGadget(*pRichEdit)  
            Case #PB_Gadget_BackColor : *pRichEdit\Format[Item]\BackColor = Value : RichEdit_RedrawGadget(*pRichEdit) 
            Case #PB_Gadget_FontStlye : *pRichEdit\Format[Item]\FontStyle = Value : RichEdit_RedrawGadget(*pRichEdit)
         EndSelect
      EndIf
   EndIf 
EndProcedure

; <��ȡ�ؼ�ϸ�ڵ���ɫ> : 
Procedure RichEdit_Event_GetGadgetItemColor(GadgetID, Item, ColorType, Column=0)
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      If Item >= 0 And Item < #Format_Count
         Select ColorType
            Case #PB_Gadget_FontColor : Result = *pRichEdit\Format[Item]\FontColor
            Case #PB_Gadget_BackColor : Result = *pRichEdit\Format[Item]\BackColor 
            Case #PB_Gadget_FontStlye : Result = *pRichEdit\Format[Item]\FontStyle 
         EndSelect
      EndIf
   EndIf 
   ProcedureReturn Result
EndProcedure

; <���ÿؼ��ı�������>
Procedure RichEdit_Event_SetGadgetItemText(GadgetID, Index, LineText$, Column=0)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      With *pRichEdit
         CountList = ListSize(\ListTextLine())
         If \EditState & #EditState_EmptyText
            \EditState & ~ #EditState_EmptyText
            *pElement  = FirstElement(\ListTextLine())
            MemorySize = (Len(LineText$)/16*16+16) *  #RichEdit_EditCharSize
            LineWidth  = StringByteLength(LineText$, #PB_Ascii) * \Font\W
            \ListTextLine()\LineText$    = LineText$            
            \ListTextLine()\CountChars   = Len(LineText$)
            \ListTextLine()\LineWidth    = LineWidth
            \ListTextLine()\pMemEditChar = ReAllocateMemory(\ListTextLine()\pMemEditChar, MemorySize)
            KillTimer_(hGadget,#Timer_AddItem_Flags)  
            SetTimer_ (hGadget,#Timer_AddItem_Flags, #Timer_AddItem_Timer, #Null)
            
         ElseIf Index >= 0 And Index < CountList
            *pElement  = SelectElement(\ListTextLine(), Index)
            MemorySize = (Len(LineText$)/16*16+16) *  #RichEdit_EditCharSize
            LineWidth  = StringByteLength(LineText$, #PB_Ascii) * \Font\W
            \ListTextLine()\LineText$    = LineText$            
            \ListTextLine()\CountChars   = Len(LineText$)
            \ListTextLine()\LineWidth    = LineWidth
            \ListTextLine()\pMemEditChar = ReAllocateMemory(\ListTextLine()\pMemEditChar, MemorySize)
            KillTimer_(hGadget,#Timer_AddItem_Flags)  
            SetTimer_ (hGadget,#Timer_AddItem_Flags, #Timer_AddItem_Timer, #Null)
         EndIf 

      EndWith
   EndIf 
   ProcedureReturn *pElement
EndProcedure

Procedure$ RichEdit_Event_GetGadgetItemText(GadgetID, Index, Column=0)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      With *pRichEdit
         CountList = ListSize(\ListTextLine())
         If Index >= 0 And Index < CountList
            *pElement = SelectElement(\ListTextLine(), Index)
            LineText$ = \ListTextLine()\LineText$ 
         EndIf 
      EndWith
   EndIf 
   ProcedureReturn LineText$
EndProcedure

; <���ÿؼ�����>
Procedure RichEdit_Event_SetGadgetAttribute(GadgetID, Attribute, Value)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      With *pRichEdit
         Select Attribute
            Case #MCS_RichEdit_Format 
               If Value = #FormatType_Common 
                  \EditState & ~#EditState_FoldVisible
               Else 
                  \EditState | #EditState_FoldVisible
               EndIf 
               RichEdit_SetFormatType(*pRichEdit, Value)
               RichEdit_RedrawGadget(*pRichEdit)
            Case #MCS_RichEdit_FoldBar   
               If Value   
                  \EditState | #EditState_FoldVisible
               Else 
                  \EditState & ~#EditState_FoldVisible
               EndIf 
               RichEdit_RedrawGadget(*pRichEdit)    
               
            Case #MCS_RichEdit_FoldStart 
               \KeyWord$[#FoldStart] = PeekS(Value)
               RichEdit_ParserEditChar(*pRichEdit)
               RichEdit_RedrawGadget(*pRichEdit)  

            Case #MCS_RichEdit_FoldToEnd
               \KeyWord$[#FoldToEnd] = PeekS(Value)
               RichEdit_ParserEditChar(*pRichEdit)
               RichEdit_RedrawGadget(*pRichEdit)
                 
            Case #MCS_RichEdit_KeyWord01 
               \KeyWord$[#KeyWord01] = PeekS(Value) : RichEdit_RedrawGadget(*pRichEdit) 
            Case #MCS_RichEdit_KeyWord02 
               \KeyWord$[#KeyWord02] = PeekS(Value) : RichEdit_RedrawGadget(*pRichEdit) 
            Case #MCS_RichEdit_KeyWord03
               \KeyWord$[#KeyWord03] = PeekS(Value) : RichEdit_RedrawGadget(*pRichEdit) 
            Case #MCS_RichEdit_KeyWord04
               \KeyWord$[#KeyWord04] = PeekS(Value) : RichEdit_RedrawGadget(*pRichEdit) 
            Case #MCS_RichEdit_KeyWord05
               \KeyWord$[#KeyWord05] = PeekS(Value) : RichEdit_RedrawGadget(*pRichEdit) 
         EndSelect
      EndWith
   EndIf 
EndProcedure

; <���ÿؼ�����>
Procedure RichEdit_Event_GetGadgetAttribute(GadgetID, Attribute)
   ;��ȡ�ؼ���Ϣ
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      With *pRichEdit
         Select Attribute
            Case #MCS_RichEdit_Format 
               Result = \FormatType
            Case #MCS_RichEdit_FoldBar
               If \EditState & #EditState_FoldVisible
                  Result = #True
               Else 
                  Result = #False
               EndIf  
            Case #MCS_RichEdit_FoldStart : Result = @\KeyWord$[#FoldStart]
            Case #MCS_RichEdit_FoldToEnd : Result = @\KeyWord$[#FoldToEnd]
            Case #MCS_RichEdit_KeyWord01 : Result = @\KeyWord$[#KeyWord01]   
            Case #MCS_RichEdit_KeyWord02 : Result = @\KeyWord$[#KeyWord02]   
            Case #MCS_RichEdit_KeyWord03 : Result = @\KeyWord$[#KeyWord03]   
            Case #MCS_RichEdit_KeyWord04 : Result = @\KeyWord$[#KeyWord04]   
            Case #MCS_RichEdit_KeyWord05 : Result = @\KeyWord$[#KeyWord05]   
         EndSelect
      EndWith
   EndIf 
   ProcedureReturn Result
EndProcedure


;- <><><><><><><><><><><><>
;-[DLL]
;����һ��EDIT��ؼ�
ProcedureDLL mcsRichEditGadget_(GadgetID, X, Y, Width, Height)
   Shared  *pCurrRichEdit.__RichEditInfo
   Shared  *pPrevRichEdit.__RichEditInfo
   Protected *pCommand.__PBGadgetCommand
   Protected *pPointer.__PBGadgetPointer
   Shared  *pCurrRichEdit.__RichEditInfo
   If GadgetID  < #PB_Any : ProcedureReturn -1 : EndIf 
   *pThread  = PB_Object_GetThreadMemory(PB_Gadget_Globals)
   hWindow   = PeekI(*pThread)
   hInstance = GetModuleHandle_(0)

   ; ���ÿؼ�����
   WndClass.WNDCLASSEX 
   GadgetClass$ = #GadgetClass_RichEdit$
   With WndClass
      \cbSize        = SizeOf(WNDCLASSEX) 
      \style         = #CS_DBLCLKS | #CS_OWNDC | #CS_HREDRAW | #CS_VREDRAW 
      \lpfnWndProc   = @RichEdit_GadgetHook() 
      \hInstance     = hInstance 
      \hCursor       = 0 
      \hbrBackground = CreateSolidBrush_($FFFFFF)
      \lpszClassName = @GadgetClass$
   EndWith
   
   ; ע��ؼ�����, 1410��ʾ�ÿؼ����Ѿ�ע����
   Register = RegisterClassEx_(@WndClass)
   If Register = 0 And GetLastError_() <> 1410 : ProcedureReturn 0 : EndIf 

   ; �����ؼ�
   GadgetFlags = #WS_VISIBLE | #WS_CHILD ; #WS_TABSTOP ; #WS_VSCROLL  | #WS_HSCROLL 
   hGadget     = CreateWindowEx_(#Null, @GadgetClass$, "", GadgetFlags, 0, 0, 0, 0, hWindow, GadgetID, hInstance, 0)

   *pCommand = AllocateMemory(SizeOf(__PBGadgetCommand))
   With *pCommand
      \GadgetType       = #PB_GadgetType_RichEdit
      \ResizeGadget     = @RichEdit_Event_ResizeGadget()
      \FreeGadget       = @RichEdit_Event_FreeGadget()
      \ClearGadgetItems = @RichEdit_Event_ClearGadgetItems()
      \CountGadgetItems = @RichEdit_Event_CountGadgetItems()
      \AddGadgetItem3   = @RichEdit_Event_AddGadgetItem()
      \RemoveGadgetItem = @RichEdit_Event_RemoveGadgetItem()
      \SetGadgetText    = @RichEdit_Event_SetGadgetText()
      \GetGadgetText    = @RichEdit_Event_GetGadgetText()
      \SetGadgetState   = @RichEdit_Event_SetGadgetState()
      \GetGadgetState   = @RichEdit_Event_GetGadgetState()
      \SetGadgetFont    = @RichEdit_Event_SetGadgetFont()
      \GetGadgetFont    = @RichEdit_Event_GetGadgetFont()
      \SetGadgetColor   = @RichEdit_Event_SetGadgetColor()
      \GetGadgetColor   = @RichEdit_Event_GetGadgetColor()
      \SetGadgetItemColor2 = @RichEdit_Event_SetGadgetItemColor()
      \GetGadgetItemColor2 = @RichEdit_Event_GetGadgetItemColor()
      
      \SetGadgetItemData   = @RichEdit_Event_SetGadgetItemData()
      \GetGadgetItemData   = @RichEdit_Event_GetGadgetItemData()
      \SetGadgetItemText   = @RichEdit_Event_SetGadgetItemText()
      \GetGadgetItemText   = @RichEdit_Event_GetGadgetItemText()
      \SetGadgetAttribute  = @RichEdit_Event_SetGadgetAttribute()
      \GetGadgetAttribute  = @RichEdit_Event_GetGadgetAttribute()

      ;-<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   EndWith
   *pPointer = PB_Object_GetOrAllocateID(PB_Gadget_Objects, GadgetID)
   Result = PB_Gadget_RegisterGadget(GadgetID, *pPointer, hGadget, *pCommand)

   *pRichEdit.__RichEditInfo = AllocateStructure(__RichEditInfo)
   *pCurrRichEdit = *pRichEdit
   With *pRichEdit
      ; ���ÿؼ���ʶ�;��
      If GadgetID = #PB_Any 
         \GadgetID = Result   : \hGadget  = hGadget
      Else
         \GadgetID = GadgetID : \hGadget  = Result
      EndIf    
      MemorySize    = #RichEdit_MaxShowLines * #RichEdit_FullRowBytes
      \pMemViewChar = AllocateMemory(MemorySize)
      
      ; =======================
      ;����[��ʽ��ͷ���]/[�����ͷ���]/[����״̬���]
      \Cursor\hRMARK = CreateCursor_(hInstance, 32, 0, 32, 32, ?_Bin_ANDPlane, ?_Bin_XORPlane)
      \Cursor\hARROW = LoadCursor_(0,#IDC_ARROW)
      \Cursor\hIBEAM = LoadCursor_(0,#IDC_IBEAM)
      \EditState     = #EditState_EmptyText|#EditState_FoldVisible
      ; =======================
      ;���ÿؼ���ʽ
      hDefaultFont = GetGadgetFont(#PB_Default)   
      GetObject_(hDefaultFont, SizeOf(LOGFONT), @FontInfo.LOGFONT)
      \Font\hFont = hDefaultFont        
      \Font\Name$ = PeekS(@FontInfo\lfFaceName)        ;��ȡĬ�����������
      \Font\Size  = (-FontInfo\lfHeight*3+0.3)/4      ;��������Ĭ�ϸ߶�,��������Ĵ�С
      \Font\TapCount = 3
      RichEdit_SetGadgetFont(*pRichEdit)
      ; =======================
      \pMaxTextLine = AddElement(\ListTextLine())
      \ListTextLine()\pMemEditChar = AllocateMemory($10) 
      AddElement(\ListEditLine()) 
      \ListEditLine()\LineIndex = 0
      \ListEditLine()\pElement  = \pMaxTextLine
      SetProp_(\hGadget, #GadgetClass_RichEdit$, *pRichEdit)
      RichEdit_SetFormatType(*pRichEdit, #FormatType_Common)
      RichEdit_ResizeGadget(*pRichEdit, X, Y, Width, Height)
      \hMouseHook  = SetWindowsHookEx_(#WH_MOUSE_LL, @RichEdit_MouseHook(), hInstance, 0)
   EndWith 
   ProcedureReturn Result
EndProcedure

; �����ı����ؼ�
ProcedureDLL mcsRichEditLoadFile_(GadgetID, FileName$)
   hGadget = GadgetID(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      FileID = ReadFile(#PB_Any, FileName$)
      If FileID > 0
         Flags  = ReadStringFormat(FileID)
         Result = RichEdit_LoadFile(*pRichEdit, FileID, Flags)
      Else 
         Result = FileID
      EndIf 
   Else 
      Result = -3
   EndIf 
   ProcedureReturn Result
EndProcedure

; �����ı����ؼ�
ProcedureDLL mcsRichEditLoadFile_2(GadgetID, FileName$, Flags=#PB_Ascii)
   hGadget = GadgetID(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      FileID = ReadFile(#PB_Any, FileName$)
      If FileID > 0
         ReadStringFormat(FileID)
         Result = RichEdit_LoadFile(*pRichEdit, FileID, Flags)
      Else 
         Result = FileID
      EndIf 
   Else 
      Result = -3
   EndIf 
   ProcedureReturn Result
EndProcedure

; �����ı����ؼ�
ProcedureDLL mcsRichEditSaveFile_(GadgetID, FileName$)
   hGadget = GadgetID(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      FileID = CreateFile(#PB_Any, FileName$)
      If FileID
         WriteStringFormat(FileID, #PB_Ascii)
         ForEach *pRichEdit\ListTextLine()
            WriteStringN(FileID, *pRichEdit\ListTextLine()\LineText$, #PB_Ascii)
         Next 
         CloseFile(FileID)
      EndIf 
   Else 
      Result = -1
   EndIf 
   ProcedureReturn Result
EndProcedure

; �����ı����ؼ�
ProcedureDLL mcsRichEditSaveFile_2(GadgetID, FileName$, Flags=#PB_Ascii)
   hGadget = GadgetID(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      FileID = CreateFile(#PB_Any, FileName$)
      If FileID
         WriteStringFormat(FileID, Flags)
         ForEach *pRichEdit\ListTextLine()
            WriteStringN(FileID, *pRichEdit\ListTextLine()\LineText$, Flags)
         Next 
         CloseFile(FileID)
      EndIf 
   Else 
      Result = -1
   EndIf 
   ProcedureReturn Result
EndProcedure


;- DataSection
DataSection
   _Bin_ANDPlane:   ; [�з���][��ʽ��ͷ���]1
      Data.l  $FFFFFFFF, $FFFFFFFF, $FDFFFFFF, $F9FFFFFF, $F1FFFFFF, $E1FFFFFF, $C1FFFFFF, $81FFFFFF
      Data.l  $01FFFFFF, $01FEFFFF, $01FCFFFF, $01F8FFFF, $81FFFFFF, $91FFFFFF, $39FFFFFF, $3DFFFFFF
      Data.l  $7FFEFFFF, $7FFEFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF
      Data.l  $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF
   _Bin_XORPlane:   ; [�з���][��ʽ��ͷ���]2
      Data.l  $01000000, $03000000, $07000000, $0F000000, $1F000000, $3F000000, $7F000000, $FF000000
      Data.l  $FF010000, $FF030000, $FF070000, $FF0F0000, $FF0F0000, $FF000000, $EF010000, $E7010000
      Data.l  $C3030000, $C0030000, $80010000, $00000000, $00000000, $00000000, $00000000, $00000000
      Data.l  $00000000, $00000000, $00000000, $00000000, $00000000, $00000000, $00000000, $00000000

   _Bin_FormatOfCommon:   ; �����ʽ���ı���ʽ
      Data.l $000000, $FFFFFF, $00, $000000, $FFFFFF, $00, $000000, $FFFFFF, $00 ;VeiwArea/Comments/Constant
      Data.l $000000, $FFFFFF, $00, $000000, $FFFFFF, $00                        ;DQString/SQString
      Data.l $000000, $FFFFFF, $00, $000000, $FFFFFF, $00, $000000, $FFFFFF, $00 ;Special1/Special1/Operator
      Data.l $000000, $FFFFFF, $01, $000000, $FFFFFF, $01, $000000, $FFFFFF, $01 ;FoldWord/KeyWord1/KeyWord2
      Data.l $000000, $FFFFFF, $01, $000000, $FFFFFF, $01, $000000, $FFFFFF, $01 ;KeyWord3/KeyWord4/KeyWord5
      Data.l $000000, $FFFFFF, $00, $FFFFFF, $CCCCCC, $00                        ;Function/TipWords 
      Data.l $FFFFFF, $FF9933, $00, $000000, $EEEEEE, $00, $888888, $EEEEEE, $00 ;Selected/CaretRow/MarkArea
      Data.l $808080, $F0F0F0, $00, $F08040, $FFF8E8, $00, $F85810, $F8E8B8, $00 ;NScroll/MScroll/DScroll

   _Bin_FormatOfPB:   ; PB��ʽ���ı���ʽ
      Data.l $000000, $DFFFFF, $00, $AAAA00, $DFFFFF, $00, $724C92, $DFFFFF, $00 ;VeiwArea/Comments/Constant
      Data.l $FF8000, $DFFFFF, $00, $C5057F, $DFFFFF, $00                        ;DQString/SQString
      Data.l $0044FF, $DFFFFF, $00, $0044FF, $DFFFFF, $00, $0044FF, $DFFFFF, $00 ;Special1/Special1/Operator
      Data.l $666600, $B0FFFF, $01, $666600, $DFFFFF, $01, $666600, $DFFFFF, $01 ;FoldWord/KeyWord1/KeyWord2
      Data.l $666600, $DFFFFF, $01, $666600, $DFFFFF, $01, $666600, $DFFFFF, $01 ;KeyWord3/KeyWord4/KeyWord5
      Data.l $666600, $DFFFFF, $00, $FFFFFF, $A7FFB0, $01                        ;Function/TipWords 
      Data.l $FFFFFF, $FF9933, $00, $F8A4F8, $B8FFFF, $00, $888888, $CFFFFF, $00 ;Selected/CaretRow/MarkArea
      Data.l $808080, $F0F0F0, $00, $F08040, $FFF8E8, $00, $F85810, $F8E8B8, $00 ;NScroll/MScroll/DScroll

   _Bin_FormatOfLUA:   ; LUA��ʽ���ı���ʽ
      Data.l $DDDDDD, $000000, $00, $99CC66, $000000, $00, $724C92, $000000, $00 ;VeiwArea/Comments/Constant
      Data.l $FFCC88, $000000, $00, $C5057F, $000000, $00                        ;DQString/SQString
      Data.l $444444, $000000, $00, $444444, $000000, $00, $FF66FF, $000000, $00 ;Special1/Special1/Operator
      Data.l $CC9900, $444444, $01, $CC9900, $000000, $01, $CC9900, $000000, $01 ;FoldWord/KeyWord1/KeyWord2
      Data.l $CC9900, $000000, $01, $00AAAA, $000000, $01, $AAAA00, $000000, $01 ;KeyWord3/KeyWord4/KeyWord5
      Data.l $AAAA00, $000000, $01, $F8A4F8, $0277A1, $00                        ;Function/TipWords 
      Data.l $FFFFFF, $FF9933, $00, $F8A4F8, $666666, $00, $BBBBBB, $444444, $00 ;Selected/CaretRow/MarkArea
      Data.l $222222, $666666, $00, $444444, $888888, $00, $666666, $AAAAAA, $00 ;NScroll/MScroll/DScroll

EndDataSection 


;- =======================
;- Debug 
CompilerIf #PB_Compiler_ExecutableFormat <>  #PB_Compiler_DLL 

   hWindow = OpenWindow(0, 0, 0, 800, 600, "����", $CF0001)
   hNormFont = LoadFont(2, "",15)
   SetGadgetFont(#PB_Default, hNormFont)

   RichEditID1 = 1
   hRichEdit1  = mcsRichEditGadget_(RichEditID1, 005, 005, 800-10, 600-10)
   

   SetGadgetAttribute(RichEditID1, #MCS_RichEdit_Format, #FormatType_PB)
   mcsRichEditLoadFile_(RichEditID1, "Test.pb")
   
;    
   AddGadgetItem(RichEditID1, 0, Chr($22)+"AAAAAAAAAAAAAAAAAAAAAAA"+Chr($22))
   AddGadgetItem(RichEditID1, 0, ";BBBBBBBBBBBBBBBBBBBBBBB")
   AddGadgetItem(RichEditID1, 0, ";CCCCCCCCCCCCCCCCCCCCCCC")
   AddGadgetItem(RichEditID1, 0, "'DDDDDDDDDDDDDDDDDDDDDDD'")
;    RemoveGadgetItem(RichEditID1, 1)
   SetGadgetState(RichEditID1, 1)
;    SetGadgetColor(RichEditID1, #PB_Gadget_TitleBackColor, $0)
   Debug CountGadgetItems(RichEditID1)
   Debug GetGadgetText(RichEditID1)


   *p.string = GetGadgetAttribute(RichEditID1, #MCS_RichEdit_FoldStart)
   Debug PeekS(*p.string)

   Repeat
   wEventID  = WindowEvent()
   WindowID  = EventWindow()
   GadgetID  = EventGadget()
   EventType = EventType() 
   MenuID    = EventMenu() 
   Select wEventID
      Case #PB_Event_Gadget
;          Debug GadgetID
      Case #PB_Event_SizeWindow
         W = WindowWidth(0)
         H = WindowHeight(0)
         ResizeGadget(RichEditID1, 5, 5, W-10, H-10)
      Case #PB_Event_CloseWindow 
         IsExitTool = #True
   EndSelect
   Delay(1)
   Until IsExitTool = #True

CompilerEndIf


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = 0+-f-----------v-
; Executable = F:\����\XXXXX.exe
; Constant = #MCS_Test=5
; EnableUnicode