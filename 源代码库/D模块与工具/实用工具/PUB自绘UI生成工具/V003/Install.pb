




;-[Constant]
#Screen_Version$      = "V003"
#Screen_Caption$      = "迷路PureBasic自绘UI代码生成工具 - "+ #Screen_Version$
#Screen_ScrollBarW    = 18
#Screen_ScrollBarH    = 18
#Screen_AboutMilooW   = 250
#Screen_AttributeW    = 250
#Screen_GroupItemW    = 100
#Screen_GadgetItemW   = #Screen_AttributeW-#Screen_GroupItemW-10
#Canvas_BackColor     = $C0C0C0
#Window_BackColor     = $F0F0F0
#SysButton_CloseColor = $C03954FF
#Attribute_BackColor  = $F0F0F0
#Attribute_FontColor  = $000000
#Attribute_LineColor  = $808080
#Attribute_TitleColor = $E0E0E0
#DesignsFile_Flags    = $4642504D
#MCS_RichEdit_Format  = $01   
#FormatType_PB        = $01
#TIMER_SizeWindow     = 1
#TIMER_BalloonTip     = 2

;-[Enumeration]
Enumeration Screen
   #winScreen
   #winMessage
   #winBalloon
   #winVersion
   #rtxVersion
   #imgVersion
   #lblVersion
   #lblCompiler
   #txtCompiler
   #btnCompiler
   ;========
   #frmScreen
   #wsbScreen
   #wtbScreen
   #lblScreen
   #rtxSourceCode
   #cvsIllustrate
   #cvsAttributes
   #srcIllustrateH   ;水平滚动条
   #srcIllustrateV   ;垂直滚动条
EndEnumeration 
   
Enumeration Screen
   #frmScreenLayout     ;【窗体布局】
      #chkCanvasImage   
      #cmbLayoutStyle
      #txtWindowRealW   ;当前宽度 
      #txtWindowRealH   ;当前高度 
      #chkSizeWindow    ;可调整大小 
      #txtWindowSideL   ;左际留边 
      #txtWindowSideR   ;右际留边
      #txtWindowSideT   ;顶部留边 
      #txtWindowSideB   ;底部留边 
   #frmSystemButton     ;【系统按键】
      #cmbSystemButton  ;系统按键
      #chkSysCloseBox   ;关闭按键
      #chkSysMinimize   ;最小化按键
      #chkSysMaximize   ;最大化按键
      #chkSysNormalcy   ;正常化按键
      #chkSysSettings   ;体窗设置按键
      #chkSysStickyNO   ;体窗置顶按键

      
   #frmCaptionBar       ;【标题栏】
      #chkCaptionBar    ;启用
      #txtCaptionName   ;标题栏名称
      #chkIncludeIcon
      #txtCaptionIcon   ;界面图标
      #btnCaptionIcon   ;界面图标
      #txtCaptionBarX
      #txtCaptionBarH   ;相对高度  
   #frmStatusBar        ;【状态栏】
      #chkStatusBar     ;启用
      #chkStatusSize    ;缩放小图标
      #txtStatusBarX    ;X坐标
      #txtStatusBarH    ;相对高度
   #frmIcoToolbar       ;【工具栏】
      #chkIcoToolbar    ;启用
      #txtIcoToolbarY   ;Y坐标
      #txtIcoToolbarW   ;相对宽度
   #frmColorsPrefer     ;【颜色设置】
      #cmbColorsPrefer    ;颜色设置
      #chkUseGradients    ;渐变效果
      #chkAniGradients    ;渐变效果
      #cmbGradientType
      #cvsSetBackColor    ;背景色
      #cvsSetForeColor    ;前景色
      #cvsSetFontColor    ;字体色
      #cvsSetSideColor    ;边框色
      #cvsSetHighColor    ;高亮色
      #cvsSetRenderColor  ;渲染色
      #cvsSetShadowColor  ;阴影色
      #txtSetBackColor    ;背景色
      #txtSetForeColor    ;前景色
      #txtSetFontColor    ;字体色
      #txtSetSideColor    ;边框色
      #txtSetHighColor    ;高亮色
      #txtSetRenderColor  ;渲染色
      #txtSetShadowColor  ;阴影色
      
   #frmMiscellaneous   ;【杂项设置】
      #chkMessageBox       ;信息对话框
      #chkBalloonTip       ;启用提示文
      #chkPreference       ;设置文件
      #chkSystemDrop       ;系统拖放
      #chkMultiFiles
