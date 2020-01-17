;**********************************************************************
;********           迷路PureBasic自绘UI代码生成工具            ********
;********          开发者:迷路仟/Miloo [QQ:714095563]          ********
;**********************************************************************
;功能:自动生成自绘窗体界面的源代码,节省开发时间.


;-[Constant]
#Screen_Version$      = "V002"
#Screen_Caption$      = "迷路PureBasic自绘UI代码生成工具 - "+ #Screen_Version$
#Screen_ScrollBarW    = 18
#Screen_ScrollBarH    = 18
#Screen_AboutMilooW   = 250
#Screen_AttributeW    = 250
#Screen_GroupItemW    = 090
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
   #frmMiscellaneous      ;【杂项设置】
      #chkMessageBox
      #chkBalloonTip
      #chkPreference
      
EndEnumeration 

Enumeration Screen
   #frmToolBar
   #wtbToolNewFile
   #wtbToolOpenFile
   #wtbToolSaveFile
   #wtbToolSaveAs
   #wtbToolCloseFile
   #wtbToolGenerate
   #wtbToolCopyeCode
   #wtbToolSticky
   #wtbToolVersion
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
   #ButtonStyle_Cake
   #ButtonStyle_Count
EndEnumeration

;-[Structure]
;=======================
;控件基本结构
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

Structure __BalloonTipInfo
   hWindow.l
   hBackImage.i
   hWindowHook.i
   WindowW.w
   WindowH.w
   *pBalloonTip.__GadgetInfo
EndStructure

Structure __ColorStyleInfo
   *pMemColor
   ColorStyle$
EndStructure
;=================
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
   KeepW.w[4]
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
   KeepB.b[15]
EndStructure

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
   SystemPath$
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
Declare Create_btnCloseBox(*pGadget.__GadgetInfo)
Declare Create_btnMinimize(*pGadget.__GadgetInfo)
Declare Create_btnMaximize(*pGadget.__GadgetInfo)
Declare Create_btnNormalcy(*pGadget.__GadgetInfo)
Declare Create_btnSettings(*pGadget.__GadgetInfo)
Declare Message_Redraw()




XIncludeFile ".\GenerateCode.pb"
XIncludeFile ".\VersionNotice.pb"
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

;-==========================
;-[Redraw]
;[控件]绘制背景
Procedure Redraw_Gadget(*pGadget.__GadgetInfo, X, Y)
   With *pGadget
      If *pGadget = 0 : ProcedureReturn : EndIf 
      If *pGadget\IsHide = #True : ProcedureReturn : EndIf 
      If *pGadget\IsCreate = #False : ProcedureReturn : EndIf 
      If X <> #PB_Ignore : \X = X : \R = \X+\W : EndIf 
      If Y <> #PB_Ignore : \Y = Y : \B = \Y+\H : EndIf 
      If _Screen\pHoldDown = *pGadget And IsImage(\HoldDownID)
         DrawAlphaImage(ImageID(\HoldDownID), \X, \Y)
      ElseIf _Screen\pMouseTop = *pGadget And IsImage(\MouseTopID)
         DrawAlphaImage(ImageID(\MouseTopID), \X, \Y)
      ElseIf IsImage(\NormalcyID) 
         DrawAlphaImage(ImageID(\NormalcyID), \X, \Y)
      EndIf 
   EndWith
EndProcedure


