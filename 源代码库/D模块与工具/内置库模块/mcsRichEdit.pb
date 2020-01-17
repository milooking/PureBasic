;【注】自己用TBManager编译成内置模块(LIB),
;      或将[McsRichEdit]复制到[..\PureBasic-5.62-x86\PureLibraries\UserLibraries\]目录中
;***********************************************************
;************  迷路PB控件组[mcsRichEditGadget]  ************
;************ 作者: 迷路仟/Miloo [QQ:714095563] ************
;************        2019版 [2019.01.13]       *************
;***********************************************************
; V0.09: 修改选区BUG;完善方向键对字符的选择操作 2015.11.24
; V0.08: 大规模优化代码,引入全文本行扫描概念,修改折叠行的BUG,优化各种数据结构, 将滚动条从22像素改为19像素
; V0.07: 添加PB关于控件的命令.添加常规文本格式,以区分PB文本格式.
; V0.06: 优化代码,引入非折叠行概念,完善折叠区功能.
; V0.05: 添加折叠区折叠符绘制
; V0.04: 添加关键词着色功能, 添加选中词着色功能
; V0.03: 添加全选功能;优化文本重绘代码,从逐行重绘改为逐字重绘,为关键词着色做准备.
; V0.02: 字体缩放;选区加显亮
; V0.01: 控件PB化处理,添加滚动条及相关处理.
;**********************************************************
; 注释说明: []表示控件/对象, <>表示事件/过程, ()注释内容 
; 滚动条设计方案: 
; 1.由前景色和背景色及三种状态组构成主题.重设,可以改变其主题
; 2.滚动条的Minimum=0, 右侧滚动条Maximum===文本行数, 底部滚动条Maximum===最大文本行宽度.
; 显示区设计方案: 
; [编辑器]:mcsRichEditGadget,[编辑区]:VeiwArea描述非隐藏行文本域,[可视区]:ViewArea显示文本的域
; [文本行链表]用于记录全部文本行,[可视行链表]用于记录非折叠行链表
; 每个文本行,自带字符信息块,用于记录全文本行分析结果,显示时,再进行二次分析,添加当前行状态,选区状态,选中词状态等

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