EndEnumeration 

Enumeration Screen
   #frmToolBar
   #wtbToolNewFile
   #wtbToolOpenFile
   #wtbToolSaveFile
   #wtbToolSaveAs
   #wtbToolCloseFile
   #wtbToolGenerate
   #wtbToolPureBasic
   #wtbToolSticky
   #wtbToolAboutMe
   
   ;===========
   #wtbShowMessage
   ;===========
   #imgBalloon
   ;===========
   #fntDefault
   #fntRichEdit
   #fntVersion
EndEnumeration

Enumeration Screen
   #btnMessageClose 
   #btnMessageYes 
   #btnMessageNo 
   #btnMessageCancel   
EndEnumeration

Enumeration
   #ButtonStyle_Flat
   #ButtonStyle_Bread
   #ButtonStyle_Piano
   #ButtonStyle_Cake
   #ButtonStyle_Capsule
   #ButtonStyle_Groove
   #ButtonStyle_Count
EndEnumeration

;-[Structure]
;=======================
;控件基本结构
;- __GadgetInfo
Structure __GadgetInfo
   X.l
   Y.l
   R.l
   B.l
   W.l
   H.l
   ;=============
   NormalcyID.i
   MouseTopID.i
   HoldDownID.i
   ;=============
   BalloonTip$
   ;=============
   IsHide.b
   IsCreate.b
   keep.b[15]
EndStructure

;对话框结构
;- __MessageRequester
Structure __MessageRequester
   hWindow.l
   hBackImage.i
   hWindowHook.i
   WindowW.w
   WindowH.w
   TitleH.l
   NoticeH.l
   Flags.l
   hMessageIcon.i
   Title$
   List ListText$()
   BKImageID.i
   btnMessageClose.__GadgetInfo
   btnMessageYes.__GadgetInfo
   btnMessageNo.__GadgetInfo
   btnMessageCancel.__GadgetInfo
   *pMouseTop.__GadgetInfo    ;当前光标在上
   *pHoldDown.__GadgetInfo    ;当前光标按住
   *pSelected.__GadgetInfo    ;选中状态: 预留兼对齐作用
   IsExitWindow.b
   MessageResult.b
EndStructure

;- __BalloonTipInfo
Structure __BalloonTipInfo
   hWindow.l
   hBackImage.i
   hWindowHook.i
   WindowW.w
   WindowH.w
   *pBalloonTip.__GadgetInfo
EndStructure

;- __ColorStyleInfo
Structure __ColorStyleInfo
   *pMemColor
   ColorStyle$
EndStructure

;- __EnumScintilla
Structure __EnumScintilla
   hGadget.l
   Map MaphGadget.l()
EndStructure 
   
;=================
;- _AttriItemsInfo
Structure _AttriItemsInfo
   X.w
   Y.w
   R.w
   B.w
   W.w
   H.w
   Title$
   Notice$
   GadgetID1.l
   GadgetID2.l
   *pParent.__AttriGroupInfo
EndStructure

;- __AttriGroupInfo
Structure __AttriGroupInfo
   X.w
   Y.w
   R.w
   B.w
   W.w
   H.w
   Title$
   Notice$
   GadgetID.l
   List ListAttriItems._AttriItemsInfo()
   FoldState.b
EndStructure

;- __ScreenColorInfo
Structure __ScreenColorInfo
   BackColor.l    ;背景色
   ForeColor.l    ;前景色
   FontColor.l    ;字体色
   SideColor.l    ;边框色
   HighColor.l    ;高亮色
   RenderColor.l  ;渲染色
   ShadowColor.l  ;阴影色
   IsUseGradient.b   ;启用渐变效果
   IsAniGradient.b   ;启用反向渐变
   GradientTpyes.b   ;渐变效果类型
   Keep.b   
   ColorTable$
EndStructure 