Procedure Redraw_Gradient(*pColor.__ScreenColorInfo, X, Y, W, H)
   If *pColor\IsUseGradient
      DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)  
      If *pColor\IsAniGradient
         BackColor (*pColor\BackColor) : FrontColor(*pColor\ForeColor)
      Else 
         BackColor (*pColor\ForeColor) : FrontColor(*pColor\BackColor)
      EndIf 
      Select *pColor\GradientTpyes
         Case 0 : LinearGradient(0, Y, 0, Y+H)                 ;上下性线渐变
         Case 1 : LinearGradient(X, 0, X+W, 0)                 ;左右性线渐变  
         Case 2 : LinearGradient(X, Y, X+W, Y+H)               ;左上对角性线渐变 
         Case 3 : LinearGradient(X, Y+H, X+W, Y)               ;右上对角性线渐变
         Case 4 : EllipticalGradient(X+W/2, Y+H/2, W/2, H/2)   ;中心椭圆渐变   
         Case 5 : EllipticalGradient(X+0, Y+0, W, H)           ;左上椭圆渐变  
         Case 6 : EllipticalGradient(X+W, Y+0, W, H)           ;右上椭圆渐变 
         Case 7 : EllipticalGradient(X+0, Y+H, W, H)           ;左下椭圆渐变
         Case 8 : EllipticalGradient(X+W, Y+H, W, H)           ;右下椭圆渐变 
      EndSelect
   Else 
      DrawingMode(#PB_2DDrawing_AlphaBlend)
   EndIf 
   Box(X, Y, W, H, *pColor\BackColor)
EndProcedure


Procedure Redraw_cvsIllustrate()
   CanvasW = GadgetWidth (#cvsIllustrate)
   CanvasH = GadgetHeight(#cvsIllustrate)
   If StartDrawing(CanvasOutput(#cvsIllustrate))
      Box(0, 0, CanvasW, CanvasH, #Canvas_BackColor)
      ;计算画布作业域
      WindowW  = _Project\WindowW
      WindowH  = _Project\WindowH
      ;{
      If CanvasW-30 > WindowW And CanvasH-30 > WindowH
         OperateW = CanvasW
         OperateH = CanvasH
         WindowX  = (OperateW-WindowW)/2
         WindowY  = (OperateH-WindowH)/2
         HideGadget(#srcIllustrateH, #True)
         HideGadget(#srcIllustrateV, #True)
         _Screen\ScrollAreaX = 0
         _Screen\ScrollAreaY = 0
      ElseIf CanvasW-30 <= WindowW And CanvasH-30-#Screen_ScrollBarH >= WindowH
         OperateW = CanvasW-15
         OperateH = CanvasH-#Screen_ScrollBarH-4
         WindowX  = 15
         WindowY  = (OperateH-WindowH)/2
         HideGadget(#srcIllustrateH, #False)
         HideGadget(#srcIllustrateV, #True)
         Box(OperateW-#Screen_ScrollBarW-4+15, OperateH, #Screen_ScrollBarW+1, #Screen_ScrollBarH+1, #Window_BackColor)
         _Screen\ScrollAreaY = 0
         SetGadgetAttribute(#srcIllustrateH, #PB_ScrollBar_Maximum, WindowW-OperateW+4+30)

      ElseIf CanvasW-30-#Screen_ScrollBarW >= WindowW And CanvasH-30 <= WindowH
         OperateW = CanvasW-#Screen_ScrollBarH-4
         OperateH = CanvasH-15
         WindowX  = (OperateW-WindowW)/2
         WindowY  = 15
         HideGadget(#srcIllustrateH, #True)
         HideGadget(#srcIllustrateV, #False)
         Box(OperateW, OperateH-#Screen_ScrollBarH-4+15, #Screen_ScrollBarW+1, #Screen_ScrollBarH+1, #Window_BackColor)
         _Screen\ScrollAreaX = 0
         SetGadgetAttribute(#srcIllustrateV, #PB_ScrollBar_Maximum, WindowH-OperateH+4+30)
      Else
         OperateW = CanvasW-#Screen_ScrollBarW-4-15
         OperateH = CanvasH-#Screen_ScrollBarH-4-15
         WindowX  = 15
         WindowY  = 15
         Box(OperateW+15, OperateH+15, #Screen_ScrollBarW+1, #Screen_ScrollBarH+1, #Window_BackColor)
         HideGadget(#srcIllustrateH, #False)
         HideGadget(#srcIllustrateV, #False)
         SetGadgetAttribute(#srcIllustrateH, #PB_ScrollBar_Maximum, WindowW-OperateW+4+30)
         SetGadgetAttribute(#srcIllustrateV, #PB_ScrollBar_Maximum, WindowH-OperateH+4+30)
      EndIf 
      ;}

      With _Project

         ClipOutput(WindowX, WindowY, OperateW, OperateH) 
            DrawingMode(#PB_2DDrawing_Default)
            _Screen\OffsetX = WindowX-_Screen\ScrollAreaX
            _Screen\OffsetY = WindowY-_Screen\ScrollAreaY
            SetOrigin(_Screen\OffsetX, _Screen\OffsetY) 
            ;====== 窗体布局 ======
            *pColorWindow.__ScreenColorInfo = \pMapColor("窗体布局")
            DrawingFont(FontID(#fntDefault))
            Box(0, 0, WindowW, WindowH, *pColorWindow\BackColor & $FFFFFF)
            Redraw_Gradient(*pColorWindow, 0, 0, WindowW, WindowH)
            Box(0, 0, WindowW, WindowH, *pColorWindow\BackColor)
            
            ;====== 标题栏 ======
            If \IsUseCaptionBar     ;启用标题栏
               *pColorCaption.__ScreenColorInfo = \pMapColor("标题栏")
               Redraw_Gradient(*pColorCaption, \CaptionX, 0, WindowW-\CaptionX, \CaptionH)
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               If \CaptionX = 0 
                  Box(1, 0, 1, \CaptionH, *pColorCaption\HighColor)
                  Box(1, 1, WindowW-1, 1, *pColorCaption\HighColor)
                  Box(0, \CaptionH-1, WindowW, 1, *pColorCaption\SideColor)
               Else 
                  Box(\CaptionX+0, 0, 1, \CaptionH, *pColorCaption\HighColor)
                  Box(\CaptionX+0, 1, WindowW-\CaptionX-1, 1, *pColorCaption\HighColor)
                  Box(\CaptionX+0, \CaptionH-1, WindowW-\CaptionX, 1, *pColorCaption\SideColor)
               EndIf 
               IconHeight = \CaptionH-8
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Transparent)
               If IsImage(\SoftwareIconID)
                  DrawImage(ImageID(\SoftwareIconID), \CaptionX+10, (\CaptionH-IconHeight)/2, IconHeight, IconHeight)
                  DrawText(\CaptionX+20+IconHeight, (\CaptionH-TextHeight(\Caption$))/2, \Caption$, *pColorCaption\FontColor)
               Else  
                  DrawImage(_Screen\hSoftwareIcon, \CaptionX+10, (\CaptionH-IconHeight)/2, IconHeight, IconHeight)             
                  DrawText(\CaptionX+20+IconHeight, (\CaptionH-TextHeight(\Caption$))/2, \Caption$, *pColorCaption\FontColor)
               EndIf 
               AreaY = \CaptionH
            Else 
               AreaY = 1
            EndIf 
            
            ;====== 工具栏 ======
            If \IsUseIcoToolBar 
               *pColorIcoTool.__ScreenColorInfo = \pMapColor("工具栏")
               If \CaptionX < \ToolBarW And \IsUseCaptionBar 
                  ToolBarY = \CaptionH+\ToolBarY : ToolBarH = WindowH-\ToolBarY-\CaptionH
               Else 
                  ToolBarY = \ToolBarY : ToolBarH = WindowH-\ToolBarY
               EndIf 
               Redraw_Gradient(*pColorIcoTool, 0, ToolBarY, \ToolBarW, ToolBarH)
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               If ToolBarY = 0 
                  Box(1, 1, 1, ToolBarH, *pColorIcoTool\HighColor)
                  Box(0, 1, \ToolBarW, 1, *pColorIcoTool\HighColor)
                  Box(\ToolBarW-1, 0, 1, ToolBarH, *pColorIcoTool\SideColor)
               Else 
                  Box(1, ToolBarY, 1, ToolBarH, *pColorIcoTool\HighColor)
                  Box(0, ToolBarY, \ToolBarW, 1, *pColorIcoTool\HighColor)
                  Box(\ToolBarW-1, ToolBarY, 1, ToolBarH, *pColorIcoTool\SideColor)
               EndIf 
               AreaX = \ToolBarW
            Else 
               AreaX = 1
            EndIf   
            
            ;====== 状态栏 ======
            If \IsUseStatusBar 
               *pColorStatus.__ScreenColorInfo = \pMapColor("状态栏")
               If \IsUseIcoToolBar
                  StatusX = \ToolBarW : StatusW = WindowW-\StatusX-\ToolBarW
               Else 
                  StatusX = \StatusX : StatusW = WindowW-\StatusX
               EndIf 
               Redraw_Gradient(*pColorStatus, StatusX, WindowH-\StatusH, StatusW, \StatusH)
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               If StatusX = 0 
                  Box(1, WindowH-\StatusH+1, StatusW-1, 1, *pColorStatus\HighColor)
                  Box(1, WindowH-\StatusH+1, 1, \StatusH-2, *pColorStatus\HighColor)
                  Box(0, WindowH-\StatusH, StatusW, 1, *pColorStatus\SideColor)
               Else                                  
                  Box(StatusX, WindowH-\StatusH+1, StatusW-1, 1, *pColorStatus\HighColor)
                  Box(StatusX, WindowH-\StatusH+1, 1, \StatusH-2, *pColorStatus\HighColor)
                  Box(StatusX, WindowH-\StatusH, StatusW, 1, *pColorStatus\SideColor)
               EndIf    
               If \IsUseStatusSize And \IsUseSizeWindow = #True 
                  DrawingMode(#PB_2DDrawing_AlphaBlend)
                  For i = 15 To 03 Step -4
                     For j = i To 03 Step -4
                        Box(WindowW-21+i, WindowH-j-3, 2, 2, *pColorStatus\HighColor)
                        Box(WindowW-21+i, WindowH-j-3, 1, 1, *pColorStatus\ForeColor)
                     Next 
                  Next
               EndIf  
               AreaB = \StatusH
            EndIf 
            
             ;系统按键风格
            ButtonX = WindowW
            If \IsUseSysCloseBox
               ButtonX = ButtonX-1 - _Screen\btnCloseBox\W : ButtonY = 1  
               Redraw_Gadget(_Screen\btnCloseBox, ButtonX, ButtonY)
            EndIf 
            If \IsUseSysMaximize
               TempButtonX = ButtonX
               ButtonX = ButtonX-1-_Screen\btnMaximize\W : ButtonY = 1  
               Redraw_Gadget(_Screen\btnMaximize, ButtonX, ButtonY)
            EndIf             

            If \IsUseSysNormalcy
               ButtonX = TempButtonX-1-_Screen\btnNormalcy\W : ButtonY = 1  
               Redraw_Gadget(_Screen\btnNormalcy, ButtonX, ButtonY)
            EndIf               
            
            If \IsUseSysMinimize
               ButtonX = ButtonX-1-_Screen\btnMinimize\W : ButtonY = 1  
               Redraw_Gadget(_Screen\btnMinimize, ButtonX, ButtonY)
            EndIf 
            
            If \IsUseSysSettings
               ButtonX = ButtonX-1-_Screen\btnSettings\W : ButtonY = 1  
               Redraw_Gadget(_Screen\btnSettings, ButtonX, ButtonY)
            EndIf             
            
            DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
            Box(AreaX, AreaY, WindowW-AreaX, 1, *pColorWindow\HighColor)
            Box(AreaX, AreaY, 1, WindowH-AreaY-AreaB, *pColorWindow\HighColor)
            Box(0, 0, WindowW, WindowH, *pColorWindow\SideColor)            
         UnclipOutput()
      EndWith
      StopDrawing()
   EndIf
EndProcedure

Procedure Redraw_cvsAttributes()
   CanvasW = GadgetWidth (#cvsAttributes)
   CanvasH = GadgetHeight(#cvsAttributes)
   If StartDrawing(CanvasOutput(#cvsAttributes))
      Box(0, 0, CanvasW, CanvasH, #Attribute_BackColor)
      DrawingFont(FontID(#fntDefault))
      
      X = 005 : Y = 005 : W = #Screen_AttributeW-4-010 : H = 023
      ForEach _Screen\ListAttriGroup()
         With _Screen\ListAttriGroup()
            \X = X : \Y = Y : \R = X+W : \B = Y+H 
            DrawingMode(#PB_2DDrawing_Default)
            Box(X, Y, W, H, #Attribute_TitleColor)
            DrawText(X+30, Y+(H-TextHeight(\Title$))/2, \Title$, #Attribute_FontColor, #Attribute_TitleColor)
            DrawingMode(#PB_2DDrawing_Outlined)
            If \FoldState = #True
               Box (X+10+00, Y+06+00, 11, 11, #Attribute_LineColor)
               Line(X+10+00, Y+06+05, 11, 01, #Attribute_LineColor)
               Line(X+10+05, Y+06+00, 01, 11, #Attribute_LineColor)
            Else 
               Box (X+10+00, Y+06+00, 11, 11, #Attribute_LineColor)
               Line(X+10+00, Y+06+05, 11, 01, #Attribute_LineColor)
            EndIf 
            If IsGadget(\GadgetID)
               \W = GadgetWidth (\GadgetID)
               \H = GadgetHeight(\GadgetID)
               ResizeGadget(\GadgetID, #PB_Ignore, Y+(H-\H)/2, #PB_Ignore, #PB_Ignore)  
            EndIf 
            Y+H
         EndWith
         If _Screen\ListAttriGroup()\FoldState = #False And ListSize(_Screen\ListAttriGroup()\ListAttriItems())
            ForEach _Screen\ListAttriGroup()\ListAttriItems()
               With _Screen\ListAttriGroup()\ListAttriItems()
                  DrawingMode(#PB_2DDrawing_Outlined)
                  \W = GadgetWidth(\GadgetID1)
                  \H = GadgetHeight(\GadgetID1)
                  If \H < 22 
                     \X = X : \Y = Y : \R = #Screen_AttributeW-14 : \B = Y+22 : H = 22
                     Box(X, Y, W+0, H+2, #Attribute_LineColor)
                     Box(X, Y, #Screen_GroupItemW-5, H+2, #Attribute_LineColor)
                     ResizeGadget(\GadgetID1, #PB_Ignore, Y+2+(H+1-\H)/2, #PB_Ignore, #PB_Ignore) 
                  Else 
                     \X = X : \Y = Y : \R = #Screen_AttributeW-14 : \B = Y+\H : H = \H
                     Box(X, Y, W+0, \H+2, #Attribute_LineColor)
                     Box(X, Y, #Screen_GroupItemW-5, \H+2, #Attribute_LineColor)
                     ResizeGadget(\GadgetID1, #PB_Ignore, Y+1, #PB_Ignore, #PB_Ignore)                  
                  EndIf 
                  If IsGadget(\GadgetID2)
                     \W = GadgetWidth(\GadgetID2)
                     \H = GadgetHeight(\GadgetID2)
                     If \H < 22 
                        ResizeGadget(\GadgetID2, #PB_Ignore, Y+2+(H+1-\H)/2, #PB_Ignore, #PB_Ignore) 
                     Else 
                        ResizeGadget(\GadgetID2, #PB_Ignore, Y+1, #PB_Ignore, #PB_Ignore)                  
                     EndIf 
                  EndIf 
                  DrawingMode(#PB_2DDrawing_Default)
                  DrawText(X+5, Y+2+(H-TextHeight(\Title$))/2, \Title$, #Attribute_FontColor, #Attribute_BackColor)
                  Y+H+1
               EndWith
            Next 
         EndIf 
         Y+5
      Next 
      StopDrawing()
   EndIf
EndProcedure

;-==========================
Procedure Attributes_AddGroup(GadgetID, Title$, Notice$)
   *pAttriGroup.__AttriGroupInfo = AddElement(_Screen\ListAttriGroup())
   _Screen\pMapAttriGroup(Title$) = *pAttriGroup
   With *pAttriGroup
      \Title$    = Title$
      \Notice$   = Notice$
      \GadgetID  = GadgetID
      \FoldState = #True
   EndWith
   ProcedureReturn *pAttriGroup
EndProcedure

Procedure Attributes_AddItem(*pAttriGroup.__AttriGroupInfo, GadgetID1, GadgetID2, Title$, Notice$)
   *pAttriItems._AttriItemsInfo = AddElement(*pAttriGroup\ListAttriItems())
   _Screen\pMapAttriItems(*pAttriGroup\Title$+"|"+Title$) = *pAttriItems
   With *pAttriItems
      \Title$    = Title$
      \Notice$   = Notice$      
      \GadgetID1 = GadgetID1
      \GadgetID2 = GadgetID2
      \pParent   = *pAttriGroup
   EndWith
   ProcedureReturn *pAttriItems
EndProcedure

Procedure Attributes_CatchColor(*pMemColor, Pos, ColorTable$)
   *pColor.__ScreenColorInfo = AddElement(_Project\ListColor())   ;窗体布局
   _Project\pMapColor(ColorTable$) = *pColor
   *pColor\ColorTable$ = ColorTable$
   CopyMemory_(*pColor, *pMemColor+Pos, 6*4) : Pos+6*4
   ProcedureReturn Pos
EndProcedure

Procedure Attributes_InitGadget()
   With _Project
      SetGadgetText(#txtWindowRealW, Str(\WindowW))
      SetGadgetText(#txtWindowRealH, Str(\WindowH))
      SetGadgetText(#txtCaptionBarX, Str(\CaptionX))
      SetGadgetText(#txtCaptionBarH, Str(\CaptionH))
      SetGadgetText(#txtCaptionName, \Caption$)

      SetGadgetText(#txtWindowSideL, Str(\WinSideL))
      SetGadgetText(#txtWindowSideR, Str(\WinSideR))
      SetGadgetText(#txtWindowSideT, Str(\WinSideT))
      SetGadgetText(#txtWindowSideB, Str(\WinSideB))
      SetGadgetText(#txtStatusBarX,  Str(\StatusX))
      SetGadgetText(#txtStatusBarH,  Str(\StatusH))
      SetGadgetText(#txtIcoToolbarY, Str(\ToolBarY))
      SetGadgetText(#txtIcoToolbarW, Str(\ToolBarW))
      SetGadgetState(#cmbSystemButton, \SystemButtonSylte)
      SetGadgetState(#chkCanvasImage,  \IsUseCanvasImage)
      SetGadgetState(#chkSysCloseBox,  \IsUseSysCloseBox)
      SetGadgetState(#chkSysMinimize,  \IsUseSysMinimize)
      SetGadgetState(#chkSysMaximize,  \IsUseSysMaximize)
      SetGadgetState(#chkSysNormalcy,  \IsUseSysNormalcy)
      SetGadgetState(#chkSysSettings,  \IsUseSysSettings)
      SetGadgetState(#chkCaptionBar,   \IsUseCaptionBar)
      SetGadgetState(#chkStatusBar,    \IsUseStatusBar)
      SetGadgetState(#chkIcoToolbar,   \IsUseIcoToolBar)
      SetGadgetState(#chkStatusSize,   \IsUseStatusSize)
      SetGadgetState(#chkPreference,   \IsUsePreference) ;插入设置文件
      SetGadgetState(#chkMessageBox,   \IsUseMessageBox) ;插入信息对话框的代码
      SetGadgetState(#chkBalloonTip,   \IsUseBalloonTip) ;设置提示文

      
      State = 1-\IsUseSizeWindow 
      DisableGadget(#txtWindowSideL, State)  ;左际留边
      DisableGadget(#txtWindowSideR, State)  ;右际留边
      DisableGadget(#txtWindowSideT, State)  ;顶部留边
      DisableGadget(#txtWindowSideB, State)  ;底部留边
      DisableGadget(#chkStatusSize,  State)  ;缩放小图标
      StatusBarText(#wsbScreen,  1, " 窗体大小: "+Str(\WindowW)+"x"+Str(\WindowH))

      ClearList(_Project\ListColor())
      SetGadgetState(#cmbLayoutStyle, \UIColorStyleIndex)
      SelectElement(_Screen\ListColorStyle(), \UIColorStyleIndex)
      *pMemColor = _Screen\ListColorStyle()\pMemColor
      Pos = Attributes_CatchColor(*pMemColor, Pos, "窗体布局")
      Pos = Attributes_CatchColor(*pMemColor, Pos, "标题栏")
      Pos = Attributes_CatchColor(*pMemColor, Pos, "状态栏")
      Pos = Attributes_CatchColor(*pMemColor, Pos, "工具栏")
      Pos = Attributes_CatchColor(*pMemColor, Pos, "对话框按键")


      ;图标资源包含   
      If FileSize(\SoftwareIcon$) > 0
         SoftwareIconID = LoadImage(#PB_Any, \SoftwareIcon$)
         If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
         If SoftwareIconID
            \SoftwareIconID = SoftwareIconID
            DisableGadget(#chkIncludeIcon, #False)
         Else 
            DisableGadget(#chkIncludeIcon, #True)
         EndIf
      Else 
         DisableGadget(#chkIncludeIcon, #True)  
      EndIf 


      If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
         *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
         ClearGadgetItems(#cmbColorsPrefer)
         ForEach \ListColor()
            AddGadgetItem(#cmbColorsPrefer, -1, \ListColor()\ColorTable$)
         Next
         SetGadgetState(#cmbColorsPrefer, 0) 
         PostEvent(#PB_Event_Gadget, #winScreen, #cmbColorsPrefer)
      EndIf 
      FirstElement(\ListColor())
      SetGadgetState(#cmbGradientType, \ListColor()\GradientTpyes)  
      State = 1-\ListColor()\IsUseGradient
      DisableGadget(#chkAniGradients, State)  
      DisableGadget(#cmbGradientType, State) 
      
      Create_btnCloseBox(_Screen\btnCloseBox)
      Create_btnMinimize(_Screen\btnMinimize)
      Create_btnMaximize(_Screen\btnMaximize)
      Create_btnNormalcy(_Screen\btnNormalcy)
      Create_btnSettings(_Screen\btnSettings) 
      Redraw_cvsIllustrate()
   EndWith
EndProcedure

Procedure Attributes_NewProject()
   With _Project
      If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
      ClearMap(\pMapColor())
      ClearList(\ListColor())
      \WindowW  = 600         ;当前宽度
      \WindowH  = 400         ;当前高度
      \CaptionX = 000         ;X坐标偏移
      \CaptionH = 040         ;标题栏高度
      \Caption$ = "新建工具"  ;标题栏名称
      \WinSideL = 3
      \WinSideR = 3
      \WinSideT = 3
      \WinSideB = 3
      \StatusX  = 00          ;X坐标偏移
      \StatusH  = 30          ;状态栏高度      
      \ToolBarY = 00          ;Y坐标偏移
      \ToolBarW = 60          ;工具栏高度
      \SystemButtonSylte = 0      ;系统按键风格
      \IsUseCanvasImage  = #True  ;启用画布背景
      \IsUseSysCloseBox  = #True  ;关闭按键
      \IsUseSysMinimize  = #True  ;最小化按键
      \IsUseSysMaximize  = #False ;最大化按键
      \IsUseSysNormalcy  = #False ;正常化按键
      \IsUseSysSettings  = #False ;正常化按键
      \IsUseCaptionBar   = #True  ;启用标题栏
      \IsUseStatusBar    = #False ;启用状态栏
      \IsUseIcoToolBar   = #False ;启用工具栏
      \IsUseStatusSize   = #False  ;      
      \IsUseBalloonTip   = #False  ;      
      \IsUseSizeWindow   = #False    
      \IsUseMessageBox   = #False
      \DesignFile$       = #Null$
      \CreateDate        = Date()
      \UIColorStyleIndex = 0

      SetWindowTitle(#winScreen, #Screen_Caption$+" - 新建自绘界面设计稿(未保存)")
      Attributes_InitGadget()
   EndWith
EndProcedure

;-==========================
;-[Designs]
Procedure Designs_SaveFile()
   With _Project
      *MemData = AllocateMemory($100000)
      PokeL(*MemData+Pos, #DesignsFile_Flags)  : Pos+4 ;MPBF
      PokeF(*MemData+Pos, 1.0)                 : Pos+4 ;版本号
      PokeL(*MemData+Pos, \CreateDate)         : Pos+4 ;创建日期
      PokeL(*MemData+Pos, Date())              : Pos+4 ;修改日期

      CopyMemory_(*MemData+Pos, _Project, 32)            : Pos+32
      CopyMemory_(*MemData+Pos, @\SystemButtonSylte, 32) : Pos+32
      Lenght = StringByteLength(\Caption$, #PB_Ascii)+1
      PokeW(*MemData+Pos, Lenght)                        : Pos+02 
      PokeS(*MemData+Pos, \Caption$, -1, #PB_Ascii)      : Pos+Lenght
      
      Lenght = StringByteLength(\SoftwareIcon$, #PB_Ascii)+1
      PokeW(*MemData+Pos, Lenght)                        : Pos+02 
      PokeS(*MemData+Pos, \SoftwareIcon$, -1, #PB_Ascii) : Pos+Lenght
      
      Lenght = StringByteLength(\SourceFile$, #PB_Ascii)+1
      PokeW(*MemData+Pos, Lenght)                        : Pos+02 
      PokeS(*MemData+Pos, \SourceFile$, -1, #PB_Ascii)   : Pos+Lenght      
      Pos+16
      Count = ListSize(\ListColor())
      PokeW(*MemData+Pos, Count)                         : Pos+02
      ForEach \ListColor()
         CopyMemory_(*MemData+Pos, \ListColor(), 8*4) : Pos+8*04
         Lenght = StringByteLength(\ListColor()\ColorTable$, #PB_Ascii)+1
         PokeW(*MemData+Pos, Lenght)                                  : Pos+02 
         PokeS(*MemData+Pos, \ListColor()\ColorTable$, -1, #PB_Ascii) : Pos+Lenght
      Next 
      FileID = CreateFile(#PB_Any, _Project\DesignFile$)
      If FileID
         WriteData(FileID, *MemData, Pos)
         CloseFile(FileID)
      EndIf 
      FreeMemory(*MemData)
      _Project\OpenSuccess = #True
      SetWindowTitle(#winScreen, #Screen_Caption$+" - "+_Project\DesignFile$)
      If _Project\SoftwareIconID And _Project\IsUseIncludeIcon  
         CopyFile(_Project\SoftwareIcon$, ".\Software."+GetExtensionPart(_Project\SoftwareIcon$))
      EndIf 
      
   EndWith
EndProcedure

Procedure Designs_OpenFile(IsInital = #False)
   With _Project
      FileSize = FileSize(_Project\DesignFile$)
      If FileSize <= 0 
         If IsInital = #False : MessageRequester("出错提示", "文件不存在!    ") : EndIf 
         ProcedureReturn #False
      EndIf 
      *MemData = AllocateMemory(FileSize+$100)
      FileID = ReadFile(#PB_Any, _Project\DesignFile$)
      If FileID
         FileSeek(FileID, 0)
         ReadData(FileID, *MemData, FileSize)
         CloseFile(FileID)
      EndIf 
      If PeekL(*MemData+Pos) <> #DesignsFile_Flags ;MPBF
         FreeMemory(*MemData)
         MessageRequester("出错提示", "无效文件!    ")
         ProcedureReturn #False
      EndIf 
      Pos+4
      If PeekF(*MemData+Pos) <> 1.0 ;版本号
         FreeMemory(*MemData)
         MessageRequester("出错提示", "无效文件!    ")
         ProcedureReturn #False
      EndIf 
      Pos+4
      If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
      ClearMap(\pMapColor())
      ClearList(\ListColor())
      \OpenSuccess = #True
      \CreateDate  = PeekL(*MemData+Pos)                  : Pos+4+4         ;创建日期;修改日期
      CopyMemory_(_Project, *MemData+Pos, 32)             : Pos+32
      CopyMemory_(@\SystemButtonSylte, *MemData+Pos, 32)  : Pos+32
      Lenght         = PeekW(*MemData+Pos)                : Pos+02 
      \Caption$      = PeekS(*MemData+Pos, -1, #PB_Ascii) : Pos+Lenght
      Lenght         = PeekW(*MemData+Pos)                : Pos+02 
      \SoftwareIcon$ = PeekS(*MemData+Pos, -1, #PB_Ascii) : Pos+Lenght
      Lenght         = PeekW(*MemData+Pos)                : Pos+02 
      \SourceFile$   = PeekS(*MemData+Pos, -1, #PB_Ascii) : Pos+Lenght 
      Pos+16 
      Count          = PeekW(*MemData+Pos)                : Pos+02 
      For k = 1 To Count
         AddElement(\ListColor())
         CopyMemory_(\ListColor(), *MemData+Pos, 8*4)     : Pos+8*04
         Lenght = PeekW(*MemData+Pos)                     : Pos+02 
         \ListColor()\ColorTable$ = PeekS(*MemData+Pos, -1, #PB_Ascii) : Pos+Lenght
         \pMapColor(\ListColor()\ColorTable$) = \ListColor()
      Next 
      FreeMemory(*MemData)
      If FileSize(\SoftwareIcon$) > 0
         \SoftwareIconID = LoadImage(#PB_Any, \SoftwareIcon$)
      EndIf 
      Attributes_InitGadget()
      SetWindowTitle(#winScreen, #Screen_Caption$+" - "+_Project\DesignFile$)
      ProcedureReturn #True
   EndWith
EndProcedure

;-==========================
;-[EventGadget]
Procedure EventGadget_cvsIllustrate()
   With _Screen
      *pEventGadget.__GadgetInfo
      Select EventType() 
         Case #PB_EventType_MouseMove
            X = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseX) - _Screen\OffsetX
            Y = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseY) - _Screen\OffsetY
            If     Macro_Gadget_InRect1(_Project\IsUseSysCloseBox, \btnCloseBox)  : *pEventGadget = \btnCloseBox  
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysMinimize, \btnMinimize)  : *pEventGadget = \btnMinimize
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysNormalcy, \btnNormalcy)  : *pEventGadget = \btnNormalcy
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysMaximize, \btnMaximize)  : *pEventGadget = \btnMaximize
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysSettings, \btnSettings)  : *pEventGadget = \btnSettings
            
            ElseIf _Project\IsUseSizeWindow And X >= 0 And Y >=0 And X <= _Project\WindowW And Y <= _Project\WindowH
               If  X >= _Project\WindowW-_Project\StatusH And Y >= _Project\WindowH-_Project\StatusH : SetCursor_(\hSizing)      
               ElseIf _Project\WinSideL > 0 And X <= _Project\WinSideL                               : SetCursor_(\hLeftRight)                
               ElseIf _Project\WinSideR > 0 And X >= _Project\WindowW-_Project\WinSideR              : SetCursor_(\hLeftRight)
               ElseIf  _Project\WinSideT > 0 And Y <= _Project\WinSideT                              : SetCursor_(\hUpDown)           
               ElseIf _Project\WinSideT > 0 And Y >= _Project\WindowH-_Project\WinSideB              : SetCursor_(\hUpDown) 
               EndIf 
            EndIf 
            
            If _Project\IsUseBalloonTip And _Balloon\pBalloonTip <> *pEventGadget
               Select *pEventGadget
                  Case #Null
                     _Balloon\pBalloonTip = #Null
                     SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)
                  Case \btnCloseBox, \btnMinimize, \btnNormalcy, \btnMaximize, \btnSettings
                     If _Balloon\pBalloonTip <> #Null And _Balloon\pBalloonTip <> *pEventGadget
                        _Balloon\pBalloonTip = *pEventGadget
                        SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)
                     Else 
                        _Balloon\pBalloonTip = *pEventGadget
                        SetTimer_(\hWindow, #TIMER_BalloonTip, 1000, #Null)
                     EndIf 
               EndSelect
            EndIf
;             
            If \pMouseTop <> *pEventGadget : \pMouseTop = *pEventGadget : Redraw_cvsIllustrate() : EndIf   

         Case #PB_EventType_LeftButtonDown
            X = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseX) - _Screen\OffsetX
            Y = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseY) - _Screen\OffsetY
            If     Macro_Gadget_InRect1(_Project\IsUseSysCloseBox, \btnCloseBox)  : *pEventGadget = \btnCloseBox
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysMinimize, \btnMinimize)  : *pEventGadget = \btnMinimize
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysNormalcy, \btnNormalcy)  : *pEventGadget = \btnNormalcy
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysMaximize, \btnMaximize)  : *pEventGadget = \btnMaximize
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysSettings, \btnSettings)  : *pEventGadget = \btnSettings
            EndIf 
            If \pHoldDown <> *pEventGadget : \pHoldDown = *pEventGadget : Redraw_cvsIllustrate() : EndIf               
   
         Case #PB_EventType_LeftButtonUp
            X = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseX) - _Screen\OffsetX
            Y = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseY) - _Screen\OffsetY
            If     Macro_Gadget_InRect1(_Project\IsUseSysCloseBox, \btnCloseBox)  : *pEventGadget = \btnCloseBox
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysMinimize, \btnMinimize)  : *pEventGadget = \btnMinimize
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysNormalcy, \btnNormalcy)  
               *pEventGadget = \btnNormalcy
               \btnNormalcy\IsHide = #True 
               \btnMaximize\IsHide = #False 
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysMaximize, \btnMaximize)  
               *pEventGadget = \btnMaximize
               \btnNormalcy\IsHide = #False
               \btnMaximize\IsHide = #True
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysSettings, \btnSettings)                 
            EndIf 
            If \pHoldDown : \pHoldDown = 0 : Redraw_cvsIllustrate() : EndIf           
      EndSelect

      
   EndWith
EndProcedure

Procedure EventGadget_cvsAttributes()
   Select EventType()
      Case #PB_EventType_MouseMove
         X = GetGadgetAttribute(#cvsAttributes, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsAttributes, #PB_Canvas_MouseY)
         ForEach _Screen\ListAttriGroup()
            With _Screen\ListAttriGroup()
               If \Y <= Y And Y <= \B
                  StatusBarText(#wsbScreen,  2, "提示: "+ _Screen\ListAttriGroup()\Notice$)
                  ProcedureReturn 
               EndIf 
               If \FoldState = #False
                  ForEach \ListAttriItems()
                     If \ListAttriItems()\Y <= Y And Y <= \ListAttriItems()\B
                        StatusBarText(#wsbScreen,  2, "提示: "+ _Screen\ListAttriGroup()\ListAttriItems()\Notice$)
                        ProcedureReturn 
                     EndIf 
                  Next 
               EndIf 
            EndWith
         Next 

      Case #PB_EventType_LeftClick
         X = GetGadgetAttribute(#cvsAttributes, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsAttributes, #PB_Canvas_MouseY)
         ForEach _Screen\ListAttriGroup()
            With _Screen\ListAttriGroup()
               If \Y <= Y And Y <= \B
                  \FoldState = 1- \FoldState
                  ForEach \ListAttriItems()
                     HideGadget(\ListAttriItems()\GadgetID1, \FoldState)
                     If IsGadget(\ListAttriItems()\GadgetID2)
                        HideGadget(\ListAttriItems()\GadgetID2, \FoldState)
                     EndIf 
                  Next 
                  Redraw_cvsAttributes()
                  ProcedureReturn
               EndIf 
            EndWith
         Next 
   EndSelect
EndProcedure

Procedure EventGadget_srcIllustrateH()
   ScrollAreaX = GetGadgetState(#srcIllustrateH)
   If _Screen\ScrollAreaX <> ScrollAreaX
      _Screen\ScrollAreaX = ScrollAreaX
      Redraw_cvsIllustrate()
   EndIf 
EndProcedure

Procedure EventGadget_srcIllustrateV()
   ScrollAreaY = GetGadgetState(#srcIllustrateV)
   If _Screen\ScrollAreaY <> ScrollAreaY
      _Screen\ScrollAreaY = ScrollAreaY
      Redraw_cvsIllustrate()
   EndIf 
EndProcedure 

Procedure EventGadget_EventMenu()
   Select EventMenu()
      Case #wtbToolNewFile   : Attributes_NewProject()
      Case #wtbToolCloseFile : Attributes_NewProject()   
      Case #wtbToolCopyeCode
         Text$ = GetGadgetText(#rtxSourceCode)
         SetClipboardText(Text$)

      Case #wtbToolGenerate
         State = GetToolBarButtonState(#wtbScreen, #wtbToolGenerate)
         _Screen\IsGenerateView = State
         DisableToolBarButton(#wtbScreen, #wtbToolNewFile,   State)
         DisableToolBarButton(#wtbScreen, #wtbToolOpenFile,  State)
         DisableToolBarButton(#wtbScreen, #wtbToolCloseFile, State)
         DisableToolBarButton(#wtbScreen, #wtbToolCopyeCode, 1-State)
         If _Screen\IsGenerateView
            GenerateCode_Main()
         Else 
            Redraw_cvsIllustrate()
         EndIf 
         HideGadget(#rtxSourceCode, 1-State)
         HideGadget(#cvsIllustrate, State)

      Case #wtbToolSaveFile
         State = GetToolBarButtonState(#wtbScreen, #wtbToolGenerate)
         If State = #False
            If _Project\OpenSuccess 
               Designs_SaveFile()
            Else 
               Pattern$ = "自绘界面设计稿 (*.mpb)|*.mpb"
               DesignFile$ = SaveFileRequester("保存自绘界面设计稿", _Project\Caption$, Pattern$, 0)
               If DesignFile$
                  If LCase(GetExtensionPart(DesignFile$)) <> "mpb"
                     DesignFile$+".mpb"
                  EndIf 
                  _Project\DesignFile$ = DesignFile$
                  Designs_SaveFile()
               EndIf 
            EndIf 
         Else 
            If _Project\SourceFile$ <> #Null$
               mcsRichEditSaveFile_(#rtxSourceCode, _Project\SourceFile$, #PB_UTF8)
            Else 
               Pattern$ = "PureBasic源代码文件 (*.pb)|*.pb"
               SourceFile$ = SaveFileRequester("保存PureBasic源代码文件", _Project\Caption$, Pattern$, 0)
               If SourceFile$
                  If LCase(GetExtensionPart(SourceFile$)) <> "pb"
                     SourceFile$+".pb"
                  EndIf 
                  _Project\SourceFile$ = SourceFile$
                  mcsRichEditSaveFile_(#rtxSourceCode, _Project\SourceFile$, #PB_UTF8)
               EndIf 
            EndIf  
         EndIf 
      Case #wtbToolSaveAs
         State = GetToolBarButtonState(#wtbScreen, #wtbToolGenerate)
         If State = #False
            Pattern$ = "自绘界面设计稿 (*.mpb)|*.mpb"
            If _Project\OpenSuccess 
               DesignFile$ = SaveFileRequester("自绘界面设计稿另存为", _Project\DesignFile$, Pattern$, 0)
            Else 
               DesignFile$ = SaveFileRequester("保存自绘界面设计稿", _Project\Caption$, Pattern$, 0)
            EndIf 
            If DesignFile$
               If LCase(GetExtensionPart(DesignFile$)) <> "mpb"
                  DesignFile$+".mpb"
               EndIf 
               _Project\DesignFile$ = DesignFile$
               Designs_SaveFile()
            EndIf 
         Else 
            Pattern$ = "PureBasic源代码文件 (*.pb)|*.pb"
            If _Project\SourceFile$ <> #Null$
               SourceFile$ = SaveFileRequester("保存PureBasic源代码文件", _Project\Caption$, Pattern$, 0)
            Else 
               SourceFile$ = SaveFileRequester("PureBasic源代码文件另存为", _Project\Caption$, Pattern$, 0)
            EndIf 
            If SourceFile$
               If LCase(GetExtensionPart(SourceFile$)) <> "pb"
                  SourceFile$+".pb"
               EndIf 
               _Project\SourceFile$ = SourceFile$
               mcsRichEditSaveFile_(#rtxSourceCode, _Project\SourceFile$, #PB_UTF8)
            EndIf 
         EndIf 
         
      Case #wtbToolOpenFile
         Pattern$ = "自绘界面设计稿 (*.mpb)|*.mpb"
         DesignFile$ = OpenFileRequester("打开自绘界面设计稿", _Project\DesignFile$, Pattern$, 0)
         If FileSize(DesignFile$) > 0
            _Project\DesignFile$ = DesignFile$
            Designs_OpenFile()
         EndIf 
      Case #wtbToolSticky 
         _Screen\IsStickyWindow = GetToolBarButtonState(#wtbScreen, #wtbToolSticky)
         StickyWindow(#winScreen, _Screen\IsStickyWindow)
         
      Case #wtbToolVersion
         Flags = #PB_Window_SystemMenu|#PB_Window_WindowCentered
         OpenWindow(#winVersion, 0, 0, 400, 400, "版本说明", Flags, _Screen\hWindow)
         EditorGadget(#rtxVersion, 0, 0, 400, 400, #PB_Editor_ReadOnly)
         SetGadgetFont(#rtxVersion, FontID(#fntVersion))
         SetGadgetColor(#rtxVersion, #PB_Gadget_FrontColor, $7C6600)
         SetGadgetColor(#rtxVersion, #PB_Gadget_BackColor,  $DFFFFF)
         SetGadgetText(#rtxVersion, _Screen\VersionNotice$)
         Repeat
            Select WindowEvent()
               Case #PB_Event_CloseWindow   : IsExitWindow = #True
            EndSelect
         Until IsExitWindow = #True 
         CloseWindow(#winVersion)
         
   EndSelect
   
EndProcedure


Procedure EventGadget_MOUSEWHEEL()
   Scroll.w = ((EventwParam()>>16) & $FFFF)
   Scroll = - Scroll / 120
   Select Scroll
      Case -1 
      Case 01 
      Default : ProcedureReturn
   EndSelect 
   GadgetID = GetActiveGadget()   
   Select GadgetID
      Case #txtWindowRealW, #txtWindowRealH, #txtWindowSideL, #txtWindowSideR, #txtWindowSideT, #txtWindowSideB
         Value = Val(GetGadgetText(GadgetID)) : SetGadgetText(GadgetID, Str(Value+Scroll))
         PostEvent(#PB_Event_Gadget, #winScreen, GadgetID, #PB_EventType_Change)
      Case  #txtCaptionBarX, #txtCaptionBarH, #txtStatusBarX, #txtStatusBarH, #txtIcoToolbarY, #txtIcoToolbarW
         Value = Val(GetGadgetText(GadgetID)) : SetGadgetText(GadgetID, Str(Value+Scroll))
         PostEvent(#PB_Event_Gadget, #winScreen, GadgetID, #PB_EventType_Change)
      Default
         ProcedureReturn
   EndSelect
   Redraw_cvsIllustrate()
EndProcedure


;-==========================
;-[EventGroup]
Procedure EventGroup_CanvasGadget()
   If EventType() <> #PB_EventType_LeftClick : ProcedureReturn : EndIf 
   Select EventGadget()
      Case #cvsSetBackColor To #cvsSetShadowColor 
         If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
            *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
            State = GetGadgetState(#cmbColorsPrefer)
            GadgetID = EventGadget()
            If State <> -1 
               *pColor.long = SelectElement(_Project\ListColor(), State) + (GadgetID-#cvsSetBackColor)*4
               Color = ColorRequester(*pColor\l & $FFFFFF)
               If Color <> - 1 
                  *pColor\l = (Color & $FFFFFF)|(*pColor\l & $FF000000)
                  If StartDrawing(CanvasOutput(GadgetID))
                     Box(000, 000, 020, 020, *pColor\l & $FFFFFF)
                     StopDrawing()
                  EndIf 
                  SetGadgetText(#txtSetBackColor+GadgetID-#cvsSetBackColor, "$"+RSet(Hex(*pColor\l, #PB_Long), 8, "0")) 
               EndIf 
            EndIf 
         EndIf 
   EndSelect
   If _Screen\IsGenerateView
      GenerateCode_Main()
   Else 
      Redraw_cvsIllustrate()
   EndIf 
EndProcedure

Procedure EventGroup_StringGadget()
   If EventType() <> #PB_EventType_Change : ProcedureReturn : EndIf 
   With _Project
      Select EventGadget()

         Case #txtCaptionBarX : \CaptionX = Val(GetGadgetText(#txtCaptionBarX))
         Case #txtCaptionBarH : \CaptionH = Val(GetGadgetText(#txtCaptionBarH))
         Case #txtCaptionName : \Caption$ = GetGadgetText(#txtCaptionName)
         Case #txtIcoToolbarY : \ToolBarY = Val(GetGadgetText(#txtIcoToolbarY))
         Case #txtIcoToolbarW : \ToolBarW = Val(GetGadgetText(#txtIcoToolbarW))
         Case #txtStatusBarX  : \StatusX  = Val(GetGadgetText(#txtStatusBarX))
         Case #txtStatusBarH  : \StatusH  = Val(GetGadgetText(#txtStatusBarH))
         
         Case #txtWindowSideL : \WinSideL  = Val(GetGadgetText(#txtWindowSideL)) 
         Case #txtWindowSideR : \WinSideR  = Val(GetGadgetText(#txtWindowSideR)) 
         Case #txtWindowSideT : \WinSideT  = Val(GetGadgetText(#txtWindowSideT)) 
         Case #txtWindowSideB : \WinSideB  = Val(GetGadgetText(#txtWindowSideB)) 

         Case #txtWindowRealW, #txtWindowRealH 
            \WindowW  = Val(GetGadgetText(#txtWindowRealW))
            \WindowH  = Val(GetGadgetText(#txtWindowRealH))
            StatusBarText(#wsbScreen,  1, " 窗体大小: "+Str(\WindowW)+"x"+Str(\WindowH))

         Case #txtCaptionIcon          
            SoftwareIcon$ = GetGadgetText(#txtCaptionIcon)
            SoftwareIcon$ = GetPathPart(\SoftwareIcon$)+SoftwareIcon$
            If FileSize(SoftwareIcon$) <= 0
               SoftwareIconID = LoadImage(#PB_Any, SoftwareIcon$)
               If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
               If SoftwareIconID
                  \SoftwareIconID = SoftwareIconID
                  \SoftwareIcon$  = SoftwareIcon$
                  DisableGadget(#chkIncludeIcon, #False)
               Else 
                  StatusBarText(#wsbScreen,  2, "提示: 图像文件无效: "+ SoftwareIcon$)
                  DisableGadget(#chkIncludeIcon, #True)
               EndIf
            Else 
               If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
               StatusBarText(#wsbScreen,  2, "提示: 图像文件不存在: "+ SoftwareIcon$) 
               DisableGadget(#chkIncludeIcon, #True)  
            EndIf 

         Case #txtSetBackColor To #txtSetHighColor; #txtSetShadowColor
            If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
               *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
               State = GetGadgetState(#cmbColorsPrefer)
               GadgetID = EventGadget()
               If State <> -1 
                  *pColor.long = SelectElement(_Project\ListColor(), State) + (GadgetID-#txtSetBackColor)*4
                  Color = Val(GetGadgetText(GadgetID))
                  If Color <> - 1 
                     *pColor\l = Color
                     If StartDrawing(CanvasOutput(#cvsSetBackColor+GadgetID-#txtSetBackColor))
                        Box(000, 000, 020, 020, *pColor\l & $FFFFFF)
                        StopDrawing()
                     EndIf 
                     Redraw_cvsIllustrate()
                  EndIf 
               EndIf 
            EndIf 
         Default : ProcedureReturn
      EndSelect
      If _Screen\IsGenerateView
         GenerateCode_Main()
      Else 
         Redraw_cvsIllustrate()
      EndIf 
   EndWith
EndProcedure

Procedure EventGroup_ButtonGadget()
   With _Project
      Select EventGadget()
         Case #btnCaptionIcon 
            Pattern$ = "ICON 图标 (*.ico)|*.ico|BMP图像 (*.bmp)|*.bmp|PNG图像 (*.png)|*.png|"+
                    "JPG图像 (*.jpg)|*.jpg|TGA图像 (*.tga)|*.tga|TIFF图像 (*.tif)|*.tif|"+
                    "任意图像 (*.*)|*.*"
            Pattern = 0    ; 默认选择第一个
            SoftwareIcon$ = OpenFileRequester("请选择要打开的文件", \SoftwareIcon$, Pattern$, Pattern)
            If SoftwareIcon$
               SoftwareIconID = LoadImage(#PB_Any, SoftwareIcon$)
               If SoftwareIconID
                  If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
                  \SoftwareIconID = SoftwareIconID
                  \SoftwareIcon$  = SoftwareIcon$
                  SetGadgetText(#txtCaptionIcon, GetFilePart(SoftwareIcon$))
                  DisableGadget(#chkIncludeIcon, #False)
               Else 
                  MessageRequester("提示", "图标文件无效! ")
                  DisableGadget(#chkIncludeIcon, #True)
               EndIf 
            EndIf
         Default : ProcedureReturn
      EndSelect
      If _Screen\IsGenerateView
         GenerateCode_Main()
      Else 
         Redraw_cvsIllustrate()
      EndIf 
   EndWith
EndProcedure

Procedure EventGroup_CheckBoxGadget()
   With _Project
      Select EventGadget()
         Case #chkPreference   : \IsUsePreference    = GetGadgetState(#chkPreference) 
         Case #chkCaptionBar   : \IsUseCaptionBar    = GetGadgetState(#chkCaptionBar)
         Case #chkStatusBar    : \IsUseStatusBar     = GetGadgetState(#chkStatusBar)
         Case #chkIcoToolbar   : \IsUseIcoToolBar    = GetGadgetState(#chkIcoToolbar)
         Case #chkStatusSize   : \IsUseStatusSize    = GetGadgetState(#chkStatusSize)
         Case #chkSysCloseBox  : \IsUseSysCloseBox   = GetGadgetState(#chkSysCloseBox)
         Case #chkSysMinimize  : \IsUseSysMinimize   = GetGadgetState(#chkSysMinimize)
         Case #chkCanvasImage  : \IsUseCanvasImage   = GetGadgetState(#chkCanvasImage)
         Case #chkBalloonTip   : \IsUseBalloonTip    = GetGadgetState(#chkBalloonTip)
         Case #chkMessageBox   : \IsUseMessageBox    = GetGadgetState(#chkMessageBox)  
         Case #chkSysMaximize  
            \IsUseSysMaximize = GetGadgetState(#chkSysMaximize)
            \IsUseSysNormalcy = GetGadgetState(#chkSysMaximize)
            SetGadgetState(#chkSysNormalcy, \IsUseSysNormalcy)
         Case #chkSysNormalcy  
            \IsUseSysMaximize = GetGadgetState(#chkSysNormalcy)
            \IsUseSysNormalcy = GetGadgetState(#chkSysNormalcy)
            SetGadgetState(#chkSysMaximize, \IsUseSysMaximize)
         Case #chkSysSettings
            \IsUseSysSettings = GetGadgetState(#chkSysSettings)   
                               
         Case #chkIncludeIcon
            \IsUseIncludeIcon = GetGadgetState(#chkIncludeIcon)    
                                          
         Case #chkUseGradients, #chkAniGradients 
            State = 1-GetGadgetState(#chkUseGradients) 
            DisableGadget(#chkAniGradients, State)  
            DisableGadget(#cmbGradientType, State)   
            
            If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
               *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
               State = GetGadgetState(#cmbColorsPrefer)
               GadgetID = EventGadget()
               If State <> -1 
                  *pGadgetColor.__ScreenColorInfo = SelectElement(_Project\ListColor(), State)
                  *pGadgetColor\IsUseGradient = GetGadgetState(#chkUseGradients)
                  *pGadgetColor\IsAniGradient = GetGadgetState(#chkAniGradients)
               EndIf 
            EndIf 
         Case #chkSizeWindow   
            \IsUseSizeWindow = GetGadgetState(#chkSizeWindow) 
            State = 1-\IsUseSizeWindow
            DisableGadget(#txtWindowSideL, State)  ;左际留边
            DisableGadget(#txtWindowSideR, State)  ;右际留边
            DisableGadget(#txtWindowSideT, State)  ;顶部留边
            DisableGadget(#txtWindowSideB, State)  ;底部留边
            DisableGadget(#chkStatusSize,  State)  ;缩放小图标

         Default : ProcedureReturn
      EndSelect
      If _Screen\IsGenerateView
         GenerateCode_Main()
      Else 
         Redraw_cvsIllustrate()
      EndIf 
   EndWith
EndProcedure

Procedure EventGroup_ComboBoxGadget()
   Select EventGadget()
      Case #cmbSystemButton
         SystemButtonSylte = GetGadgetState(#cmbSystemButton)
         If _Project\SystemButtonSylte <> SystemButtonSylte
            _Project\SystemButtonSylte = SystemButtonSylte
            Create_btnCloseBox(_Screen\btnCloseBox)
            Create_btnMinimize(_Screen\btnMinimize)
            Create_btnMaximize(_Screen\btnMaximize)
            Create_btnNormalcy(_Screen\btnNormalcy)
            Create_btnSettings(_Screen\btnSettings)
         EndIf 

      Case #cmbLayoutStyle
         Index = GetGadgetState(#cmbLayoutStyle)
         If Index = -1 : ProcedureReturn : EndIf 
         If _Project\UIColorStyleIndex = Index : ProcedureReturn : EndIf 
         _Project\UIColorStyleIndex = Index
         ClearList(_Project\ListColor())
         SetGadgetState(#cmbLayoutStyle, _Project\UIColorStyleIndex)
         SelectElement(_Screen\ListColorStyle(), _Project\UIColorStyleIndex)
         *pMemColor = _Screen\ListColorStyle()\pMemColor
         Pos = Attributes_CatchColor(*pMemColor, Pos, "窗体布局")
         Pos = Attributes_CatchColor(*pMemColor, Pos, "标题栏")
         Pos = Attributes_CatchColor(*pMemColor, Pos, "状态栏")
         Pos = Attributes_CatchColor(*pMemColor, Pos, "工具栏")
         Pos = Attributes_CatchColor(*pMemColor, Pos, "对话框按键")

         If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
            *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
            ClearGadgetItems(#cmbColorsPrefer)
            ForEach _Project\ListColor()
               AddGadgetItem(#cmbColorsPrefer, -1, _Project\ListColor()\ColorTable$)
            Next
            SetGadgetState(#cmbColorsPrefer, 0) 
            PostEvent(#PB_Event_Gadget, #winScreen, #cmbColorsPrefer)
         EndIf 
         FirstElement(_Project\ListColor())
         SetGadgetState(#cmbGradientType, _Project\ListColor()\GradientTpyes)  
         State = 1-_Project\ListColor()\IsUseGradient
         DisableGadget(#chkAniGradients, State)  
         DisableGadget(#cmbGradientType, State)   
         Create_btnCloseBox(_Screen\btnCloseBox)
         Create_btnMinimize(_Screen\btnMinimize)
         Create_btnMaximize(_Screen\btnMaximize)
         Create_btnNormalcy(_Screen\btnNormalcy)
         Create_btnSettings(_Screen\btnSettings)



      Case #cmbGradientType
         State = GetGadgetState(#cmbColorsPrefer)
         If State = -1 : ProcedureReturn : EndIf 
         If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
            *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
            *pGadgetColor.__ScreenColorInfo = SelectElement(_Project\ListColor(), State)
            GradientType = GetGadgetState(#cmbGradientType)
            If GradientType >= 0 
               *pGadgetColor\GradientTpyes = GradientType
            EndIf 
         EndIf 
         
      Case #cmbColorsPrefer
         State = GetGadgetState(#cmbColorsPrefer)
         If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
            *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
            If State = -1 
               For GadgetID = #txtSetBackColor To #txtSetHighColor;#txtSetShadowColor
                  SetGadgetText(GadgetID, "")
               Next 
            Else 
               *pGadgetColor.__ScreenColorInfo = SelectElement(_Project\ListColor(), State)
               SetGadgetState(#chkUseGradients, *pGadgetColor\IsUseGradient)
               SetGadgetState(#chkAniGradients, *pGadgetColor\IsAniGradient)
               SetGadgetState(#cmbGradientType, *pGadgetColor\GradientTpyes)  
               State = 1-*pGadgetColor\IsUseGradient
               DisableGadget(#chkAniGradients, State)  
               DisableGadget(#cmbGradientType, State)   

               *pColor.long = *pGadgetColor
               For GadgetID = #cvsSetBackColor To #cvsSetHighColor; #cvsSetShadowColor
                  If StartDrawing(CanvasOutput(GadgetID))
                     Box(000, 000, 020, 020, *pColor\l & $FFFFFF)
                     StopDrawing()
                  EndIf 
                  SetGadgetText(#txtSetBackColor+GadgetID-#cvsSetBackColor, "$"+RSet(Hex(*pColor\l, #PB_Long), 8, "0")) 
                  *pColor+4
               Next 
            EndIf 
         EndIf 
         ProcedureReturn
      Default
         ProcedureReturn
   EndSelect
   If _Screen\IsGenerateView
      GenerateCode_Main()
   Else 
      Redraw_cvsIllustrate()
   EndIf 
EndProcedure



;-==========================
;-[Callback]
Procedure Screen_SizeWindow()
   With _Screen
      \WindowW = WindowWidth (#winScreen)
      \WindowH = WindowHeight(#winScreen)
      If \WindowW <=0  Or \WindowH <= 0 : ProcedureReturn : EndIf 
      ;===============
      TableX = \WindowW-05-#Screen_AboutMilooW
      ResizeGadget(#lblScreen, TableX, #PB_Ignore, #PB_Ignore, #PB_Ignore)
      ;窗体演示界面
      CanvasW = \WindowW-15-#Screen_AttributeW
      CanvasH = \WindowH-10-StatusBarHeight(#wsbScreen)-ToolBarHeight(#wtbScreen)
      ResizeGadget(#cvsIllustrate, #PB_Ignore, #PB_Ignore, CanvasW, CanvasH)
      ResizeGadget(#rtxSourceCode, #PB_Ignore, #PB_Ignore, CanvasW, CanvasH)
         ;底部滚动条
         GadgetY = CanvasH-#Screen_ScrollBarH-4
         GadgetW = CanvasW-#Screen_ScrollBarW-4
         ResizeGadget(#srcIllustrateH, #PB_Ignore, GadgetY, GadgetW, #PB_Ignore)
         ;右侧滚动条
         GadgetX = CanvasW - #Screen_ScrollBarW-4
         GadgetH = CanvasH - #Screen_ScrollBarH-4
         ResizeGadget(#srcIllustrateV, GadgetX, #PB_Ignore, #PB_Ignore, GadgetH)
      ;===============
      ;右侧设置栏
      CanvasX = \WindowW-05-#Screen_AttributeW
      CanvasH = \WindowH-10-StatusBarHeight(#wsbScreen)-ToolBarHeight(#wtbScreen)
      ResizeGadget(#cvsAttributes, CanvasX, #PB_Ignore, #PB_Ignore, CanvasH)
   EndWith   
EndProcedure

Procedure Screen_BalloonTip()

   With _Balloon
      *pColorWindow.__ScreenColorInfo = _Project\pMapColor("窗体布局")
      If \pBalloonTip And \pBalloonTip\BalloonTip$ <> #Null$
         
         ;计算文本占用的最大宽度和最大高度
         TempImageID = CreateImage(#PB_Any, 100, 100)
         If StartDrawing(ImageOutput(TempImageID))
            DrawingFont(FontID(#fntDefault))
            TextW = TextWidth (\pBalloonTip\BalloonTip$) + 20
            TextH = TextHeight(\pBalloonTip\BalloonTip$) + 10
            StopDrawing()
         EndIf
         FreeImage(TempImageID)
         GetCursorPos_(Mouse.POINT)
         Gadget.POINT
         Gadget\X = \pBalloonTip\X + 20
         Gadget\Y = \pBalloonTip\B + 45 + _Screen\OffsetY
         ClientToScreen_(_Screen\hWindow, Gadget) 
         Mouse\y = Gadget\y
         \WindowW = TextW
         \WindowH = TextH
         
         If IsImage(#imgBalloon) = 0
            hImageScreen = CreateImage(#imgBalloon, \WindowW, \WindowH)
         ElseIf ImageWidth(#imgBalloon) <> \WindowW Or ImageHeight(#imgBalloon) <> \WindowH
            FreeImage(#imgBalloon)
            hImageScreen = CreateImage(#imgBalloon, \WindowW, \WindowH)
         Else 
            hImageScreen = ImageID(#imgBalloon)
         EndIf 
         If hImageScreen = 0 : ProcedureReturn : EndIf

         If IsWindow(#winBalloon) = #False
            \hWindow = OpenWindow(#winBalloon, 0, 0, 0, 0, "", #PB_Window_BorderLess, _Screen\hWindow)
            HideWindow(#winBalloon, #True)
         EndIf 
         
         If StartDrawing(ImageOutput(#imgBalloon))
            DrawingFont(FontID(#fntDefault))
            DrawingMode(#PB_2DDrawing_Default)
            Box(0, 0, \WindowW, \WindowH, *pColorWindow\BackColor & $FFFFFF)
            Redraw_Gradient(*pColorWindow, 0, 0, \WindowW, \WindowH)
            DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Transparent)
            DrawText(10, 05, \pBalloonTip\BalloonTip$, *pColorWindow\FontColor)
            DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
            Box(1, 1, \WindowW-2, 1, *pColorWindow\HighColor)
            Box(1, 1, 1, \WindowH-2, *pColorWindow\HighColor)
            Box(0, 0, \WindowW, \WindowH, *pColorWindow\SideColor)      
            StopDrawing()
         EndIf 
         If \hBackImage : DeleteObject_(\hBackImage) : \hBackImage = 0 : EndIf  ;释放窗体背景句柄
        
         ;将背景图像渲染到窗体
         \hBackImage= CreatePatternBrush_(hImageScreen)
         If \hBackImage
            SetClassLongPtr_(\hWindow, #GCL_HBRBACKGROUND, \hBackImage)
            RedrawWindow_(\hWindow, #Null, #Null, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)
         EndIf 
         ResizeWindow(#winBalloon, Mouse\X, Mouse\Y, \WindowW, \WindowH)
         SetActiveWindow(#winScreen)
         HideWindow(#winBalloon, #False)
         SetActiveWindow(#winScreen)

      ElseIf IsWindow(#winBalloon) 
         HideWindow(#winBalloon, #True)
      EndIf 
   EndWith
EndProcedure

;挂钩事件
Procedure Screen_Callback(hWindow, uMsg, wParam, lParam) 
   Result = #PB_ProcessPureBasicEvents
   Select uMsg
      Case #WM_TIMER
         Select wParam
            Case #TIMER_SizeWindow
               KillTimer_(hWindow, #TIMER_SizeWindow) 
               _Screen\IsTIMER_SizeWindow = #False
               Screen_SizeWindow()
               Redraw_cvsIllustrate()
               Redraw_cvsAttributes()
            Case #TIMER_BalloonTip
               Screen_BalloonTip()
               KillTimer_(hWindow, #TIMER_BalloonTip) 
         EndSelect
      Case #WM_SIZE 
         If _Screen\IsTIMER_SizeWindow
            KillTimer_(hWindow, #TIMER_SizeWindow) 
         EndIf 
         SetTimer_(hWindow, #TIMER_SizeWindow, 15, #Null)
         _Screen\IsTIMER_SizeWindow = #True
   EndSelect 
   ProcedureReturn Result 
EndProcedure 
  
Procedure Screen_HookWindow(hWindow, uMsg, wParam, lParam) 
   *pMemSkin = GetWindowLong_(hWindow, #GWL_USERDATA) 
   If *pMemSkin
      Result = CallWindowProc_(PeekL(*pMemSkin+16), hWindow, uMsg, wParam, lParam) 
   Else 
      Result = DefWindowProc_(hWindow, uMsg, wParam, lParam) 
   EndIf 
   Select uMsg
      Case #WM_DESTROY
         DeleteObject_( PeekL(*pMemSkin+12) ) 
         GlobalFree_(*pMemSkin) 
         PostQuitMessage_(0) 
      Case #WM_CTLCOLOREDIT,#WM_CTLCOLORLISTBOX
         SetTextColor_(wParam, PeekL(*pMemSkin+0) ) 
         SetBkColor_  (wParam, PeekL(*pMemSkin+4))
         Result = PeekL(*pMemSkin+12)
   EndSelect

   ProcedureReturn Result 
EndProcedure 

;-==========================
;-[Create]
;创建关闭按键
Procedure Create_btnCloseBox(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate    = #True
      \BalloonTip$ = "关闭窗体"
      *pColor.__ScreenColorInfo = _Project\pMapColor("标题栏")
      FontColor  = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)
      CloseColor = (Alpha(#SysButton_CloseColor) << 23 & $FF000000) |(#SysButton_CloseColor & $FFFFFF)
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 40 : \H = 24 : i = (\W-9)/2 : j = (\H-10)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               LineXY(i+0, j+00, i+9+0, j+09, FontColor)
               LineXY(i+1, j+00, i+9+1, j+09, *pColor\FontColor)
               LineXY(i+2, j+00, i+9+2, j+09, FontColor)
               LineXY(i+0, j+09, i+9+0, j+00, FontColor)               
               LineXY(i+1, j+09, i+9+1, j+00, *pColor\FontColor)               
               LineXY(i+2, j+09, i+9+2, j+00, FontColor) 
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               Box(000, 000, \W, \H, #SysButton_CloseColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Box(000, 000, \W, \H, CloseColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
         Case #ButtonStyle_Bread
            \W = 48 : \H = 23 : i = (\W-9)/2 : j = (\H-10)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
               BackColor (*pColor\ForeColor)
               FrontColor($000000)
               LinearGradient(0, 0, 0, \H) 
               RoundBox(0, -5, \W, \H+5, 3, 3)   
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
               RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor)                  
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               LineXY(i+0, j+00, i+9+0, j+09, FontColor)
               LineXY(i+1, j+00, i+9+1, j+09, *pColor\FontColor)
               LineXY(i+2, j+00, i+9+2, j+09, FontColor)
               LineXY(i+0, j+09, i+9+0, j+00, FontColor)               
               LineXY(i+1, j+09, i+9+1, j+00, *pColor\FontColor)               
               LineXY(i+2, j+09, i+9+2, j+00, FontColor)               
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               RoundBox(0, -5, \W, \H+5, 3, 3, #SysButton_CloseColor)  
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               RoundBox(0, -5, \W, \H+5, 3, 3, CloseColor) 
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-12)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartVectorDrawing(ImageVectorOutput(TempImageID))
               AddPathCircle(x+14, y+14, 15)
               VectorSourceCircularGradient(x+14, y+14, 15)
               VectorSourceGradientColor($00000000, 0.00)
               VectorSourceGradientColor($00000000, 0.60)
               VectorSourceGradientColor($80000000, 0.80)
               VectorSourceGradientColor($80FFFFFF, 0.95)
               VectorSourceGradientColor($00000000, 1.00)
               FillPath() 
               StopVectorDrawing()
            EndIf
            
            If StartDrawing(ImageOutput(TempImageID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               LineXY(i+0, j+00, i+9+0, j+09, FontColor)
               LineXY(i+1, j+00, i+9+1, j+09, *pColor\FontColor)
               LineXY(i+2, j+00, i+9+2, j+09, FontColor)
               LineXY(i+0, j+09, i+9+0, j+00, FontColor)               
               LineXY(i+1, j+09, i+9+1, j+00, *pColor\FontColor)               
               LineXY(i+2, j+09, i+9+2, j+00, FontColor)  
               StopDrawing()
            EndIf

            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $E05060FF)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FF919BFF)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FF0D1CB5)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            FreeImage(TempImageID)
      EndSelect 
   EndWith
EndProcedure

;创建最小化按键
Procedure Create_btnMinimize(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      \BalloonTip$ = "最小化窗体"
      *pColor.__ScreenColorInfo = _Project\pMapColor("标题栏")
      FontColor = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)
;       Debug Hex(*pColor\ForeColor, #PB_Long)
      ForeColor = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 28 : \H = 22 : i = (\W-9)/2 : j = (\H-3)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Box(i, j+0, 09, 03, FontColor)
               Box(i, j+1, 09, 01, *pColor\FontColor)
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               Box(000, 000, \W, \H, *pColor\ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Box(000, 000, \W, \H, ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf

         Case #ButtonStyle_Bread
            \W = 32 : \H = 23 : i = (\W-9)/2 : j = (\H-3)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
               BackColor (*pColor\ForeColor)
               FrontColor($00000000)
               LinearGradient(0, 0, 0, \H) 
               RoundBox(0, -5, \W, \H+5, 3, 3)   
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
               RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor)   
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Box(i, j+0, 09, 03, FontColor)
               Box(i, j+1, 09, 01, *pColor\FontColor)
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               RoundBox(0, -5, \W, \H+5, 3, 3, ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-09)/2 : j = (\H-03)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartVectorDrawing(ImageVectorOutput(TempImageID))
               AddPathCircle(x+14, y+14, 15)
               VectorSourceCircularGradient(x+14, y+14, 15)
               VectorSourceGradientColor($00000000, 0.00)
               VectorSourceGradientColor($00000000, 0.60)
               VectorSourceGradientColor($80000000, 0.80)
               VectorSourceGradientColor($80FFFFFF, 0.95)
               VectorSourceGradientColor($00000000, 1.00)
               FillPath() 
               StopVectorDrawing()
            EndIf
            
            If StartDrawing(ImageOutput(TempImageID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Box(i, j+0, 09, 03, FontColor)
               Box(i, j+1, 09, 01, *pColor\FontColor)
               StopDrawing()
            EndIf

            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $E020E080)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FF4ADF95)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FF048B48)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            FreeImage(TempImageID)
      EndSelect 
      
   EndWith
EndProcedure

;创建最大化按键
Procedure Create_btnMaximize(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      \BalloonTip$ = "最大化窗体"
      *pColor.__ScreenColorInfo = _Project\pMapColor("标题栏")
      FontColor = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)
      ForeColor = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)
;       \IsHide = #True
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 28 : \H = 22 : i = (\W-12)/2 : j = (\H-8)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
               Box(i+00, j+00, 12, 08, *pColor\FontColor)
               Box(i+01, j+00, 10, 08, FontColor)
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               Box(000, 000, \W, \H, *pColor\ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Box(000, 000, \W, \H, ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
         Case #ButtonStyle_Bread
            \W = 32 : \H = 23 : i = (\W-12)/2 : j = (\H-8)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
               BackColor (*pColor\ForeColor)
               FrontColor($00000000)
               LinearGradient(0, 0, 0, \H) 
               RoundBox(0, -5, \W, \H+5, 3, 3)   
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
               RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor)  
               Box(i+00, j+00, 12, 08, *pColor\FontColor)
               Box(i+01, j+00, 10, 08, FontColor)
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               RoundBox(0, -5, \W, \H+5, 3, 3, ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-9)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartVectorDrawing(ImageVectorOutput(TempImageID))
               AddPathCircle(x+14, y+14, 15)
               VectorSourceCircularGradient(x+14, y+14, 15)
               VectorSourceGradientColor($00000000, 0.00)
               VectorSourceGradientColor($00000000, 0.60)
               VectorSourceGradientColor($80000000, 0.80)
               VectorSourceGradientColor($80FFFFFF, 0.95)
               VectorSourceGradientColor($00000000, 1.00)
               FillPath() 
               StopVectorDrawing()
            EndIf
            
            If StartDrawing(ImageOutput(TempImageID))
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
               Box(i+00, j+00, 12, 08, *pColor\FontColor)
               Box(i+01, j+00, 10, 08, FontColor)
               StopDrawing()
            EndIf

            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FFFF8060)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FFFFBA87)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FF993A22)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            FreeImage(TempImageID)
      EndSelect 
   EndWith
EndProcedure

;创建正常化按键
Procedure Create_btnNormalcy(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      \BalloonTip$ = "窗体正常化"
      *pColor.__ScreenColorInfo = _Project\pMapColor("标题栏")
      FontColor = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)
      ForeColor = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)
      \IsHide = #True
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 28 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined) 
               Box(i+05, j+00, 07, 06, *pColor\FontColor)
               DrawingMode(#PB_2DDrawing_AllChannels) 
               Box(i+00, j+03, 09, 07, $0)
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
               Box(i+00, j+03, 09, 07, *pColor\FontColor)
               Box(i+01, j+03, 07, 07, FontColor)  
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               Box(000, 000, \W, \H, *pColor\ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Box(000, 000, \W, \H, ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
         Case #ButtonStyle_Bread
            \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(TempImageID))
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined) 
               Box(i+05, j+00, 07, 06, *pColor\FontColor)
               DrawingMode(#PB_2DDrawing_AllChannels) 
               Box(i+00, j+03, 09, 07, $0)
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
               Box(i+00, j+03, 09, 07, *pColor\FontColor)
               Box(i+01, j+03, 07, 07, FontColor)   
               StopDrawing()
            EndIf
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
               BackColor (*pColor\ForeColor)
               FrontColor($00000000)
               LinearGradient(0, 0, 0, \H) 
               RoundBox(0, -5, \W, \H+5, 3, 3)   
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
               RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor) 
               DrawingMode(#PB_2DDrawing_Default)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            FreeImage(TempImageID)
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               RoundBox(0, -5, \W, \H+5, 3, 3, ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-11)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartVectorDrawing(ImageVectorOutput(TempImageID))
               AddPathCircle(x+14, y+14, 15)
               VectorSourceCircularGradient(x+14, y+14, 15)
               VectorSourceGradientColor($00000000, 0.00)
               VectorSourceGradientColor($00000000, 0.60)
               VectorSourceGradientColor($80000000, 0.80)
               VectorSourceGradientColor($80FFFFFF, 0.95)
               VectorSourceGradientColor($00000000, 1.00)
               FillPath() 
               StopVectorDrawing()
            EndIf
            
            If StartDrawing(ImageOutput(TempImageID))
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined) 
               Box(i+05, j+00, 07, 06, *pColor\FontColor)
               DrawingMode(#PB_2DDrawing_AllChannels) 
               Box(i+00, j+03, 09, 07, $0)
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
               Box(i+00, j+03, 09, 07, *pColor\FontColor)
               Box(i+01, j+03, 07, 07, FontColor)  
               StopDrawing()
            EndIf

            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FFFF8060)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FFFFBA87)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FF993A22)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            FreeImage(TempImageID)
      EndSelect 
   EndWith
EndProcedure

;创建窗体设置按键
Procedure Create_btnSettings(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      \BalloonTip$ = "软件设置"
      *pColor.__ScreenColorInfo = _Project\pMapColor("标题栏")
      FontColor = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)
      ForeColor = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 28 : \H = 22 : i = (\W-14)/2 : j = (\H-07)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               Line(i+0, j+0, 07, 07, FontColor)
               Line(i+7, j+5, 06, -6, FontColor)
               Line(i+2, j+0, 05, 05, FontColor)
               Line(i+7, j+3, 04, -4, FontColor)
               Line(i+1, j+0, 06, 06, *pColor\FontColor)
               Line(i+7, j+4, 05, -5, *pColor\FontColor)
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               Box(000, 000, \W, \H, *pColor\ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Box(000, 000, \W, \H, ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
         Case #ButtonStyle_Bread
            \W = 32 : \H = 22 : i = (\W-14)/2 : j = (\H-07)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(TempImageID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               Line(i+0, j+0, 07, 07, FontColor)
               Line(i+7, j+5, 06, -6, FontColor)
               Line(i+2, j+0, 05, 05, FontColor)
               Line(i+7, j+3, 04, -4, FontColor)
               Line(i+1, j+0, 06, 06, *pColor\FontColor)
               Line(i+7, j+4, 05, -5, *pColor\FontColor)
               StopDrawing()
            EndIf
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
               BackColor (*pColor\ForeColor)
               FrontColor($00000000)
               LinearGradient(0, 0, 0, \H) 
               RoundBox(0, -5, \W, \H+5, 3, 3)   
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
               RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor) 
               DrawingMode(#PB_2DDrawing_Default)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            FreeImage(TempImageID)
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend) 
               RoundBox(0, -5, \W, \H+5, 3, 3, ForeColor)
               DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
               StopDrawing()
            EndIf
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-14)/2 : j = (\H-07)/2
            If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
            If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
            If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
            
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartVectorDrawing(ImageVectorOutput(TempImageID))
               AddPathCircle(x+14, y+14, 15)
               VectorSourceCircularGradient(x+14, y+14, 15)
               VectorSourceGradientColor($00000000, 0.00)
               VectorSourceGradientColor($00000000, 0.60)
               VectorSourceGradientColor($80000000, 0.80)
               VectorSourceGradientColor($80FFFFFF, 0.95)
               VectorSourceGradientColor($00000000, 1.00)
               FillPath() 
               StopVectorDrawing()
            EndIf
            
            If StartDrawing(ImageOutput(TempImageID))
               DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined) 
               Line(i+0, j+0, 07, 07, FontColor)
               Line(i+7, j+5, 06, -6, FontColor)
               Line(i+2, j+0, 05, 05, FontColor)
               Line(i+7, j+3, 04, -4, FontColor)
               Line(i+1, j+0, 06, 06, *pColor\FontColor)
               Line(i+7, j+4, 05, -5, *pColor\FontColor)
               StopDrawing()
            EndIf

            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FFE43ADE)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            
            \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\MouseTopID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FFFF53F8)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            
            \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\HoldDownID))
               DrawingMode(#PB_2DDrawing_AlphaBlend)
               Circle(x+14, y+14, 10, $FF9E1799)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            FreeImage(TempImageID)
      EndSelect 
   EndWith
EndProcedure

;创建普通按键
Procedure Screen_btnGadget(*pGadget.__GadgetInfo, X, Y, W, H, Text$)
   With *pGadget
      \IsCreate = #True
      *pColor.__ScreenColorInfo = _Project\pMapColor("对话框按键")
      HighColor = (Alpha(*pColor\HighColor) << 23 & $FF000000) |(*pColor\HighColor & $FFFFFF)
      \X = X : \Y = Y : \W = W : \H = H : \R = X+W : \B = Y+H
      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
      \NormalcyID = CreateImage(#PB_Any, W, H, 32, #PB_Image_Transparent)
      If StartDrawing(ImageOutput(\NormalcyID))
         Redraw_Gradient(*pColor, 0, 0, \W, \H)
         DrawingMode(#PB_2DDrawing_Transparent)
         DrawingFont(FontID(#fntDefault))
         X = (W-TextWidth(Text$))/2
         Y = (H-TextHeight(Text$))/2
         DrawText(X+0, Y+0, Text$, *pColor\FontColor)
         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
         Box(0, 0, W, H, *pColor\SideColor)
         StopDrawing()
      EndIf
      
      \MouseTopID = CreateImage(#PB_Any, W, H, 32, #PB_Image_Transparent)
      If StartDrawing(ImageOutput(\MouseTopID))
         DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
         Box(0, 0, W, H, *pColor\HighColor)
         StopDrawing()
      EndIf
      
      \HoldDownID = CreateImage(#PB_Any, W, H, 32, #PB_Image_Transparent)
      If StartDrawing(ImageOutput(\HoldDownID))
         DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
         Box(0, 0, W, H, HighColor)
         StopDrawing()
      EndIf      
   EndWith
EndProcedure



;注销控件
Procedure Create_Release(*pGadget.__GadgetInfo)
   If *pGadget = 0 : ProcedureReturn #False: EndIf 
   If *pGadget\IsCreate = #False : ProcedureReturn #False: EndIf 
   With *pGadget
      \X = 0 : \Y = 0 : \R = 0: \B = 0 
      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf : \NormalcyID = 0
      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf : \MouseTopID = 0
      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf : \HoldDownID = 0
   EndWith
EndProcedure

;-==========================
;- [Message]
;光标在上事件
Procedure Message_Hook_MOUSEMOVE(*pMouse.POINTS)
   With _Message
      If     Macro_Gadget_InRect3(\btnMessageClose)  : *pEventGadget = \btnMessageClose
      ElseIf Macro_Gadget_InRect3(\btnMessageYes)    : *pEventGadget = \btnMessageYes
      ElseIf Macro_Gadget_InRect3(\btnMessageNo)     : *pEventGadget = \btnMessageNo
      ElseIf Macro_Gadget_InRect3(\btnMessageCancel) : *pEventGadget = \btnMessageCancel   
      EndIf 
      ;整理响应事件
      If _Screen\pMouseTop <> *pEventGadget : _Screen\pMouseTop = *pEventGadget : Message_Redraw() : EndIf
   EndWith
EndProcedure

;左键按下事件
Procedure Message_Hook_LBUTTONDOWN(*pMouse.POINTS)
   With _Message
      If     Macro_Gadget_InRect3(\btnMessageClose)  : *pEventGadget = \btnMessageClose
      ElseIf Macro_Gadget_InRect3(\btnMessageYes)    : *pEventGadget = \btnMessageYes
      ElseIf Macro_Gadget_InRect3(\btnMessageNo)     : *pEventGadget = \btnMessageNo
      ElseIf Macro_Gadget_InRect3(\btnMessageCancel) : *pEventGadget = \btnMessageCancel
      Else
         SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)      
      EndIf 
      ;整理响应事件
      If _Screen\pHoldDown <> *pEventGadget : _Screen\pHoldDown = *pEventGadget : Message_Redraw() : EndIf   
   EndWith
EndProcedure

;左键释放事件
Procedure Message_Hook_LBUTTONUP(*pMouse.POINTS)
   With _Message
      If Macro_Gadget_InRect3(\btnMessageClose)
         If _Screen\pHoldDown = \btnMessageClose
            *pEventGadget = \btnMessageClose
            PostEvent(#PB_Event_Gadget, #winMessage, #btnMessageClose)
         EndIf 
         
      ElseIf Macro_Gadget_InRect3(\btnMessageYes)
         If _Screen\pHoldDown = \btnMessageYes
            *pEventGadget = \btnMessageYes
            PostEvent(#PB_Event_Gadget, #winMessage, #btnMessageYes)
         EndIf
         
      ElseIf Macro_Gadget_InRect3(\btnMessageNo)
         If _Screen\pHoldDown = \btnMessageNo
            *pEventGadget = \btnMessageNo
            PostEvent(#PB_Event_Gadget, #winMessage, #btnMessageNo)
         EndIf
         
      ElseIf Macro_Gadget_InRect3(\btnMessageCancel)
         If _Screen\pHoldDown = \btnMessageCancel
            *pEventGadget = \btnMessageCancel
            PostEvent(#PB_Event_Gadget, #winMessage, #btnMessageCancel)
         EndIf
      EndIf 
      
      ;整理响应事件
      If _Screen\pHoldDown Or _Screen\pHoldDown
         _Screen\pHoldDown = 0 : _Screen\pMouseTop = 0 : Message_Redraw() 
      EndIf   
   EndWith
EndProcedure

;挂钩事件
Procedure Message_Hook(hWindow, uMsg, wParam, lParam) 
   With _Message
      If \hWindow <> hWindow
         ProcedureReturn DefWindowProc_(hWindow, uMsg, wParam, lParam)
      EndIf
      Select uMsg 
         Case #WM_MOUSEMOVE     : Message_Hook_MOUSEMOVE  (@lParam)
         Case #WM_LBUTTONDOWN   : Message_Hook_LBUTTONDOWN(@lParam)
         Case #WM_LBUTTONUP     : Message_Hook_LBUTTONUP  (@lParam)
      EndSelect 
      Result = CallWindowProc_(\hWindowHook, hWindow, uMsg, wParam, lParam) 
   EndWith
   ProcedureReturn Result
EndProcedure

;绘制事件
Procedure Message_Redraw()

   With _Message
      ;绘制与当前窗体与鼠标事件相关的界面
      ImageID = CreateImage(#PB_Any, \WindowW, \WindowH)
      If StartDrawing(ImageOutput(ImageID))
         *pColorWindow.__ScreenColorInfo = _Project\pMapColor("窗体布局")
         DrawingFont(FontID(#fntDefault))
         Box(0, 0, \WindowW, \WindowH, *pColorWindow\BackColor & $FFFFFF)
         Redraw_Gradient(*pColorWindow, 0, 0, \WindowW, \WindowH)
         Box(0, 0, \WindowW, \WindowH, *pColorWindow\BackColor)
         Box(1, \TitleH, 1, \WindowH-\TitleH-1, *pColorWindow\HighColor)
         Box(1, \TitleH, \WindowW-1, 1, *pColorWindow\HighColor)
         
         *pColorCaption.__ScreenColorInfo = _Project\pMapColor("标题栏")
         Redraw_Gradient(*pColorCaption, 0, 0, \WindowW, \TitleH)
         DrawingMode(#PB_2DDrawing_AlphaBlend)
         Box(1, 0, 1, \TitleH, *pColorCaption\HighColor)
         Box(1, 1, \WindowW-1, 1, *pColorCaption\HighColor)
         Box(0, \TitleH-1, \WindowW, 1, *pColorCaption\SideColor)

         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Transparent)
         If IsImage(_Project\SoftwareIconID)
            DrawImage(ImageID(_Project\SoftwareIconID), 10, (\TitleH-24)/2, 24, 24)
            DrawText(20+24, (\TitleH-TextHeight(\Title$))/2, \Title$, *pColorCaption\FontColor)
         Else 
            DrawImage(_Screen\hSoftwareIcon, 10, (\TitleH-24)/2, 24, 24)
            DrawText(20+24, (\TitleH-TextHeight(\Title$))/2, \Title$, *pColorCaption\FontColor)
         EndIf 
      
         X = 40 : Y = \TitleH+10
         If \hMessageIcon
            X + 50 
            If \NoticeH < 50 : Y = \TitleH+10 + (50-\NoticeH)/2 : EndIf 
            DrawImage(\hMessageIcon, 40, \TitleH+(\WindowH-\TitleH-32-50)/2, 32, 32)
         EndIf 

         ForEach \ListText$()
            DrawText(X+0, Y+0, \ListText$(),*pColorCaption\FontColor)
            Y + TextHeight(\ListText$()) + 5
         Next 
         
         
         *pColorMessage.__ScreenColorInfo = _Project\pMapColor("对话框按键")
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         ButtonX = \WindowW-1 - \btnMessageClose\W : ButtonY = 1  
         Redraw_Gadget(\btnMessageClose, ButtonX, ButtonY)
         Redraw_Gadget(\btnMessageYes,   #PB_Ignore, #PB_Ignore)
         Redraw_Gadget(\btnMessageNo,    #PB_Ignore, #PB_Ignore)
         Redraw_Gadget(\btnMessageCancel,#PB_Ignore, #PB_Ignore)
         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
         Box(0, 0, \WindowW, \WindowH, *pColorWindow\SideColor)  
         StopDrawing()
      EndIf 
     
      ;将对话框图像渲染到窗体
      DeleteObject_(\hBackImage)  
      If IsImage(ImageID)
         \hBackImage= CreatePatternBrush_(ImageID(ImageID))
         If \hBackImage
            SetClassLongPtr_(\hWindow, #GCL_HBRBACKGROUND, \hBackImage)
            RedrawWindow_(\hWindow, #Null, #Null, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)
         EndIf 
      EndIf 
   EndWith
   
EndProcedure

;初始化窗体
Procedure Message_Requester(hWindow, Title$, Notice$, Flags=#PB_MessageRequester_Ok, IsEnable=#True)

   With _Message
      If IsWindow(#winMessage) 
         Create_Release(\btnMessageClose)
         Create_Release(\btnMessageYes)
         Create_Release(\btnMessageNo)
         Create_Release(\btnMessageCancel)
         DeleteObject_ (\hBackImage)
         ClearList(\ListText$())
         If \hMessageIcon : DestroyIcon_(\hMessageIcon) : EndIf 
         CloseWindow(#winMessage) 
      EndIf 

      ;分割文本,并计算文本占用的最大宽度和最大高度
      TempImageID = CreateImage(#PB_Any, 100, 100)
      ClearList(\ListText$())
      If StartDrawing(ImageOutput(TempImageID))
         DrawingFont(FontID(#fntDefault))
         H = 00
         For k = 1 To CountString(Notice$, #LF$)+1
            LineText$ = StringField(Notice$, k, #LF$)
            TextW = TextWidth(LineText$)
            If W < TextW : W = TextW : EndIf 
            H + TextHeight(LineText$) + 5
            AddElement(\ListText$())
            \ListText$() = LineText$
         Next 
         StopDrawing()
      EndIf
      FreeImage(TempImageID)

      \NoticeH = H
      ;根据标志,定义按键名称及计算最小宽度
      Select Flags & $0F
         Case #PB_MessageRequester_YesNo        : MinW = 240 : Button1$ = "确认" : Button2$ = "取消"
         Case #PB_MessageRequester_YesNoCancel  : MinW = 340 : Button1$ = "是"   : Button2$ = "否"   : Button3$ = "取消"
         Default : MinW = 100 : Button1$ = "OK"
      EndSelect 
      Select Flags & $F0
         Case #PB_MessageRequester_Error    : W+50 : MinH = 50 : \hMessageIcon = ExtractIcon_(0, _Screen\SystemPath$+"\User32.dll", 3)
         Case $20                           : W+50 : MinH = 50 : \hMessageIcon = ExtractIcon_(0, _Screen\SystemPath$+"\User32.dll", 2)
         Case #PB_MessageRequester_Warning  : W+50 : MinH = 50 : \hMessageIcon = ExtractIcon_(0, _Screen\SystemPath$+"\User32.dll", 1)
         Case #PB_MessageRequester_Info     : W+50 : MinH = 50 : \hMessageIcon = ExtractIcon_(0, _Screen\SystemPath$+"\User32.dll", 4)
         Default : \hMessageIcon = 0  
      EndSelect 
      If W < MinW : W = MinW : EndIf
      If H < MinH : H = MinH : EndIf
      
      ;计算对话框的宽度和高度
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat  : \TitleH  = 30
         Case #ButtonStyle_Bread : \TitleH  = 30
         Case #ButtonStyle_Cake  : \TitleH  = 36
      EndSelect
      W = W + 40 + 40  
      H = H + \TitleH + 20 + 50  

      ;创建对话框窗体
      hParent = hWindow
      \WindowW = W
      \WindowH = H
      \Flags   = Flags
      \Title$  = Title$
      If hParent = 0
         WindowFlags = #PB_Window_BorderLess|#PB_Window_ScreenCentered
         \hWindow = OpenWindow(#winMessage, 0, 0, W, H, "", WindowFlags)
      Else 
         WindowFlags = #PB_Window_BorderLess|#PB_Window_WindowCentered
         \hWindow = OpenWindow(#winMessage, 0, 0, W, H, "", WindowFlags, hParent)
      EndIf
      Create_btnCloseBox(\btnMessageClose) 
      Select \Flags & $0F
         Case #PB_MessageRequester_YesNo
            Screen_btnGadget (\btnMessageYes,   \WindowW/2-120, \WindowH-050, 100, 030, Button1$)
            Screen_btnGadget (\btnMessageNo,    \WindowW/2+020, \WindowH-050, 100, 030, Button2$)
         Case  #PB_MessageRequester_YesNoCancel
            Screen_btnGadget (\btnMessageYes,   \WindowW/2-170, \WindowH-050, 100, 030, Button1$)
            Screen_btnGadget (\btnMessageNo,    \WindowW/2-050, \WindowH-050, 100, 030, Button2$)
            Screen_btnGadget (\btnMessageCancel,\WindowW/2+070, \WindowH-050, 100, 030, Button3$)
         Default; #PB_MessageRequester_Ok
            Screen_btnGadget (\btnMessageYes,   \WindowW/2-050, \WindowH-050, 100, 030, Button1$)            
      EndSelect 
      
      Message_Redraw()
      If IsEnable=#True
         EnableWindow_(hParent, #False)  ;让父窗体不响应动作
      EndIf 
      \hWindowHook = SetWindowLongPtr_(\hWindow, #GWL_WNDPROC, @Message_Hook()) 
      Repeat
         Select WindowEvent()
            Case #PB_Event_CloseWindow   : \IsExitWindow = #True
            Case #PB_Event_Gadget
               Select EventGadget()
                  Case #btnMessageClose  : \IsExitWindow = #True
                  Case #btnMessageYes    : \IsExitWindow = #True : Result = #PB_MessageRequester_Yes
                  Case #btnMessageNo     : \IsExitWindow = #True : Result = #PB_MessageRequester_No
                  Case #btnMessageCancel : \IsExitWindow = #True : Result = #PB_MessageRequester_Cancel
               EndSelect
            Default 
         EndSelect
      Until \IsExitWindow = #True 
      
      Create_Release(\btnMessageClose)
      Create_Release(\btnMessageYes)
      Create_Release(\btnMessageNo)
      Create_Release(\btnMessageCancel)
      DeleteObject_ (\hBackImage)
      ClearList(\ListText$())
      
      If \hMessageIcon : DestroyIcon_(\hMessageIcon) : EndIf 
      CloseWindow(#winMessage)
      If IsEnable=#True
         EnableWindow_(hParent, #True)   ;恢复父窗体的响应动作
      EndIf 
   EndWith
   ProcedureReturn Result
EndProcedure


;-==========================
;-[Create]
Procedure CreateGadget_ComboBox(GadgetID, FrontColor, BackColor) 
   *pMemSkin = GlobalAlloc_(#Null,5*4) 
   SetWindowLong_(GadgetID(GadgetID), #GWL_USERDATA, *pMemSkin)
   PokeL(*pMemSkin+ 0, FrontColor ) 
   PokeL(*pMemSkin+ 4, BackColor )
   PokeL(*pMemSkin+12, CreateSolidBrush_(BackColor))
   PokeL(*pMemSkin+16, SetWindowLong_(GadgetID(GadgetID), #GWL_WNDPROC, @Screen_HookWindow())) 
EndProcedure

;右侧设置栏
Procedure CreateGadget_Attributes()
   CanvasX = _Screen\WindowW-05-#Screen_AttributeW
   CanvasY = 05+ToolBarHeight(#wtbScreen)
   CanvasH = _Screen\WindowH-10-StatusBarHeight(#wsbScreen)-ToolBarHeight(#wtbScreen)
   SetGadgetFont(#PB_Default, FontID(#fntDefault))
   CanvasGadget(#cvsAttributes, CanvasX, CanvasY, #Screen_AttributeW, CanvasH, #PB_Canvas_Border|#PB_Canvas_Container)
      With *pAttribute
         X = #Screen_GroupItemW : W = #Screen_GadgetItemW
         *pAttribute = Attributes_AddGroup(#cmbLayoutStyle, "窗体布局", "设置窗体大小及缩放.")
            Attributes_AddItem(*pAttribute, #chkCanvasImage,  0, "使用画布",    "创建以画布为背景的窗体(启用后ImageGadget()无效).") 
            Attributes_AddItem(*pAttribute, #txtWindowRealW,  0, "创建宽度",    "创建窗体的初始宽度.") 
            Attributes_AddItem(*pAttribute, #txtWindowRealH,  0, "创建高度",    "创建窗体的初始高度.") 
            Attributes_AddItem(*pAttribute, #chkSizeWindow,   0, "可调整大小",  "窗体支持改变大小的功能.") 
            Attributes_AddItem(*pAttribute, #txtWindowSideL,  0, "左际留边",    "为0时表示不支持窗体左侧拉伸窗体,非0表示支持.") 
            Attributes_AddItem(*pAttribute, #txtWindowSideR,  0, "右际留边",    "为0时表示不支持窗体右侧拉伸窗体,非0表示支持.") 
            Attributes_AddItem(*pAttribute, #txtWindowSideT,  0, "顶部留边",    "为0时表示不支持窗体顶部拉伸窗体,非0表示支持.") 
            Attributes_AddItem(*pAttribute, #txtWindowSideB,  0, "底部留边",    "为0时表示不支持窗体底部拉伸窗体,非0表示支持.") 
            CheckBoxGadget(#chkCanvasImage,  X+05, 001, W-10, 22, "启用")            
            ComboBoxGadget(#cmbLayoutStyle,  X+20, 001, W-20, 22) 
            StringGadget  (#txtWindowRealW,  X+05, 001, W-10, 18, "500", #PB_String_BorderLess)
            StringGadget  (#txtWindowRealH,  X+05, 001, W-10, 18, "350", #PB_String_BorderLess)
            CheckBoxGadget(#chkSizeWindow,   X+05, 001, W-10, 22, "启用")
            StringGadget  (#txtWindowSideL,  X+05, 002, W-10, 18, "3",   #PB_String_BorderLess)
            StringGadget  (#txtWindowSideR,  X+05, 002, W-10, 18, "3",   #PB_String_BorderLess)
            StringGadget  (#txtWindowSideT,  X+05, 002, W-10, 18, "3",   #PB_String_BorderLess)
            StringGadget  (#txtWindowSideB,  X+05, 002, W-10, 18, "3",   #PB_String_BorderLess)

         *pAttribute = Attributes_AddGroup(#cmbSystemButton, "系统按键", "设置窗体右上角小按键.")
            Attributes_AddItem(*pAttribute, #chkSysCloseBox, 0, "关闭小按键",  "是否启用[X]关闭窗体小按键.") 
            Attributes_AddItem(*pAttribute, #chkSysMinimize, 0, "最小化按键",  "是否启用[-]最小化窗体小按键.") 
            Attributes_AddItem(*pAttribute, #chkSysMaximize, 0, "最大化按键",  "是否启用[□]最大化窗体小按键.") 
            Attributes_AddItem(*pAttribute, #chkSysNormalcy, 0, "正常化按键",  "是否启用[□]正常化窗体小按键.") 
            Attributes_AddItem(*pAttribute, #chkSysSettings, 0, "设置小按键",  "是否启用[V]窗体设置小按键.") 
            ComboBoxGadget(#cmbSystemButton, X+20, 001, W-20, 22) 
            CheckBoxGadget(#chkSysCloseBox,  X+05, 001, W-10, 22, "启用")
            CheckBoxGadget(#chkSysMinimize,  X+05, 001, W-10, 22, "启用")
            CheckBoxGadget(#chkSysMaximize,  X+05, 001, W-10, 22, "启用")
            CheckBoxGadget(#chkSysNormalcy,  X+05, 001, W-10, 22, "启用")
            CheckBoxGadget(#chkSysSettings,  X+05, 001, W-10, 22, "启用")
            
         *pAttribute = Attributes_AddGroup(#chkCaptionBar, "标题栏", "设置标题栏和工具名称及图标.")
            Attributes_AddItem(*pAttribute, #txtCaptionName, 0, "标题栏名称",             "设置创建的新窗体的标题名称.") 
            Attributes_AddItem(*pAttribute, #txtCaptionIcon, #btnCaptionIcon, "界面图标", "设置创建的新窗体的图标.") 
            Attributes_AddItem(*pAttribute, #chkIncludeIcon, 0, "包含图标",               "将图标文件包含到EXE资源中,保存pb时,自动复制到同根目录.") 
            
            Attributes_AddItem(*pAttribute, #txtCaptionBarX, 0, "X坐标偏移",              "设置标题栏的起始位置(当大于工具栏宽度时,工具栏靠顶).")  
            Attributes_AddItem(*pAttribute, #txtCaptionBarH, 0, "标题栏高度",             "设置标题栏的高度")  
            CheckBoxGadget(#chkCaptionBar,  X+20,   001, W-20, 22, "启用")
            StringGadget  (#txtCaptionName, X+05,   002, W-10, 18, "新建工具", #PB_String_BorderLess)
            StringGadget  (#txtCaptionIcon, X+05,   002, W-25, 18, "" ,        #PB_String_BorderLess)
            ButtonGadget  (#btnCaptionIcon, X+W-20, 000, 0020, 20, "…")
            CheckBoxGadget(#chkIncludeIcon, X+05,   001, W-10, 22, "启用") 
            StringGadget  (#txtCaptionBarX, X+05,   002, W-10, 18, "0",        #PB_String_BorderLess)
            StringGadget  (#txtCaptionBarH, X+05,   002, W-10, 18, "40",       #PB_String_BorderLess)


         *pAttribute = Attributes_AddGroup(#chkStatusBar, "状态栏", "设置状态栏及窗体缩放图标.")
            Attributes_AddItem(*pAttribute, #chkStatusSize, 0, "缩放小图标",  "启用缩放窗体的小图标(前提[窗体布局]->[可调整大小]启用).") 
            Attributes_AddItem(*pAttribute, #txtStatusBarX, 0, "X坐标偏移",   "设置状态栏的起始位置.") 
            Attributes_AddItem(*pAttribute, #txtStatusBarH, 0, "状态栏高度",  "设置状态栏的高度.")  
            CheckBoxGadget(#chkStatusBar,   X+20, 001, W-20, 22, "启用")
            CheckBoxGadget(#chkStatusSize,  X+05, 001, W-10, 22, "启用")
            StringGadget  (#txtStatusBarX,  X+05, 002, W-10, 18, "30", #PB_String_BorderLess)
            StringGadget  (#txtStatusBarH,  X+05, 002, W-10, 18, "60", #PB_String_BorderLess)


         *pAttribute = Attributes_AddGroup(#chkIcoToolbar, "工具栏", "设置窗体右侧的图标工具栏.")
            Attributes_AddItem(*pAttribute, #txtIcoToolbarY, 0, "Y坐标偏移",   "设置工具栏的起始位置(相对于标题栏的高度).") 
            Attributes_AddItem(*pAttribute, #txtIcoToolbarW, 0, "工具栏宽度",  "设置状态栏的宽度(当标题栏X坐标大于此设置时,工具栏靠顶).") 
            CheckBoxGadget(#chkIcoToolbar,  X+20, 001, W-20, 22, "启用")
            StringGadget  (#txtIcoToolbarY, X+05, 002, W-10, 18, "60",  #PB_String_BorderLess)
            StringGadget  (#txtIcoToolbarW, X+05, 002, W-10, 18, "60",  #PB_String_BorderLess)

         *pAttribute = Attributes_AddGroup(#cmbColorsPrefer, "颜色设置", "设置工具各种颜色参数.")
            Attributes_AddItem(*pAttribute, #chkUseGradients,   #chkAniGradients,   "渐变效果",  "支持产生渐变效果,提供正反两种渐变效果.") 
            Attributes_AddItem(*pAttribute, #cmbGradientType,   0,                  "渐变类型",  "支持产生渐变效果的类型.") 
            Attributes_AddItem(*pAttribute, #cvsSetBackColor,   #txtSetBackColor,   "背景色",    "设置背景色,支持Alpha效果.") 
            Attributes_AddItem(*pAttribute, #cvsSetForeColor,   #txtSetForeColor,   "前景色",    "设置前景色,支持Alpha效果.") 
            Attributes_AddItem(*pAttribute, #cvsSetFontColor,   #txtSetFontColor,   "字体色",    "设置字体色,支持Alpha效果.") 
            Attributes_AddItem(*pAttribute, #cvsSetSideColor,   #txtSetSideColor,   "边框色",    "设置边框色,支持Alpha效果.") 
            Attributes_AddItem(*pAttribute, #cvsSetHighColor,   #txtSetHighColor,   "高亮色",    "设置边框色,支持Alpha效果.") 
            ComboBoxGadget(#cmbColorsPrefer, X+20, 001, W-20, 22) 
            CheckBoxGadget(#chkUseGradients, X+05, 001, (W-15)/2, 22, "启用")
            CheckBoxGadget(#chkAniGradients, X+10+(W-15)/2, 001, (W-15)/2, 22, "反向")
            ComboBoxGadget(#cmbGradientType, X+00, 001, W-0, 22)
            CanvasGadget(#cvsSetBackColor,   X+02, 002, 0018, 18)
            StringGadget(#txtSetBackColor,   X+25, 002, W-30, 18, "0xFFFFFFFF", #PB_String_BorderLess)  
            CanvasGadget(#cvsSetForeColor,   X+02, 002, 0018, 18)
            StringGadget(#txtSetForeColor,   X+25, 002, W-30, 18, "0xFFFFFFFF", #PB_String_BorderLess)  
            CanvasGadget(#cvsSetFontColor,   X+02, 002, 0018, 18)
            StringGadget(#txtSetFontColor,   X+25, 002, W-30, 18, "0xFFFFFFFF", #PB_String_BorderLess)  
            CanvasGadget(#cvsSetSideColor,   X+02, 002, 0018, 18)
            StringGadget(#txtSetSideColor,   X+25, 002, W-30, 18, "0xFFFFFFFF", #PB_String_BorderLess)  
            CanvasGadget(#cvsSetHighColor,   X+02, 002, 0018, 18)
            StringGadget(#txtSetHighColor,   X+25, 002, W-30, 18, "0xFFFFFFFF", #PB_String_BorderLess)  

            
         *pAttribute = Attributes_AddGroup(0, "杂项设置", "其它杂项设置")
            Attributes_AddItem(*pAttribute, #chkMessageBox, 0, "信息对话框",  "启用后生成代码时，自动生成[信息对话框]的代码.") 
            Attributes_AddItem(*pAttribute, #chkBalloonTip, 0, "启用提示文",  "启用提示文功能.") 
            Attributes_AddItem(*pAttribute, #chkPreference, 0, "设置文件",    "启用设置文件的加载和保存功能.") 
            CheckBoxGadget(#chkMessageBox, X+05, 001, W-10, 22, "启用")
            CheckBoxGadget(#chkBalloonTip, X+05, 001, W-10, 22, "启用")
            CheckBoxGadget(#chkPreference, X+05, 001, W-10, 22, "启用")
            
      EndWith
   CloseGadgetList()

   AddGadgetItem(#cmbSystemButton, -1, "扁平风格") 
   AddGadgetItem(#cmbSystemButton, -1, "面包风格")
   AddGadgetItem(#cmbSystemButton, -1, "钮扣风格")
   
   AddGadgetItem(#cmbGradientType, -1, "上下性线渐变")     
   AddGadgetItem(#cmbGradientType, -1, "左右性线渐变")   
   AddGadgetItem(#cmbGradientType, -1, "左上对角性线渐变")   
   AddGadgetItem(#cmbGradientType, -1, "右上对角性线渐变") 
   AddGadgetItem(#cmbGradientType, -1, "中心椭圆渐变")   
   AddGadgetItem(#cmbGradientType, -1, "左上椭圆渐变")   
   AddGadgetItem(#cmbGradientType, -1, "右上椭圆渐变") 
   AddGadgetItem(#cmbGradientType, -1, "左下椭圆渐变") 
   AddGadgetItem(#cmbGradientType, -1, "右下椭圆渐变") 
   SetGadgetState(#cmbGradientType, 0)
   DisableGadget(#chkSysCloseBox, #True)
   DisableGadget(#chkSysNormalcy, #True)

   ForEach _Screen\ListColorStyle()
      AddGadgetItem(#cmbLayoutStyle, -1, _Screen\ListColorStyle()\ColorStyle$)
   Next 
   
   With _Screen\pMapAttriGroup()
      ForEach _Screen\pMapAttriGroup()
         If IsGadget(\GadgetID)
            Select GadgetType(\GadgetID) 
               Case #PB_GadgetType_String
                  SetGadgetColor(\GadgetID, #PB_Gadget_BackColor, #Attribute_TitleColor)
               Case #PB_GadgetType_ComboBox
                  CreateGadget_ComboBox(\GadgetID, #Attribute_FontColor, #Attribute_TitleColor) 
                  BindGadgetEvent(\GadgetID, @EventGroup_ComboBoxGadget())
               Case #PB_GadgetType_CheckBox  
                  BindGadgetEvent(\GadgetID, @EventGroup_CheckBoxGadget())
            EndSelect
         EndIf 
      Next 
   EndWith
   With _Screen\pMapAttriItems()
      ForEach _Screen\pMapAttriItems()
         If IsGadget(\GadgetID1)
            Select GadgetType(\GadgetID1) 
               Case #PB_GadgetType_String
                  SetGadgetColor(\GadgetID1, #PB_Gadget_BackColor, #Window_BackColor)
                  BindGadgetEvent(\GadgetID1, @EventGroup_StringGadget())
               Case #PB_GadgetType_ComboBox
                  CreateGadget_ComboBox(\GadgetID1, #Attribute_FontColor, #Window_BackColor) 
                  BindGadgetEvent(\GadgetID1, @EventGroup_ComboBoxGadget())
               Case #PB_GadgetType_CheckBox  
                  BindGadgetEvent(\GadgetID1, @EventGroup_CheckBoxGadget())
               Case #PB_GadgetType_Canvas 
                  BindGadgetEvent(\GadgetID1, @EventGroup_CanvasGadget())
               Case #PB_GadgetType_Button 
                  BindGadgetEvent(\GadgetID1, @EventGroup_ButtonGadget())                  
                  
            EndSelect
            HideGadget(\GadgetID1, \pParent\FoldState)
         EndIf 
         
         If IsGadget(\GadgetID2) 
            Select GadgetType(\GadgetID2) 
               Case #PB_GadgetType_String
                  SetGadgetColor(\GadgetID2, #PB_Gadget_BackColor, #Window_BackColor)
                  BindGadgetEvent(\GadgetID2, @EventGroup_StringGadget())
               Case #PB_GadgetType_CheckBox  
                  BindGadgetEvent(\GadgetID2, @EventGroup_CheckBoxGadget())
               Case #PB_GadgetType_Button 
                  BindGadgetEvent(\GadgetID2, @EventGroup_ButtonGadget())     
            EndSelect
            HideGadget(\GadgetID2, \pParent\FoldState)
         EndIf 
      Next 
   EndWith

EndProcedure

Procedure CreateGadget_Screen()
   With _Screen
      ContainerGadget(#frmScreen, 10, 5, 250, 030)
         hGadget = ContainerGadget(#frmToolBar, 0, -2, 250, 030)
            If CreateToolBar(#wtbScreen, hGadget)
               ToolBarImageButton(#wtbToolNewFile,    ImageID(#wtbToolNewFile)) 
               ToolBarImageButton(#wtbToolOpenFile,   ImageID(#wtbToolOpenFile)) 
               ToolBarImageButton(#wtbToolSaveFile,   ImageID(#wtbToolSaveFile)) 
               ToolBarSeparator() 
               ToolBarImageButton(#wtbToolSaveAs,     ImageID(#wtbToolSaveAs)) 
               ToolBarImageButton(#wtbToolCloseFile,  ImageID(#wtbToolCloseFile)) 
               ToolBarSeparator() 
               ToolBarImageButton(#wtbToolGenerate,   ImageID(#wtbToolGenerate), #PB_ToolBar_Toggle)         
               ToolBarSeparator() 
               ToolBarImageButton(#wtbToolCopyeCode,  ImageID(#wtbToolCopyeCode)) 
               ToolBarSeparator() 
               ToolBarImageButton(#wtbToolSticky,     ImageID(#wtbToolSticky), #PB_ToolBar_Toggle) 
               ToolBarImageButton(#wtbToolVersion,    ImageID(#wtbToolVersion)) 
               
               ToolBarToolTip(#wtbScreen, #wtbToolNewFile,   "新建文件")
               ToolBarToolTip(#wtbScreen, #wtbToolOpenFile,  "打开文件")
               ToolBarToolTip(#wtbScreen, #wtbToolSaveFile,  "保存文件")
               ToolBarToolTip(#wtbScreen, #wtbToolSaveAs,    "文件另存为")
               ToolBarToolTip(#wtbScreen, #wtbToolCloseFile, "关闭")
               ToolBarToolTip(#wtbScreen, #wtbToolCopyeCode, "复制代码")
               ToolBarToolTip(#wtbScreen, #wtbToolGenerate,  "生成代码")
               ToolBarToolTip(#wtbScreen, #wtbToolSticky,    "工具置顶")
               DisableToolBarButton(#wtbScreen, #wtbToolCopyeCode, 1)
            EndIf 
            ToolBarH = ToolBarHeight(#wtbScreen)
            ResizeGadget(#frmScreen,  #PB_Ignore, #PB_Ignore, #PB_Ignore, ToolBarH)
            ResizeGadget(#frmToolBar, #PB_Ignore, #PB_Ignore, #PB_Ignore, ToolBarH)
         CloseGadgetList()
      CloseGadgetList()
      If CreateStatusBar(#wsbScreen, \hWindow)
         AddStatusBarField(0100)
         AddStatusBarField(0150)
         AddStatusBarField(2999)
         StatusBarText(#wsbScreen,  0, "- 迷路仟作品 -", #PB_StatusBar_Center)
         StatusBarText(#wsbScreen,  1, " 窗体大小: 1024x1024")
         StatusBarText(#wsbScreen,  2, "欢迎使用【迷路PureBasic自绘UI代码生成工具】")
      EndIf
;       
      ;{
      ;===============
      TextGadget(#lblScreen, \WindowW-5-#Screen_AboutMilooW, 10, #Screen_AboutMilooW, 20, "迷路仟/Miloo [QQ:714095563]", #PB_Text_Right)
      ;窗体演示界面
      CanvasX = 05
      CanvasY = 05+ToolBarHeight(#wtbScreen)
      CanvasW = \WindowW-15-#Screen_AttributeW
      CanvasH = \WindowH-10-StatusBarHeight(#wsbScreen)-ToolBarHeight(#wtbScreen)
      CanvasGadget(#cvsIllustrate, CanvasX, CanvasY, CanvasW, CanvasH, #PB_Canvas_Border|#PB_Canvas_Container)
         ;底部滚动条
         GadgetX = 0
         GadgetY = CanvasH-#Screen_ScrollBarH-4
         GadgetW = CanvasW-#Screen_ScrollBarW-4
         ScrollBarGadget(#srcIllustrateH, GadgetX, GadgetY, GadgetW, #Screen_ScrollBarH, 0, 100, 1)
         
         ;右侧滚动条
         GadgetX = CanvasW - #Screen_ScrollBarW-4
         GadgetY = 00
         GadgetH = CanvasH - #Screen_ScrollBarH-4
         ScrollBarGadget(#srcIllustrateV, GadgetX, GadgetY, #Screen_ScrollBarW, GadgetH, 0, 100, 1, #PB_ScrollBar_Vertical)
      CloseGadgetList()
      mcsRichEditGadget_(#rtxSourceCode, CanvasX, CanvasY, CanvasW, CanvasH)
      HideGadget(#rtxSourceCode, #True)
      ;===============
      ;}
      ;右侧设置栏
      CreateGadget_Attributes()
   EndWith
   SetGadgetAttribute(#rtxSourceCode, #MCS_RichEdit_Format, #FormatType_PB)
   SetGadgetFont(#rtxSourceCode, FontID(#fntRichEdit))
   SetGadgetFont(#lblScreen,     FontID(#fntVersion))
   SetGadgetColor(#lblScreen, #PB_Gadget_FrontColor, $F48000)
   SetToolBarButtonState(#wtbScreen, #wtbToolSticky, _Screen\IsStickyWindow)
   StickyWindow(#winScreen, _Screen\IsStickyWindow)
   BindGadgetEvent(#cvsIllustrate,  @EventGadget_cvsIllustrate())
   BindGadgetEvent(#cvsAttributes,  @EventGadget_cvsAttributes())
   BindGadgetEvent(#srcIllustrateV, @EventGadget_srcIllustrateV())
   BindGadgetEvent(#srcIllustrateH, @EventGadget_srcIllustrateH())

EndProcedure  

;-==========================
;-[Main]
Procedure Main_Initial()
   UseGIFImageDecoder()
   UsePNGImageDecoder()
   UseTGAImageDecoder()
   UseTIFFImageDecoder()
   UseJPEGImageDecoder()
   UseJPEG2000ImageDecoder()
   LoadFont(#fntDefault,  "宋体", 11)
   LoadFont(#fntRichEdit, "宋体", 14)
   LoadFont(#fntVersion,  "宋体", 12, #PB_Font_Bold)
   ToolIconID = CatchImage(#PB_Any, ?_ICON_ToolIcon)
   For ImageID = #wtbToolNewFile To #wtbToolVersion
      GrabImage(ToolIconID, ImageID, Index * 16, 0, 16, 16) : Index+1
   Next 
   FreeImage(ToolIconID)
   
   Offset = ?_End_PartSytle-?_Bin_GadgetColor
   *pMemColor = ?_Bin_GadgetColor   
   ColorColor$ = "深灰色风格,嫣红色风格,橙红色风格,土黄色风格,深紫色风格,深绿色风格,深蓝色风格,深青色风格,"
   For k = 1 To CountString(ColorColor$, ",")
      AddElement(_Screen\ListColorStyle())
      _Screen\ListColorStyle()\pMemColor   = *pMemColor
      _Screen\ListColorStyle()\ColorStyle$ = StringField(ColorColor$, k, ",")
      *pMemColor+Offset
   Next 

   _Screen\SystemPath$ = Space(255) 
   Result=GetSystemDirectory_(@_Screen\SystemPath$,255) 
   _Screen\hSoftwareIcon = ExtractIcon_(0, _Screen\SystemPath$+"\User32.dll", 0)
   _Screen\hSizing    = LoadCursor_(0,#IDC_SIZENWSE)
   _Screen\hLeftRight = LoadCursor_(0,#IDC_SIZEWE)
   _Screen\hUpDown    = LoadCursor_(0,#IDC_SIZENS)
EndProcedure

Procedure Main_Release()
   FreeFont(#fntDefault)
   FreeFont(#fntRichEdit)
   FreeFont(#fntVersion)
   
   Create_Release(_Screen\btnCloseBox)
   Create_Release(_Screen\btnMinimize)
   Create_Release(_Screen\btnMaximize)
   Create_Release(_Screen\btnNormalcy)
   For ImageID = #wtbToolNewFile To #wtbToolVersion
      If IsImage(ImageID) : FreeImage(ImageID) : EndIf 
   Next 

   FreeList(_Screen\ListColorStyle())
   If _Balloon\hBackImage : DeleteObject_(_Balloon\hBackImage) : EndIf  ;释放提示文窗体背景句柄
   DestroyIcon_(_Screen\hSoftwareIcon)
   DestroyCursor_(_Screen\hSizing) 
   DestroyCursor_(_Screen\hLeftRight) 
   DestroyCursor_(_Screen\hUpDown) 
EndProcedure

; 加载设置文件
Procedure Main_LoadPrefer()
   OpenPreferences("设置.ini")
   PreferenceGroup("窗体设置")
      _Screen\WindowX = ReadPreferenceLong("WindowX", 0)
      _Screen\WindowY = ReadPreferenceLong("WindowY", 0)
      _Screen\WindowW = ReadPreferenceLong("WindowW", 800)
      _Screen\WindowH = ReadPreferenceLong("WindowH", 500)
      _Screen\IsStickyWindow = ReadPreferenceLong("窗体置顶", 0)
   PreferenceGroup("设计稿")
      _Project\DesignFile$ = ReadPreferenceString("设计稿", "")      
      
   ClosePreferences()
EndProcedure

; 保存设置文件
Procedure Main_SavePrefer()
   If CreatePreferences("设置.ini")
      PreferenceComment("")
      PreferenceGroup("窗体设置")
         WritePreferenceLong("WindowX", WindowX(#winScreen))
         WritePreferenceLong("WindowY", WindowY(#winScreen))
         WritePreferenceLong("WindowW", _Screen\WindowW)
         WritePreferenceLong("WindowH", _Screen\WindowH)
         WritePreferenceLong("窗体置顶", _Screen\IsStickyWindow)
      PreferenceGroup("设计稿")
         WritePreferenceString("设计稿", _Project\DesignFile$)    
      ClosePreferences()
   EndIf 
EndProcedure

; UIDrawTool
;- ##########################
;- [Demo]        
With _Screen
   Main_Initial()
   Main_LoadPrefer()
   WindowFlags = #PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
   If \WindowX <= 0 Or \WindowY <= 0 Or \WindowW <= 500 Or \WindowH =< 300
      \WindowW = 800
      \WindowH = 500
      \hWindow = OpenWindow(#winScreen, 0, 0, \WindowW, \WindowH, #Screen_Caption$, #PB_Window_ScreenCentered|WindowFlags)
   Else 
      \hWindow = OpenWindow(#winScreen, \WindowX, \WindowY, \WindowW, \WindowH, #Screen_Caption$, WindowFlags)
   EndIf 
   WindowBounds(#winScreen, 500, 300, #PB_Ignore, #PB_Ignore)
   CreateGadget_Screen()
   Redraw_cvsAttributes()
   SetWindowCallback(@Screen_Callback())    ; 启用Callback
   If Designs_OpenFile(#True) = #False
      Attributes_NewProject()
   EndIf 

   Repeat
      WinEvent  = WindowEvent()
      Select WinEvent
         Case #PB_Event_CloseWindow 
            Select EventWindow() 
               Case #winScreen   : \IsExitWindow = #True
               Case #winMessage  : _Message\IsExitWindow = #True : _Message\MessageResult = #Null
            EndSelect 
         
         Case #PB_Event_Menu     : EventGadget_EventMenu()
         Case #WM_MOUSEWHEEL     : EventGadget_MOUSEWHEEL()

      EndSelect      
      Delay(1)
   Until \IsExitWindow = #True
EndWith

Main_Release()
Main_SavePrefer()
End


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
;    IncludeBinary ".\ToolIcon.png" 
   
   Data.l  $474E5089, $0A1A0A0D, $0D000000, $52444849, $90000000, $10000000, $00000308, $0628CE00, $00000052, $4D416704, $B1000041, $61FC0B8F
   Data.l  $00000005, $47527301, $CEAE0042, $0000E91C, $4C50CA02, $70474554, $2EB7D34C, $35C77F54, $88D8B667, $F0D1BD2D, $72BA662F, $8B4EDC9D
   Data.l  $C57F42C8, $F6CC8655, $ACDAFDF9, $BC846435, $FDFCF2EA, $C2E3D4F6, $BC6B3560, $F1B8743A, $E7D6FEF7, $C8793FFF, $33CD9E70, $97668B50
   Data.l  $C8824CD6, $E5B87438, $83546FC6, $B97E45CC, $95C98144, $E9D9DDAF, $C77545FF, $38A56837, $6131BD6D, $B6A38EA8, $BCC68749, $77480446
   Data.l  $B98562C8, $BD359ADA, $B8D80E4C, $FDE5D138, $32FBE1C8, $86519152, $0345B9CA, $672F8294, $6ECC2360, $FFEADB2A, $CDC27C43, $7339FCE3
   Data.l  $405A60C0, $5FFADDC4, $EEE31F5A, $C38A58F5, $44CC8757, $9765C775, $CA7D4DCF, $4324626F, $A1D0CB8B, $FF7F3F34, $8E2C87D8, $D6B8EBBE
   Data.l  $308BD9F6, $39B57749, $88629B5A, $28ACC8C0, $301F575F, $34128455, $F8F2EB76, $35BA652E, $6B35BC7C, $FFFFFFB1, $003FBFCF, $B0A07F27
   Data.l  $2F989F6F, $EFFEFBF8, $E9D8FBF5, $E1A279FF, $D4FDE3CD, $6A36FEE6, $FBE1C9BC, $C4FFFFFF, $BC92F9DD, $FFF8F1E6, $64FDF2E7, $6030C98C
   Data.l  $F8E7DCAB, $FEB36634, $EFE5F1FC, $F6EBDEF9, $8891E6F8, $916B62C0, $FBF3EACE, $DBCDA080, $986C3695, $F6D8BEC5, $7F9EE6F6, $BE64E7AC
   Data.l  $92DEF4FC, $F6F6D4B3, $D3F183E1, $72DFF57D, $D0F7FDFF, $A27739BD, $C09267D0, $F4F3DED0, $BCA061DA, $F9F4EDE6, $AEF8B353, $845DE5C5
   Data.l  $4ED5F2B3, $FF2090AE, $F8F490F3, $60E2F0FC, $8F397379, $8B65D9B5, $1E6772B6, $0BD69A52, $AC857B30, $E1C4A9D3, $F0DBBEA2, $F7FF70EB
   Data.l  $DFBC9EA0, $D180EFF3, $D3E5FCE5, $D2B69892, $FDC2F7FF, $D698B2F2, $46CAE0FF, $C60970E6, $DAF9FBE0, $147DFBAE, $FCBFDCC2, $3E9FE7F7
   Data.l  $6069F638, $D49D94AC, $B4D0F9E5, $C6966624, $78E5CCB6, $7590C5A0, $DDC2A616, $D02E37B7, $B38040C8, $69CDE4E2, $EAB44B12, $A3F4F1F1
   Data.l  $3D43BC4E, $A7EDDFD3, $A77BBDAD, $125B68D6, $D8B87D52, $D7BA4D56, $4B4962F6, $1745AABB, $79589942, $DB5C20A7, $8A145AC3, $80E2F0BB
   Data.l  $C4ECF56C, $C6D6CDCD, $658789C1, $D8A88069, $8FBC8E5C, $9E69C7A9, $A25E3DCF, $C6E4C8B0, $C8B1E9D5, $26598BF4, $5194B1F6, $C5BF6E59
   Data.l  $8A7F8DD9, $B43C46CA, $52966865, $4C5DEE51, $E1FDC06B, $8D676061, $127FA0CD, $C0CBA77D, $8AEB75B6, $DBC4B140, $D2F0946C, $4040AFB4
   Data.l  $E0835540, $CFF2E6D7, $B24FA49E, $8D7177F7, $AE450676, $5A000000, $534E5274, $C9FD1100, $FEF6FDF8, $FDDCF9F7, $FEDE07F6, $DE72EDFB
   Data.l  $F7FD8EDE, $F761C0F4, $FEEA30FE, $AA54F7DE, $FEF70FEF, $78F822D3, $E0DEDED7, $E8F8E1D1, $DE81DEFD, $B0DE2BF7, $E4FEE4DE, $FE7BB2D9
   Data.l  $DEC36067, $82F6E8DE, $8FC8F89E, $EEDAEFE0, $A090DBF8, $0DE490F0, $000099E8, $4449D305, $C7485441, $53F7968D, $C7145953, $2291891F
   Data.l  $A0894310, $50100580, $B1560440, $FB7DEF62, $4A909203, $84912C09, $79424A12, $0351E102, $8A5C1148, $2690194B, $BD83A2A0, $ABEC7777
   Data.l  $0FFEFBDB, $697DEE7B, $ECECECEE, $EE4C87E7, $3E4EF37D, $72F39EF9, $BDF31043, $7836181D, $4A6610BA, $97A952A5, $40B726D7, $CD93CDC2
   Data.l  $B1E09913, $B08BA097, $7DFADEF5, $7022F52C, $4E11CDBD, $0B9B8440, $4EF17FF1, $B2D218A3, $49772CBD, $5CB972C5, $077A9729, $931717FA
   Data.l  $29C94924, $6CE34978, $F1170F98, $ACB72516, $B0EF51FF, $67EFDEA9, $8F88BD50, $D75D5D5D, $F7DCEEBB, $ABBE461F, $6EB7EABC, $C10CF3F5
   Data.l  $112A3F2B, $A4B44890, $85246AD6, $9656894D, $1764F528, $82A49367, $4CA4D392, $F0E1CC99, $82DA22E0, $3A1D661D, $876A1117, $C5FBB741
   Data.l  $977AE375, $72322D48, $BE1B5F72, $F87B9776, $015655CE, $F1F1D0BB, $706E9D71, $01FF7070, $FD7DA994, $B2B296A3, $710FA196, $00940EE0
   Data.l  $48689448, $DFDB2081, $2D83242C, $B3451A4D, $32D9C578, $24050299, $D04E4E4F, $B5FA58A4, $9C9A3598, $2CE29650, $C02EF446, $975B836C
   Data.l  $17B941C6, $FC0C7F03, $8CF12772, $5EAD083F, $BD6BBE1D, $1B26FBAB, $5CDBF1A1, $F364E3A0, $B9F06AF1, $BA735F5F, $4D7EE1A5, $4B47C363
   Data.l  $E3E0856C, $21168E95, $D12050A1, $512C9568, $AE5CB671, $2A48CB90, $D8091939, $25A86BF4, $B9C534A1, $AB373D30, $18531527, $3DB508CA
   Data.l  $EC6AFD7D, $F47BB9DC, $85082394, $8B5EAD85, $DFCF9266, $0885CAB4, $DDBDEED9, $A71637F7, $D1D1DB97, $4D50595C, $CF83DAF8, $A3637D05
   Data.l  $10D4DF5E, $84848210, $6AD23200, $69824729, $1F165481, $392D842F, $56C9244B, $4914952A, $6950912B, $44BF6D8A, $9A9420F6, $313F9B9B
   Data.l  $75E88F91, $C26D42C6, $B1B1BE81, $5A4DCBB1, $7908296A, $C3858478, $2660AA4C, $D9766E6F, $6566C9C7, $855E6F68, $5B2B9A78, $CCEDC841
   Data.l  $D3D1F023, $1FAF9F34, $0917B07D, $6387C3C5, $31080D23, $D821002D, $90B04812, $C8C8A142, $055780C8, $20C4A008, $FB2E2630, $BDCE2985
   Data.l  $DC17F227, $63121266, $F85E2A21, $EC6FBA74, $52E6BB72, $11E4231C, $EEEB8D26, $96EC9986, $BE7EB27A, $7454B57E, $E5EBF8DD, $55E3CAF4
   Data.l  $7784D525, $9E8D4B7D, $526A6FCF, $ED0DD5AB, $3090B02B, $8248C99E, $580B7084, $0A681090, $60942064, $041EDEC6, $C9146270, $30B195C4
   Data.l  $585C59C9, $4DCA9858, $29282BCF, $EE849AE1, $D335BADC, $5C27F2F7, $D17DC9CF, $D03C8B07, $D26B764C, $FF8FB454, $D1A349F5, $FBBC6938
   Data.l  $ACE9F203, $3EB61C26, $6AD5F3D1, $545D58B1, $479C6EA4, $A1288E10, $9836F8F8, $042444A3, $699B982D, $34896286, $10931D56, $2B898C0A
   Data.l  $B2D268E3, $27938EC2, $F327C0B3, $688DD046, $9BE06846, $BEFEFEFE, $956EEEE9, $4DADA855, $55A4B920, $F4FDF46E, $9343F6D0, $56CAC693
   Data.l  $2100A9F0, $7A27C73F, $3CE87AB5, $8558045D, $44824450, $177A841A, $827B3D9C, $67138DC2, $1C44B14E, $1120809B, $0ED86273, $9D62A509
   Data.l  $67E8CC92, $97A2B73D, $E9C27AA3, $6F7BBE99, $8417C25E, $19EB4E7A, $0DB0A121, $F446E4CD, $BC667D90, $2A7C10FA, $47F73A2A, $2D0E7E11
   Data.l  $A2A1EA0D, $6D6D74F3, $996A30ED, $418852A3, $86689109, $30B20B50, $2710945C, $0200B481, $4EC64126, $4FB08481, $67678DC5, $71FA9D4F
   Data.l  $A2F7AA25, $C0CDE67F, $4317AE34, $9022BB04, $42423210, $ACBA2176, $13E3CAE6, $839D7457, $B7080775, $D51A0F0B, $E2C5A745, $EDE5E5F3
   Data.l  $02A2F6D7, $B3D02CC7, $E9856589, $EEE009C0, $7E993BDD, $130BE858, $DDAB2126, $BB01A3D1, $F0593DB9, $F507E59C, $82A7A240, $AF6BBD50
   Data.l  $5EEF65A0, $27FF55FF, $0E6C431D, $0E0E0D8E, $A4CF31F6, $A27D080F, $CAABE783, $75645DF0, $842DC5DD, $869ED7AF, $DADAA2A6, $87F2F2F2
   Data.l  $50422BC3, $4D2F9C81, $54A120E4, $57979424, $9B9ADF00, $AFA21049, $4CAFC813, $762C8598, $6DEC0149, $42CF763B, $5D404104, $8C50905D
   Data.l  $ED4D6DF2, $66EF73BD, $F544DF9E, $98E27C18, $21F38D39, $9D74ECEC, $BA55ADAD, $50C18311, $8E102EB7, $7F1F6FC6, $5B5C34DF, $9E1F6EAE
   Data.l  $79187E87, $48163969, $94EB0846, $2C845854, $2C8B4109, $39B0B46B, $7747968F, $C1057575, $BDA4C50C, $CFF54A85, $C9CB1F9F, $9A116399
   Data.l  $A65B7E62, $2E9B6840, $1742AAAF, $5C8C3069, $AE06B75C, $79EDBA05, $3A3EDE5C, $FB0D735A, $4E061080, $D9A69A43, $2E6E2CC4, $9F979790
   Data.l  $1B7F905F, $65657884, $168219D6, $B0B0D759, $AF97213D, $3E095A0C, $B8C391C4, $A2A54A9E, $6239CCE7, $52A7E8BA, $15476129, $AEEC22C7
   Data.l  $18AEE84C, $2E464722, $63596D46, $AE0F5C3A, $F41C0798, $36372BC5, $F619B66F, $2CC7627C, $8410761B, $052F3FA7, $60098491, $E2CCD69B
   Data.l  $9B6E8EDF, $F9B63C7A, $EC7780CF, $8B2C4C62, $AA323CF8, $675A880E, $0604C1D6, $FE6F3206, $D3D0C906, $924E9925, $000000F4, $4E454900
   Data.q  $6042AE44, $00000082
   
EndDataSection







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1465
; FirstLine = 1162
; Folding = AE----9-----
; EnableXP
; UseIcon = LOGO.ico
; Executable = ..\..\PUB代码库\PUB自绘UI生成工具.exe
; EnableUnicode