;{ 杂项
#GadgetClass_RichEdit$  = "mcsRichEdit"
#PB_GadgetType_RichEdit = 35
#Timer_Refresh_Flags  = 1   : #Timer_Refresh_Timer = 0001   ;缓冲刷新的次数
#Timer_Scrolls_Flags  = 2   : #Timer_Scrolls_Timer = 0500   ;缓冲刷新的次数
#Timer_AddItem_Flags  = 3   : #Timer_AddItem_Timer = 0010   ;缓冲刷新的次数
#Timer_LDChick_Flags  = 4   : #Timer_LDChick_Timer = 500   ;缓冲刷新的次数,双击延时标志

#FoldState_Start   = $01    ; 折叠行开始处节点,
#FoldState_ToEnd   = $02    ; 折叠行结束处节点
#FoldState_IsHide  = $10    ; 折叠行隐藏状态
#FoldState_Closed  = $20    ; 折叠行节点关闭状态

 
#Redraw_NotEvent   = $00   ; 表示没有动作
#Redraw_SetCaret   = $01   ; 表示重设光标
#Redraw_ViewArea   = $02   ; 表示重绘画面
#Redraw_FullArea   = $03   ; 表示重绘画面并设置光标行


#EditState_EmptyText     = $0100   ; [编辑区]内容是否为空
#EditState_CaretVisible  = $0200   ; [提示符]是否为隐藏状态
#EditState_FoldVisible   = $0400   ; 是否显示[折叠区]

#FormatType_Common  = $00
#FormatType_PB      = $01
#FormatType_LUA     = $02
#FormatType_XML     = $03
#FormatType         = $FF

#Symbol_Space    = $00   ; 空格符
#Symbol_Number   = $01   ; 数字符
#Symbol_Letter   = $02   ; 字母符, 包括_, 中文
#Symbol_Operator = $04   ; 运算符
#Symbol_Logical  = $08   ; 运算符
#Symbol_Define   = $10   ; 定义符,如".","[","]"等等
#Symbol_Special  = $20  
#Symbol_TabChar  = $40   
#Symbol_Other    = $80   ; 数值标识符, $

#Symbol_String   = $03

#Event_MouseOnTop = $10000    ;<鼠标在上>
#Event_MouseLDown = $20000    ;<左键按下>
#Event_MouseLToUp = $40000    ;<左键释放>
#Event_MouseMoveOn = #Event_MouseOnTop
#Event_MouseLClick = #Event_MouseMoveOn|#Event_MouseLDown

#Event_MarkArea  = $0100    ;[符号区]标识
#Event_FoldArea  = $0200    ;[折叠区]标识
#Event_VScroll   = $0410    ;[右侧滚动条]标识
#Event_HScroll   = $0420    ;[底部滚动条]标识
#Event_EditArea  = $0800    ;[可视区]标识

#Event_MarkArea_OnTop = #Event_MouseMoveOn|#Event_MarkArea   ;[符号区]<鼠标在上>
#Event_MarkArea_LDown = #Event_MouseLClick|#Event_MarkArea   ;[符号区]<鼠标按下>
#Event_FoldArea_OnTop = #Event_MouseMoveOn|#Event_FoldArea   ;[折叠区]<鼠标在上>
#Event_FoldArea_LDown = #Event_MouseLClick|#Event_FoldArea   ;[折叠区]<鼠标按下>
#Event_EditArea_OnTop = #Event_MouseMoveOn|#Event_EditArea   ;[文本区]<鼠标在上>
#Event_EditArea_LDown = #Event_MouseLClick|#Event_EditArea   ;[文本区]<鼠标按下>
#Event_EditArea_OTSelected = #Event_MouseLClick|#Event_EditArea|1   ;[文本区]<鼠标选区在上>


#Event_VScrollM_OnTop = #Event_MouseMoveOn|$410   ;[右侧滚动条|滑片按键]<鼠标在上>
#Event_VScrollT_OnTop = #Event_MouseMoveOn|$411   ;[右侧滚动条|上际按键]<鼠标在上>
#Event_VScrollB_OnTop = #Event_MouseMoveOn|$412   ;[右侧滚动条|下际按键]<鼠标在上>
#Event_VScrollW_OnTop = #Event_MouseMoveOn|$413   ;[右侧滚动条|上移按键]<鼠标在上>
#Event_VScrollS_OnTop = #Event_MouseMoveOn|$414   ;[右侧滚动条|下移按键]<鼠标在上>

#Event_VScrollM_LDown = #Event_MouseLClick|$410   ;[右侧滚动条|滑片按键]<鼠标按下>
#Event_VScrollT_LDown = #Event_MouseLClick|$411   ;[右侧滚动条|上际按键]<鼠标按下>
#Event_VScrollB_LDown = #Event_MouseLClick|$412   ;[右侧滚动条|下际按键]<鼠标按下>
#Event_VScrollW_LDown = #Event_MouseLClick|$413   ;[右侧滚动条|上移按键]<鼠标按下>
#Event_VScrollS_LDown = #Event_MouseLClick|$414   ;[右侧滚动条|下移按键]<鼠标按下>

#Event_HScrollM_OnTop = #Event_MouseMoveOn|$420   ;[底部滚动条|滑片按键]<鼠标在上>
#Event_HScrollL_OnTop = #Event_MouseMoveOn|$421   ;[底部滚动条|左际按键]<鼠标在上>
#Event_HScrollR_OnTop = #Event_MouseMoveOn|$422   ;[底部滚动条|右际按键]<鼠标在上>
#Event_HScrollA_OnTop = #Event_MouseMoveOn|$423   ;[底部滚动条|左移按键]<鼠标在上>
#Event_HScrollD_OnTop = #Event_MouseMoveOn|$424   ;[底部滚动条|右移按键]<鼠标在上>

#Event_HScrollM_LDown = #Event_MouseLClick|$420   ;[底部滚动条|滑片按键]<鼠标按下>
#Event_HScrollL_LDown = #Event_MouseLClick|$421   ;[底部滚动条|左际按键]<鼠标按下>
#Event_HScrollR_LDown = #Event_MouseLClick|$422   ;[底部滚动条|右际按键]<鼠标按下>
#Event_HScrollA_LDown = #Event_MouseLClick|$423   ;[底部滚动条|左移按键]<鼠标按下>
#Event_HScrollD_LDown = #Event_MouseLClick|$424   ;[底部滚动条|右移按键]<鼠标按下>
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
   #MCS_RichEdit_Format       ; 控件的文本解析类型
   #MCS_RichEdit_FoldBar      ; 控件的折叠区
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

; 字符格式
Enumeration
   ;=================
   #Format_ViewArea  ; 常格式
   #Format_Comments  ; 注释文本格式
   #Format_Constant  ; 常量格式
   #Format_DQString  ; 双引号格式
   #Format_SQString  ; 单引号格式
   #Format_Special1  ; 特殊格式
   #Format_Special2  ; 特殊格式
   #Format_Operator  ; 运算符
   #Format_FoldWord  ; 折叠词格式
   #Format_KeyWord1  ; 关键词格式
   #Format_KeyWord2
   #Format_KeyWord3
   #Format_KeyWord4
   #Format_KeyWord5
   #Format_Function  ; 函数格式
   #Format_TipWords  ; 选中词格式
   ;=================
   #Format_Selected  ; 选区格式
   #Format_CaretRow  ; 光标行格式         
   #Format_MarkArea  ; 行符号|折叠区格式   
   #Format_NScroll   ;滚动条<正常状态>
   #Format_MScroll   ;滚动条<在上状态>
   #Format_DScroll   ;滚动条<按住状态>
   #Format_Count
EndEnumeration

;- Structure
;{ 
; PB自带的命令结构
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

; PB控件的指针结构
Structure __PBGadgetPointer
   Gadget.i
   *pCommand.__PBGadgetCommand
   UserData.i
   OldCallback.i
   Daten.l[4]
EndStructure




; [编辑器]的光标
Structure __RichEdit_Cursor
   hARROW.i    ; [反式箭头光标]句柄
   hIBEAM.i    ; [常规箭头光标]句柄
   hRMARK.i    ; [输入状态光标]句柄
   Row.l       ; 提示符所处的行
   RealRow.l   ; 实际行行数(字符),即文本行行数
   RealCol.l   ; 实际列位置(字符)
   Col.w       ; 提示符所处的列
   IsInFold.b  ; 是否包含在折叠区里面
   IsLDChick.b ; 双击选项延时标志
EndStructure

; [编辑器]的字符格式
Structure __RichEdit_Format
   FontColor.l       ;字体色/前景色
   BackColor.l       ;背景色
   FontStyle.b       ;字体标志:0=常规,1=粗体,2=斜体,3=粗体|斜体
   KeepB.b[3]        ;保留空间,以对齐字节
EndStructure

; [编辑器]的字符样式
Structure __RichEdit_FontInfo
   ID.l[4]     ;字体ID: 0=常规,1=粗体,2=斜体,3=粗体|斜体
   hFont.l
   Name$    ;字体名称
   Size.a   ;字体大小
   TapCount.a
   TapWith.w   
   H.w      ;字体高度
   W.w      ;常规字体宽度
EndStructure

; [编辑器]的滚动条信息
Structure __RichEdit_Scroll
   SetpScale.f       ; [滑片]的步进值
   VanePos.w         ; [滑片]当前位置     
   VaneSize.w        ; [滑片]大小 
   MouseDownPos.w    ; [滑片]<按下>时的鼠标X/Y坐标值
   RecordingPos.w    ; [滑片]<按下>时的[滑片]X/Y坐标值
   PageLine.l        ; [滑片]<按下>时的[滑片]翻页的结束行
   VaneLast.l        ; [滑片]的最终位置
EndStructure

; [编辑器]的单字符信息
Structure __RichEdit_EditChar
   Format.a       ; 控件格式索引
   Symbol.b       ; 字符分类标识
EndStructure

; [编辑器]的单字符信息
Structure __RichEdit_ViewChar
   X.l
   W.l               ;字符的宽度
   iFontStyle.a      ;字体标志:0=常规,1=粗体,2=斜体,3=粗体|斜体
   iFontColor.a      ;字符格式:采用什么字体色
   iBackColor.a      ;字符格式:采用什么背景色
   CharSymbol.b      ;字符分类标识
EndStructure

; [编辑器]的文本行信息
Structure __RichEdit_TextLine
   ItemData.i        ; Set/GetGadgetItemData()所需
   LineText$         ; 行文本内容
   LineWidth.l       ; 行文本的宽度[加载时,评估大小,字节*加粗字体宽度,显示后,以实际宽度计]
   CountChars.w      ; 行文本字符数量[加载时,无视单双字节,显示后,以实际字节计]
   FoldFloor.a       ; 折叠区的层数
   FoldState.b       ; 折叠区的状态,
   HideState.b
   Keep.b[3]
   *pMemEditChar     ; [文本行]内存块(__RichEdit_EditChar)
EndStructure

; [编辑器]的非折叠行的文本行信息
Structure __RichEdit_EditLine
   LineIndex.l       ; [文本行]的索引号
   LastCursorX.w   ; 行尾的光标位置
   CurrCursorX.w   
   *pElement.__RichEdit_TextLine
EndStructure

; [可视区]的显示区信息[按像素计]
Structure __RichEdit_Gadget
   X.w   ; [编辑器]左际:<ResizeGadget>时刷新
   Y.w   ; [编辑器]右际:<ResizeGadget>时刷新 
   R.w   ; [编辑器]右际:<ResizeGadget>时刷新   
   B.w   ; [编辑器]下际:<ResizeGadget>时刷新     
   W.w   ; [编辑器]宽度:<ResizeGadget>时刷新  
   H.w   ; [编辑器]高度:<ResizeGadget>时刷新   
EndStructure

; [可视区]的显示区信息[按字符计]
Structure __RichEdit_Viewer
   X.w         ; [可视区|编辑域|像素]左际 
   Y.w         ; [可视区|编辑域|像素]上际:<SetGadgetFont>时刷新
   W.w         ; [可视区|编辑域|像素]宽度 
   H.w         ; [可视区|编辑域|像素]高度
;    LimitPos.l  ; [可视区|字符]用于快速锁定光标的位置   
   ;========================
   Row.l       ; [可视区|字符]上际  
   Col.w       ; [可视区|字符]左际 
   MarkW.w     ; [行符区|像素]宽度     
   HoldRows.w  ; [可视区|字符]容纳的行数  
   HoldCols.w  ; [可视区|字符]容纳的列数
   LastLine.l  ; [可视区|字符]的最后一行索引
;    LastChar.l  ; [可视区|字符]的最后一行索引
EndStructure

; [选择区]信息
Structure __RichEdit_FoldArea
   StartRow.l       
   ToEndRow.l 
   W.w         ; [折叠区|像素]宽度:<SetGadgetFont>时刷新  
   Size.a      ; [折叠区|像素]折叠符的大小
   Floor.a     ; [折叠区]折叠层数
EndStructure

; [选择区]信息
Structure __RichEdit_Record
   Row.l       ; 记录选区所处的行
   RealRow.l   ; 实际行行数(字符),即文本行行数
   RealCol.l   ; 实际列位置(字符)
   Col.w       ; 记录选区所处的列
   IsInFold.b  ; 是否包含在折叠区里面
   Keep.b 
EndStructure

;}

; 控件信息
Structure __RichEditInfo
   GadgetID.i        ; 控件ID
   hGadget.i         ; 控件句柄
   hBrushBack.i      ; 背景刷[背景图片]
   hGadgetFont.i     ; 当前的字体句柄
   CurrEvnetHook.i   ; 当前的HOOK事件标识
   PrevEvnetHook.i   ; 上一个的HOOK事件标识
   hMouseHook.i      ; 当前的字体句柄
   ;=================
   EditState.l  
   FormatType.l     ;
   DelayTime.l   
   AddLineWidth.l 
   FlagsWord$
   KeyWord$[#KeyWordCount]
   ;=================
   VScroll.__RichEdit_Scroll  ; [右侧滚动条]
   HScroll.__RichEdit_Scroll  ; [底部滚动条] 
   Cursor.__RichEdit_Cursor   ; [光标]信息
   Record.__RichEdit_Record   ; [选区]记录信息
   Gadget.__RichEdit_Gadget   ; [控件]外观信息
   Viewer.__RichEdit_Viewer   ; [可视区]信息
   Fold.__RichEdit_FoldArea   ; [折叠区]信息
   Font.__RichEdit_FontInfo   ; [控件]字符信息   
   Format.__RichEdit_Format[#Format_Count]   ; 控件格式
   *pMemViewChar                             ; [可视区]内存块(__RichEdit_ViewChar)
   *pMaxTextLine.__RichEdit_TextLine         ; 文本行中,最大的行宽的行指针
   List ListTextLine.__RichEdit_TextLine()   ; 记录全部的文本行
   List ListEditLine.__RichEdit_EditLine()   ; 记录非折叠的文本行信息
   
EndStructure

#RichEdit_EditCharSize = SizeOf(__RichEdit_EditChar)
#RichEdit_ViewCharSize = SizeOf(__RichEdit_ViewChar)      ; 结构的大小
#RichEdit_MaxLineChars = 1024    ;最大的行宽
#RichEdit_MaxShowLines = 300     ;每屏最大300行
#RichEdit_FullRowBytes = #RichEdit_MaxLineChars * #RichEdit_ViewCharSize 

Global *pCurrRichEdit.__RichEditInfo
Global *pPrevRichEdit.__RichEditInfo

;- =======================
; 获取极限值
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
; 设置控件的解析格式,默认有: 常规/PB/LUA/XML[未完成后两者]
Procedure RichEdit_SetFormatType(*pRichEdit.__RichEditInfo, FormatType=0)
   With *pRichEdit  
      \FormatType = FormatType
      Select FormatType
         Case #FormatType_Common  
            CopyMemory_(\Format, ?_Bin_FormatOfCommon, #Format_Count*SizeOf(__RichEdit_Format))
            \KeyWord$[#FoldStart] = ""  ; 折叠词[起始部分]
            \KeyWord$[#FoldToEnd] = ""  ; 折叠词[结束部分]
            \KeyWord$[#KeyWord01] = ""  ; 判断/选择/循环等结构
            \KeyWord$[#KeyWord02] = ""  ; 包含/定义
            \KeyWord$[#KeyWord03] = ""  ; 调试类/编译
            \KeyWord$[#KeyWord04] = ""  ; 预留给用户自行添加
            \KeyWord$[#KeyWord05] = ""  ; 预留给用户自行添加
            
         Case #FormatType_PB 

            \EditState | #EditState_FoldVisible
            CopyMemory_(\Format, ?_Bin_FormatOfPB, #Format_Count*SizeOf(__RichEdit_Format))
            ;折叠词[起始部分]
            \KeyWord$[#FoldStart] = " Enumeration Structure StructureUnion Procedure Procedure$ ProcedureDLL ProcedureCDLL Interface"
            \KeyWord$[#FoldStart] + " DeclareModule UseModule CompilerIf CompilerSelect"
            \KeyWord$[#FoldStart] + " Module Import ImportC Macro DataSection ;{ "
            
            ;折叠词[结束部分]
            \KeyWord$[#FoldToEnd] = " EndEnumeration EndStructure EndStructureUnion EndProcedure EndInterface"
            \KeyWord$[#FoldToEnd] + " EndDeclareModule UnuseModule CompilerEndIf CompilerEndSelect"
            \KeyWord$[#FoldToEnd] + " EndModule EndImport EndImportC EndMacro EndDataSection ;} "
            
            ;判断/选择/循环等结构
            \KeyWord$[#KeyWord01] = " If Else ElseIf EndIf Select Case Default EndSelect"      
            \KeyWord$[#KeyWord01] + " For To Step ForEach Next While Wend Repeat Until ForEver With EndWith"      
            \KeyWord$[#KeyWord01] + " ProcedureReturn Break Continue Gosub Return Swap Goto End Runtime Threaded "
            ;包含/定义
            \KeyWord$[#KeyWord02] = " IncludeFile XIncludeFile IncludeBinary IncludePath "      
            \KeyWord$[#KeyWord02] + " Declare DeclareC DeclareCDLL DeclareDLL"
            \KeyWord$[#KeyWord02] + " Global Define Protected Shared Static Prototype Pseudotype"
            \KeyWord$[#KeyWord02] + " Extends NewList List NewMap Map Dim ReDim Array Data Restore Read "
            ; 调试类/编译
            \KeyWord$[#KeyWord03] = " Debug DebugLevel DisableDebugger CallDebugger EnableDebugger"
            \KeyWord$[#KeyWord03] + " CompilerElse CompilerElseIf"
            \KeyWord$[#KeyWord03] + " CompilerCase CompilerWarning CompilerError"
            \KeyWord$[#KeyWord03] + " CompilerError EnableExplicit DisableExplicit EnableASM DisableASM "
            
         Case #FormatType_LUA  
            \EditState  | #EditState_FoldVisible
            CopyMemory_(\Format, ?_Bin_FormatOfLUA, #Format_Count*SizeOf(__RichEdit_Format))
            \KeyWord$[#FoldStart] = " --{ function if while for foreach repeat do "           ; 折叠词[起始部分]
            \KeyWord$[#FoldToEnd] = " --} end "           ; 折叠词[结束部分]
            \KeyWord$[#KeyWord01] = " then else elseif return in break "                      ; 判断/选择/循环等结构
            \KeyWord$[#KeyWord02] = " local type require setmetatable _index __newindex "     ; 包含/定义
            \KeyWord$[#KeyWord03] = " and or xor not "    ; 逻辑运算符
            \KeyWord$[#KeyWord04] = " nil true false "    ; 其它
            \KeyWord$[#KeyWord05] = ""                    ; 预留给用户自行添加
            
         Case #FormatType_XML    
            ;当前没有处理XML的代码,等引用者编写
            \EditState  | #EditState_FoldVisible
            CopyMemory_(\Format, ?_Bin_FormatOfCommon, #Format_Count*SizeOf(__RichEdit_Format))
            \KeyWord$[#FoldStart] = ""  ; 折叠词[起始部分]
            \KeyWord$[#FoldToEnd] = ""  ; 折叠词[结束部分]
            \KeyWord$[#KeyWord01] = ""  ; 判断/选择/循环等结构
            \KeyWord$[#KeyWord02] = ""  ; 包含/定义
            \KeyWord$[#KeyWord03] = ""  ; 调试类/编译
            \KeyWord$[#KeyWord04] = ""  ; 预留给用户自行添加
            \KeyWord$[#KeyWord05] = ""  ; 预留给用户自行添加
            
      EndSelect
   EndWith
EndProcedure

; 设置控件的解析格式 PB
Procedure RichEdit_ParserEditChar_Com(*pRichEdit.__RichEditInfo, Index)
   With *pRichEdit
      *pEditChar.__RichEdit_EditChar   ; 字符信息指针:标志每个字符的格式及字符分类
      *pFindChar.__RichEdit_EditChar   ; 字符信息指针
      *pTextLine.__RichEdit_TextLine   ; 文本行指针
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
               Case $41 To $5A               : CurrSymbol = #Symbol_Letter      ; 大写字母
               Case $61 To $7A               : CurrSymbol = #Symbol_Letter      ; 小写字母/下划线
               Case $30 To $39               : CurrSymbol = #Symbol_Number      ; 数字符号
               Case $25,$2B,$2D,$2F,$2A      : CurrSymbol = #Symbol_Operator    ; 运算符[%+-/*]
               Case $21,$26,$5E,$7C,$7E,$5F  : CurrSymbol = #Symbol_Operator    ; 运算符[!&^|~_]                  
               Case $3C To $3E               : CurrSymbol = #Symbol_Operator    ; 运算符[<=>]
               Case $2E                      : CurrSymbol = #Symbol_Define      ; 定义类[.]
               Case $09                      : CurrSymbol = #Symbol_TabChar     ; 
               Case $3F,$40,$22,$27,$23,$24  : CurrSymbol = #Symbol_Other       ; 其它[?@"'#$]
               Case $2C,$3A,$3B,$5C,$60      : CurrSymbol = #Symbol_Other       ; 其它[,:;\`]
               Case $28,$29,$5B,$5D,$7B,$7D  : CurrSymbol = #Symbol_Other       ; 其它[()[]{}]
               Case $20                      : CurrSymbol = #Symbol_Space    
               Default                       : CurrSymbol = #Symbol_Letter
            EndSelect
            ; ******************************
            ; 设置语词的样式
            ;============================== 注释内容
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
            *pTextLine\FoldState = #FoldState_Start   ; 折叠行开始处节点
            FoldFloor + 1 : CountFold + 1 : StartFold = #False
         ElseIf ToEndFold = #True And CountFold > 0
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #FoldState_ToEnd   ; 折叠行结束处节点
            CountFold - 1 : FoldFloor - 1 : ToEndFold = #False
         Else 
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #Null
         EndIf  
         *pTextLine = NextElement(*pRichEdit\ListTextLine())
         LineIndex+1
         If \pMaxTextLine And \pMaxTextLine\LineWidth < \ListTextLine()\LineWidth
            \pMaxTextLine = *pTextLine           ; 设置最大的文本行
         EndIf 
      Wend 
   EndWith
EndProcedure

; 设置控件的解析格式 LUA
Procedure RichEdit_ParserEditChar_PB(*pRichEdit.__RichEditInfo, Index)
   With *pRichEdit
      *pEditChar.__RichEdit_EditChar   ; 字符信息指针:标志每个字符的格式及字符分类
      *pFindChar.__RichEdit_EditChar   ; 字符信息指针
      *pTextLine.__RichEdit_TextLine   ; 文本行指针
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
               Case $41 To $5A               : CurrSymbol = #Symbol_Letter      ; 大写字母
               Case $61 To $7A               : CurrSymbol = #Symbol_Letter      ; 小写字母/下划线
               Case $30 To $39               : CurrSymbol = #Symbol_Number      ; 数字符号
               Case $25,$2B,$2D,$2F          : CurrSymbol = #Symbol_Operator    ; 运算符[%+-/]
               Case $21,$26,$5E,$7C,$7E      : CurrSymbol = #Symbol_Operator    ; 运算符[!&^|~]                  
               Case $3C To $3E               : CurrSymbol = #Symbol_Operator    ; 运算符[<=>]
               Case $2E                      : CurrSymbol = #Symbol_Define      ; 定义类[.]
               Case $09                      : CurrSymbol = #Symbol_TabChar     ; 
               Case $3F,$40,$22,$27          : CurrSymbol = #Symbol_Other       ; 其它[?@"']
               Case $2C,$3A,$3B,$5C,$60      : CurrSymbol = #Symbol_Other       ; 其它[,:;\`]
               Case $28,$29,$5B,$5D,$7B,$7D  : CurrSymbol = #Symbol_Other       ; 其它[()[]{}]
               Case $20                      : CurrSymbol = #Symbol_Space    
               Case $23                      : CurrSymbol = #Symbol_Special|#Symbol_Number   ; 特珠[#]
               Case $24                      : CurrSymbol = #Symbol_Other|#Symbol_String     ; 其它[$]
               Case $2A, $5F                 : CurrSymbol = #Symbol_Operator|#Symbol_String  ; 其它[*]
               Default                       : CurrSymbol = #Symbol_Letter
            EndSelect
            ; ******************************
            ; 设置语词的样式
            ;============================== 注释内容
            
            If CurrFormat = #Format_Comments  
            ElseIf CurrFormat = #Format_Special1 And CurrSymbol & #Symbol_String And CurrSymbol & #Symbol_Operator = 0
            ElseIf CurrFormat = #Format_Constant And CurrSymbol & #Symbol_String 
               If CurrSymbol & #Symbol_Special : NextFormat = #Format_ViewArea : EndIf     
            ElseIf CurrFormat = #Format_DQString                          
               If iCurrChar = '"' : NextFormat = #Format_ViewArea : EndIf                
            ElseIf CurrFormat = #Format_SQString 
               If CurrChar$ = "'" : NextFormat = #Format_ViewArea : EndIf 
            ;============================== ;设置NextFormat
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

               ; 如果找到函数名 
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
            *pTextLine\FoldState = #FoldState_Start   ; 折叠行开始处节点
            FoldFloor + 1 : CountFold + 1 : StartFold = #False
         ElseIf ToEndFold = #True And CountFold > 0
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #FoldState_ToEnd   ; 折叠行结束处节点
            CountFold - 1 : FoldFloor - 1 : ToEndFold = #False
         Else 
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #Null
         EndIf  
         *pTextLine = NextElement(*pRichEdit\ListTextLine())
         LineIndex+1
         If \pMaxTextLine And \pMaxTextLine\LineWidth < \ListTextLine()\LineWidth
            \pMaxTextLine = *pTextLine           ; 设置最大的文本行
         EndIf 
      Wend 
   EndWith
EndProcedure

; 设置控件的解析格式 XML
Procedure RichEdit_ParserEditChar_LUA(*pRichEdit.__RichEditInfo, Index)
   With *pRichEdit
      *pEditChar.__RichEdit_EditChar   ; 字符信息指针:标志每个字符的格式及字符分类
      *pFindChar.__RichEdit_EditChar   ; 字符信息指针
      *pTextLine.__RichEdit_TextLine   ; 文本行指针
      
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
               Case $41 To $5A               : CurrSymbol = #Symbol_Letter      ; 大写字母
               Case $61 To $7A               : CurrSymbol = #Symbol_Letter      ; 小写字母/下划线
               Case $30 To $39               : CurrSymbol = #Symbol_Number      ; 数字符号
               Case $25,$2B,$2F,$2A          : CurrSymbol = #Symbol_Operator    ; 运算符[%+-/*]
               Case $21,$26,$5E,$7C,$7E      : CurrSymbol = #Symbol_Logical     ; 运算符[!&^|]                  
               Case $3C To $3E               : CurrSymbol = #Symbol_Logical     ; 运算符[<=>]
               Case $2E                      : CurrSymbol = #Symbol_Define      ; 定义类[.]
               Case $09                      : CurrSymbol = #Symbol_TabChar     ; 
               Case $3F,$40,$22,$27,$24,$23  : CurrSymbol = #Symbol_Other       ; 其它[?@"'$#]
               Case $2C,$3A,$3B,$5C,$60      : CurrSymbol = #Symbol_Other       ; 其它[,:;\`]
               Case $28,$29,$7B,$7D          : CurrSymbol = #Symbol_Other       ; 其它[(){}]
               Case $20                      : CurrSymbol = #Symbol_Space    
               Case $5F                      : CurrSymbol = #Symbol_Other|#Symbol_Letter ; 其它[_]   
               Case $2D,$5B,$5D              : CurrSymbol = #Symbol_Special     ; 特珠[-[]]
               Default                       : CurrSymbol = #Symbol_Letter
            EndSelect
            ; ******************************
            ; 设置语词的样式
            ;============================== 注释内容
            
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

               ; 如果找到函数名 
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
            *pTextLine\FoldState = #FoldState_Start   ; 折叠行开始处节点
            FoldFloor + 1 : CountFold + 1 : StartFold = #False
         ElseIf ToEndFold = #True And CountFold > 0
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #FoldState_ToEnd   ; 折叠行结束处节点
            CountFold - 1 : FoldFloor - 1 : ToEndFold = #False
         Else 
            *pTextLine\FoldFloor = FoldFloor
            *pTextLine\FoldState = #Null
         EndIf  
         *pTextLine = NextElement(*pRichEdit\ListTextLine())
         LineIndex+1
         If \pMaxTextLine And \pMaxTextLine\LineWidth < \ListTextLine()\LineWidth
            \pMaxTextLine = *pTextLine           ; 设置最大的文本行
         EndIf 
      Wend 
   EndWith
EndProcedure

;- ***********************
; 解析全文本行字符格式/样式
Procedure RichEdit_ParserEditChar(*pRichEdit.__RichEditInfo, Index=0)
   With *pRichEdit
      Select \FormatType
         Case #FormatType_Common : RichEdit_ParserEditChar_Com(*pRichEdit, Index)
         Case #FormatType_PB     : RichEdit_ParserEditChar_PB (*pRichEdit, Index)
         Case #FormatType_LUA    : RichEdit_ParserEditChar_LUA(*pRichEdit, Index)
         Case #FormatType_XML    : RichEdit_ParserEditChar_Com(*pRichEdit, Index)  ;当前没有处理XML的代码,等引用者编写
      EndSelect
   EndWith
EndProcedure

; 解析[可视区]字符格式/样式/选中词
Procedure RichEdit_ParserViewChar(*pRichEdit.__RichEditInfo)
   With *pRichEdit
      CurrIndex = \Viewer\Row             ; 当前行,用于结束重新时,步进用 
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针                       
      *pViewChar.__RichEdit_ViewChar      ; [可视区|编辑行]内存的字符指针
      *pEditChar.__RichEdit_EditChar      ; [可视区|可视行]内存的字符指针 
      *pEditLine = SelectElement(\ListEditLine(), \Viewer\Row) ; 获取[可视区]的首行的指针
      While *pEditLine And CurrIndex <= \Viewer\LastLine
         *pViewLine = \pMemViewChar + ViewIndex * #RichEdit_FullRowBytes
         *pViewChar = *pViewLine
         SelectElement(\ListTextLine(), *pEditLine\LineIndex)
         *pEditChar = \ListTextLine()\pMemEditChar
         For k = 1 To *pEditLine\pElement\CountChars
            CurrChar$ = Mid(*pEditLine\pElement\LineText$, k, 1)
            *pViewChar\iBackColor = *pEditChar\Format    ; 从[文本行]复制字符格式到[可视行]
            *pViewChar\iFontColor = *pEditChar\Format
            *pViewChar\iFontStyle = *pEditChar\Format
            *pViewChar\CharSymbol = *pEditChar\Symbol    ; 从[文本行]复制字符标识到[可视行]
            *pEditChar + #RichEdit_EditCharSize          ; 步进[可视区|可视行]字符指针
            *pViewChar + #RichEdit_ViewCharSize          ; 步进[可视区|编辑行]字符指针       
         Next 
         ; 判断[文本行]是否有[选中词],如果有,把它标识出来
         If \FlagsWord$ <> #Null$
            LenWord = Len(\FlagsWord$)
            Pos = FindString(\ListTextLine()\LineText$, \FlagsWord$, Pos+1)   ; 搜索[选中词]
            While Pos                                                ; 建立一个循环来查找是否有[选中词]
               *pViewChar = *pViewLine+(Pos-2) * #RichEdit_ViewCharSize
               StartBool  = *pViewChar\CharSymbol & #Symbol_String   ; 判断搜索结果前一字符是否为文本标识
               *pViewChar = *pViewLine+(Pos+LenWord-1) * #RichEdit_ViewCharSize
               ToEndBool  = *pViewChar\CharSymbol & #Symbol_String   ; 判断搜索结果后一字符是否为文本标识
               If StartBool = #Null And ToEndBool = #Null           ; 如果搜索结果前后都不为文本标识,则视为合法[选中词]
                  For k = Pos To Pos+LenWord-1                      ; 历遍搜索结果,并把字符标识为[选中词]状态
                     *pViewChar = *pViewLine + (k-1) * #RichEdit_ViewCharSize
                     *pViewChar\iBackColor = #Format_TipWords        ; 标识字符为[选中词]状态
                  Next 
               EndIf
               Pos = FindString(\ListTextLine()\LineText$, \FlagsWord$, Pos+1) ;继续查找,直到查不到为止
            Wend   
         EndIf     
         CurrIndex + 1 : ViewIndex + 1                ; 步进行数
         *pEditLine = NextElement(\ListEditLine())    ; 步进[可视区|可视行]指针 
      Wend
   EndWith
EndProcedure

; 解析[折叠区]
Procedure RichEdit_ParserFoldArea(*pRichEdit.__RichEditInfo, RealFoldRow)
   With *pRichEdit
      *pTextLine.__RichEdit_TextLine                           ; [可视区|编辑行]内存的行指针         
      *pTextLine = SelectElement(\ListTextLine(), RealFoldRow) ; 选择[可视区|文本行]
      If *pTextLine = 0                                        ; 如果行不存在,退出
         \Fold\StartRow = 0 : \Fold\ToEndRow = 0 : \Fold\Floor = 0
         ProcedureReturn
      EndIf 
      ; 如果选中行存在[折叠域]或是[折叠域]开始行,则找出[折叠域]的开始行和结束行
      If *pTextLine\FoldFloor Or *pTextLine\FoldState & #FoldState_Start
         ; 查找[折叠域]的开始行
         If *pTextLine\FoldState & #FoldState_Start   ; 如果刚好[折叠域]开始行, FoldFloor+1
            FoldFloor = *pTextLine\FoldFloor+1
            StartRow  = RealFoldRow                   ; 标识开始行为当前行
         Else 
            FoldFloor = *pTextLine\FoldFloor          ; 如果选中行不是开始行,则查出开始行
            StartRow  = RealFoldRow
            While PreviousElement(\ListTextLine())    ; 向上步进[文本行],
               StartRow-1                             ; 行数递减
               If \ListTextLine()\FoldFloor = FoldFloor-1 And \ListTextLine()\FoldState & #FoldState_Start
                  Break
               EndIf 
            Wend
         EndIf 
         ; 查找[折叠域]的结束行
         SelectElement(\ListTextLine(), RealFoldRow)  ; 选择[可视区|文本行]
         If *pTextLine\FoldFloor = FoldFloor And *pTextLine\FoldState & #FoldState_ToEnd
            ToEndRow  = RealFoldRow                   ; 如果刚好是[折叠域]结束行, 标识结束行为当前行
         Else 
            ToEndRow  = RealFoldRow                   ; 标识结束行为当前行,然后边判断边递增,直到查找结束行为止
            While NextElement(\ListTextLine())
               If \ListTextLine()\FoldFloor < FoldFloor : Break : EndIf 
               ToEndRow+1                             ; 行数递增
            Wend
         EndIf 
         \Fold\Floor = FoldFloor                      ; 设置[折叠区]当前的层,用于绘制[折叠区]时采用
         If \Fold\StartRow <> StartRow : \Fold\StartRow = StartRow : IsRedraw=#True : EndIf 
         If \Fold\ToEndRow <> ToEndRow : \Fold\ToEndRow = ToEndRow : IsRedraw=#True : EndIf 
      Else                                            ; 选中行没有落在[折叠区]上时,清空三个参数
         \Fold\StartRow = 0 : \Fold\ToEndRow = 0 : \Fold\Floor = 0
      EndIf 
   EndWith 
   ProcedureReturn IsRedraw
EndProcedure

; 解析[编辑区]
Procedure RichEdit_ParserEditArea(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit 
      *pViewChar.__RichEdit_ViewChar                  ; [可视区|编辑行]内存的字符指针
      ;==========================                   
      ; 获取光标的落点行     
      CurrRow = (*pMouse\y-\Viewer\Y) /\Font\H        ; 获取当前[光标行]相对位置
      *pViewChar  = \pMemViewChar + CurrRow * #RichEdit_FullRowBytes
      CurrRow + \Viewer\Row                           ; 获取当前[光标行]具体位置
      ; 如果[编辑行]不存在,则退出[鼠标按住拖曳]时,会产生这种情况(越界)
      If CurrRow < 0 : ProcedureReturn #False : EndIf  
      *pElement = SelectElement(\ListEditLine(), CurrRow)
      ; 如果[编辑行]不存在,则退出[鼠标按住拖曳]时,会产生这种情况(越界)
      If *pElement = 0 : ProcedureReturn #False : EndIf  
      ;==========================                   
      ; 上下移屏事件
      If *pMouse\Y < \Viewer\Y And \Viewer\Row > 0
         \Viewer\Row - 1 : IsRedraw = #True  
      ElseIf *pMouse\Y > \Gadget\H-20 And \Viewer\Row < \Viewer\LastLine
         \Viewer\Row + 1 : IsRedraw = #True 
      EndIf       
      ;==========================  
      ; 左右移屏事件      
      RealRow    = \ListEditLine()\LineIndex                   ; 获取绝对行
      CountChars = (\ListEditLine()\pElement\LineWidth+\Font\W-1)/\Font\W  ; 评估行的字符数,
      ; 之所以不采用\pElement\CountChars,是为了防止文本行中采用到粗体字等非标准字体时及TAB,造成的行宽变化
      MaxChars   = CountChars-\Viewer\HoldCols                 ; 右拖曳时,最大的限度
      If CountChars < \Viewer\HoldCols : MaxChars = CountChars : EndIf 
      If *pMouse\X >= \Viewer\W  And \Viewer\Col < MaxChars
         \Viewer\Col+3 : IsRedraw = #True 
      ElseIf *pMouse\X <= \Viewer\X  And \Viewer\Col > 0
         \Viewer\Col-3 : IsRedraw = #True 
      EndIf 
      ;==========================
      ; 获取光标的落点列
      If *pMouse\X <= \Viewer\X  And \Viewer\Col <= 0          ; 如果已经是最左侧了,则设置落点列为0
         \Viewer\Col = 0                                       ; 此处代码,主要是为了防止当鼠标拖曳到最左侧时,光标出现在最右侧的BUG.
      Else 
         CurrCol = \ListEditLine()\pElement\CountChars         ; 默认光标的落点列在行的最右侧
         For k = 0 To \ListEditLine()\pElement\CountChars-1    ; 循环判断每个字符是否为光标落点处
            If *pViewChar\X <= *pMouse\X And *pMouse\X < *pViewChar\X+*pViewChar\W 
               CurrCol = k : Break                             ; 如果是,则退出.
            ElseIf *pViewChar\X =0 And *pViewChar\W = 0        ; 如果到了行的最右侧,则退出,这时,落点处为最右侧
                Break
            EndIf 
            *pViewChar+ #RichEdit_ViewCharSize                  ; 步进字符指针
         Next  
      EndIf 
      ;==========================
      ; 设置当前光标和[折叠域],并判断选区是否可视为选中词
      If \Cursor\Col <> CurrCol Or \Cursor\Row <> CurrRow
         \Cursor\Col = CurrCol : \Cursor\Row = CurrRow : \Cursor\RealRow = RealRow
         RichEdit_ParserFoldArea(*pRichEdit, RealRow)                            ; 处理[折叠域]信息
         ; 以下是选中词判断
         \FlagsWord$ = #Null$                                  
         If \Cursor\Row <> \Record\Row : ProcedureReturn #True : EndIf      ; 如果选区是多行,则退出
         *pViewChar.__RichEdit_ViewChar
         *pViewLine  = \pMemViewChar + (\Cursor\Row-\Viewer\Row) * #RichEdit_FullRowBytes
         ; 判断选区是否可视为[选中词],如果有,把它标识出来
         If \Cursor\Col < \Record\Col                                            ; 当选区列大于光标列的情况
            *pViewChar   = *pViewLine+(\Cursor\Col-1) * #RichEdit_ViewCharSize   ; 判断选区前一字符是否为文本标识
            If *pViewChar\CharSymbol & #Symbol_String : ProcedureReturn #True : EndIf 
            *pViewChar   = *pViewLine+(\Record\Col) * #RichEdit_ViewCharSize     ; 判断选区后一字符是否为文本标识
            If *pViewChar\CharSymbol & #Symbol_String : ProcedureReturn #True : EndIf 
            StartPos = \Cursor\Col : ToEndPos = \Record\Col                      ; 重置起始位置和结束位置,用于标识
         ElseIf \Cursor\Col > \Record\Col                                        ; 当选区列小于光标列的情况
            *pViewChar   = *pViewLine+(\Record\Col-1) * #RichEdit_ViewCharSize   ; 判断选区前一字符是否为文本标识
            If *pViewChar\CharSymbol & #Symbol_String : ProcedureReturn #True : EndIf 
            *pViewChar   = *pViewLine+(\Cursor\Col) * #RichEdit_ViewCharSize     ; 判断选区后一字符是否为文本标识
            If *pViewChar\CharSymbol & #Symbol_String : ProcedureReturn #True : EndIf 
            StartPos=\Record\Col : ToEndPos=\Cursor\Col                          ; 重置起始位置和结束位置,用于标识
         Else                                                                    ; 如果不存在选区,则退出
            ProcedureReturn #True
         EndIf 
         *pViewChar = *pViewLine + StartPos * #RichEdit_ViewCharSize             ; 获取[选中词]起始处提字符指针
         For k = StartPos To ToEndPos-1                                          ; 循环[选中词]的每个字符
            ; 如何[选区]出现非文本字符,则退出 
            If *pViewChar\CharSymbol & #Symbol_String : Else : ProcedureReturn #True : EndIf    
            *pViewChar + #RichEdit_ViewCharSize                                  ; 步进字符指针
         Next 
         ; 设置[选中词]
         \FlagsWord$ = Mid(\ListEditLine()\pElement\LineText$, StartPos+1, ToEndPos-StartPos)    
      EndIf 
   EndWith 
   ProcedureReturn IsRedraw
EndProcedure


;- =======================
; 注销控件
Procedure RichEdit_FreeGadget(*pRichEdit.__RichEditInfo, hGadget)
   With *pRichEdit
      If *pRichEdit
         DestroyCursor_(\Cursor\hRMARK)    ; 注销[反式箭头光标]
         DestroyCursor_(\Cursor\hARROW)    ; 注销[常规箭头光标]
         DestroyCursor_(\Cursor\hIBEAM)    ; 注销[输入状态光标]
         DestroyCaret_()                   ; 注销[文本提示符光标]
         If \hBrushBack : DeleteObject_(\hBrushBack) : EndIf   ; 注销[背景刷]
         For k = 0 To 3 : FreeFont(\Font\ID[k]) : Next         ; 释放字体
         ForEach \ListTextLine()                               ; 循环[文本行],释放每个文本行的内存
            FreeMemory(\ListTextLine()\pMemEditChar)
         Next 
         FreeMemory(*pRichEdit\pMemViewChar)          ; 释放[可视区]的内存
         FreeList(*pRichEdit\ListTextLine())          ; 释放[编辑行]的链表
         FreeList(*pRichEdit\ListEditLine())          ; 释放[文本行]的链表
         FreeStructure(*pRichEdit)                    ; 释放控件信息结构
         RemoveProp_(hGadget, #GadgetClass_RichEdit$) ; 删除控件信息记录
         DestroyWindow_(hGadget)                      ; 释放整个控件
      EndIf 
   EndWith 
EndProcedure

; 设置字体
Procedure RichEdit_SetGadgetFont(*pRichEdit.__RichEditInfo)
   With *pRichEdit\Font
      For k = 0 To 3
         If IsFont(\ID[k]) : FreeFont(\ID[k]) : EndIf    
      Next 
      \ID[0] = LoadFont(#PB_Any, \Name$, \Size)                   ; 创建常规字体
      \ID[1] = LoadFont(#PB_Any, \Name$, \Size, #PB_Font_Bold)    ; 创建加粗字体
      \ID[2] = LoadFont(#PB_Any, \Name$, \Size, #PB_Font_Italic)  ; 创建斜体字体
      \ID[3] = LoadFont(#PB_Any, \Name$, \Size, #PB_Font_Bold|#PB_Font_Italic) ; 创建粗体|斜体字体
      ;获取设备中字体的设置
      hDC = GetDC_(hGadget)
      hObject = SelectObject_(hDC, FontID(\ID[0]))
      GetTextExtentPoint32_(hDC, @"99999", 5, FontStyle.SIZE)
      \W = FontStyle\cx/5        ; 获取常规字体宽度
      \H = FontStyle\cy          ; 获取常规字体高度
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

; <调整控件大小>
Procedure RichEdit_ResizeGadget(*pRichEdit.__RichEditInfo, X, Y, Width, Height)
   ;获取控件信息
   With *pRichEdit
      If X = #PB_Ignore      : X = GadgetX(\GadgetID) : EndIf 
      If Y = #PB_Ignore      : Y = GadgetY(\GadgetID) : EndIf 
      If Width  = #PB_Ignore : W = GadgetWidth (\GadgetID) : EndIf 
      If Height = #PB_Ignore : H = GadgetHeight(\GadgetID) : EndIf 
      MoveWindow_(\hGadget, X, Y, Width, Height, #True)
      ; [编辑器]四际
      \Gadget\X = X : \Gadget\W = Width  : \Gadget\R = X+Width
      \Gadget\Y = Y : \Gadget\H = Height : \Gadget\B = Y+Height
      ;========================
      KillTimer_(\hGadget, #Timer_Refresh_Flags) 
      SetTimer_ (\hGadget, #Timer_Refresh_Flags, #Timer_Refresh_Timer, #Null)
   EndWith
EndProcedure

;- ***********************
; 绘制[行符区|折叠区]
Procedure RichEdit_RedrawMarkArea (*pRichEdit.__RichEditInfo)   
   With *pRichEdit
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针   
      DrawingFont(FontID(\Font\ID[0])) 
      ; 绘制[行符区]
      Box(000, 000, \Viewer\MarkW, \Gadget\H, \Format[#Format_MarkArea]\BackColor)   ; [行符区]背景色
      MaxChar   = Len(Str(\ListEditLine()\LineIndex))                   ; 计算行符的字节数      
      *pEditLine = SelectElement(\ListEditLine(), \Viewer\Row)          ; [可视区]首行
      CurrIndex = \Viewer\Row             ; 设置绘制区的起始行行数,当大于结束行时,结否绘制
      CurrLineY = \Viewer\Y               ; 设置绘制区的起始行坐标,用于步进
      While *pEditLine And CurrIndex <= \Viewer\LastLine               ; 循环绘制行的[编辑行]
         LineIndex$ = RSet(Str(*pEditLine\LineIndex+1), MaxChar, " ")   ; 行符进行格式化处理
         DrawText(04, CurrLineY, LineIndex$, \Format[#Format_MarkArea]\FontColor, \Format[#Format_MarkArea]\BackColor)
         CurrLineY + \Font\H : CurrIndex+1                              ; 步进行数和行坐标
         *pEditLine = NextElement(\ListEditLine())                      ; 跳转到下一个[编辑行]
      Wend
      ;======================= 
;       If \EditState & #EditState_FoldVisible = 0 : ProcedureReturn : EndIf 
      ; 绘制[折叠区]
      Box(\Viewer\MarkW, 000, \Fold\W, \Gadget\H, \Format[#Format_MarkArea]\BackColor)  ;[折叠区]背景色    
      *pEditLine = SelectElement(\ListEditLine(), \Viewer\Row)           ; [可视区]首行
      CurrIndex = \Viewer\Row             ; 设置绘制区的起始行行数,当大于结束行时,结否绘制
      CurrLineY = \Viewer\Y               ; 设置绘制区的起始行坐标,用于步进
      CurrCaseX = \Viewer\MarkW           ; [折叠区]"田"字符的左际
      CurrLineX = CurrCaseX+\Fold\Size/2  ; [折叠区]"|"字符的左际
      CenterPos = (\Font\H-\Fold\Size)/2  ; [折叠区]的居中位置
      While *pEditLine And CurrIndex <= \Viewer\LastLine               ; 循环绘制行的[编辑行]
         BoolIndex = Bool(*pEditLine\LineIndex >= \Fold\StartRow And *pEditLine\LineIndex<= \Fold\ToEndRow)
         If \Fold\Floor > 0 And BoolIndex                              ; 如果光标行处理[折叠区]
            FontColor = \Format[#Format_CaretRow]\FontColor             ; 采用高亮颜色
         Else   
            FontColor = \Format[#Format_MarkArea]\FontColor             ;采用默认颜色
         EndIf 
         If *pEditLine\pElement\FoldState & #FoldState_Start            ; 折叠行开始处节点
            ;=======================
            ; 折叠起始行
            CurrCaseY = CurrLineY + CenterPos
            If \Fold\Size < 9                                           ; 如果尺寸太小,转换成点和线段
               If *pEditLine\pElement\FoldState & #FoldState_Closed     ; 折叠区闭合时,为点,否则为线段
                  Circle(CurrLineX, CurrCaseY+\Fold\Size/2, \Fold\Size/2, FontColor)
               Else 
                  Box(CurrCaseX, CurrCaseY+\Fold\Size/2, \Fold\Size, 02, FontColor)
               EndIf 
            Else 
               DrawingMode(#PB_2DDrawing_Outlined)                      ; 画出方框       
               Box(CurrCaseX, CurrCaseY, \Fold\Size, \Fold\Size, FontColor)
               DrawingMode(#PB_2DDrawing_Default)
               If \Fold\Size < 13 : W = 2 : Else : W = 3 : EndIf
               Line(CurrCaseX+W, CurrCaseY+\Fold\Size/2, \Fold\Size-W*2, 01, FontColor)
               If *pEditLine\pElement\FoldState & #FoldState_Closed     ; 折叠区闭合时+否则为-
                  Line(CurrCaseX+\Fold\Size/2, CurrCaseY+W, 01, \Fold\Size-W*2, FontColor)
               EndIf
               ; 要画出上际线: 这里的逻辑判断有难度 
               If *pEditLine\pElement\FoldFloor And *pEditLine\pElement\FoldFloor+1 = \Fold\Floor 
                  Line(CurrLineX, CurrLineY, 1, CenterPos, \Format[#Format_MarkArea]\FontColor)
               ElseIf *pEditLine\pElement\FoldFloor 
                  Line(CurrLineX, CurrLineY, 1, CenterPos, FontColor)
               EndIf 
               ; 要画出下际线: 这里的逻辑判断有难度 
               If *pEditLine\pElement\FoldFloor Or *pEditLine\pElement\FoldState & #FoldState_Closed = 0  
                  If *pEditLine\pElement\FoldFloor+1 = \Fold\Floor And *pEditLine\pElement\FoldState & #FoldState_Closed
                     Line(CurrLineX, CurrCaseY+\Fold\Size, 1, CenterPos+1, \Format[#Format_MarkArea]\FontColor)
                  Else 
                     Line(CurrLineX, CurrCaseY+\Fold\Size, 1, CenterPos+1, FontColor)
                  EndIf 
               EndIf    
            EndIf
         ;=======================     
         ; 折叠结束行
         ElseIf *pEditLine\pElement\FoldState & #FoldState_ToEnd   ; 折叠行结束处节点
            Line(CurrLineX, CurrLineY, 01, \Font\H/2, FontColor)
            ; 如果是子级结束行,要画出下际线: 这里的逻辑判断有难度 
            If *pEditLine\pElement\FoldFloor > 1 And *pEditLine\pElement\FoldFloor <= \Fold\Floor 
               Line(CurrLineX, CurrLineY+\Font\H/2, 01, \Font\H/2, \Format[#Format_MarkArea]\FontColor)
            ElseIf *pEditLine\pElement\FoldFloor > 1               ; 如果是子级结束行,要画出下际线
               Line(CurrLineX, CurrLineY+\Font\H/2, 01, \Font\H/2, FontColor)
            EndIf 
            Line(CurrLineX, CurrLineY+\Font\H/2, \Fold\Size/2+1, 01, FontColor)
         ;======================= 
         ; 折叠中间行
         ElseIf *pEditLine\pElement\FoldFloor > 0 
            Line(CurrLineX, CurrLineY, 01, \Font\H, FontColor)
         EndIf 
         CurrLineY + \Font\H : CurrIndex+1         ; 步进行数和行坐标
         *pEditLine = NextElement(\ListEditLine()) ; 跳转到下一个[编辑行]
      Wend
   EndWith
EndProcedure

; 重绘[选区]
Procedure RichEdit_RedrawSelected(*pRichEdit.__RichEditInfo, *pViewChar.__RichEdit_ViewChar, CurrIndex, Index)
   With *pRichEdit
      If \Cursor\RealRow = CurrIndex And *pViewChar\iBackColor <> #Format_TipWords
         *pViewChar\iBackColor = #Format_CaretRow        ; 如果是提示符行,则采用提示符行的底色
      EndIf 
      
      ;如果选区不存在,直接无视.
      If \Record\RealRow = \Cursor\RealRow And \Record\Col = \Cursor\Col ;没有选区
      ;[起始点=结束点]如果选区起始行就是当前行,结束行也是当前行,相当于中段被选状态
      ElseIf \Record\RealRow = CurrIndex And \Cursor\RealRow = CurrIndex 
         If \Record\Col < \Cursor\Col And \Record\Col+1 <= Index And Index < \Cursor\Col+1
            *pViewChar\iFontColor = #Format_Selected
            *pViewChar\iBackColor = #Format_Selected
         ElseIf \Record\Col > \Cursor\Col And \Record\Col+1 > Index And Index >= \Cursor\Col+1
            *pViewChar\iFontColor = #Format_Selected
            *pViewChar\iBackColor = #Format_Selected
         EndIf 
      ;[起始点<结束点]如果选区起始行小于当前行,结束行就是当前行,相当于前端被选状态
      ElseIf \Record\RealRow < CurrIndex And \Cursor\RealRow = CurrIndex And Index < \Cursor\Col+1
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected
      ;[起始点<结束点]如果选区起始行小于当前行,结束行就是当前行,相当于后端被选状态
      ElseIf \Record\RealRow = CurrIndex And \Cursor\RealRow > CurrIndex And Index >= \Record\Col+1
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected 
         IsAddEnter = #True
      ;[起始点<结束点]如果选区起始行小于当前行,结束行大于当前行,相当于全行被选状态
      ElseIf \Record\RealRow < CurrIndex And \Cursor\RealRow > CurrIndex
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected
         IsAddEnter = #True
      ;[起始点<结束点]如果选区起始行就当前行,结束行小于当前行,相当于前端被选状态
      ElseIf \Record\RealRow = CurrIndex And \Cursor\RealRow < CurrIndex And Index < \Record\Col+1
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected
      ;[起始点>结束点]如果选区起始行就是当前行,结束行小于当前行,相当于后端被选状态
      ElseIf \Record\RealRow > CurrIndex And \Cursor\RealRow = CurrIndex And Index >= \Cursor\Col+1
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected
         IsAddEnter = #True
      ;[起始点>结束点]如果选区起始行小于当前行,结束行大于当前行,相当于全行被选状态
      ElseIf \Record\RealRow > CurrIndex And \Cursor\RealRow < CurrIndex
         *pViewChar\iFontColor = #Format_Selected
         *pViewChar\iBackColor = #Format_Selected
         IsAddEnter = #True
      EndIf
   EndWith
   ProcedureReturn IsAddEnter
EndProcedure

; 绘制[可视区]
Procedure RichEdit_RedrawViewArea (*pRichEdit.__RichEditInfo)   
   With *pRichEdit
      Box(\Viewer\X-4, 000, \Gadget\W, \Gadget\H, \Format[#Format_ViewArea]\BackColor)  ;[可视区]背景色 
      RichEdit_ParserViewChar(*pRichEdit)                      ; 刷新[可视区]内存
      CurrIndex = \Viewer\Row                                  ; 当前行,用于结束重新时,步进用             
      CurrLineY = \Viewer\Y                                    ; 字符绘制的Y坐标,步进用
      *pEditLine.__RichEdit_EditLine                           ; [可视区|编辑行]内存的行指针
      *pViewChar.__RichEdit_ViewChar                           ; [可视区|可视行]内存的字符指针 
      *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row) ; [可视区]首行
      If \Cursor\IsInFold = #False
         HightLightY = CurrLineY + (\Cursor\Row-\Viewer\Row) * \Font\H    ; 当前高亮行
         If HightLightY > 0 And HightLightY < \Gadget\H-21-\Font\H
            Box(\Viewer\X-4, HightLightY, \Viewer\W+4, \Font\H, \Format[#Format_CaretRow]\BackColor) 
         EndIf 
      EndIf 
      *pEditLine = SelectElement(\ListEditLine(), \Viewer\Row)    ; [可视区]首行
      ;=======================
      DrawingFont(FontID(\Font\ID[FontIndex]))                    ; 启用默认字符
      ClipOutput(\Viewer\X, CurrLineY, \Viewer\W, \Viewer\H)      ; [编辑区]绘制的范围
      While *pEditLine And CurrIndex <= \Viewer\LastLine
         If Left(*pEditLine\pElement\LineText$, 25) = "; IDE Options = PureBasic"
            Break
         EndIf 
      
         *pViewChar = \pMemViewChar + ViewIndex * #RichEdit_FullRowBytes   ;[可视行]内存的字符指针  
         CurrCharX = \Viewer\X-\Viewer\Col * \Font\W              ; 设置字符的左际
    
         CountWidth = 0
         IsAddEnter = #False
         ; 绘制字符前的判断动作
         If *pEditLine\pElement\CountChars = 0                    ; 如果没有字节存在,填充文本行信息
            FillMemory(*pViewChar, #RichEdit_FullRowBytes)
            ;如果选区不存在,直接无视.
            If \Cursor\RealRow < *pEditLine\LineIndex And *pEditLine\LineIndex < \Record\RealRow
               IsAddEnter = #True                                 ; 补偿回车键
            ElseIf \Cursor\RealRow > *pEditLine\LineIndex And *pEditLine\LineIndex > \Record\RealRow
               IsAddEnter = #True                                 ; 补偿回车键
            EndIf
         Else 
            For k = 1 To *pEditLine\pElement\CountChars           ; 循环字符
               IsAddEnter = RichEdit_RedrawSelected(*pRichEdit, *pViewChar, *pEditLine\LineIndex, K)
               CurrChar$ = Mid(*pEditLine\pElement\LineText$,k,1) ; 依次截取单个字符            
               FontStyle = \Format[*pViewChar\iFontStyle]\FontStyle
               If FontIndex <> FontStyle                          ; 如现字体出现变化,则启用
                  FontIndex = FontStyle : DrawingFont(FontID(\Font\ID[FontIndex]))
                  FontIndex = FontStyle : DrawingFont(FontID(\Font\ID[FontIndex]))
               EndIf 
               If *pViewChar\CharSymbol = #Symbol_TabChar         ; 如果出现TAB,则对字符进行强制对齐
                  NewCountWidth = CountWidth/\Font\TapWith * \Font\TapWith + \Font\TapWith
                  *pViewChar\W = NewCountWidth-CountWidth         ; 设置字符的对齐宽度
                  BackColor = \Format[*pViewChar\iBackColor]\BackColor
                  Box(CurrCharX, CurrLineY, *pViewChar\W, \Font\H, BackColor)
               Else
                  If CurrChar$ = " "
                     *pViewChar\W = \Font\W                       ; 如果是空格,强制使用默认字体的宽度
                  Else 
                     *pViewChar\W = TextWidth(CurrChar$)          ; 设置字符的宽度
                  EndIf     
                  If CurrCharX+\Font\W >= \Viewer\X And CurrCharX <= \Viewer\W+\Viewer\X
                     FontColor = \Format[*pViewChar\iFontColor]\FontColor
                     BackColor = \Format[*pViewChar\iBackColor]\BackColor
                     DrawText(CurrCharX, CurrLineY, CurrChar$, FontColor, BackColor)
                  EndIf 
               EndIf 
               *pViewChar\X = CurrCharX
               CountWidth + *pViewChar\W                          ; 统计行的最大宽度
               CurrCharX  + *pViewChar\W                          ; 步进字符左际
               *pViewChar + #RichEdit_ViewCharSize                ; 指向下一字符的信息
               If \Cursor\RealRow = *pEditLine\LineIndex And k = \Cursor\Col+1
                  \Cursor\RealCol = CountWidth /\Font\W           ; 计算实际列的列数
               EndIf    
               If \Record\RealRow = *pEditLine\LineIndex And k = \Record\Col+1
                  \Record\RealCol = CountWidth /\Font\W           ; 计算实际列的列数
               EndIf           
            Next
            *pViewChar\X = CurrCharX
            *pViewChar\W = 0
            *pViewChar + #RichEdit_ViewCharSize                ; 指向下一字符的信息
            FillSize = #RichEdit_FullRowBytes - (*pEditLine\pElement\CountChars+1) * #RichEdit_ViewCharSize
            FillMemory(*pViewChar, FillSize)

         EndIf 
         If CurrCharX+\Font\W >= \Viewer\X And CurrCharX <= \Viewer\W+\Viewer\X        
            If IsAddEnter = #True                                 ; 补偿回车键
               If FontIndex <> 0 : FontIndex = 0 : DrawingFont(FontID(\Font\ID[0])) : EndIf 
               FontColor = \Format[#Format_Selected]\FontColor
               BackColor = \Format[#Format_Selected]\BackColor
               DrawText(CurrCharX, CurrLineY, " ", FontColor, BackColor)
            EndIf  
         EndIf 
         *pEditLine\LastCursorX = CurrCharX
         CurrLineY + \Font\H : CurrIndex+1 : ViewIndex+1          ; 步进行
         *pEditLine\pElement\LineWidth = CountWidth
         *pEditLine = NextElement(\ListEditLine())                ; 指向下一[编辑行]
      Wend
      UnclipOutput()                                              ; 取消绘制区限制
   EndWith
EndProcedure

; 绘制[滚动条]
Procedure RichEdit_RedrawScrollBar(*pRichEdit.__RichEditInfo)  
   With *pRichEdit
      W = \Gadget\W : H = \Gadget\H
      FontColor = \Format[#Format_NScroll]\FontColor
      BackColor = \Format[#Format_NScroll]\BackColor
      NFontColor = \Format[#Format_NScroll]\FontColor  ;正常状态
      NBackColor = \Format[#Format_NScroll]\BackColor
      MFontColor = \Format[#Format_MScroll]\FontColor  ;鼠标在上
      MBackColor = \Format[#Format_MScroll]\BackColor
      DFontColor = \Format[#Format_DScroll]\FontColor  ;左键按键
      DBackColor = \Format[#Format_DScroll]\BackColor
      ;计算插值颜色
      NFaceColor = RGB(Red(NFontColor)*0.5, Green(NFontColor)*0.5, Blue(NFontColor)*0.5)   
      MFaceColor = RGB(Red(MFontColor)*0.5, Green(MFontColor)*0.5, Blue(MFontColor)*0.5)   
      DFaceColor = RGB(Red(DFontColor)*0.5, Green(DFontColor)*0.5, Blue(DFontColor)*0.5)   
      ;********** ********** ********** ********** ********** **********
      ; 获取垂直滚动条参数
      CountLines = ListSize(\ListEditLine())
      If CountLines <= \Viewer\HoldRows
         \VScroll\VaneSize  = H-57        ; 计算[滑片]的大小
         \VScroll\VanePos   = 0           ; 重置[滑片]的位置
         \VScroll\VaneLast  = 0           ; 重置[滑片]的最终位置
         \VScroll\SetpScale = 1           ; 重置[滑片]的步进值
      Else
         HideLines = CountLines-\Viewer\HoldRows
         VaneSize  = H-58-HideLines * \Font\H         ; 计算[滑片]的大小
         If VaneSize <= 22 : VaneSize = 22 : EndIf 
         SetpScale.f = (H-58-VaneSize) / HideLines
         If \Viewer\Row >= HideLines 
            \Viewer\Row = HideLines 
            VanePos = H-57-VaneSize                   ; 计算[滑片]的位置
         Else
            VanePos = \Viewer\Row * SetpScale         ; 计算[滑片]的位置
         EndIf 
         \VScroll\VaneSize  = VaneSize    ; 设置[滑片]的大小
         \VScroll\VanePos   = VanePos     ; 设置[滑片]的位置
         \VScroll\VaneLast  = HideLines   ; 设置[滑片]的最终位置
         \VScroll\SetpScale = SetpScale   ; 设置[滑片]的步进值
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
      LinearGradient(W-30,0,W-17,0) : Box(W-20,1,19,19)     ; 上际按键[背景]
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(W-25,0,W+80,0) : Box(W-17,4,6,13)      ; 上际按键[底图左侧]
      LinearGradient(W-35,0,W+60,0) : Box(W-11,4,7,13)      ; 上际按键[底图右侧]  
      BackColor(FaceColor) : FrontColor(BackColor) : LinearGradient(W-23,0,W,0)
      For k=1 To 5 : LineXY(W-10-k,7+k,W-12+k,7+k) : Next  ; 上际按键[小箭头]
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(W-19,02,17,17,1,1,FontColor)                 ; 上际按键[外边框]
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
      LinearGradient(W-30,0,W-17,0) : Box(W-20,H-39,19,19)           ; 下际按键[背景]
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(W-25,0,W+80,0) : Box(W-17,H-36,6,13)            ; 下际按键[底图左侧]
      LinearGradient(W-35,0,W+60,0) : Box(W-11,H-36,7,13)            ; 下际按键[底图右侧]   
      BackColor(FaceColor) : FrontColor(BackColor) : LinearGradient(W-23,0,W,0)
      For k = 1 To 5 : LineXY(W-10-k,H-27-k,W-12+k,H-27-k) : Next   ; 下际按键[小箭头]
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(W-19,H-38,17,17,1,1,FontColor)                        ; 下际按键[外边框]
      ;========== ========== ========== ========== ========== ==========
      DrawingMode(#PB_2DDrawing_Gradient)
      If \CurrEvnetHook  = #Event_VScrollW_OnTop
         BackColor(MFontColor) : FrontColor(MBackColor) 
      ElseIf \CurrEvnetHook  = #Event_VScrollW_LDown
         BackColor(DFontColor) : FrontColor(DBackColor) 
      Else 
         BackColor(NFontColor) : FrontColor(NBackColor) 
      EndIf
      LinearGradient(W-30,0,W-17,0) : Box(W-20,20,19,VY)             ; 上移按键[背景]  
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_VScrollS_OnTop
         BackColor(MFontColor) : FrontColor(MBackColor) 
      ElseIf \CurrEvnetHook  = #Event_VScrollS_LDown
         BackColor(DFontColor) : FrontColor(DBackColor) 
      Else 
         BackColor(NFontColor) : FrontColor(NBackColor) 
      EndIf
      LinearGradient(W-30,0,W-17,0) : Box(W-20,19+VB,19,H-58-VB)     ; 下移按键[背景]   
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_VScrollM_OnTop
         FontColor = MFontColor : BackColor = MBackColor : FaceColor = MFaceColor
      ElseIf \CurrEvnetHook  = #Event_VScrollM_LDown
         FontColor = DFontColor : BackColor = DBackColor : FaceColor = DFaceColor
      Else 
         FontColor = NFontColor : BackColor = NBackColor : FaceColor = NFaceColor
      EndIf
      BackColor(FontColor)          : FrontColor(BackColor) 
      LinearGradient(W-30,0,W-17,0) : Box(W-20,19+VY,19,VH)          ; 滑片按键[背景]   
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(W-25,0,W+80,0) : Box(W-17,22+VY,6,VH-6)         ; 滑片按键[底图左侧]
      LinearGradient(W-35,0,W+60,0) : Box(W-11,22+VY,7,VH-6)         ; 滑片按键[底图右侧]
      BackColor(FaceColor)          : FrontColor(BackColor) 
      LinearGradient(W-23,0,W,0)    : LineXY(W-14,18+VM,W-9,18+VM)   ; 滑片按键[三道杠]
      LineXY(W-14,15+VM,W-09,15+VM) : LineXY(W-14,21+VM,W-9,21+VM)   ; 滑片按键[三道杠] 
      LinearGradient(W-63,0,W,0)    : LineXY(W-14,19+VM,W-9,19+VM)   ; 滑片按键[三道杠阴影] 
      LineXY(W-14,16+VM,W-09,16+VM) : LineXY(W-14,22+VM,W-9,22+VM)   ; 滑片按键[三道杠阴影]  
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(W-19,20+VY,17,VH-2,1,1,FontColor)                     ; 滑片按键[外边框] 
      ;********** ********** ********** ********** ********** **********
      CountWidth = \pMaxTextLine\LineWidth+\AddLineWidth+\Font\W
      If CountWidth <= \Viewer\W
         \HScroll\VaneSize  = W-57        ; 计算[滑片]的大小
         \HScroll\VanePos   = 0           ; 重置[滑片]的位置
         \HScroll\VaneLast  = 0           ; 重置[滑片]的最终位置
         \HScroll\SetpScale = 1           ; 重置[滑片]的步进值
      Else
         HideWith = CountWidth-\Viewer\W
         HideChar = HideWith / \Font\W + 1         ;折算成字符数
         VaneSize  = W-58-HideWith                 ; 计算[滑片]的大小
         If VaneSize <= 22 : VaneSize = 22 : EndIf 
         SetpScale.f = (W-58-VaneSize)/HideChar    ; 计算[滑片]的位置
         If \Viewer\Col * \Font\W >= HideWith - 1
            \Viewer\Col = HideChar 
            VanePos = W-57-VaneSize                ; 计算[滑片]的位置
         Else
            VanePos = \Viewer\Col * SetpScale      ; 计算[滑片]的位置
         EndIf 
         \HScroll\VaneSize  = VaneSize    ; 设置[滑片]的大小
         \HScroll\VanePos   = VanePos     ; 设置[滑片]的位置
         \HScroll\VaneLast  = HideChar    ; 设置[滑片]的最终位置
         \HScroll\SetpScale = SetpScale   ; 设置[滑片]的步进值
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
      LinearGradient(0,H-30,0,H-17) : Box(01,H-20,19,19)             ; 左际按键[背景]
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(0,H-25,0,H+80) : Box(04,H-17,13,6)              ; 左际按键[底图上侧]
      LinearGradient(0,H-35,0,H+60) : Box(04,H-11,13,7)              ; 左际按键[底图下侧]  
      BackColor(FaceColor) : FrontColor(BackColor) : LinearGradient(0,H-23,0,H)
      For k = 1 To 5 : LineXY(7+k,H-10-k,07+k,H-12+k) : Next        ; 左际按键[小箭头]
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(02,H-19,17,17,1,1,FontColor)                          ; 左际按键[外边框]
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
      LinearGradient(0,H-30,0,H-17) : Box(W-39,H-20,19,19)          ; 右际按键[背景]
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(0,H-25,0,H+80) : Box(W-36,H-17,13,6)           ; 右际按键[底图上侧]
      LinearGradient(0,H-35,0,H+60) : Box(W-36,H-11,13,7)           ; 右际按键[底图下侧]  
      BackColor(FaceColor) : FrontColor(BackColor) : LinearGradient(0,H-23,0,H)
      For k = 1 To 5 : LineXY(W-27-k,H-10-k,W-27-k,H-12+k) : Next  ; 右际按键[小箭头]
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(W-38,H-19,17,17,1,1,FontColor)                       ; 右际按键[外边框]
      ;========== ========== ========== ========== ========== ==========      
      DrawingMode(#PB_2DDrawing_Gradient)
      If \CurrEvnetHook  = #Event_HScrollA_OnTop
         BackColor(MFontColor) : FrontColor(MBackColor)
      ElseIf \CurrEvnetHook  = #Event_HScrollA_LDown
         BackColor(DFontColor) : FrontColor(DBackColor) 
      Else 
         BackColor(NFontColor) : FrontColor(NBackColor) 
      EndIf
      LinearGradient(0,H-30,0,H-17) : Box(20,H-20,HX,19)             ; 左移按键[背景]   
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_HScrollD_OnTop
         BackColor(MFontColor) : FrontColor(MBackColor) 
      ElseIf \CurrEvnetHook  = #Event_HScrollD_LDown
         BackColor(DFontColor) : FrontColor(DBackColor) 
      Else 
         BackColor(NFontColor) : FrontColor(NBackColor) 
      EndIf
      LinearGradient(0,H-30,0,H-17) : Box(19+HR,H-20,W-58-HR,19)     ; 右移按键[背景]   
      ;========== ========== ========== ========== ========== ==========
      If \CurrEvnetHook  = #Event_HScrollM_OnTop
         FontColor = MFontColor : BackColor = MBackColor : FaceColor = MFaceColor
      ElseIf \CurrEvnetHook  = #Event_HScrollM_LDown
         FontColor = DFontColor : BackColor = DBackColor : FaceColor = DFaceColor
      Else 
         FontColor = NFontColor : BackColor = NBackColor : FaceColor = NFaceColor
      EndIf 
      BackColor(FontColor)          : FrontColor(BackColor) 
      LinearGradient(0,H-30,0,H-17) : Box(19+HX,H-20,HW,19)          ; 滑片按键[背景]   
      BackColor(BackColor)          : FrontColor(FontColor) 
      LinearGradient(0,H-25,0,H+80) : Box(22+HX,H-17,HW-6,6)         ; 滑片按键[底图上侧]
      LinearGradient(0,H-35,0,H+60) : Box(22+HX,H-11,HW-6,7)         ; 滑片按键[底图下侧]
      BackColor(FaceColor)          : FrontColor(BackColor) 
      LinearGradient(0,H-23,0,H)    : LineXY(18+HM,H-14,18+HM,H-9)   ; 滑片按键[三道杠]
      LineXY(15+HM,H-14,15+HM,H-9)  : LineXY(21+HM,H-14,21+HM,H-9)   ; 滑片按键[三道杠] 
      LinearGradient(0,H-63,0,H)    : LineXY(19+HM,H-14,19+HM,H-9)   ; 滑片按键[三道杠阴影] 
      LineXY(16+HM,H-14,16+HM,H-9)  : LineXY(22+HM,H-14,22+HM,H-9)   ; 滑片按键[三道杠阴影]  
      DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_Transparent)
      RoundBox(20+HX,H-19,HW-2,17,1,1,FontColor)                     ; 滑片按键[外边框] 
      ;********** ********** ********** ********** ********** **********
      DrawingMode(#PB_2DDrawing_Gradient)
      BackColor (NFontColor) : FrontColor(NBackColor)
      LinearGradient(W-80, H-80, W-1, H-1) : Box(W-20, H-20, 19, 19) ; 底图  
      BackColor(NFaceColor) : FrontColor(NBackColor) 
      LinearGradient(W-23,H-23,W-1,H-1)
      Circle(W-06,H-6,1) : Circle(W-10,H-6,1) : Circle(W-6,H-10,1)
      Circle(W-14,H-6,1) : Circle(W-6,H-14,1) : Circle(W-10,H-10,1)
   EndWith
EndProcedure

; 设置[输入提示符光标]
Procedure RichEdit_RedrawSetCaret(*pRichEdit.__RichEditInfo)
   With *pRichEdit
      If GetFocus_() <> *pRichEdit\hGadget : ProcedureReturn : EndIf 
      *pViewChar.__RichEdit_ViewChar                           ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine                           ; [可视区|可视行]内存的行指针  
      CaretY = \Viewer\Y+(\Cursor\Row-\Viewer\Row) * \Font\H   ; 计算出提示符光标在所在Y坐标
      *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row) ; 获取当前光标行指针

      If CaretY >= 0 And CaretY < \Gadget\H-20-\Font\H And *pEditLine\LineIndex = \Cursor\RealRow
         ; 如果光标出现列逃逸现象,则将光标位置视为最大允许的光标位置
         If \Cursor\Col >= #RichEdit_MaxLineChars Or \Cursor\Col >= *pEditLine\pElement\CountChars
            CaretX = *pEditLine\LastCursorX
         Else                                                  ; 计算光标的列位置
            *pViewChar = \pMemViewChar+ (\Cursor\Row-\Viewer\Row) * #RichEdit_FullRowBytes
            *pViewChar + \Cursor\Col * #RichEdit_ViewCharSize
            CaretX = *pViewChar\X               
         EndIf 
         If CaretX >= \Viewer\X And CaretX <= \Viewer\X+\Viewer\W
            SetCaretPos_(CaretX,  CaretY)                      ; 设置光标的位置
            If \EditState & #EditState_CaretVisible = #Null    ; 如果光标隐藏,则显示它
               ShowCaret_(\hGadget) : \EditState | #EditState_CaretVisible
            EndIf 
         ElseIf \EditState & #EditState_CaretVisible          ; 如果光标可视,则隐藏它
            HideCaret_(\hGadget) : \EditState & ~#EditState_CaretVisible
         EndIf 
      ElseIf \EditState & #EditState_CaretVisible             ; 如果光标可视,则隐藏它
         HideCaret_(\hGadget) : \EditState & ~#EditState_CaretVisible
      EndIf 
   EndWith
EndProcedure

; 重绘整个控件
Procedure RichEdit_RedrawGadget(*pRichEdit.__RichEditInfo)
   With *pRichEdit
      ; 重新整理[可视区]的信息
      \Viewer\Y        = (\Font\H-\Font\Size)/2       ; [可视区]的上际   
      \Viewer\H        = \Gadget\H-\Viewer\Y-20       ; [可视区]的下际   
      \Viewer\HoldRows = \Viewer\H /\Font\H           ; [可视区]容纳的列数  
;       If \EditState & #EditState_FoldVisible
         \Fold\Size  = \Font\H/2*2+1                  ; [折叠区]的折叠符的大小   
         If \Font\H >= 15 : \Fold\Size = 15 : EndIf     
         \Fold\W  = \Fold\Size+6                      ; [折叠区]的宽度              
;       Else 
;          \Fold\Size = 0  : \Fold\W = 0     
;       EndIf 
    
      CountLines       = ListSize(\ListEditLine())    ; 非折叠行的行数
      MaxLines         = CountLines-\Viewer\HoldRows
      If CountLines < \Viewer\HoldRows : MaxLines = CountLines : EndIf 
      \Viewer\Row      = RichEdit_Limit(\Viewer\Row, 0, MaxLines)
      \Viewer\LastLine = \Viewer\Row+\Viewer\HoldRows ; [可视区]下际显示的行数
      If \Viewer\LastLine > CountLines-1 : \Viewer\LastLine = CountLines-1 : EndIf 
      SelectElement(\ListEditLine(), \Viewer\LastLine); 选择[可视区]最后一行
      MaxChar = Len(Str(\ListEditLine()\LineIndex))   ; 计算行符的字节数
      \Viewer\MarkW    = MaxChar * \Font\W + 10       ; [行符区]的宽度
      \Viewer\X        = \Viewer\MarkW+\Fold\W        ; [可视区]的左际
      \Viewer\W        = \Gadget\W-\Viewer\X-20       ; [可视区]的左际
      \Viewer\HoldCols = \Viewer\W /\Font\W           ; [可视区]容纳的行数  
      CountChars       = (\pMaxTextLine\LineWidth+\AddLineWidth)/\Font\W+1
      MaxChars         = CountChars-\Viewer\HoldCols
      If CountChars < \Viewer\HoldCols : MaxChars = CountChars : EndIf 
      \Viewer\Col      = RichEdit_Limit(\Viewer\Col, 0, MaxChars)
      
      ; 重绘[可视区]图像
      ImageID = CreateImage(#PB_Any, \Gadget\W, \Gadget\H)
      If ImageID = 0 : ProcedureReturn : EndIf 
      If StartDrawing(ImageOutput(ImageID))
         RichEdit_RedrawMarkArea (*pRichEdit)         ; 绘制[行符区]
         RichEdit_RedrawViewArea (*pRichEdit)         ; 绘制[可视区]
         RichEdit_RedrawScrollBar(*pRichEdit)         ; 绘制[滚动条]
         DrawingMode(#PB_2DDrawing_Outlined)
         Box(000, 000, \Gadget\W, \Gadget\H, $888888)
         StopDrawing()
         ; 设置背景刷,并刷新控件
         If \hBrushBack : DeleteObject_(\hBrushBack) : EndIf 
         \hBrushBack = CreatePatternBrush_(ImageID(ImageID)) : FreeImage(ImageID) 
         SetClassLong_(\hGadget, #GCL_HBRBACKGROUND, \hBrushBack)
         InvalidateRect_(\hGadget, #Null, #True)      ;设置刷新域
         UpdateWindow_(\hGadget)                      ;刷新控件
         RichEdit_RedrawSetCaret(*pRichEdit)          ;设置输入提示符光标
      EndIf 
   EndWith
EndProcedure

;- ***********************
; 快捷键[Shift|方向键↑]
Procedure RichEdit_GadgetHook_KeyDown_TOUP(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针   
      ; <Shift>情况下,出现跳行状态
      If IsKeyDownShift And \Cursor\Row > 0
         \Cursor\Row     = \Cursor\Row - 1  
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex 
         RedrawType = #Redraw_FullArea
      ; <Shift>情况下,到顶了,没得选了
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <Shift>情况下,将选区切换成输入点状态, 逆拖情况A
      ElseIf \Cursor\Row < \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <Shift>情况下,将选区切换成输入点状态, 顺拖情况B
      ElseIf \Cursor\Row > \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea    
      ; <Shift>情况下,将选区切换成输入点状态, 逆拖情况C,注:此处不能与(逆拖情况A)合并  
      ElseIf \Cursor\Col < \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <Shift>情况下,将选区切换成输入点状态, 顺拖情况D,注:此处不能与(逆拖情况B)合并 
      ElseIf \Cursor\Col > \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea  
      ; 无跳行状态         
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

; 快捷键[Shift|方向键↓]
Procedure RichEdit_GadgetHook_KeyDown_DOWN(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针   
      ; <Shift>情况下,出现跳行状态
      If IsKeyDownShift And \Cursor\Row < ListSize(\ListEditLine())-1
         \Cursor\Row     = \Cursor\Row + 1  
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex 
         RedrawType      = #Redraw_FullArea
      ; <Shift>情况下,到顶了,没得选了
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <Shift>情况下,将选区切换成输入点状态, 逆拖情况A
      ElseIf \Cursor\Row < \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <Shift>情况下,将选区切换成输入点状态, 顺拖情况B
      ElseIf \Cursor\Row > \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea    
      ; <Shift>情况下,将选区切换成输入点状态, 逆拖情况C,注:此处不能与(逆拖情况A)合并  
      ElseIf \Cursor\Col < \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <Shift>情况下,将选区切换成输入点状态, 顺拖情况D,注:此处不能与(逆拖情况B)合并 
      ElseIf \Cursor\Col > \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea  
      ; 无跳行状态         
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

; 快捷键[Shift|方向键←] 
Procedure RichEdit_GadgetHook_KeyDown_LEFT (*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针   
      ; <Shift>情况下,出现跳行状态
      If IsKeyDownShift And \Cursor\Col = 0 And \Cursor\Row > 0
         \Cursor\Row     = \Cursor\Row - 1  
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\Col     = *pEditLine\pElement\CountChars
         \Cursor\RealRow = *pEditLine\LineIndex 
         \Cursor\RealCol = *pEditLine\pElement\LineWidth / \Font\W
         RedrawType = #Redraw_FullArea
      ; <Shift>情况下,无跳行状态
      ElseIf IsKeyDownShift And \Cursor\Col > 0
         \Cursor\Col - 1 : \Cursor\RealCol - 1 : RedrawType = #Redraw_FullArea
      ; <Shift>情况下,到顶了,没得选了
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <非Shift>情况下,将选区切换成输入点状态, 逆拖情况A
      ElseIf \Cursor\Row < \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <非Shift>情况下,将选区切换成输入点状态, 顺拖情况B
      ElseIf \Cursor\Row > \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea    
      ; <非Shift>情况下,将选区切换成输入点状态, 逆拖情况C,注:此处不能与(逆拖情况A)合并  
      ElseIf \Cursor\Col < \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <非Shift>情况下,将选区切换成输入点状态, 顺拖情况D,注:此处不能与(逆拖情况B)合并 
      ElseIf \Cursor\Col > \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea  
      ; <非Shift>情况下,出现跳行状态
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
      ; <非Shift>情况下,无跳行状态         
      ElseIf \Cursor\Col > 0
         \Cursor\Col - 1 : \Record\Col - 1 : \Cursor\RealCol - 1
         RedrawType = #Redraw_SetCaret 
      EndIf 
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; 快捷键[Shift|方向键→] 
Procedure RichEdit_GadgetHook_KeyDown_RIGHT(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   ;如果[光标行]不存[可视区]内,应先处理光标处落在[可视区]
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针  
      *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row)   
      ; <Shift>情况下,出现跳行状态
      If IsKeyDownShift And \Cursor\Col = *pEditLine\pElement\CountChars And \Cursor\Row < ListSize(\ListEditLine())-2
         \Cursor\Row = \Cursor\Row + 1  
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row) 
         \Cursor\Col     = 0 
         \Cursor\RealRow = *pEditLine\LineIndex 
         \Cursor\RealCol = 0 
         RedrawType = #Redraw_FullArea
      ; <Shift>情况下,无跳行状态
      ElseIf IsKeyDownShift And \Cursor\Col < *pEditLine\pElement\CountChars
         \Cursor\Col + 1 : \Cursor\RealCol + 1 : RedrawType = #Redraw_FullArea
      ; <Shift>情况下,到顶了,没得选了
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <非Shift>情况下,将选区切换成输入点状态, 逆拖情况A
      ElseIf \Cursor\Row < \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <非Shift>情况下,将选区切换成输入点状态, 顺拖情况B
      ElseIf \Cursor\Row > \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea    
      ; <非Shift>情况下,将选区切换成输入点状态, 逆拖情况C,注:此处不能与(逆拖情况A)合并  
      ElseIf \Cursor\Col < \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <非Shift>情况下,将选区切换成输入点状态, 顺拖情况D,注:此处不能与(逆拖情况B)合并 
      ElseIf \Cursor\Col > \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea  
      ; <非Shift>情况下,出现跳行状态
      ElseIf \Cursor\Col = *pEditLine\pElement\CountChars And \Cursor\Row < ListSize(\ListEditLine())-1
         \Cursor\Row     = \Cursor\Row + 1 
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row) 
         \Cursor\Col     = 0
         \Cursor\RealRow = *pEditLine\LineIndex 
         \Cursor\RealCol = 0
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea  
      ; <非Shift>情况下,无跳行状态         
      ElseIf \Cursor\Col < *pEditLine\pElement\CountChars
         \Cursor\Col + 1 : \Record\Col + 1 : \Record\RealCol + 1
         RedrawType = #Redraw_SetCaret 
      EndIf 
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; 快捷键[Shift|翻页键PageUp]
Procedure RichEdit_GadgetHook_KeyDown_PREV(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针   
      ; <Shift>情况下,出现跳行状态
      If IsKeyDownShift And \Cursor\Row > 0
         \Cursor\Row     = \Cursor\Row - \Viewer\HoldRows
         If \Cursor\Row < 0 : \Cursor\Row = 0 : EndIf 
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex 
         RedrawType      = #Redraw_FullArea
         
      ; <Shift>情况下,到顶了,没得选了
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <Shift>情况下,将选区切换成输入点状态, 逆拖情况A
      ElseIf \Cursor\Row < \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType  = #Redraw_FullArea 
      ; <Shift>情况下,将选区切换成输入点状态, 顺拖情况B
      ElseIf \Cursor\Row > \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType  = #Redraw_FullArea    
      ; <Shift>情况下,将选区切换成输入点状态, 逆拖情况C,注:此处不能与(逆拖情况A)合并  
      ElseIf \Cursor\Col < \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType  = #Redraw_FullArea 
      ; <Shift>情况下,将选区切换成输入点状态, 顺拖情况D,注:此处不能与(逆拖情况B)合并 
      ElseIf \Cursor\Col > \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType  = #Redraw_FullArea  
      ; 无跳行状态         
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

; 快捷键[Shift|翻页键PageDown]
Procedure RichEdit_GadgetHook_KeyDown_NEXT(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针   
      ; <Shift>情况下,出现跳行状态
      If IsKeyDownShift And \Cursor\Row < ListSize(\ListEditLine())-1
         \Cursor\Row     = \Cursor\Row + \Viewer\HoldRows
         If \Cursor\Row > ListSize(\ListEditLine())-1 : \Cursor\Row = ListSize(\ListEditLine()) - 1 : EndIf 
         *pEditLine      = SelectElement(\ListEditLine(), \Cursor\Row)    
         \Cursor\RealRow = *pEditLine\LineIndex 
         RedrawType      = #Redraw_FullArea
         
      ; <Shift>情况下,到顶了,没得选了
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <非Shift>情况下,将选区切换成输入点状态, 逆拖情况A
      ElseIf \Cursor\Row < \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <非Shift>情况下,将选区切换成输入点状态, 顺拖情况B
      ElseIf \Cursor\Row > \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea    
      ; <非Shift>情况下,将选区切换成输入点状态, 逆拖情况C,注:此处不能与(逆拖情况A)合并  
      ElseIf \Cursor\Col < \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <非Shift>情况下,将选区切换成输入点状态, 顺拖情况D,注:此处不能与(逆拖情况B)合并 
      ElseIf \Cursor\Col > \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea  
      ; 无跳行状态         
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

; 快捷键[Shift|翻页键Home]
Procedure RichEdit_GadgetHook_KeyDown_Home(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针   
      ; <Shift>情况下,出现跳行状态
      If IsKeyDownShift And \Cursor\Col > 0
         \Cursor\Col = 0 : \Cursor\RealCol = 0 : RedrawType = #Redraw_FullArea
      ; <Shift>情况下,到顶了,没得选了
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <非Shift>情况下,将选区切换成输入点状态, 逆拖情况A
      ElseIf \Cursor\Row < \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <非Shift>情况下,将选区切换成输入点状态, 顺拖情况B
      ElseIf \Cursor\Row > \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea    
      ; <非Shift>情况下,将选区切换成输入点状态, 逆拖情况C,注:此处不能与(逆拖情况A)合并  
      ElseIf \Cursor\Col < \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea 
      ; <非Shift>情况下,将选区切换成输入点状态, 顺拖情况D,注:此处不能与(逆拖情况B)合并 
      ElseIf \Cursor\Col > \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea  
      ; <非Shift>情况下,无跳行状态         
      ElseIf \Cursor\Col > 0
         \Cursor\Col = 0 : \Cursor\RealCol = 0
         \Record\Col = 0 : \Record\RealCol = 0
         RedrawType = #Redraw_SetCaret 
      EndIf 
   EndWith
   ProcedureReturn RedrawType
EndProcedure

; 快捷键[Shift|翻页键End]
Procedure RichEdit_GadgetHook_KeyDown_END(*pRichEdit.__RichEditInfo, IsKeyDownShift)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针  
      *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row)    
      ; <Shift>情况下,出现跳行状态
      If IsKeyDownShift And \Cursor\Col < *pEditLine\pElement\CountChars
         \Cursor\Col     = *pEditLine\pElement\CountChars
         \Cursor\RealCol = *pEditLine\pElement\LineWidth / \Font\W
         RedrawType = #Redraw_FullArea
      ; <Shift>情况下,到顶了,没得选了
      ElseIf IsKeyDownShift
         RedrawType = #Redraw_NotEvent
      ; <非Shift>情况下,将选区切换成输入点状态, 逆拖情况A
      ElseIf \Cursor\Row < \Record\Row 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <非Shift>情况下,将选区切换成输入点状态, 顺拖情况B
      ElseIf \Cursor\Row > \Record\Row 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea    
      ; <非Shift>情况下,将选区切换成输入点状态, 逆拖情况C,注:此处不能与(逆拖情况A)合并  
      ElseIf \Cursor\Col < \Record\Col 
         \Cursor\Col = \Record\Col : \Cursor\RealRow = \Record\RealRow
         \Cursor\Row = \Record\Row : \Cursor\RealCol = \Record\RealCol
         RedrawType = #Redraw_FullArea 
      ; <非Shift>情况下,将选区切换成输入点状态, 顺拖情况D,注:此处不能与(逆拖情况B)合并 
      ElseIf \Cursor\Col > \Record\Col 
         \Record\Col = \Cursor\Col : \Record\RealRow = \Cursor\RealRow
         \Record\Row = \Cursor\Row : \Record\RealCol = \Cursor\RealCol
         RedrawType = #Redraw_FullArea  
      ; <非Shift>情况下,无跳行状态         
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

; 快捷键[Ctrl+A]键<全选事件>
Procedure RichEdit_GadgetHook_KeyDown_SELA(*pRichEdit.__RichEditInfo, IsKeyDownCtrl)
   With *pRichEdit
      If IsKeyDownCtrl = 0 : ProcedureReturn : EndIf 
      *pViewChar.__RichEdit_ViewChar      ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针  
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

; 快捷键[Ctrl+C]
Procedure RichEdit_GadgetHook_KeyDown_COPY(*pRichEdit.__RichEditInfo, IsKeyDownCtrl)
   With *pRichEdit
      *pViewChar.__RichEdit_ViewChar      ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine      ; [可视区|可视行]内存的行指针  
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

; 当键盘按键被按下时
Procedure RichEdit_GadgetHook_KeyDown(*pRichEdit.__RichEditInfo, KeyValue)
   With *pRichEdit
      IsKeyDownCtrl  = GetKeyState_(#VK_CONTROL) & $80
      IsKeyDownShift = GetKeyState_(#VK_SHIFT)   & $80
      *pViewChar.__RichEdit_ViewChar                           ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine                           ; [可视区|可视行]内存的行指针  
      Select KeyValue
         Case #VK_UP          ;[文本区|方向键↑]
            RedrawType = RichEdit_GadgetHook_KeyDown_TOUP (*pRichEdit, IsKeyDownShift)
         Case #VK_DOWN       ;[文本区|方向键↓]
            RedrawType = RichEdit_GadgetHook_KeyDown_DOWN (*pRichEdit, IsKeyDownShift)
         Case #VK_LEFT        ;[文本区|方向键←] 
            RedrawType = RichEdit_GadgetHook_KeyDown_LEFT (*pRichEdit, IsKeyDownShift)
         Case #VK_RIGHT       ;[文本区|方向键→] 
            RedrawType = RichEdit_GadgetHook_KeyDown_RIGHT(*pRichEdit, IsKeyDownShift)
         ;=======================
         Case #VK_PRIOR       ;[文本区|翻页键PageUp]
            RedrawType = RichEdit_GadgetHook_KeyDown_PREV (*pRichEdit, IsKeyDownShift)
         Case #VK_NEXT        ;[文本区|翻页键PageDown]
            RedrawType = RichEdit_GadgetHook_KeyDown_NEXT (*pRichEdit, IsKeyDownShift)
         Case #VK_HOME        ;[文本区|翻页键Home]
            RedrawType = RichEdit_GadgetHook_KeyDown_HOME (*pRichEdit, IsKeyDownShift)
         Case #VK_END         ;[文本区|翻页键End]
            RedrawType = RichEdit_GadgetHook_KeyDown_END  (*pRichEdit, IsKeyDownShift)
         ;======================= 
         Case #VK_A           ;[[文本区|A键]<全选事件>
            RedrawType = RichEdit_GadgetHook_KeyDown_SELA (*pRichEdit, IsKeyDownCtrl)
         Case #VK_C           ;[[文本区|C键]<复制事件>
            RichEdit_GadgetHook_KeyDown_COPY (*pRichEdit, IsKeyDownCtrl)  
            ProcedureReturn 
      EndSelect
      ;=======================
      If RedrawType
         ; 判断光标是否在[可视区],否则移动[可视区]使用光标可见
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
         Case #Redraw_SetCaret   ; 表示重设光标
            RichEdit_RedrawSetCaret(*pRichEdit)
         Case #Redraw_ViewArea   ; 表示重绘画面
            RichEdit_ParserFoldArea(*pRichEdit, \Cursor\RealRow) 
         Case #Redraw_FullArea   ; 表示重绘画面并设置光标行
            RichEdit_ParserFoldArea(*pRichEdit, \Cursor\RealRow) 
            SelectElement(\ListTextLine(), \Cursor\RealRow)                   ; 选中光标处的[文本行]
            \Cursor\IsInFold = \ListTextLine()\FoldState & #FoldState_IsHide  ; 设置折叠状态         
            RichEdit_RedrawGadget(*pRichEdit)
      EndSelect
   EndWith
EndProcedure
   
;- ***********************
; <HOOK|鼠标在上>事件
Procedure RichEdit_GadgetHook_MouseOnTop(*pRichEdit.__RichEditInfo, *pMouse.Points)
   Shared  *pCurrRichEdit.__RichEditInfo
   Shared  *pPrevRichEdit.__RichEditInfo
   *pCurrRichEdit = *pRichEdit   ; 向<MouseHook>事件传递当前控件信息,实现越界拖动
   If *pPrevRichEdit <> *pCurrRichEdit
      *pPrevRichEdit = *pCurrRichEdit : SetActiveGadget(*pRichEdit\GadgetID)
   EndIf 

   With *pRichEdit   
      If *pMouse\x >= \Gadget\W-20 And *pMouse\y >= \Gadget\H-20 
         hCursor = \Cursor\hARROW                  ; 切换为[常规箭头光标]
      ;========== ========== ========== ========== ========== ==========
      ElseIf *pMouse\x >= \Gadget\W-20            ; [右侧滚动条]
         hCursor = \Cursor\hARROW                  ; 切换为[常规箭头光标]
         If *pMouse\y < 20
            \CurrEvnetHook = #Event_VScrollT_OnTop ; [右侧滚动条|上际按键]
         ElseIf *pMouse\y > \Gadget\H - 40  
            \CurrEvnetHook = #Event_VScrollB_OnTop ; [右侧滚动条|下际按键]
         ElseIf *pMouse\y < \VScroll\VanePos + 20
            \CurrEvnetHook = #Event_VScrollW_OnTop ; [右侧滚动条|上移按键]
         ElseIf *pMouse\y > \VScroll\VanePos + \VScroll\VaneSize + 20
            \CurrEvnetHook = #Event_VScrollS_OnTop ; [右侧滚动条|下移按键]
         Else 
            \CurrEvnetHook = #Event_VScrollM_OnTop ; [右侧滚动条|滑片按键]
         EndIf 
      ;========== ========== ========== ========== ========== ==========
      ElseIf *pMouse\y >= \Gadget\H-20             ; [底部滚动条]
         hCursor = \Cursor\hARROW                  ; 切换为[常规箭头光标]
         If *pMouse\x < 20
            \CurrEvnetHook = #Event_HScrollL_OnTop ; [底部滚动条|左际按键]<鼠标在上>
         ElseIf *pMouse\x > \Gadget\W - 40  
            \CurrEvnetHook = #Event_HScrollR_OnTop ; [底部滚动条|右际按键]<鼠标在上>
         ElseIf *pMouse\x < \HScroll\VanePos + 20
            \CurrEvnetHook = #Event_HScrollA_OnTop ; [底部滚动条|左移按键]<鼠标在上>
         ElseIf *pMouse\x > \HScroll\VanePos + \HScroll\VaneSize + 20
            \CurrEvnetHook = #Event_HScrollD_OnTop ; [底部滚动条|右移按键]<鼠标在上>
         Else 
            \CurrEvnetHook = #Event_HScrollM_OnTop ;[底部滚动条|滑片按键]<鼠标在上>
         EndIf
      ;========== ========== ========== ========== ========== ==========
      ElseIf *pMouse\x <= \Viewer\MarkW           ; [行符区]
         hCursor = \Cursor\hRMARK                  ; 切换为[反式箭头光标]
         \CurrEvnetHook = #Event_MarkArea_OnTop
      ;========== ========== ========== ========== ========== ==========
      ElseIf *pMouse\x <= \Viewer\X               ; [折叠区]
         hCursor = \Cursor\hRMARK                  ; 切换为[反式箭头光标]
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
            hCursor = \Cursor\hARROW               ;切换为[提示符光标]
            \CurrEvnetHook = #Event_EditArea_OTSelected
         Else 
            hCursor = \Cursor\hIBEAM               ;切换为[提示符光标]
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


; <HOOK|鼠标在上>事件
Procedure RichEdit_GadgetHook_MouseLDown(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit          
      If \CurrEvnetHook & #Event_MouseLDown
         Result = #True
         Select \CurrEvnetHook 
            Case #Event_MarkArea_LDown       ;[行符区]<按住行符|选择文本> 
               CursorRow = (*pMouse\y-\Viewer\Y) / \Font\H + \Viewer\Row
               SelectElement(\ListEditLine(), CursorRow) 
               \Cursor\RealRow = \ListEditLine()\LineIndex
               If \Cursor\Row <> CursorRow : \Cursor\Row = CursorRow : IsRedraw = #True : EndIf 
               RichEdit_ParserFoldArea(*pRichEdit, \Cursor\RealRow)
            Case #Event_EditArea_LDown       ;[编辑区]<按住移动|选择文本>
               IsRedraw = RichEdit_ParserEditArea(*pRichEdit, *pMouse)
               
            Case #Event_VScrollM_LDown       ;[右侧滚动条|滑片按键]<按住移动>
               VanePos = \VScroll\RecordingPos + *pMouse\y - \VScroll\MouseDownPos
               VanePos = RichEdit_Limit(VanePos, 0, \VScroll\VaneLast*\VScroll\SetpScale)    ; 计算[滑片]新的绝对位置 
               ViewRow = RichEdit_Limit(VanePos/\VScroll\SetpScale, 0, \VScroll\VaneLast)    ; 计算[滑片]新的行位置
               If \Viewer\Row <> ViewRow : \Viewer\Row = ViewRow : IsRedraw = #True : EndIf ; 如果[滑片]位置不同,刷新界面
            Case #Event_HScrollM_LDown       ;[底部滚动条|滑片按键]<按住移动>
               VanePos = \HScroll\RecordingPos + *pMouse\x - \HScroll\MouseDownPos
               VanePos = RichEdit_Limit(VanePos, 0, \HScroll\VaneLast * \HScroll\SetpScale)    ; 计算[滑片]新的绝对位置 
               ViewCol = RichEdit_Limit(VanePos/\HScroll\SetpScale, 0, \HScroll\VaneLast)    ; 计算[滑片]新的行位置
               If \Viewer\Col <> ViewCol : \Viewer\Col = ViewCol : IsRedraw = #True : EndIf ; 如果[滑片]位置不同,刷新界面
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

; <HOOK|移动鼠标>事件
Procedure RichEdit_GadgetHook_MouseMove(*pRichEdit.__RichEditInfo, *pMouse.Points, CompositeKey)
   If *pMouse = 0 : ProcedureReturn : EndIf 
   With *pRichEdit          
      Select CompositeKey
         Case 0 : RichEdit_GadgetHook_MouseOnTop(*pRichEdit, *pMouse) ; 鼠标在上
         Case 1 : RichEdit_GadgetHook_MouseLDown(*pRichEdit, *pMouse) ; 左键拖动
      EndSelect  
   EndWith 
EndProcedure

;- -----------------------
; [右侧滚动条]<HOOK|左键按下>事件
Procedure RichEdit_GadgetHook_LDownVScroll(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit   
      \CurrEvnetHook | #Event_MouseLDown
      Select \CurrEvnetHook
         Case #Event_VScrollM_LDown    ;[右侧滚动条|滑片按键]<鼠标按下>
            If \PrevEvnetHook <> #Event_VScrollM_LDown
               \VScroll\MouseDownPos = *pMouse\y         ; 记录鼠标按下的位置
               \VScroll\RecordingPos = \VScroll\VanePos  ; 记录按下时[滑片]的位置
            EndIf 
         Case #Event_VScrollT_LDown    ;[右侧滚动条|上际按键]<鼠标按下>
            If \Viewer\Row > 0
               \Viewer\Row-1 : \DelayTime = #Timer_Scrolls_Timer
               SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
            EndIf  
         Case #Event_VScrollB_LDown    ;[右侧滚动条|下际按键]<鼠标按下>
            If \Viewer\Row < \VScroll\VaneLast
               \Viewer\Row+1 : \DelayTime = #Timer_Scrolls_Timer
               SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
            EndIf 
            
         Case #Event_VScrollW_LDown    ;[右侧滚动条|上移按键]<鼠标按下>
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
         
         Case #Event_VScrollS_LDown    ;[右侧滚动条|下移按键]<鼠标按下>  
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

; [底部滚动条]<HOOK|左键按下>事件
Procedure RichEdit_GadgetHook_LDownHScroll(*pRichEdit.__RichEditInfo, *pMouse.Points)
  
   With *pRichEdit   
      \CurrEvnetHook | #Event_MouseLDown
      Select \CurrEvnetHook
         Case #Event_HScrollM_LDown    ;[底部滚动条|滑片按键]<鼠标按下>
            If \PrevEvnetHook <> #Event_HScrollM_LDown
               \HScroll\MouseDownPos = *pMouse\x
               \HScroll\RecordingPos = \HScroll\VanePos 
            EndIf 
         Case #Event_HScrollL_LDown    ;[底部滚动条|左际按键]<鼠标按下>
            If \Viewer\Col > 0
               \Viewer\Col-1 : \DelayTime = #Timer_Scrolls_Timer
               SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
            EndIf  
         Case #Event_HScrollR_LDown    ;[底部滚动条|右际按键]<鼠标按下>
            If \Viewer\Col < \HScroll\VaneLast
               \Viewer\Col+1 : \DelayTime = #Timer_Scrolls_Timer
               SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
            ElseIf \Viewer\Col  < 1024 -\Viewer\HoldCols
               \AddLineWidth+\Font\W : \Viewer\Col+1 : \DelayTime = #Timer_Scrolls_Timer
               SetTimer_(\hGadget,#Timer_Scrolls_Flags, #Timer_Scrolls_Timer, #Null)
            EndIf 
         Case #Event_HScrollA_LDown    ;[底部滚动条|左移按键]<鼠标按下>
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
         Case #Event_HScrollD_LDown    ;[右侧滚动条|下移按键]<鼠标按下>  
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

; [折叠区]<HOOK|左键按下>事件
Procedure RichEdit_GadgetHook_LDownFoldBar(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit  
      \CurrEvnetHook | #Event_MouseLDown
      CursorY = (*pMouse\y-\Viewer\Y-1) / \Font\H + \Viewer\Row
      *pEditLine.__RichEdit_EditLine
      *pTextLine.__RichEdit_TextLine
      ; 对折叠区进行处理
      *pEditLine = SelectElement(\ListEditLine(), CursorY)
      If *pEditLine <= 0 : ProcedureReturn : EndIf 
      *pTextLine = SelectElement(\ListTextLine(), *pEditLine\LineIndex)
      If *pTextLine <= 0 : ProcedureReturn : EndIf 
      FoldFloor = *pEditLine\pElement\FoldFloor
      ; 如果是[折叠行节点]
      If *pEditLine\pElement\FoldState  & #FoldState_Start 
         ; 当[折叠行节点]为闭合状态时
         If *pEditLine\pElement\FoldState & #FoldState_Closed
            *pEditLine\pElement\FoldState & ~#FoldState_Closed
            LineIndex  = *pEditLine\LineIndex+1             ; 开始扫描的行索引
            *pEditLine = NextElement(\ListEditLine())       ; 将链表指针指向下一个编辑行
            *pTextLine = NextElement(\ListTextLine())       ; 将链表指针指向下一个文本行
            LastIndex  = *pEditLine\LineIndex               ; 结束扫描的行索引
            While *pTextLine And LineIndex < LastIndex     ; 循环扫描文本行
               ;如果文本行跟目标行的层一致,如果扫到节点行时,FoldFloor要递增,当扫到结束行时,FoldFloor要递减
               ; 注意: 此处逻辑有些复杂.
               If *pTextLine\FoldFloor = FoldFloor+1     
                  IsAddElement = #False
                  If *pTextLine\FoldState & #FoldState_Start And IsHideLine = #Null                                    ; 如查
                     IsAddElement = #True : FoldFloor + 1                     ; FoldFloor递增, 节点扫描子层,并添加到编辑行
                     IsHideLine = *pTextLine\FoldState & #FoldState_Closed    ; 如果节点行是闭合的,放弃添加到编辑行
                  ElseIf *pTextLine\FoldState & #FoldState_ToEnd
                     If IsHideLine = #Null : IsAddElement = #True : EndIf 
                     FoldFloor - 1 : IsHideLine = #Null                       ; FoldFloor递减, 返回父层扫描
                  ElseIf IsHideLine = #Null : IsAddElement = #True           ; 如果父节点是展开的,才添加到编辑行
                  EndIf 
                  If IsAddElement = #True                         
                     *pEditLine = InsertElement(\ListEditLine())  ; 插入编辑行 
                     *pEditLine\LineIndex = LineIndex             ; 设置编辑行对应的文本行索引号
                     *pEditLine\pElement  = *pTextLine            ; 指向文本行元素的指针
                     *pTextLine\FoldState & ~#FoldState_IsHide
                     NextElement(\ListEditLine())                 ; 跳到插入行的下一行
                  EndIf 
               EndIf 
               LineIndex+1
               *pTextLine = NextElement(\ListTextLine())          ; 跳转到下一个文本行
            Wend
            IsRedraw = #True
         ; 当[折叠行节点]为展开状态时   
         Else 
            *pEditLine\pElement\FoldState | #FoldState_Closed
            *pEditLine = NextElement(\ListEditLine())
            While *pEditLine
               If *pEditLine\pElement\FoldFloor > FoldFloor       ; 如果文本行的层数大于节点行,全部删除
                  *pEditLine\pElement\FoldState | #FoldState_IsHide
                  DeleteElement(\ListEditLine())
               ElseIf *pEditLine\pElement\FoldFloor <= FoldFloor  ; 折叠范围结束时,退出删除事件
                  Break
               EndIf 
               *pEditLine = NextElement(\ListEditLine())          ; 跳转到下一个文本行
            Wend
            IsRedraw = #True
         EndIf 
      ; 如果是折叠域结束行
      ElseIf *pEditLine\pElement\FoldState  & #FoldState_ToEnd
         *pEditLine = PreviousElement(\ListEditLine())            ; 跳转到上一个文本行        
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
      ; =======================                                   ;获取光标行折叠区的起始和结束位置
      *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row)
      CursorRow = \Cursor\Row
      ; 如果当前行不存在,则表示折叠后,光标的相对位置已经逃逸到文本行之外
      If *pEditLine = 0          
         *pEditLine = LastElement(\ListEditLine())
         CursorRow = ListIndex(\ListEditLine())
         While *pEditLine                                         ; 重新锁定光标行
            If \ListEditLine()\LineIndex = \Cursor\RealRow        ; 通过绝对行锁定光标行,
               \Cursor\Row = CursorRow : Break                    ; 将绝对行换算成光标行位置
            ElseIf \ListEditLine()\LineIndex < \Cursor\RealRow    ; 如果光标行被包含在折叠区内,则放弃锁定       
               Break
            EndIf  
            CursorRow-1 
            *pEditLine = PreviousElement(\ListEditLine())         ; 跳到上一个[编辑行]
         Wend 
         
      ; 如果是闭合折叠事件
      ElseIf *pEditLine\LineIndex < \Cursor\RealRow
         While NextElement(\ListEditLine())                       ; 跳到下一个[编辑行]
            CursorRow+1              
            If \ListEditLine()\LineIndex = \Cursor\RealRow        ; 通过绝对行锁定光标行,
               \Cursor\Row = CursorRow : Break                    ; 将绝对行换算成光标行位置
            ElseIf \ListEditLine()\LineIndex > \Cursor\RealRow    ; 如果光标行被包含在折叠区内,则放弃锁定  
               Break
            EndIf  
         Wend
         
      ; 如果是展开折叠事件
      ElseIf *pEditLine\LineIndex > \Cursor\RealRow
         While PreviousElement(\ListEditLine())                   ; 跳到上一个[编辑行]
            CursorRow-1             
            If \ListEditLine()\LineIndex = \Cursor\RealRow        ; 通过绝对行锁定光标行,
               \Cursor\Row = CursorRow : Break                    ; 将绝对行换算成光标行位置
            ElseIf \ListEditLine()\LineIndex < \Cursor\RealRow    ; 如果光标行被包含在折叠区内,则放弃锁定  
               Break
            EndIf  
         Wend 
      EndIf
      SelectElement(\ListTextLine(), \Cursor\RealRow)                   ; 选中光标处的[文本行]
      \Cursor\IsInFold = \ListTextLine()\FoldState & #FoldState_IsHide  ; 设置折叠状态
   EndWith
   ProcedureReturn IsRedraw
EndProcedure

; [编辑区]<HOOK|左键按下>事件 
Procedure RichEdit_GadgetHook_LDownEditArea(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit 
      \CurrEvnetHook | #Event_MouseLDown  
;       If \EditState & #EditState_FoldVisible = 0 : ProcedureReturn : EndIf 
      *pViewChar.__RichEdit_ViewChar                  ; [可视区|编辑行]内存的字符指针
      CurrRow = (*pMouse\y-\Viewer\Y) /\Font\H        ; 计算当前光标处相对行位置
      *pViewChar = \pMemViewChar+ CurrRow * #RichEdit_FullRowBytes
      CurrRow + \Viewer\Row                           ; 设置当前光标处行的位置
      \FlagsWord$ = #Null$                            ; 清空选中词内容
      *pElement = SelectElement(\ListEditLine(), CurrRow) ; 调用[可视行]链表元素

      If *pElement <= 0 : ProcedureReturn : EndIf 
      RealRow = \ListEditLine()\LineIndex             ; 获取绝对行位置
      CurrCol = #RichEdit_MaxLineChars                ; 默认为本行的最后一个字符
      CurrCol = \ListEditLine()\pElement\CountChars   ; 默认为本行的最后一个字符
      For k = 0 To \ListEditLine()\pElement\CountChars-1
         If *pViewChar\X <= *pMouse\X And *pMouse\X < *pViewChar\X+*pViewChar\W 
            CurrCol = k : Break 
         ElseIf *pViewChar\X =0 And *pViewChar\W = 0 
             Break
         EndIf 
         *pViewChar+ #RichEdit_ViewCharSize
      Next  

      ; 如果<单击>事件是在双击延时时间内进行当前选中词的点击,则视为选中全行         
      If \Cursor\Row = CurrRow And \Record\Row = \Cursor\Row
         If \Record\Col = \Cursor\Col                 ; 单纯改变光标位置的情况,不用重绘界面
            NoRedraw = #True
         ElseIf \Cursor\Col >= CurrCol And \Record\Col < CurrCol And \Cursor\IsLDChick = #True
            IsFullLine = #True : \Cursor\IsLDChick = #False
         ElseIf \Cursor\Col < CurrCol And \Record\Col >= CurrCol And \Cursor\IsLDChick = #True
            IsFullLine = #True : \Cursor\IsLDChick = #False            
         EndIf 
      EndIf  
      ;=======================
      If IsFullLine = #True                           ; 如果<单击|选中全行>时,设置选择区
         \Record\Col = 0            : \Cursor\Col = #RichEdit_MaxLineChars
         \Record\Row = CurrRow      : \Cursor\Row = CurrRow
         \Record\RealRow = RealRow  : \Cursor\RealRow = RealRow
         \Record\RealRow = RealRow  : \Cursor\RealRow = RealRow
      Else                                            ; 设置<单击>位置
         \Record\Col = CurrCol      : \Cursor\Col = CurrCol
         \Record\Row = CurrRow      : \Cursor\Row = CurrRow
         \Record\RealRow = RealRow  : \Cursor\RealRow = RealRow
      EndIf 

      ; 如果只是改变输入提示符,则只设提示符位置,不对[编辑器]进行重绘
      If NoRedraw = #True 
         RichEdit_RedrawSetCaret(*pRichEdit) : ProcedureReturn
      Else
         RichEdit_ParserFoldArea(*pRichEdit, RealRow) 
      EndIf  
      SelectElement(\ListTextLine(), \Cursor\RealRow)                   ; 选中光标处的[文本行]
      \Cursor\IsInFold = \ListTextLine()\FoldState & #FoldState_IsHide  ; 设置折叠状态
   EndWith
   ProcedureReturn IsRedraw
EndProcedure

; <HOOK|左键按下>事件
Procedure RichEdit_GadgetHook_LButtonDown(*pRichEdit.__RichEditInfo, *pMouse.Points)
   Shared  *pCurrRichEdit.__RichEditInfo
   Shared  *pPrevRichEdit.__RichEditInfo
   *pCurrRichEdit = *pRichEdit   ; 向<MouseHook>事件传递当前控件信息,实现越界拖动
   If *pPrevRichEdit <> *pCurrRichEdit
      *pPrevRichEdit = *pCurrRichEdit : SetActiveGadget(*pRichEdit\GadgetID)
   EndIf 
   
   If *pMouse = 0 : ProcedureReturn : EndIf 
   With *pRichEdit          
      SetActiveGadget(\GadgetID)
      If \CurrEvnetHook & #Event_VScroll = #Event_VScroll
         IsRedraw = RichEdit_GadgetHook_LDownVScroll(*pRichEdit, *pMouse) ; [右侧滚动条]<HOOK|左键按下>事件
      ElseIf \CurrEvnetHook & #Event_HScroll = #Event_HScroll 
         IsRedraw = RichEdit_GadgetHook_LDownHScroll(*pRichEdit, *pMouse) ; [底部滚动条]<HOOK|左键按下>事件         
      ElseIf \CurrEvnetHook & #Event_FoldArea = #Event_FoldArea    
         IsRedraw = RichEdit_GadgetHook_LDownFoldBar(*pRichEdit, *pMouse) ; [折叠区]<HOOK|左键按下>事件
      ElseIf \CurrEvnetHook & #Event_EditArea = #Event_EditArea
         IsRedraw = RichEdit_GadgetHook_LDownEditArea(*pRichEdit, *pMouse); [编辑区]<HOOK|左键按下>事件     
      ElseIf \CurrEvnetHook & #Event_MarkArea = #Event_MarkArea         
         \CurrEvnetHook | #Event_MouseLDown
         CurrRow = (*pMouse\y-\Viewer\Y) / \Font\H + \Viewer\Row
         *pElement = SelectElement(\ListEditLine(), CurrRow)
         If *pElement <= 0 : ProcedureReturn : EndIf 
         RealRow   = \ListEditLine()\LineIndex
         \Record\Col = 0            : \Cursor\Col = #RichEdit_MaxLineChars
         \Record\Row = CurrRow      : \Cursor\Row = CurrRow
         \Record\RealRow = RealRow  : \Cursor\RealRow = RealRow
         SelectElement(\ListTextLine(), \Cursor\RealRow)                   ; 选中光标处的[文本行]
         \Cursor\IsInFold = \ListTextLine()\FoldState & #FoldState_IsHide  ; 设置折叠状态
         RichEdit_ParserFoldArea(*pRichEdit, \Cursor\RealRow)
      EndIf 
      If \PrevEvnetHook <> \CurrEvnetHook Or IsRedraw = #True
         \PrevEvnetHook = \CurrEvnetHook : RichEdit_RedrawGadget(*pRichEdit)
      EndIf   
   EndWith 
EndProcedure

;- -----------------------
; <HOOK|双击左键>事件[编辑区]
Procedure RichEdit_GadgetHook_LBDChick_EditArea(*pRichEdit.__RichEditInfo, *pMouse.Points)
   With *pRichEdit  
      \CurrEvnetHook | #Event_MouseLDown 
      ; 处理双击选词事件
      *pViewChar.__RichEdit_ViewChar            ; [可视区|编辑行]内存的字符指针
      *pEditLine.__RichEdit_EditLine            ; [可视区|可视行]内存的行指针    
      RecordCol  = \Cursor\Col                  ; 记录当前的列数,后在比较用到
      *pViewLine = \pMemViewChar+ (\Cursor\Row-\Viewer\Row) * #RichEdit_FullRowBytes
      *pViewChar = *pViewLine + RecordCol * #RichEdit_ViewCharSize
      CharSymbol = *pViewChar\CharSymbol        ; 获取当前光标处的字符标识
     
      ; 如果是文本类标识,则选中全本为文本类标识的字符
      If CharSymbol & #Symbol_String            
         For Col = \Cursor\Col To 0 Step -1    ; 往左扫描为文本类标识的字符
            If *pViewChar\CharSymbol & #Symbol_String 
               \Record\Col = Col
            ElseIf *pViewChar\CharSymbol & #Symbol_String = 0 
               Break 
            EndIf 
            *pViewChar-#RichEdit_ViewCharSize   ; 往左步进字符指针
         Next 
         *pViewChar = *pViewLine + RecordCol * #RichEdit_ViewCharSize
         *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row)
         For Col = \Cursor\Col To *pEditLine\pElement\CountChars-1   ; 往右扫描为文本类标识的字符 
            If *pViewChar\CharSymbol & #Symbol_String 
               \Cursor\Col = Col+1    
            ElseIf *pViewChar\CharSymbol & #Symbol_String = 0
               Break 
            EndIf 
            *pViewChar+#RichEdit_ViewCharSize   ; 往右步进字符指针
         Next 
         \FlagsWord$ = Mid(*pEditLine\pElement\LineText$, \Record\Col+1, \Cursor\Col-\Record\Col)
      
      ; 如果是非文本类标识,则选中同一类标识的字符
      Else 
         For Col = \Cursor\Col To 0 Step -1    ; 往左扫描字符
            If *pViewChar\CharSymbol = CharSymbol
               \Record\Col = Col
            ElseIf *pViewChar\CharSymbol <> CharSymbol
               Break 
            EndIf 
            *pViewChar-#RichEdit_ViewCharSize   ; 往左步进字符指针
         Next 
         *pViewChar = *pViewLine + RecordCol * #RichEdit_ViewCharSize
         *pEditLine.__RichEdit_EditLine
         *pEditLine = SelectElement(\ListEditLine(), \Cursor\Row)
         For Col = \Cursor\Col To *pEditLine\pElement\CountChars-1   ; 往右扫描字符
            If *pViewChar\CharSymbol = CharSymbol
               \Cursor\Col = Col+1    
            ElseIf *pViewChar\CharSymbol <> CharSymbol
               Break 
            EndIf 
            *pViewChar+#RichEdit_ViewCharSize   ; 往右步进字符指针
         Next 
         \FlagsWord$ = #Null$
      EndIf 
      ; 获取光标的像素位置及做双击延时处理,
      ; 双击延时处理效果: 双击时,选词,如果是在#Timer_LDChick_Timer时间内,再单击,则选择全行文本
      If RecordCol <> \Cursor\Col
         \Cursor\IsLDChick = #True                 ; 双击选词延时处理
         SetTimer_(\hGadget,#Timer_LDChick_Flags, #Timer_LDChick_Timer, #Null)
      EndIf
      RichEdit_RedrawGadget(*pRichEdit)
   EndWith 
EndProcedure

; <HOOK|双击左键>事件
Procedure RichEdit_GadgetHook_LButtonDChick(*pRichEdit.__RichEditInfo, *pMouse.Points)
   If *pMouse = 0 : ProcedureReturn : EndIf 
   With *pRichEdit          
      If \CurrEvnetHook & #Event_MarkArea = #Event_MarkArea          ; <HOOK|双击左键>事件[行符区] 
         \CurrEvnetHook | #Event_MouseLDown
         \Record\Row = 0 : \Cursor\Row = ListSize(\ListEditLine())-1
         \Record\Col = 0 : \Cursor\Col = #RichEdit_MaxLineChars
         RichEdit_RedrawGadget(*pRichEdit)
      ElseIf \CurrEvnetHook & #Event_EditArea = #Event_EditArea      ; <HOOK|双击左键>事件[编辑区]
         RichEdit_GadgetHook_LBDChick_EditArea(*pRichEdit, *pMouse)
      EndIf 
   EndWith 
EndProcedure

;- =======================
; <HOOK|左键释放>事件
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

; <Callback|移动中轮>事件
Procedure RichEdit_GadgetHook_MouseWHeel(*pRichEdit.__RichEditInfo, wParam)
   With *pRichEdit
      x.w = ((wParam>>16)&$FFFF) : Event = -(x/120)  
      If wParam & $FFFF = 8      ; 缩放字体
         If Event < 0 And \Font\Size < 120
            \Font\Size  + 3 : IsRedraw = #True : RichEdit_SetGadgetFont(*pRichEdit)         
         ElseIf Event > 0 And \Font\Size  > 3 
            \Font\Size  - 3 : IsRedraw = #True : RichEdit_SetGadgetFont(*pRichEdit)
         EndIf 
      ElseIf wParam & $FFFF = 0  ; 滚动页面
         If Event < 0 And \Viewer\Row > 0 : \Viewer\Row - 3 : IsRedraw = #True
         ElseIf Event > 0 And \Viewer\Row < \VScroll\VaneLast : \Viewer\Row + 3 : IsRedraw = #True
         EndIf
      EndIf
      If IsRedraw = #True : RichEdit_RedrawGadget(*pRichEdit) : EndIf 
   EndWith 
EndProcedure

; <HOOK|计时器>事件
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
               Case #Event_VScrollT_LDown    ;[右侧滚动条|上际按键]<鼠标按下>
                  If \Viewer\Row> 0 : \Viewer\Row-5 : Else : \CurrEvnetHook=0 : EndIf 
               Case #Event_VScrollB_LDown    ;[下侧滚动条|上际按键]<鼠标按下>
                  If \Viewer\Row < \VScroll\VaneLast : \Viewer\Row+5 : Else : \CurrEvnetHook=0 : EndIf 
                Case #Event_VScrollW_LDown   ;[右侧滚动条|上移按键]<鼠标按下>
                  If \Viewer\Row>\VScroll\PageLine : \Viewer\Row-\Viewer\HoldRows : Else : \CurrEvnetHook=0 : EndIf 
                  If \Viewer\Row<\VScroll\PageLine : \Viewer\Row=\VScroll\PageLine : EndIf 
               Case #Event_VScrollS_LDown    ;[右侧滚动条|下移按键]<鼠标按下> 
                  If \Viewer\Row<\VScroll\PageLine : \Viewer\Row+\Viewer\HoldRows : Else : \CurrEvnetHook=0 : EndIf 
                  If \Viewer\Row>\VScroll\PageLine : \Viewer\Row=\VScroll\PageLine : EndIf
               ;========== ========== ========== ========== ========== ==========  
               Case #Event_HScrollL_LDown    ;[底部滚动条|左际按键]<鼠标按下>
                  If \Viewer\Col> 0 : \Viewer\Col-5 : Else : \CurrEvnetHook=0 : EndIf 
               Case #Event_HScrollR_LDown    ;[底部滚动条|右际按键]<鼠标按下>
                  If \Viewer\Col < \HScroll\VaneLast : \Viewer\Col+5 
                  ElseIf \AddLineWidth = 0 : \CurrEvnetHook=0 
                  Else : \AddLineWidth+\Font\W*5 : \Viewer\Col+5
                  EndIf 
               Case #Event_HScrollA_LDown    ;[底部滚动条|左移按键]<鼠标按下>
                  If \Viewer\Col>\HScroll\PageLine : \Viewer\Col-20 : Else : \CurrEvnetHook=0 : EndIf 
                  If \Viewer\Col<\HScroll\PageLine : \Viewer\Col=\HScroll\PageLine : EndIf 
               Case #Event_HScrollD_LDown    ;[底部滚动条|右移按键]<鼠标按下>
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

; 当控件获取焦点时
Procedure RichEdit_GadgetHook_SetFocus(*pRichEdit.__RichEditInfo)
   ;创建[文本输入符光标]
   DestroyCaret_()  
   *pRichEdit\EditState & ~#EditState_CaretVisible
   CreateCaret_(*pRichEdit\hGadget, #Null, 1, *pRichEdit\Font\H);
   RichEdit_RedrawGadget(*pRichEdit)
EndProcedure

; <GadgetHook>事件
Procedure RichEdit_GadgetHook(hGadget, uMsg, wParam, lParam) 
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit ;And GetFocus_() = *pRichEdit\hGadget 
      With *pRichEdit
         Select uMsg 
            Case #WM_SETFOCUS       : RichEdit_GadgetHook_SetFocus(*pRichEdit)
            Case #WM_KILLFOCUS 
;             Case #WM_ACTIVATE       : HideCaret_(\hGadget) : \EditState & ~#EditState_CaretVisible
            Case #WM_CHAR           : ;本版本没有输入功能
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
   If hGadgetHook       ; 使用CallWindowProc_()后,某些uMsg命令才有效,不清楚为什么.
      ProcedureReturn CallWindowProc_(hGadgetHook, hGadget, uMsg, wParam, lParam) 
   Else 
      ProcedureReturn DefWindowProc_(hGadget, uMsg, wParam, lParam) 
   EndIf 
EndProcedure 

;- ***********************
; <HOOK|鼠标在上>事件
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

; <HOOK|左键释放>事件
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

; <MouseHook>事件
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
; 加载文本文件到控件
Procedure RichEdit_LoadFile(*pRichEdit.__RichEditInfo, FileID, Flags)
   With *pRichEdit
      ; 清空[文本行]链表的内存
      ForEach \ListTextLine() : FreeMemory(\ListTextLine()\pMemEditChar) : Next 
      ClearList(\ListTextLine())    ;清空[文本行]链表
      ClearList(\ListEditLine())    ;清空[编辑行]链表
      ;置位光标/选区/[可视区]
      \Viewer\Row=0 : \Cursor\Row=0 : \Record\Row=0 : \Cursor\RealRow=0 : \Record\RealRow=0 
      \Viewer\Col=0 : \Cursor\Col=0 : \Record\Col=0 : \Cursor\RealCol=0 : \Record\RealCol=0 
      ; 开始加载文本行
      While Eof(FileID) = 0     
         LineText$ = ReadString(FileID, Flags) 
         If Left(LineText$, 25) = "; IDE Options = PureBasic"
            Break
         EndIf 
         *pElement = AddElement(\ListTextLine())

         ; 开辟[文本行]字符信息内存块,以16字节向下对齐,多出部分为预留空间
         MemorySize = (Len(LineText$)/16*16+16) *  #RichEdit_EditCharSize
         LineWidth  = StringByteLength(LineText$, #PB_Ascii) * \Font\W
         \ListTextLine()\LineText$    = LineText$
         \ListTextLine()\CountChars   = Len(LineText$) 
         \ListTextLine()\LineWidth    = LineWidth                 
         \ListTextLine()\pMemEditChar = AllocateMemory(MemorySize) 

         AddElement(\ListEditLine())            ; 添加[编辑行]
         \ListEditLine()\pElement  = *pElement
         \ListEditLine()\LineIndex = LineIndex
         LineIndex + 1
      Wend
      CloseFile(FileID)
      \EditState & ~ #EditState_EmptyText       ; 设置控件为非空文本状态      
      ; 如果加载的文件为空.则置位文本行
      Result = ListSize(\ListTextLine())        ; 返回值
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
; <调整控件大小>
Procedure RichEdit_Event_ResizeGadget(GadgetID, X, Y, Width, Height)
   ;获取控件信息
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      RichEdit_ResizeGadget(*pRichEdit, X, Y, Width, Height)
   EndIf 
EndProcedure

; <注销控件>
Procedure RichEdit_Event_FreeGadget(GadgetID)
   ;获取控件信息
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   RichEdit_FreeGadget(*pRichEdit, hGadget)
EndProcedure

; <清空控件文本>
Procedure RichEdit_Event_ClearGadgetItems(GadgetID)
   ;获取控件信息
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   With *pRichEdit
      If *pRichEdit
         ; 清空[文本行]链表的内存
         ForEach \ListTextLine() : FreeMemory(\ListTextLine()\pMemEditChar) : Next 
         ClearList(\ListTextLine())    ;清空[文本行]链表
         ClearList(\ListEditLine())    ;清空[编辑行]链表
         ;置位光标/选区/[可视区]
         \Viewer\Row=0 : \Cursor\Row=0 : \Record\Row=0 : \Cursor\RealRow=0 : \Record\RealRow=0 
         \Viewer\Col=0 : \Cursor\Col=0 : \Record\Col=0 : \Cursor\RealCol=0 : \Record\RealCol=0 
         \Fold\StartRow = 0
         \Fold\ToEndRow = 0
         \Fold\Floor    = 0
         ; 初始化
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

; <获取控件文本行数>
Procedure RichEdit_Event_CountGadgetItems(GadgetID)
   ;获取控件信息
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      Result = ListSize(*pRichEdit\ListTextLine())
   EndIf 
   ProcedureReturn Result
EndProcedure

; <新添控件文本行>
Procedure RichEdit_Event_AddGadgetItem(GadgetID, Index, LineText$,  ImageID=0, Flags=0)
   ;获取控件信息
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
            ; 开辟[文本行]字符信息内存块,以16字节向下对齐,多出部分为预留空间
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
            ; 开辟[文本行]字符信息内存块,以16字节向下对齐,多出部分为预留空间
            MemorySize = (Len(LineText$)/16*16+16) *  #RichEdit_EditCharSize
            LineWidth  = StringByteLength(LineText$, #PB_Ascii) * \Font\W
            \ListTextLine()\pMemEditChar = AllocateMemory(MemorySize) 
            \ListTextLine()\LineWidth    = LineWidth
            LastElement(\ListEditLine())           ; 添加[编辑行]
            AddElement(\ListEditLine())            ; 添加[编辑行]
            \ListEditLine()\pElement  = *pElement
            \ListEditLine()\LineIndex = ListIndex(\ListTextLine())
            ClearList(\ListEditLine())
            ForEach  \ListTextLine()
               AddElement(\ListEditLine())            ; 添加[编辑行]
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
            ; 开辟[文本行]字符信息内存块,以16字节向下对齐,多出部分为预留空间
            MemorySize = (Len(LineText$)/16*16+16) *  #RichEdit_EditCharSize
            LineWidth  = StringByteLength(LineText$, #PB_Ascii) * \Font\W
            \ListTextLine()\pMemEditChar = AllocateMemory(MemorySize) 
            \ListTextLine()\LineWidth    = LineWidth
            If \pMaxTextLine And \pMaxTextLine\LineWidth < LineWidth
               \pMaxTextLine = *pElement              ; 设置最大的文本行
            EndIf
            ClearList(\ListEditLine())
            ForEach  \ListTextLine()
               AddElement(\ListEditLine())            ; 添加[编辑行]
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

; <删除控件文本行>
Procedure RichEdit_Event_RemoveGadgetItem(GadgetID, Index)
   ;获取控件信息
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
               AddElement(\ListEditLine())            ; 添加[编辑行]
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

; <设置控件文本内容>
Procedure RichEdit_Event_SetGadgetText(GadgetID, Text$)
   ;获取控件信息
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      With *pRichEdit
         FullText$ = ReplaceString(Text$, Chr(10), "")
         LineCount = CountString(FullText$, Chr(13))
         ; 清空[文本行]链表的内存
         ForEach \ListTextLine() : FreeMemory(\ListTextLine()\pMemEditChar) : Next 
         ClearList(\ListTextLine())    ;清空[文本行]链表
         ClearList(\ListEditLine())    ;清空[编辑行]链表
         ;置位光标/选区/[可视区]
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
            AddElement(\ListEditLine())            ; 添加[编辑行]
            \ListEditLine()\pElement  = *pElement
            \ListEditLine()\LineIndex = LineIndex-1
         Next 
         \EditState & ~ #EditState_EmptyText       ; 设置控件为非空文本状态      
         ; 如果加载的文件为空.则置位文本行
         Result = ListSize(\ListTextLine())        ; 返回值
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

; <获取控件文本内容>
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

; <设置控件当前高亮行> 
Procedure RichEdit_Event_SetGadgetState(GadgetID, State)
   ;获取控件信息
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

; <获取控件当前高亮行位置> 
Procedure RichEdit_Event_GetGadgetState(GadgetID)
   ;获取控件信息
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit : Result = *pRichEdit\Cursor\RealRow : EndIf 
   ProcedureReturn Result
EndProcedure

; <设置控件字体>
Procedure RichEdit_Event_SetGadgetFont(GadgetID, hFont)
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit  ;设置控件样式
      GetObject_(hFont, SizeOf(LOGFONT), @FontInfo.LOGFONT)
      *pRichEdit\Font\hFont = hFont      
      *pRichEdit\Font\Name$ = PeekS(@FontInfo\lfFaceName)        ;获取默认字体的名字
      *pRichEdit\Font\Size  = (-FontInfo\lfHeight*3+0.3)/4       ;根据字体默认高度,计算字体的大小
      RichEdit_SetGadgetFont(*pRichEdit)
      RichEdit_RedrawGadget (*pRichEdit)
   EndIf 
   ProcedureReturn @*pRichEdit\Font
EndProcedure

; <获取控件字体>
Procedure RichEdit_Event_GetGadgetFont(GadgetID)
   hGadget = PeekL(GadgetID)
   *pRichEdit.__RichEditInfo = GetProp_(hGadget, #GadgetClass_RichEdit$)
   If *pRichEdit
      ProcedureReturn *pRichEdit\Font\hFont   
   EndIf 
EndProcedure

; <获取控件颜色> : 兼容PB设置控件的函数[完整设置参考SetGadgetItemColor()]
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

; <获取控件颜色> : 兼容PB设置控件的函数 
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


; <设置控件行数据> ; 返回行信息的指针
Procedure RichEdit_Event_SetGadgetItemData(GadgetID, Index, Value)
   ;获取控件信息
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

; <获取控件行数据>
Procedure RichEdit_Event_GetGadgetItemData(GadgetID, Index)
   ;获取控件信息
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

; <获取控件细节的颜色> : 
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

; <获取控件细节的颜色> : 
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

; <设置控件文本行内容>
Procedure RichEdit_Event_SetGadgetItemText(GadgetID, Index, LineText$, Column=0)
   ;获取控件信息
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
   ;获取控件信息
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

; <设置控件属性>
Procedure RichEdit_Event_SetGadgetAttribute(GadgetID, Attribute, Value)
   ;获取控件信息
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

; <设置控件属性>
Procedure RichEdit_Event_GetGadgetAttribute(GadgetID, Attribute)
   ;获取控件信息
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
;创建一个EDIT类控件
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

   ; 设置控件类型
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
   
   ; 注册控件类型, 1410表示该控件类已经注册了
   Register = RegisterClassEx_(@WndClass)
   If Register = 0 And GetLastError_() <> 1410 : ProcedureReturn 0 : EndIf 

   ; 创建控件
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
      ; 设置控件标识和句柄
      If GadgetID = #PB_Any 
         \GadgetID = Result   : \hGadget  = hGadget
      Else
         \GadgetID = GadgetID : \hGadget  = Result
      EndIf    
      MemorySize    = #RichEdit_MaxShowLines * #RichEdit_FullRowBytes
      \pMemViewChar = AllocateMemory(MemorySize)
      
      ; =======================
      ;创建[反式箭头光标]/[常规箭头光标]/[输入状态光标]
      \Cursor\hRMARK = CreateCursor_(hInstance, 32, 0, 32, 32, ?_Bin_ANDPlane, ?_Bin_XORPlane)
      \Cursor\hARROW = LoadCursor_(0,#IDC_ARROW)
      \Cursor\hIBEAM = LoadCursor_(0,#IDC_IBEAM)
      \EditState     = #EditState_EmptyText|#EditState_FoldVisible
      ; =======================
      ;设置控件样式
      hDefaultFont = GetGadgetFont(#PB_Default)   
      GetObject_(hDefaultFont, SizeOf(LOGFONT), @FontInfo.LOGFONT)
      \Font\hFont = hDefaultFont        
      \Font\Name$ = PeekS(@FontInfo\lfFaceName)        ;获取默认字体的名字
      \Font\Size  = (-FontInfo\lfHeight*3+0.3)/4      ;根据字体默认高度,计算字体的大小
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

; 加载文本到控件
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

; 加载文本到控件
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

; 加载文本到控件
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

; 加载文本到控件
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
   _Bin_ANDPlane:   ; [行符区][反式箭头光标]1
      Data.l  $FFFFFFFF, $FFFFFFFF, $FDFFFFFF, $F9FFFFFF, $F1FFFFFF, $E1FFFFFF, $C1FFFFFF, $81FFFFFF
      Data.l  $01FFFFFF, $01FEFFFF, $01FCFFFF, $01F8FFFF, $81FFFFFF, $91FFFFFF, $39FFFFFF, $3DFFFFFF
      Data.l  $7FFEFFFF, $7FFEFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF
      Data.l  $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF
   _Bin_XORPlane:   ; [行符区][反式箭头光标]2
      Data.l  $01000000, $03000000, $07000000, $0F000000, $1F000000, $3F000000, $7F000000, $FF000000
      Data.l  $FF010000, $FF030000, $FF070000, $FF0F0000, $FF0F0000, $FF000000, $EF010000, $E7010000
      Data.l  $C3030000, $C0030000, $80010000, $00000000, $00000000, $00000000, $00000000, $00000000
      Data.l  $00000000, $00000000, $00000000, $00000000, $00000000, $00000000, $00000000, $00000000

   _Bin_FormatOfCommon:   ; 常规格式的文本格式
      Data.l $000000, $FFFFFF, $00, $000000, $FFFFFF, $00, $000000, $FFFFFF, $00 ;VeiwArea/Comments/Constant
      Data.l $000000, $FFFFFF, $00, $000000, $FFFFFF, $00                        ;DQString/SQString
      Data.l $000000, $FFFFFF, $00, $000000, $FFFFFF, $00, $000000, $FFFFFF, $00 ;Special1/Special1/Operator
      Data.l $000000, $FFFFFF, $01, $000000, $FFFFFF, $01, $000000, $FFFFFF, $01 ;FoldWord/KeyWord1/KeyWord2
      Data.l $000000, $FFFFFF, $01, $000000, $FFFFFF, $01, $000000, $FFFFFF, $01 ;KeyWord3/KeyWord4/KeyWord5
      Data.l $000000, $FFFFFF, $00, $FFFFFF, $CCCCCC, $00                        ;Function/TipWords 
      Data.l $FFFFFF, $FF9933, $00, $000000, $EEEEEE, $00, $888888, $EEEEEE, $00 ;Selected/CaretRow/MarkArea
      Data.l $808080, $F0F0F0, $00, $F08040, $FFF8E8, $00, $F85810, $F8E8B8, $00 ;NScroll/MScroll/DScroll

   _Bin_FormatOfPB:   ; PB格式的文本格式
      Data.l $000000, $DFFFFF, $00, $AAAA00, $DFFFFF, $00, $724C92, $DFFFFF, $00 ;VeiwArea/Comments/Constant
      Data.l $FF8000, $DFFFFF, $00, $C5057F, $DFFFFF, $00                        ;DQString/SQString
      Data.l $0044FF, $DFFFFF, $00, $0044FF, $DFFFFF, $00, $0044FF, $DFFFFF, $00 ;Special1/Special1/Operator
      Data.l $666600, $B0FFFF, $01, $666600, $DFFFFF, $01, $666600, $DFFFFF, $01 ;FoldWord/KeyWord1/KeyWord2
      Data.l $666600, $DFFFFF, $01, $666600, $DFFFFF, $01, $666600, $DFFFFF, $01 ;KeyWord3/KeyWord4/KeyWord5
      Data.l $666600, $DFFFFF, $00, $FFFFFF, $A7FFB0, $01                        ;Function/TipWords 
      Data.l $FFFFFF, $FF9933, $00, $F8A4F8, $B8FFFF, $00, $888888, $CFFFFF, $00 ;Selected/CaretRow/MarkArea
      Data.l $808080, $F0F0F0, $00, $F08040, $FFF8E8, $00, $F85810, $F8E8B8, $00 ;NScroll/MScroll/DScroll

   _Bin_FormatOfLUA:   ; LUA格式的文本格式
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

   hWindow = OpenWindow(0, 0, 0, 800, 600, "测试", $CF0001)
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
; Executable = F:\桌面\XXXXX.exe
; Constant = #MCS_Test=5
; EnableUnicode