;- __ProjectInfo
Structure __ProjectInfo
   WindowW.W
   WindowH.W
   WinSideL.w
   WinSideR.w
   WinSideT.w
   WinSideB.w
   CaptionX.w
   CaptionH.w
   StatusX.w
   StatusH.w
   ToolBarY.w
   ToolBarW.w
   KeepW.w[4+16]
   ;==================
   Caption$
   SoftwareIcon$
   SoftwareIconID.i
   CreateDate.l
   DesignFile$
   SourceFile$
   OpenSuccess.l
   List ListColor.__ScreenColorInfo()
   Map *pMapColor.__ScreenColorInfo()
   ;==================
   SystemButtonSylte.b     ;系统按键风格
   UIColorStyleIndex.b     ;UI颜色风格
   IsUseSysCloseBox.b      ;关闭按键
   IsUseSysMinimize.b      ;最小化按键
   IsUseSysMaximize.b      ;最大化按键
   IsUseSysNormalcy.b      ;正常化按键
   IsUseSysSettings.b      ;窗体设置按键
   IsUseSysStickyNO.b      ;体窗置顶按键
   ;==================
   IsUseCanvasImage.b      ;启用画布背景
   IsUseCaptionBar.b       ;启用标题栏
   IsUseStatusBar.b        ;启用状态栏
   IsUseIcoToolBar.b       ;启用工具栏
   IsUseOperateArea.b      ;启用工具作
   IsUseIncludeIcon.b      ;启用图标资源包含
   IsUseSizeWindow.b       ;是否支持窗体改变大小
   IsUseStatusSize.b       ;启用缩放小图标
   IsUsePreference.b       ;插入设置文件
   IsUseBalloonTip.b       ;设置提示文
   IsUseMessageBox.b       ;插入信息对话框的代码
   IsUseSystemDrop.b       ;启用系统拖放
   IsUseMultiFiles.b       ;启用系统拖放多个文件
   KeepB.b[13]
EndStructure

;- __ScreenInfo
Structure __ScreenInfo
   hWindow.i
   hWindowHook.i
   WindowX.w
   WindowY.w
   WindowW.w
   WindowH.w
   ScrollAreaX.w
   ScrollAreaY.w
   OffsetX.w
   OffsetY.w
   ;=================
   hSoftwareIcon.i
   hScintilla.i
   SystemPath$
   Compiler$
   VersionNotice$
   ;=================
   hSizing.i
   hLeftRight.i
   hUpDown.i
   ;=================
   btnCloseBox.__GadgetInfo
   btnMinimize.__GadgetInfo
   btnNormalcy.__GadgetInfo
   btnMaximize.__GadgetInfo
   btnSettings.__GadgetInfo
   btnStickyNO.__GadgetInfo
   btnStickyNC.__GadgetInfo
   *pMouseTop.__GadgetInfo    ;当前光标在上
   *pHoldDown.__GadgetInfo    ;当前光标按住
   *pSelected.__GadgetInfo    ;选中状态: 预留兼对齐作用
   ;=================
   List ListColorStyle.__ColorStyleInfo()
   List ListAttriGroup.__AttriGroupInfo()      
   Map *pMapAttriGroup.__AttriGroupInfo()
   Map *pMapAttriItems._AttriItemsInfo()
   IsExitWindow.b
   IsStickyWindow.b
   IsGenerateView.b
   IsTIMER_SizeWindow.b    ;
EndStructure

;-[Global]
Global _Screen.__ScreenInfo
Global _Project.__ProjectInfo
Global _Message.__MessageRequester
Global _Balloon.__BalloonTipInfo

Prototype.i GetModuleFileNameExW(hProcess.l,hModule.l,*lpFilename,nSize.i)
Declare Create_btnCloseBox(*pGadget.__GadgetInfo)
Declare Create_btnMinimize(*pGadget.__GadgetInfo)
Declare Create_btnMaximize(*pGadget.__GadgetInfo)
Declare Create_btnNormalcy(*pGadget.__GadgetInfo)
Declare Create_btnSettings(*pGadget.__GadgetInfo)
Declare Create_btnStickyNO(*pGadget.__GadgetInfo)
Declare Create_btnStickyNC(*pGadget.__GadgetInfo)
Declare Message_Redraw()




;- ==========================
;- VersionNotice$
With _Screen
   \VersionNotice$ + "【V003】版 2019.03.19"                         
   \VersionNotice$+#CRLF$+"新增 [系统按键]中的[琴键式风格]和[胶囊式风格]."
   \VersionNotice$+#CRLF$+"新增 [系统按键]中的[设置按键]和[置顶按键]功能."
   \VersionNotice$+#CRLF$+"新增 [杂项设置]中的[系统拖放]功能."
   \VersionNotice$+#CRLF$+"新增 工具栏中在PUB编辑器打开源代码功能."
   \VersionNotice$+#CRLF$+"更新 生成工具中的工具栏图标."
   \VersionNotice$+#CRLF$+"删除 工具栏中复制代码的功能."
   \VersionNotice$+#CRLF$+"修复 若干细节绘制."
   \VersionNotice$+#CRLF$
   
   \VersionNotice$+#CRLF$+"【V002】版 2019.03.12"
   \VersionNotice$+#CRLF$+"新增 控件不闪烁处理方案的注释实例."    
   \VersionNotice$+#CRLF$+"新增 几组界面颜色风格."        
   \VersionNotice$+#CRLF$+"修复 窗体调整大小时异常的BUG."
   \VersionNotice$+#CRLF$+"修复 几处生成的源代码有误的BUG."
   \VersionNotice$+#CRLF$+"修复 系统小按键渲染和几处界面绘制的BUG."
           
   
   \VersionNotice$+#CRLF$
   \VersionNotice$+#CRLF$+"【V001】版 2019.03.11"
   \VersionNotice$+#CRLF$+"基本版功能."
   \VersionNotice$+#CRLF$+"支持 画布背景和窗体刷子背景两种模式."
   \VersionNotice$+#CRLF$+"支持 并提供了多种颜色风格设置选择."
   \VersionNotice$+#CRLF$+"支持 系统小按键功能及窗体大小调整."
   \VersionNotice$+#CRLF$+"支持 标题栏,工具栏,信息对话框.等等"
   \VersionNotice$+#CRLF$
EndWith



;- ==========================
;- [Macro]
;[宏]判断操作域
Macro Macro_Gadget_InRect1(IsUseGadget, Gadget)
   Bool(Gadget\IsCreate = #True And IsUseGadget And X > Gadget\X And X < Gadget\R And Y > Gadget\Y And Y < Gadget\B)
EndMacro

Macro Macro_Gadget_InRect2(IsUseGadget, Gadget)
   Bool(Gadget\IsHide = #False And Gadget\IsCreate = #True And IsUseGadget And X > Gadget\X And X < Gadget\R And Y > Gadget\Y And Y < Gadget\B)
EndMacro

Macro Macro_Gadget_InRect3(Gadget)
   Bool(Gadget\IsCreate = #True And *pMouse\X > Gadget\X And *pMouse\X < Gadget\R And *pMouse\Y > Gadget\Y And *pMouse\Y < Gadget\B)
EndMacro



;- ##########################
;- [DataSection]      
DataSection
_Bin_GadgetColor: ;背景色,前景色,字体色,边框色,高亮色,
   ;       背景色,    前景色,    字体色,    边框色,    高亮色          [深灰色风格]
   Data.l $FF383838, $FF888888, $FFFFFFFF, $FF181818, $FF707070, $0   ;窗体布局
   Data.l $FF585858, $FF888888, $FFFFFFFF, $FF282828, $FF707070, $0   ;标题栏
   Data.l $FF585858, $FF888888, $FFFFFFFF, $FF282828, $FF707070, $0   ;状态栏
   Data.l $ff585858, $FF888888, $FFFFFFFF, $FF282828, $FF707070, $0   ;工具栏
   Data.l $ff585858, $ff888888, $ffFFFFFF, $ff181818, $ff888888, $1   ;对话框按键
_End_PartSytle:
   ;       背景色,    前景色,    字体色,    边框色,    高亮色          [嫣红色风格]
   Data.l $FF885EF0, $FFDB75FF, $FFFFFFFF, $FF51228C, $FFB981FF, $0   ;窗体布局
   Data.l $FF9D5BEF, $FFDB75FF, $FFFFFFFF, $FF51228C, $FFB981FF, $1   ;标题栏
   Data.l $FF9D5BEF, $FFDB75FF, $FFFFFFFF, $FF51228C, $FFB981FF, $0   ;状态栏
   Data.l $FF9D5BEF, $FFDB75FF, $FFFFFFFF, $FF51228C, $FFB981FF, $1   ;工具栏
   Data.l $FF9D5BEF, $FFDB75FF, $FFFFFFFF, $FF51228C, $FFB981FF, $1   ;对话框按键
   ;       背景色,    前景色,    字体色,    边框色,    高亮色          [橙红色风格]
   Data.l $FF2E80CA, $FF4ED5F2, $FF000000, $FF0E508C, $FF80B4E4, $0   ;窗体布局
   Data.l $FF529CDF, $FF4ED5F2, $FF000000, $FF0E508C, $FF80B4E4, $1   ;标题栏
   Data.l $FF529CDF, $FF4ED5F2, $FF000000, $FF0E508C, $FF80B4E4, $0   ;状态栏
   Data.l $FF529CDF, $FF4ED5F2, $FF000000, $FF0E508C, $FF80B4E4, $1   ;工具栏
   Data.l $FF529CDF, $FF4ED5F2, $FF000000, $FF0E508C, $FF80B4E4, $1   ;对话框按键
   ;       背景色,    前景色,    字体色,    边框色,    高亮色          [土黄色风格]
   Data.l $FF2E8AD1, $FF32C9FC, $FF000000, $FF0E508C, $FF80B4E4, $0   ;窗体布局
   Data.l $FF299EE4, $FF32C9FC, $FF000000, $FF0E508C, $FF80B4E4, $1   ;标题栏
   Data.l $FF299EE4, $FF32C9FC, $FF000000, $FF0E508C, $FF80B4E4, $0   ;状态栏
   Data.l $FF299EE4, $FF32C9FC, $FF000000, $FF0E508C, $FF80B4E4, $1   ;工具栏
   Data.l $FF299EE4, $FF32C9FC, $FF000000, $FF0E508C, $FF80B4E4, $1   ;对话框按键
   ;       背景色,    前景色,    字体色,    边框色,    高亮色          [深紫色风格]
   Data.l $FF9D3252, $FFED7496, $FFFFFFFF, $FF60031E, $FFB88493, $0   ;窗体布局
   Data.l $FFDB4C75, $FFED7496, $FFFFFFFF, $FF60031E, $FFB88493, $1   ;标题栏
   Data.l $FFDB4C75, $FFED7496, $FFFFFFFF, $FF60031E, $FFB88493, $0   ;状态栏
   Data.l $FFDB4C75, $FFED7496, $FFFFFFFF, $FF60031E, $FFB88493, $1   ;工具栏
   Data.l $FFDB4C75, $FFED7496, $FFFFFFFF, $FF60031E, $FFB88493, $1   ;对话框按键
   ;       背景色,    前景色,    字体色,    边框色,    高亮色          [深绿色风格]
   Data.l $FF41631B, $FF688D47, $FFFFFFFF, $FF1E3D02, $FFA0B88A, $0   ;窗体布局
   Data.l $FF43721C, $FF688D47, $FFFFFFFF, $FF1E3D02, $FFA0B88A, $1   ;标题栏
   Data.l $FF43721C, $FF688D47, $FFFFFFFF, $FF1E3D02, $FFA0B88A, $0   ;状态栏
   Data.l $FF43721C, $FF688D47, $FFFFFFFF, $FF1E3D02, $FFA0B88A, $1   ;工具栏
   Data.l $FF43721C, $FF688D47, $FFFFFFFF, $FF1E3D02, $FFA0B88A, $1   ;对话框按键
   ;       背景色,    前景色,    字体色,    边框色,    高亮色          [深蓝色风格]
   Data.l $FFB86010, $FFF09830, $FFFFFFFF, $FF883800, $FFD88838, $0   ;窗体布局
   Data.l $FFD07020, $FFF09830, $FFFFFFFF, $FF883800, $FFD88838, $0   ;标题栏
   Data.l $FFD07020, $FFF09830, $FFFFFFFF, $FF883800, $FFD88838, $0   ;状态栏
   Data.l $FFD07020, $FFF09830, $FFFFFFFF, $FF883800, $FFD88838, $0   ;工具栏
   Data.l $FFD07020, $FFF09830, $FFFFFFFF, $FF883800, $FFD88838, $1   ;对话框按键
   ;       背景色,    前景色,    字体色,    边框色,    高亮色          [深青色风格]
   Data.l $FFE9E7E6, $FFFFFFFF, $FF000000, $FF000000, $FF9E9B8C, $0   ;窗体布局
   Data.l $FF3B392F, $FF726F60, $FFFFFFFF, $FF000000, $FF9E9B8C, $0   ;标题栏
   Data.l $FF3B392F, $FF726F60, $FFFFFFFF, $FF000000, $FF9E9B8C, $0   ;状态栏
   Data.l $FF3B392F, $FF726F60, $FFFFFFFF, $FF000000, $FF9E9B8C, $0   ;工具栏
   Data.l $FF3B392F, $FF726F60, $FFFFFFFF, $FF000000, $FF9E9B8C, $1   ;对话框按键

_ICON_ToolIcon:
   IncludeBinary ".\Image\ToolIcon.png" 

_Image_PBLogo:
   IncludeBinary ".\Image\PBLogo.png" 
EndDataSection














; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 289
; FirstLine = 89
; Folding = AM--
; EnableXP
; Executable = 迷路代码库工具2.exe
; EnableUnicode