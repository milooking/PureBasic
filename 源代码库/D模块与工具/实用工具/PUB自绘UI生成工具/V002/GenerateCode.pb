



;-
Procedure$ GenerateCode_Define()
   CodeText$ + ";*******************************************************************" + #CRLF$
   CodeText$ + ";********      此代码由[迷路PUB自绘UI生成工具]自动生成      ********" + #CRLF$
   CodeText$ + ";********        源代码生成时间: 2019-03-11 11:52:08        ********" + #CRLF$
   CodeText$ + ";********      工具为绿色免费开源,发现BUG,欢迎及时反馈      ********" + #CRLF$
   CodeText$ + ";********        开发者: 迷路仟/Miloo [QQ:714095563]        ********" + #CRLF$
   CodeText$ + ";*******************************************************************" + #CRLF$
   If _Project\IsUseCanvasImage = #True     ;启用画布背景
      CodeText$ + ";【源代码功能】:自动生成自绘窗体界面的源代码,节省开发时间."                               + #CRLF$
      CodeText$ + ";【源代码说明】:" + #CRLF$
      CodeText$ + ";1.窗体背景使用了CanvasGadget()做为背景及控件容器.可以在画布中直接添加标准控件."          + #CRLF$
      CodeText$ + ";2.由于采用无边框窗体为基础框架,所以在设计控件时,注意非客户区的空间."                     + #CRLF$
      CodeText$ + ";3.在CanvasGadget()为容器的情况下,ImageGadget()会产生BUG现象."                            + #CRLF$
   Else 
      CodeText$ + ";【源代码功能】:自动生成自绘窗体界面的源代码,节省开发时间."                               + #CRLF$
      CodeText$ + ";【源代码说明】:" + #CRLF$
      CodeText$ + ";1.窗体背景采用背景刷进行,可以在窗体中直接添加标准控件."                                  + #CRLF$
      CodeText$ + ";2.由于采用无边框窗体为基础框架,所以在设计控件时,注意非客户区的空间."                     + #CRLF$
      CodeText$ + ";3.添加标准控件后,刷新窗体时,如果采用全局刷新,会导致控件闪烁现象,代码预留了刷新区域选项." + #CRLF$
   EndIf
   
   
   With _Project
      CodeText$ + #CRLF$
      CodeText$ + #CRLF$
      ;====== 【常量部分】 ======
      CodeText$ + ";-[Constant]"        + #CRLF$
      CodeText$ + "Enumeration"         + #CRLF$
      CodeText$ + "   #winScreen           ;窗体编号"                + #CRLF$
      If \IsUseCanvasImage = #True     ;启用画布背景
         CodeText$ + "   #cvsScreen           ;背景画布"             + #CRLF$
      EndIf
      If \IsUseBalloonTip = #True     ;启用画布背景
         CodeText$ + "   #winBalloon          ;提示文本窗体编号"     + #CRLF$
      EndIf      
      If \IsUseMessageBox
         CodeText$ + "   #winMessage          ;对话框编号"           + #CRLF$
         CodeText$ + "   #btnMessageClose     ;对话框关闭按键编号"   + #CRLF$
         CodeText$ + "   #btnMessageYes       ;对话框YES按键编号"    + #CRLF$
         CodeText$ + "   #btnMessageNo        ;对话框NO按键编号"     + #CRLF$
         CodeText$ + "   #btnMessageCancel    ;对话框取消按键编号"   + #CRLF$
      EndIf 
      CodeText$ + "   ;======"                                       + #CRLF$
      CodeText$ + "   #imgScreen           ;主界面背景图像"          + #CRLF$
      If \IsUseBalloonTip = #True
         CodeText$ + "   #imgBalloon          ;提示文背景图像"       + #CRLF$
      EndIf 
      CodeText$ + "   #fntDefault          ;默认字体编号"            + #CRLF$
      CodeText$ + "EndEnumeration"                                   + #CRLF$

      Select \SystemButtonSylte
         Case #ButtonStyle_Flat, #ButtonStyle_Bread
            IsAddCRLF = #True
            CodeText$ + #CRLF$
            CodeText$ + LSet("#SysButton_CloseColor = $C03954FF", 36, " ")+";关闭按键底色"  + #CRLF$
      EndSelect 

      ;====== 窗体四际 ====== 
      If \IsUseSizeWindow
         If IsAddCRLF = #False : CodeText$ + #CRLF$ : IsAddCRLF = #True : EndIf 
         If \WinSideL
            CodeText$ + LSet("#WinSideL = "+Str(\WinSideL), 36, " ")+";左际留边大小"  + #CRLF$
         EndIf 
         If \WinSideR
            CodeText$ + LSet("#WinSideR = "+Str(\WinSideR), 36, " ")+";右际留边大小"  + #CRLF$
         EndIf 
         If \WinSideT
            CodeText$ + LSet("#WinSideT = "+Str(\WinSideT), 36, " ")+";顶部留边大小"  + #CRLF$
         EndIf 
         If \WinSideB
            CodeText$ + LSet("#WinSideB = "+Str(\WinSideB), 36, " ")+";底部留边大小"  + #CRLF$
         EndIf          
      EndIf 

      ;====== 标题栏 ====== 
      If \IsUseCaptionBar
         If IsAddCRLF = #False : CodeText$ + #CRLF$ : IsAddCRLF = #True : EndIf 
         If \CaptionX
            CodeText$ + LSet("#CaptionX = "+Str(\CaptionX), 36, " ")+";标题栏X坐标"   + #CRLF$
         EndIf 
         CodeText$ + LSet("#CaptionH = "+Str(\CaptionH), 36, " ")+";标题栏高度"       + #CRLF$
      EndIf 
      
      ;====== 工具栏 ====== 
      If \IsUseIcoToolBar 
         If IsAddCRLF = #False : CodeText$ + #CRLF$ : IsAddCRLF = #True : EndIf 
         If \CaptionX < \ToolBarW And \IsUseCaptionBar 
            If \ToolBarY
               CodeText$ + LSet("#ToolBarY = #CaptionH + "+Str(\ToolBarY), 36, " ")+";工具栏Y坐标"  + #CRLF$
            Else 
               CodeText$ + LSet("#ToolBarY = #CaptionH", 36, " ")+";工具栏Y坐标"      + #CRLF$
            EndIf 
         ElseIf \ToolBarY
            CodeText$ + LSet("#ToolBarY = "+Str(\ToolBarY), 36, " ")+";工具栏Y坐标"   + #CRLF$
         EndIf 
         CodeText$ + LSet("#ToolBarW = "+Str(\ToolBarW), 36, " ")+";工具栏宽度"       + #CRLF$
      EndIf 
      
      ;====== 状态栏 ====== 
      If \IsUseStatusBar
         If IsAddCRLF = #False : CodeText$ + #CRLF$ : IsAddCRLF = #True : EndIf 
         If \IsUseIcoToolBar
            If \StatusX
               CodeText$ + LSet("#StatusX  = #ToolBarW + "+Str(\StatusX), 36, " ")+";状态栏X坐标" + #CRLF$
            Else
               CodeText$ + LSet("#StatusX  = #ToolBarW", 36, " ")+";状态栏X坐标"                  + #CRLF$
            EndIf 
         ElseIf \StatusX
            CodeText$ + LSet("#StatusX  = "+Str(\StatusX), 36, " ")+";状态栏X坐标"   + #CRLF$
         EndIf 
         CodeText$ + LSet("#StatusH  = "+Str(\StatusH), 36, " ")+";状态栏高度"       + #CRLF$
      EndIf 
      If \IsUseSizeWindow
         CodeText$ + LSet("#TIMER_SizeWindow     = 1", 36, " ")+";窗体调整计时器事件"  + #CRLF$
      EndIf 
      If \IsUseBalloonTip
         CodeText$ + LSet("#TIMER_BalloonTip     = 2", 36, " ")+";提示文计时器事件"  + #CRLF$
      EndIf 
      
   EndWith
   If _Project\SoftwareIconID And _Project\IsUseIncludeIcon = #False
      CodeText$ + "#SoftwareIcon$ = "+#DQUOTE$+_Project\SoftwareIcon$ +#DQUOTE$     + #CRLF$  
   EndIf 
   
   CodeText$ + #CRLF$
   CodeText$ + #CRLF$

   ;====== 【结构部分】 ======
   CodeText$ + ";-[Structure]"                + #CRLF$ 
   CodeText$ + ";界面/控件颜色设置"           + #CRLF$ 
   CodeText$ + "Structure __ScreenColorInfo"  + #CRLF$ 
   CodeText$ + "   BackColor.l    ;背景色"    + #CRLF$ 
   CodeText$ + "   ForeColor.l    ;前景色"    + #CRLF$ 
   CodeText$ + "   FontColor.l    ;字体色"    + #CRLF$ 
   CodeText$ + "   SideColor.l    ;边框色"    + #CRLF$ 
   CodeText$ + "   HighColor.l    ;高亮色"    + #CRLF$ 
   CodeText$ + "EndStructure"                 + #CRLF$ 
   CodeText$ + #CRLF$
   CodeText$ + ";控件基本结构"                 + #CRLF$ 
   CodeText$ + "Structure __GadgetInfo"        + #CRLF$ 
   CodeText$ + "   X.l            ;左际/X坐标" + #CRLF$ 
   CodeText$ + "   Y.l            ;上际/Y坐标" + #CRLF$ 
   CodeText$ + "   R.l            ;右际"       + #CRLF$ 
   CodeText$ + "   B.l            ;下际"       + #CRLF$ 
   CodeText$ + "   W.l"                        + #CRLF$ 
   CodeText$ + "   H.l"                        + #CRLF$ 
   CodeText$ + "   ;======"                    + #CRLF$ 
   CodeText$ + "   NormalcyID.i   ;正常状态下的控件图像编号"    + #CRLF$ 
   CodeText$ + "   MouseTopID.i   ;鼠标置顶时的控件图像编号"    + #CRLF$ 
   CodeText$ + "   HoldDownID.i   ;左键按下时的控件图像编号"    + #CRLF$ 
   CodeText$ + "   ;======"                    + #CRLF$ 
   
   If _Project\IsUseBalloonTip
      CodeText$ + "   BalloonTip$    ;按键提示文"               + #CRLF$ 
      CodeText$ + "   ;======"                                  + #CRLF$ 
   EndIf 
   CodeText$ + "   IsHide.b       ;控件是否隐藏"                + #CRLF$ 
   CodeText$ + "   IsCreate.b     ;控件是否创建"                + #CRLF$ 
   CodeText$ + "   Keep.b[2]      ;保留空间/对齐"               + #CRLF$ 
   CodeText$ + "EndStructure"                  + #CRLF$ 
   CodeText$ + #CRLF$

   If _Project\IsUseMessageBox
      CodeText$ + ";对话框结构"                       + #CRLF$
      CodeText$ + "Structure __MessageRequester"      + #CRLF$
      CodeText$ + "   hWindow.l"                      + #CRLF$
      CodeText$ + "   hBackImage.i"                   + #CRLF$      
      CodeText$ + "   hWindowHook.i"                  + #CRLF$
      CodeText$ + "   hMessageIcon.i"                 + #CRLF$
      CodeText$ + "   WindowW.w"                      + #CRLF$
      CodeText$ + "   WindowH.w"                      + #CRLF$
      CodeText$ + "   TitleH.l"                       + #CRLF$
      CodeText$ + "   NoticeH.l"                      + #CRLF$
      CodeText$ + "   Flags.l"                        + #CRLF$
      CodeText$ + "   Title$"                         + #CRLF$
      CodeText$ + "   List ListText$()"               + #CRLF$
      CodeText$ + "   BKImageID.i"                    + #CRLF$
      CodeText$ + "   btnMessageClose.__GadgetInfo"   + #CRLF$
      CodeText$ + "   btnMessageYes.__GadgetInfo"     + #CRLF$
      CodeText$ + "   btnMessageNo.__GadgetInfo"      + #CRLF$
      CodeText$ + "   btnMessageCancel.__GadgetInfo"  + #CRLF$
      CodeText$ + "   *pMouseTop.__GadgetInfo    ;当前光标在上"               + #CRLF$
      CodeText$ + "   *pHoldDown.__GadgetInfo    ;当前光标按住"               + #CRLF$
      CodeText$ + "   *pSelected.__GadgetInfo    ;选中状态: 预留兼对齐作用"   + #CRLF$
      CodeText$ + "   IsExitWindow.b"                 + #CRLF$
      CodeText$ + "   MessageResult.b"                + #CRLF$
      CodeText$ + "EndStructure"                      + #CRLF$
      CodeText$ + #CRLF$
   EndIf 
   
   If _Project\IsUseBalloonTip
      CodeText$ + ";提示文数据结构"                   + #CRLF$
      CodeText$ + "Structure __BalloonTipInfo"        + #CRLF$
      CodeText$ + "   hWindow.l"                      + #CRLF$
      CodeText$ + "   hBackImage.i"                   + #CRLF$
      CodeText$ + "   hWindowHook.i"                  + #CRLF$
      CodeText$ + "   WindowW.w"                      + #CRLF$
      CodeText$ + "   WindowH.w"                      + #CRLF$
      CodeText$ + "   *pBalloonTip.__GadgetInfo"      + #CRLF$
      CodeText$ + "EndStructure"                      + #CRLF$
      CodeText$ + #CRLF$
   EndIf 

   CodeText$ + ";主界面结构"                   + #CRLF$ 
   CodeText$ + "Structure __MainScreen"        + #CRLF$ 
   With _Project
      If \IsUsePreference
         CodeText$ + "   WindowX.w         ;主界面窗体X坐标"      + #CRLF$ 
         CodeText$ + "   WindowY.w         ;主界面窗体Y坐标"      + #CRLF$ 
      EndIf 
      CodeText$ + "   WindowW.w         ;主界面窗体宽度"          + #CRLF$ 
      CodeText$ + "   WindowH.w         ;主界面窗体高度"          + #CRLF$ 
      CodeText$ + "   hWindow.i         ;主界面窗体句柄"          + #CRLF$ 
      CodeText$ + "   hWindowHook.i     ;主界面HOOK句柄"          + #CRLF$ 
      If _Project\IsUseCanvasImage = #True          ;启用画布背景
         CodeText$ + "   hGadgetHook.i     ;主界面HOOK句柄"          + #CRLF$ 
         CodeText$ + "   hCanvas.l         ;主界面画布句柄"          + #CRLF$      
      Else 
         
         CodeText$ + "   hBackImage.i      ;主界面背景句柄"          + #CRLF$
      EndIf 
      CodeText$ + "   hDefaultIcon.i    ;软件默认图标句柄"        + #CRLF$      
      CodeText$ + "   SoftwareIconID.l  ;软件图标编号"            + #CRLF$
      CodeText$ + "   ;======"                                    + #CRLF$ 

      If \IsUseSizeWindow
         CodeText$ + "   hSizing.i         ;系统光标[左上-右下]"  + #CRLF$ 
         If \WinSideL Or \WinSideR
            CodeText$ + "   hLeftRight.i      ;系统光标[左-右]"   + #CRLF$ 
         EndIf 
         If \WinSideT Or \WinSideB
            CodeText$ + "   hUpDown.i         ;系统光标[上-下]"   + #CRLF$ 
         EndIf 
         CodeText$ + "   ;======"                                 + #CRLF$      
      EndIf 
      CodeText$ + "   Title$            ;窗体标题"                + #CRLF$ 
      CodeText$ + "   SystemPath$       ;系统路径"                + #CRLF$
      CodeText$ + "   DimColor.__ScreenColorInfo["+Str(ListSize(_Project\ListColor()))+"]    ;颜色参数"  + #CRLF$ 
      CodeText$ + "   ;======"                                    + #CRLF$ 
      If \IsUseSysCloseBox
         CodeText$ + "   btnCloseBox.__GadgetInfo   ;关闭窗体小按键"     + #CRLF$ 
      EndIf 
      If \IsUseSysMinimize
         CodeText$ + "   btnMinimize.__GadgetInfo   ;最小化窗体小按键"   + #CRLF$ 
      EndIf 
      If \IsUseSysMaximize
         CodeText$ + "   btnNormalcy.__GadgetInfo   ;正常化窗体小按键"   + #CRLF$ 
      EndIf 
      If \IsUseSysNormalcy
         CodeText$ + "   btnMaximize.__GadgetInfo   ;最大化窗体小按键"   + #CRLF$ 
      EndIf
      If \IsUseSysSettings
         CodeText$ + "   btnSettings.__GadgetInfo   ;窗体设置小按键"   + #CRLF$ 
      EndIf      
      
      CodeText$ + "   ;======"                              + #CRLF$ 
      CodeText$ + "   *pMouseTop.__GadgetInfo    ;当前光标在上"       + #CRLF$ 
      CodeText$ + "   *pHoldDown.__GadgetInfo    ;当前光标按住"       + #CRLF$ 
      CodeText$ + "   *pSelected.__GadgetInfo    ;选中状态"           + #CRLF$ 
      CodeText$ + "   ;======"                                        + #CRLF$ 
      CodeText$ + "   IsExitWindow.b             ;关闭窗体条件"       + #CRLF$ 
      If \IsUseSizeWindow
         CodeText$ + "   IsSizeWindow.b             ;计时器用,窗体调整大小事件"       + #CRLF$ 
      EndIf 
   EndWith
   
   CodeText$ + "EndStructure"                 + #CRLF$ 
   CodeText$ + #CRLF$
   CodeText$ + ";-[Global]"                   + #CRLF$ 
   CodeText$ + "Global _Screen.__MainScreen"  + #CRLF$
   If _Project\IsUseMessageBox
      CodeText$ + "Global _Message.__MessageRequester"  + #CRLF$
   EndIf 
   If _Project\IsUseBalloonTip
      CodeText$ + "Global _Balloon.__BalloonTipInfo"  + #CRLF$
   EndIf 
   If _Project\IsUseMessageBox
      CodeText$ + #CRLF$
      CodeText$ + "Declare Message_Redraw()"  + #CRLF$
   EndIf    
   CodeText$ + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure
   
Procedure$ GenerateCode_Macro()

   CodeText$ + ";- =========================="        + #CRLF$
   CodeText$ + ";- [Macro]"                           + #CRLF$
   CodeText$ + ";[宏]判断操作域"                      + #CRLF$

   CodeText$ + "Macro Macro_Gadget_InRect1(Gadget)"   + #CRLF$
   CodeText$ + "   *pMouse\X > Gadget\X And *pMouse\X < Gadget\R And *pMouse\Y > Gadget\Y And *pMouse\Y < Gadget\B" + #CRLF$
   CodeText$ + "EndMacro"                             + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "Macro Macro_Gadget_InRect2(Gadget)"   + #CRLF$
   CodeText$ + "   Gadget\IsHide = #False And *pMouse\X > Gadget\X And *pMouse\X < Gadget\R And *pMouse\Y > Gadget\Y And *pMouse\Y < Gadget\B" + #CRLF$
   CodeText$ + "EndMacro"                             + #CRLF$
   CodeText$ + #CRLF$

   CodeText$ + "Macro Macro_Gadget_InRect3(Gadget)"   + #CRLF$
   CodeText$ + "   Gadget\IsCreate = #True And *pMouse\X > Gadget\X And *pMouse\X < Gadget\R And *pMouse\Y > Gadget\Y And *pMouse\Y < Gadget\B" + #CRLF$
   CodeText$ + "EndMacro"                             + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure
   
Procedure$ GenerateCode_Gradient(*pColor.__ScreenColorInfo, TextX$, TextY$, TextW$, TextH$)

   If *pColor\IsUseGradient
      CodeText$ + "         DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)"    + #CRLF$ 
      If *pColor\IsAniGradient
         CodeText$ + "         BackColor (*pColor\BackColor)"           + #CRLF$
         CodeText$ + "         FrontColor(*pColor\ForeColor)"           + #CRLF$
      Else 
         CodeText$ + "         BackColor (*pColor\ForeColor)"           + #CRLF$
         CodeText$ + "         FrontColor(*pColor\BackColor)"           + #CRLF$
      EndIf 
      
      Select *pColor\GradientTpyes
         Case 0 : ;上下性线渐变
            CodeText$ + "         ;上下性线渐变"                        + #CRLF$
            If TextY$ = "0"
               CodeText$ + "         LinearGradient(0, 0, 0, "+TextH$+") "                      + #CRLF$
            Else 
               CodeText$ + "         LinearGradient(0, "+TextY$+", 0, "+TextY$+"+"+TextH$+") "  + #CRLF$
            EndIf 

         Case 1 : ;左右性线渐变  
            CodeText$ + "         ;左右性线渐变"                        + #CRLF$
            If TextX$ = "0"
               CodeText$ + "         LinearGradient(0, 0, "+TextW$+", 0) "                      + #CRLF$
            Else 
               CodeText$ + "         LinearGradient("+TextX$+", 0, "+TextX$+"+"+TextW$+", 0) "  + #CRLF$
            EndIf 
            
         Case 2 : ;左上对角性线渐变
            CodeText$ + "         ;左上对角性线渐变"                  + #CRLF$
            If TextX$ = "0" And TextY$ = "0"
               CodeText$ + "         LinearGradient(0, 0, "+TextW$+", "+TextH$+")"                       + #CRLF$
            ElseIf TextX$ = "0"
               CodeText$ + "         LinearGradient(0, "+TextY$+", "+TextW$+", "+TextY$+"+"+TextH$+")"   + #CRLF$
            ElseIf  TextY$ = "0"
               CodeText$ + "         LinearGradient("+TextX$+", 0, "+TextX$+"+"+TextW$+", "+TextH$+")"   + #CRLF$ 
            Else 
               CodeText$ + "         LinearGradient("+TextX$+", "+TextY$+", "+TextX$+"+"+TextW$+", "+TextY$+"+"+TextH$+") " + #CRLF$
            EndIf 

         Case 3 : ;右上对角性线渐变
            CodeText$ + "         ;右上对角性线渐变"                 + #CRLF$
            If TextX$ = "0" And TextY$ = "0"
               CodeText$ + "         LinearGradient(0, "+TextH$+", "+TextW$+", 0)"                       + #CRLF$
            ElseIf TextX$ = "0"
               CodeText$ + "         LinearGradient(0, "+TextY$+"+"+TextH$+", "+TextW$+", "+TextY$+")"   + #CRLF$
            ElseIf  TextY$ = "0"
               CodeText$ + "         LinearGradient("+TextX$+", "+TextH$+", "+TextX$+"+"+TextW$+", 0)"   + #CRLF$ 
            Else 
               CodeText$ + "         LinearGradient("+TextX$+", "+TextY$+"+"+TextH$+", "+TextX$+"+"+TextW$+", "+TextY$+") " + #CRLF$
            EndIf 
         
         Case 4 :   ;中心椭圆渐变  
            CodeText$ + "         ;中心椭圆渐变"                     + #CRLF$
            If TextX$ = "0" And TextY$ = "0"
               CodeText$ + "         EllipticalGradient("+TextW$+"/2, "+TextH$+"/2, "+TextW$+"/2, "+TextH$+"/2)"              + #CRLF$
            ElseIf TextX$ = "0"
               CodeText$ + "         EllipticalGradient("+TextW$+"/2, "+TextY$+"+"+TextH$+"/2+, "+TextW$+"/2, "+TextH$+"/2)"   + #CRLF$
            ElseIf  TextY$ = "0"
               CodeText$ + "         EllipticalGradient("+TextX$+"+"+TextW$+"/2, "+TextH$+"/2+, "+TextW$+"/2, "+TextH$+"/2)"   + #CRLF$ 
            Else 
               CodeText$ + "         EllipticalGradient("+TextX$+"+"+TextW$+"/2, "+TextY$+"+"+TextH$+"/2+, "+TextW$+"/2, "+TextH$+"/2)" + #CRLF$
            EndIf 
            
         Case 5 :    ;左上椭圆渐变
            CodeText$ + "         ;左上椭圆渐变"                    + #CRLF$
            If TextX$ = "0" And TextY$ = "0"
               CodeText$ + "         EllipticalGradient(0, 0, "+TextW$+", "+TextH$+")"                    + #CRLF$
            ElseIf TextX$ = "0"
               CodeText$ + "         EllipticalGradient(0, "+TextY$+", "+TextW$+", "+TextH$+")"           + #CRLF$
            ElseIf  TextY$ = "0"
               CodeText$ + "         EllipticalGradient("+TextX$+", 0, "+TextW$+", "+TextH$+")"           + #CRLF$ 
            Else 
               CodeText$ + "         EllipticalGradient("+TextX$+", "+TextY$+", "+TextW$+", "+TextH$+")"  + #CRLF$
            EndIf 

         Case 6 :    ;右上椭圆渐变
            CodeText$ + "         ;右上椭圆渐变"                    + #CRLF$
            If TextX$ = "0" And TextY$ = "0"
               CodeText$ + "         EllipticalGradient("+TextW$+", 0, "+TextW$+", "+TextH$+")"                       + #CRLF$
            ElseIf TextX$ = "0"
               CodeText$ + "         EllipticalGradient("+TextW$+", "+TextY$+", "+TextW$+", "+TextH$+")"              + #CRLF$
            ElseIf  TextY$ = "0"
               CodeText$ + "         EllipticalGradient("+TextX$+"+"+TextW$+", 0, "+TextW$+", "+TextH$+")"            + #CRLF$ 
            Else 
               CodeText$ + "         EllipticalGradient("+TextX$+"+"+TextW$+", "+TextY$+", "+TextW$+", "+TextH$+")"   + #CRLF$
            EndIf 
            
         Case 7 :    ;左下椭圆渐变
            CodeText$ + "         ;左下椭圆渐变"                    + #CRLF$
            If TextX$ = "0" And TextY$ = "0"
               CodeText$ + "         EllipticalGradient(0, "+TextH$+", "+TextW$+", "+TextH$+")"                     + #CRLF$
            ElseIf TextX$ = "0"
               CodeText$ + "         EllipticalGradient(0, "+TextY$+"+"+TextH$+", "+TextW$+", "+TextH$+")"             + #CRLF$
            ElseIf  TextY$ = "0"
               CodeText$ + "         EllipticalGradient("+TextX$+", "+TextH$+", "+TextW$+", "+TextH$+")"            + #CRLF$ 
            Else 
               CodeText$ + "         EllipticalGradient("+TextX$+", "+TextY$+"+"+TextH$+", "+TextW$+", "+TextH$+")"   + #CRLF$
            EndIf 

         Case 8 :    ;右下椭圆渐变
            CodeText$ + "         ;右下椭圆渐变"                    + #CRLF$
            If TextX$ = "0" And TextY$ = "0"
               CodeText$ + "         EllipticalGradient("+TextW$+", "+TextH$+", "+TextW$+", "+TextH$+")"                     + #CRLF$
            ElseIf TextX$ = "0"
               CodeText$ + "         EllipticalGradient("+TextW$+", "+TextY$+"+"+TextH$+", "+TextW$+", "+TextH$+")"             + #CRLF$
            ElseIf  TextY$ = "0"
               CodeText$ + "         EllipticalGradient("+TextX$+"+"+TextW$+", "+TextH$+", "+TextW$+", "+TextH$+")"            + #CRLF$ 
            Else 
               CodeText$ + "         EllipticalGradient("+TextX$+"+"+TextW$+", "+TextY$+"+"+TextH$+", "+TextW$+", "+TextH$+")"   + #CRLF$
            EndIf 
      EndSelect
   Else 
      CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"      + #CRLF$
   EndIf 
   CodeText$ + "         Box("+TextX$+","+TextY$+","+TextW$+", "+TextH$+", *pColor\BackColor)"  + #CRLF$ 
   ProcedureReturn CodeText$

EndProcedure

Procedure$ GenerateCode_Redraw()
   CodeText$ + ";- =========================="        + #CRLF$
   CodeText$ + ";- [Draw]"                            + #CRLF$
   
   CodeText$ + "Procedure Redraw_Gadget(*pGadget.__GadgetInfo, X, Y)"               + #CRLF$
   CodeText$ + "   With *pGadget"                                                   + #CRLF$
   CodeText$ + "      If *pGadget = 0 : ProcedureReturn : EndIf"                    + #CRLF$
   CodeText$ + "      If *pGadget\IsHide = #True : ProcedureReturn : EndIf"         + #CRLF$
   CodeText$ + "      If *pGadget\IsCreate = #False : ProcedureReturn : EndIf"      + #CRLF$
   CodeText$ + "      If X <> #PB_Ignore : \X = X : \R = \X+\W : EndIf"             + #CRLF$
   CodeText$ + "      If Y <> #PB_Ignore : \Y = Y : \B = \Y+\H : EndIf"             + #CRLF$
   CodeText$ + "      If _Screen\pHoldDown = *pGadget And IsImage(\HoldDownID)"     + #CRLF$
   CodeText$ + "         DrawAlphaImage(ImageID(\HoldDownID), \X, \Y)"              + #CRLF$
   CodeText$ + "      ElseIf _Screen\pMouseTop = *pGadget And IsImage(\MouseTopID)" + #CRLF$
   CodeText$ + "         DrawAlphaImage(ImageID(\MouseTopID), \X, \Y)"              + #CRLF$
   CodeText$ + "      ElseIf IsImage(\NormalcyID)"                                  + #CRLF$
   CodeText$ + "         DrawAlphaImage(ImageID(\NormalcyID), \X, \Y)"              + #CRLF$
   CodeText$ + "      EndIf "   + #CRLF$
   CodeText$ + "   EndWith"     + #CRLF$
   CodeText$ + "EndProcedure"   + #CRLF$
   CodeText$ + #CRLF$   
   
   CodeText$ + ";主界面自绘函数"                                           + #CRLF$
   CodeText$ + "Procedure Redraw_Screen()"                                 + #CRLF$
   CodeText$ + "   With _Screen"                                           + #CRLF$
   If _Project\IsUseCanvasImage = #True           ;启用画布背景
      CodeText$ + "      If StartDrawing(CanvasOutput(#cvsScreen))"        + #CRLF$
      CodeText$ + "         DrawingFont(FontID(#fntDefault))"              + #CRLF$ 
   Else 
      CodeText$ + "      If IsImage(#imgScreen) = 0"              + #CRLF$ 
      CodeText$ + "         hImageScreen = CreateImage(#imgScreen, \WindowW+200, \WindowH+200)"                      + #CRLF$
      CodeText$ + "      ElseIf ImageWidth(#imgScreen) <> \WindowW+200 Or ImageHeight(#imgScreen) <> \WindowH+200"   + #CRLF$
      CodeText$ + "         FreeImage(#imgScreen)"                + #CRLF$
      CodeText$ + "         hImageScreen = CreateImage(#imgScreen, \WindowW+200, \WindowH+200)"  + #CRLF$
      CodeText$ + "      Else "                                   + #CRLF$
      CodeText$ + "         hImageScreen = ImageID(#imgScreen)"   + #CRLF$
      CodeText$ + "      EndIf "                                  + #CRLF$
      CodeText$ + "      If hImageScreen = 0 : ProcedureReturn : EndIf"    + #CRLF$
      CodeText$ + #CRLF$
      CodeText$ + "      If StartDrawing(ImageOutput(#imgScreen))"         + #CRLF$
      CodeText$ + "         DrawingFont(FontID(#fntDefault))"              + #CRLF$ 
   EndIf 

   With _Project
      ;====== 窗体布局 ======
      *pColorWindow.__ScreenColorInfo = \pMapColor("窗体布局")
      ChangeCurrentElement(\ListColor(), *pColorWindow)
      Index = ListIndex(\ListColor())
      CodeText$ + "         ;绘制窗体布局"         + #CRLF$
      CodeText$ + "         *pColor.__ScreenColorInfo = @\DimColor["+Str(Index)+"]"     + #CRLF$
      CodeText$ + "         DrawingMode(#PB_2DDrawing_Default)"            + #CRLF$ 
      CodeText$ + "         Box(0,0,\WindowW+200, \WindowH+200, *pColor\BackColor & $FFFFFF)"  + #CRLF$
      CodeText$ +           GenerateCode_Gradient(*pColorWindow, "0", "0", "\WindowW", "\WindowH")
      CodeText$ + #CRLF$   

      ;====== 标题栏 ======
      If \IsUseCaptionBar
         *pColorCaption.__ScreenColorInfo = \pMapColor("标题栏")
         ChangeCurrentElement(\ListColor(), *pColorCaption)
         Index = ListIndex(\ListColor())
         CodeText$ + "         ;绘制标题栏"         + #CRLF$
         CodeText$ + "         *pColor.__ScreenColorInfo = @\DimColor["+Str(Index)+"]"     + #CRLF$
         If \CaptionX
            CodeText$ +           GenerateCode_Gradient(*pColorCaption, "#CaptionX", "0", "\WindowW-#CaptionX", "#CaptionH")
            CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                                    + #CRLF$
            CodeText$ + "         Box(#CaptionX+0, 0, 1, #CaptionH, *pColor\HighColor)"                     + #CRLF$
            CodeText$ + "         Box(#CaptionX+0, 1, \WindowW-#CaptionX-1, 1, *pColor\HighColor)"          + #CRLF$
            CodeText$ + "         Box(#CaptionX+0, #CaptionH-1, \WindowW-#CaptionX, 1, *pColor\SideColor)"  + #CRLF$

            CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Transparent)"          + #CRLF$
            CodeText$ + "         IconHeight = #CaptionH-8"                                                 + #CRLF$
            CodeText$ + "         If IsImage(\SoftwareIconID)"                                              + #CRLF$
            CodeText$ + "            DrawImage(ImageID(\SoftwareIconID), #CaptionX+10, (#CaptionH-IconHeight)/2, IconHeight, IconHeight)" + #CRLF$
            CodeText$ + "            DrawText(#CaptionX+20+IconHeight, (#CaptionH-TextHeight(\Title$))/2, \Title$, *pColor\FontColor)"    + #CRLF$
            CodeText$ + "         Else"                                                                     + #CRLF$
            CodeText$ + "            DrawImage(_Screen\hDefaultIcon, #CaptionX+10, (#CaptionH-IconHeight)/2, IconHeight, IconHeight)"     + #CRLF$
            CodeText$ + "            DrawText(#CaptionX+20+IconHeight, (#CaptionH-TextHeight(\Title$))/2, \Title$, *pColor\FontColor)"    + #CRLF$
            CodeText$ + "         EndIf"                                                                    + #CRLF$ 
            CodeText$ + #CRLF$ 
         Else 
            CodeText$ +           GenerateCode_Gradient(*pColorCaption, "0", "0", "\WindowW", "#CaptionH")
            CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                                    + #CRLF$
            CodeText$ + "         Box(1, 0, 1, #CaptionH, *pColor\HighColor)"                               + #CRLF$
            CodeText$ + "         Box(1, 1, \WindowW-1, 1, *pColor\HighColor)"                              + #CRLF$
            CodeText$ + "         Box(0, #CaptionH-1, \WindowW, 1, *pColor\SideColor)"                      + #CRLF$
            CodeText$ + "         IconHeight = #CaptionH-8"                                                 + #CRLF$
            CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Transparent)"          + #CRLF$
            CodeText$ + "         If IsImage(\SoftwareIconID)"                                              + #CRLF$
            CodeText$ + "            DrawImage(ImageID(\SoftwareIconID), 10, (#CaptionH-IconHeight)/2, IconHeight, IconHeight)"  + #CRLF$
            CodeText$ + "            DrawText(20+IconHeight, (#CaptionH-TextHeight(\Title$))/2, \Title$, *pColor\FontColor)"     + #CRLF$
            CodeText$ + "         Else"                                                                     + #CRLF$
            CodeText$ + "            DrawImage(_Screen\hDefaultIcon, 10, (#CaptionH-32)/2, IconHeight, IconHeight)"              + #CRLF$
            CodeText$ + "            DrawText(20+IconHeight, (#CaptionH-TextHeight(\Title$))/2, \Title$, *pColor\FontColor)"     + #CRLF$
            CodeText$ + "         EndIf"                                                                    + #CRLF$
            CodeText$ + #CRLF$ 
         EndIf 
      

      EndIf 
      
      ;====== 工具栏 ======
      If \IsUseIcoToolBar
         *pColorIcoTool.__ScreenColorInfo = \pMapColor("工具栏")
         ChangeCurrentElement(\ListColor(), *pColorIcoTool)
         Index = ListIndex(\ListColor())
         CodeText$ + "         ;绘制工具栏"         + #CRLF$
         CodeText$ + "         *pColor.__ScreenColorInfo = @\DimColor["+Str(Index)+"]"     + #CRLF$
         If (\CaptionX < \ToolBarW And \IsUseCaptionBar) Or \ToolBarY
            CodeText$ +           GenerateCode_Gradient(*pColorIcoTool, "0", "#ToolBarY", "#ToolBarW", "\WindowH-#ToolBarY")
            CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                                    + #CRLF$
            CodeText$ + "         Box(1, #ToolBarY, 1, \WindowH-#ToolBarY, *pColor\HighColor)"              + #CRLF$
            CodeText$ + "         Box(0, #ToolBarY, #ToolBarW, 1, *pColor\HighColor)"                       + #CRLF$
            CodeText$ + "         Box(#ToolBarW-1, #ToolBarY, 1, \WindowH-#ToolBarY, *pColor\SideColor)"    + #CRLF$
         Else 
            CodeText$ +           GenerateCode_Gradient(*pColorIcoTool, "0", "0", "#ToolBarW", "\WindowH")
            CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                  + #CRLF$
            CodeText$ + "         Box(1, 1, 1, \WindowH, *pColor\HighColor)"              + #CRLF$
            CodeText$ + "         Box(0, 1, #ToolBarW, 1, *pColor\HighColor)"             + #CRLF$
            CodeText$ + "         Box(#ToolBarW-1, 0, 1, \WindowH, *pColor\SideColor)"    + #CRLF$
         EndIf 
         CodeText$ + #CRLF$ 
      EndIf 
      
      ;====== 状态栏 ======
      If \IsUseStatusBar
         *pColorStatusBar.__ScreenColorInfo = \pMapColor("状态栏")
         ChangeCurrentElement(\ListColor(), *pColorStatusBar)
         Index = ListIndex(\ListColor())
         CodeText$ + "         ;绘制状态栏"         + #CRLF$
         CodeText$ + "         *pColor.__ScreenColorInfo = @\DimColor["+Str(Index)+"]"     + #CRLF$
         If \IsUseIcoToolBar Or \StatusX
            CodeText$ +           GenerateCode_Gradient(*pColorStatusBar, "#StatusX", "\WindowH-#StatusH", "\WindowW-#StatusX", "#StatusH")
            CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                                             + #CRLF$
            CodeText$ + "         Box(#StatusX, \WindowH-#StatusH+1, \WindowW-#StatusX-1, 1, *pColor\HighColor)"     + #CRLF$
            CodeText$ + "         Box(#StatusX, \WindowH-#StatusH+1, 1, #StatusH-2,          *pColor\HighColor)"     + #CRLF$
            CodeText$ + "         Box(#StatusX, \WindowH-#StatusH+0, \WindowW-#StatusX-0, 1, *pColor\SideColor)"     + #CRLF$
         ElseIf \IsUseIcoToolBar 
            CodeText$ +           GenerateCode_Gradient(*pColorStatusBar, "0", "\WindowH-#StatusH", "\WindowW", "#StatusH")
            CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                              + #CRLF$
            CodeText$ + "         Box(0, \WindowH-#StatusH+1, \WindowW-1, 1, *pColor\HighColor)"      + #CRLF$
            CodeText$ + "         Box(0, \WindowH-#StatusH+1, 1, #StatusH-2, *pColor\HighColor)"      + #CRLF$
            CodeText$ + "         Box(0, \WindowH-#StatusH+0, \WindowW,   1, *pColor\SideColor)"      + #CRLF$
            
         Else
            CodeText$ +           GenerateCode_Gradient(*pColorStatusBar, "0", "\WindowH-#StatusH", "\WindowW", "#StatusH")
            CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                              + #CRLF$
            CodeText$ + "         Box(1, \WindowH-#StatusH+1, \WindowW-1, 1, *pColor\HighColor)"      + #CRLF$
            CodeText$ + "         Box(1, \WindowH-#StatusH+1, 1, #StatusH-2, *pColor\HighColor)"      + #CRLF$
            CodeText$ + "         Box(0, \WindowH-#StatusH+0, \WindowW,   1, *pColor\SideColor)"      + #CRLF$
         EndIf
          
         If \IsUseStatusSize And \IsUseSizeWindow = #True
            CodeText$ + #CRLF$ 
            CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"      + #CRLF$
            CodeText$ + "         For i = 15 To 03 Step -4"                   + #CRLF$
            CodeText$ + "            For j = i To 03 Step -4"                 + #CRLF$
            CodeText$ + "               Box(\WindowW-21+i, \WindowH-j-3, 2, 2, *pColor\HighColor)"   + #CRLF$
            CodeText$ + "               Box(\WindowW-21+i, \WindowH-j-3, 2, 2, *pColor\ForeColor)"   + #CRLF$
            CodeText$ + "            Next "                                   + #CRLF$
            CodeText$ + "         Next"                                       + #CRLF$
         EndIf
         
         CodeText$ + #CRLF$ 
      EndIf 

   EndWith
   
   ;====== 系统小按键 ======
   CodeText$ + "         ;绘制系统小按键"                               + #CRLF$
   CodeText$ + "         ButtonY = 1 "                                  + #CRLF$
   CodeText$ + "         ButtonX = \WindowW-1-\btnCloseBox\W"           + #CRLF$
   CodeText$ + "         Redraw_Gadget(\btnCloseBox, ButtonX, ButtonY)" + #CRLF$
   If _Project\IsUseSysNormalcy
      CodeText$ + "         ButtonX = ButtonX-1-\btnNormalcy\W"            + #CRLF$
      CodeText$ + "         Redraw_Gadget(\btnNormalcy, ButtonX, ButtonY)" + #CRLF$
      CodeText$ + "         Redraw_Gadget(\btnMaximize, ButtonX, ButtonY)" + #CRLF$
   EndIf 
   If _Project\IsUseSysMinimize
      CodeText$ + "         ButtonX = ButtonX-1-\btnMinimize\W"           + #CRLF$
      CodeText$ + "         Redraw_Gadget(\btnMinimize, ButtonX, ButtonY)" + #CRLF$
   EndIf 
   If _Project\IsUseSysSettings
      CodeText$ + "         ButtonX = ButtonX-1-\btnSettings\W"           + #CRLF$
      CodeText$ + "         Redraw_Gadget(\btnSettings, ButtonX, ButtonY)" + #CRLF$
   EndIf    
   
   
   CodeText$ + #CRLF$   
   CodeText$ + "         ;绘制主界面边框"                                                 + #CRLF$
   CodeText$ + "         *pColor.__ScreenColorInfo = @\DimColor[0]"                       + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"    + #CRLF$
   CodeText$ + "         Box(0,0,\WindowW, \WindowH, *pColor\SideColor)"                  + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                           + #CRLF$
   If _Project\IsUseCaptionBar And _Project\IsUseStatusBar And _Project\IsUseIcoToolBar
      CodeText$ + "         Box(#ToolBarW, #CaptionH, \WindowW-#ToolBarW-1, 1, *pColor\HighColor)"          + #CRLF$
      CodeText$ + "         Box(#ToolBarW, #CaptionH, 1, \WindowH-#CaptionH-#StatusH, *pColor\HighColor)" + #CRLF$
   ElseIf _Project\IsUseCaptionBar And _Project\IsUseStatusBar
      CodeText$ + "         Box(1, #CaptionH, \WindowW-2, 1, *pColor\HighColor)"                    + #CRLF$
      CodeText$ + "         Box(1, #CaptionH, 1, \WindowH-#CaptionH-#StatusH, *pColor\HighColor)"   + #CRLF$
   ElseIf _Project\IsUseCaptionBar And _Project\IsUseIcoToolBar
      CodeText$ + "         Box(#ToolBarW, #CaptionH, \WindowW-#ToolBarW-1, 1, *pColor\HighColor)"    + #CRLF$
      CodeText$ + "         Box(#ToolBarW, #CaptionH, 1, \WindowH-#CaptionH-1, *pColor\HighColor)"    + #CRLF$
   ElseIf _Project\IsUseStatusBar And _Project\IsUseIcoToolBar
      CodeText$ + "         Box(#ToolBarW, 1, \WindowW-#ToolBarW-1, 1, *pColor\HighColor)"   + #CRLF$
      CodeText$ + "         Box(#ToolBarW, 1, 1, \WindowH-1-#StatusH, *pColor\HighColor)"  + #CRLF$
   ElseIf _Project\IsUseCaptionBar
      CodeText$ + "         Box(1, #CaptionH, \WindowW-2, 1, *pColor\HighColor)"           + #CRLF$
      CodeText$ + "         Box(1, #CaptionH, 1, \WindowH-#CaptionH-1, *pColor\HighColor)"   + #CRLF$
   ElseIf _Project\IsUseStatusBar
      CodeText$ + "         Box(1, 1, \WindowW-2, 1, *pColor\HighColor)"          + #CRLF$
      CodeText$ + "         Box(1, 1, 1, \WindowH-1-#StatusH, *pColor\HighColor)" + #CRLF$
   ElseIf _Project\IsUseIcoToolBar
      CodeText$ + "         Box(#ToolBarW, 1, \WindowW-#ToolBarW-1, 1, *pColor\HighColor)"   + #CRLF$
      CodeText$ + "         Box(#ToolBarW, 1, 1, \WindowH-2, *pColor\HighColor)"           + #CRLF$
   Else 
      CodeText$ + "         Box(1, 1, \WindowW-2, 1, *pColor\HighColor)"   + #CRLF$
      CodeText$ + "         Box(1, 1, 1, \WindowH-2, *pColor\HighColor)"   + #CRLF$
   EndIf 
   
   CodeText$ + "         StopDrawing()"               + #CRLF$
   CodeText$ + "      EndIf "                         + #CRLF$
   
   If _Project\IsUseCanvasImage = #False           ;启用画布背景
      CodeText$ + #CRLF$
      CodeText$ + "      If \hBackImage : DeleteObject_(\hBackImage) : \hBackImage = 0 : EndIf  ;释放窗体背景句柄"   + #CRLF$
      CodeText$ + "      ;将背景图像渲染到窗体"          + #CRLF$
      CodeText$ + "      \hBackImage= CreatePatternBrush_(hImageScreen)"                  + #CRLF$
      CodeText$ + "      If \hBackImage"                                                  + #CRLF$
      CodeText$ + "         ;设置刷新域,去掉窗体界面控件部分 注意:*pRectScreen.RECT, *pRgnCombine是指针,不一样"      + #CRLF$ 
      CodeText$ + "         ;*pRgnCombine = CreateRectRgn_(0,0,\WindowW, \WindowH)           ;设置一个大的区域"      + #CRLF$ 
      CodeText$ + "         ;*pRgnReserve = CreateRectRgn_(100,100,100+100,100+50)           ;设置第一个按键的区域"  + #CRLF$  
      CodeText$ + "         ;CombineRgn_(*pRgnCombine,*pRgnCombine,*pRgnReserve,#RGN_DIFF)   ;在大区域中挖去按键区域"+ #CRLF$ 
      CodeText$ + "         ;*pRgnReserve = CreateRectRgn_(300,100,300+100,100+50)           ;设置第二个按键的区域"  + #CRLF$ 
      CodeText$ + "         ;CombineRgn_(*pRgnCombine,*pRgnCombine,*pRgnReserve,#RGN_DIFF)   ;在大区域中挖去按键区域"+ #CRLF$ 
      CodeText$ + "         SetClassLongPtr_(\hWindow, #GCL_HBRBACKGROUND, \hBackImage)"                             + #CRLF$
      CodeText$ + "         RedrawWindow_(\hWindow, *pRectScreen, *pRgnCombine, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)"    + #CRLF$
      CodeText$ + "      EndIf "                      + #CRLF$
   EndIf       
   CodeText$ + "   EndWith"                           + #CRLF$
   CodeText$ + "EndProcedure"                         + #CRLF$

   CodeText$ + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ GenerateCode_BalloonTip()

   If _Project\IsUseBalloonTip = #False : ProcedureReturn : EndIf 
   CodeText$ + ";- =========================="        + #CRLF$
   CodeText$ + ";- [BalloonTip]"                            + #CRLF$
   CodeText$ + "Procedure Screen_BalloonTip()"              + #CRLF$
   CodeText$ + "   With _Balloon"                           + #CRLF$
   *pColorWindow.__ScreenColorInfo = _Project\pMapColor("窗体布局")
   ChangeCurrentElement(_Project\ListColor(), *pColorWindow)
   Index = ListIndex(_Project\ListColor())
   CodeText$ + "      *pColor.__ScreenColorInfo = @_Screen\DimColor["+Str(Index)+"]"    + #CRLF$
   CodeText$ + "      If \pBalloonTip And \pBalloonTip\BalloonTip$ <> #Null$"    + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "         ;计算文本占用的最大宽度和最大高度"                + #CRLF$
   CodeText$ + "         TempImageID = CreateImage(#PB_Any, 100, 100)"     + #CRLF$
   CodeText$ + "         If StartDrawing(ImageOutput(TempImageID))"        + #CRLF$
   CodeText$ + "            DrawingFont(FontID(#fntDefault))"              + #CRLF$
   CodeText$ + "            TextW = TextWidth (\pBalloonTip\BalloonTip$) + 20"    + #CRLF$
   CodeText$ + "            TextH = TextHeight(\pBalloonTip\BalloonTip$) + 10"    + #CRLF$
   CodeText$ + "            StopDrawing()"                  + #CRLF$
   CodeText$ + "         EndIf"                             + #CRLF$
   CodeText$ + "         FreeImage(TempImageID)"            + #CRLF$
   CodeText$ + "         GetCursorPos_(Mouse.POINT)"        + #CRLF$
   CodeText$ + "         Gadget.POINT"                      + #CRLF$
   CodeText$ + "         Gadget\X = \pBalloonTip\X + 20"    + #CRLF$
   CodeText$ + "         Gadget\Y = \pBalloonTip\B + 15"    + #CRLF$
   CodeText$ + "         ClientToScreen_(_Screen\hWindow, Gadget) "     + #CRLF$
   CodeText$ + "         Mouse\y = Gadget\y"                + #CRLF$
   CodeText$ + "         \WindowW = TextW"                  + #CRLF$
   CodeText$ + "         \WindowH = TextH"                  + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "         If IsImage(#imgBalloon) = 0"       + #CRLF$
   CodeText$ + "            hImageScreen = CreateImage(#imgBalloon, \WindowW, \WindowH)"    + #CRLF$
   CodeText$ + "         ElseIf ImageWidth(#imgBalloon) <> \WindowW Or ImageHeight(#imgBalloon) <> \WindowH"               + #CRLF$
   CodeText$ + "            FreeImage(#imgBalloon)"         + #CRLF$
   CodeText$ + "            hImageScreen = CreateImage(#imgBalloon, \WindowW, \WindowH)"    + #CRLF$
   CodeText$ + "         Else "                             + #CRLF$
   CodeText$ + "            hImageScreen = ImageID(#imgBalloon)"        + #CRLF$
   CodeText$ + "         EndIf "                            + #CRLF$
   CodeText$ + "         If hImageScreen = 0 : ProcedureReturn : EndIf" + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "         If IsWindow(#winBalloon) = #False" + #CRLF$
   CodeText$ + "            \hWindow = OpenWindow(#winBalloon, 0, 0, 0, 0, "+#DQUOTE$+#DQUOTE$+", #PB_Window_BorderLess, _Screen\hWindow)"    + #CRLF$
   CodeText$ + "            HideWindow(#winBalloon, #True)" + #CRLF$
   CodeText$ + "         EndIf "                            + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "         If StartDrawing(ImageOutput(#imgBalloon))"                          + #CRLF$
   CodeText$ + "            DrawingFont(FontID(#fntDefault))"                                + #CRLF$
   CodeText$ + "            DrawingMode(#PB_2DDrawing_Default)"                              + #CRLF$
   CodeText$ + "            Box(0, 0, \WindowW, \WindowH, *pColor\BackColor & $FFFFFF)"      + #CRLF$
   CodeText$ +              GenerateCode_Gradient(*pColorWindow, "0", "0", "\WindowW", "\WindowH") 
   CodeText$ + "            DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Transparent)" + #CRLF$
   CodeText$ + "            DrawText(10, 05, \pBalloonTip\BalloonTip$, *pColor\FontColor)"   + #CRLF$
   CodeText$ + "            DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"    + #CRLF$
   CodeText$ + "            Box(1, 1, \WindowW-2, 1, *pColor\HighColor)"                     + #CRLF$
   CodeText$ + "            Box(1, 1, 1, \WindowH-2, *pColor\HighColor)"                     + #CRLF$
   CodeText$ + "            Box(0, 0, \WindowW, \WindowH, *pColor\SideColor) "               + #CRLF$ 
   CodeText$ + "            StopDrawing()"                  + #CRLF$
   CodeText$ + "         EndIf "                            + #CRLF$
   CodeText$ + "         If \hBackImage : DeleteObject_(\hBackImage) : \hBackImage = 0 : EndIf  ;释放窗体背景句柄"         + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "         ;将背景图像渲染到窗体"             + #CRLF$
   CodeText$ + "         \hBackImage= CreatePatternBrush_(hImageScreen)"                     + #CRLF$
   CodeText$ + "         If \hBackImage"                    + #CRLF$
   CodeText$ + "            SetClassLongPtr_(\hWindow, #GCL_HBRBACKGROUND, \hBackImage)"     + #CRLF$
   CodeText$ + "            RedrawWindow_(\hWindow, #Null, #Null, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)"          + #CRLF$
   CodeText$ + "         EndIf "                            + #CRLF$
   CodeText$ + "         ResizeWindow(#winBalloon, Mouse\X, Mouse\Y, \WindowW, \WindowH)"    + #CRLF$
   CodeText$ + "         SetActiveWindow(#winScreen)"       + #CRLF$
   CodeText$ + "         HideWindow(#winBalloon, #False)"   + #CRLF$
   CodeText$ + "         SetActiveWindow(#winScreen)"       + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "      ElseIf IsWindow(#winBalloon) "        + #CRLF$
   CodeText$ + "         HideWindow(#winBalloon, #True)"    + #CRLF$
   CodeText$ + "      EndIf "                               + #CRLF$
   CodeText$ + "   EndWith"                                 + #CRLF$
   CodeText$ + "EndProcedure"                               + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure


Procedure$ GenerateCode_HookGadget()
   If _Project\IsUseCanvasImage = #True : ProcedureReturn : EndIf     ;启用画布背景
   CodeText$ + ";- =========================="  + #CRLF$
   CodeText$ + ";- [HOOK]"                      + #CRLF$
   CodeText$ + ";光标在上事件"                  + #CRLF$
   CodeText$ + "Procedure Screen_Hook_MOUSEMOVE(*pMouse.POINTS)"              + #CRLF$
   CodeText$ + "   With _Screen"  + #CRLF$
   CodeText$ + "      If     Macro_Gadget_InRect1(\btnCloseBox)  : *pEventGadget = \btnCloseBox"    + #CRLF$
   If _Project\IsUseSysMinimize
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)  : *pEventGadget = \btnMinimize" + #CRLF$
   EndIf 
   If _Project\IsUseSysNormalcy
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnNormalcy)  : *pEventGadget = \btnNormalcy" + #CRLF$
   EndIf 
   If _Project\IsUseSysMaximize
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnMaximize)  : *pEventGadget = \btnMaximize" + #CRLF$
   EndIf 
   If _Project\IsUseSysSettings
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)  : *pEventGadget = \btnSettings" + #CRLF$
   EndIf    
   ;是否启用窗体大小调整
   If _Project\IsUseSizeWindow
      If _Project\IsUseStatusBar
         CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#StatusH And *pMouse\Y >= \WindowH-#StatusH : SetCursor_(\hSizing)"     + #CRLF$
      Else 
         CodeText$ + "      ElseIf *pMouse\X >= \WindowW-25 And *pMouse\Y >= \WindowH-25 : SetCursor_(\hSizing)"                 + #CRLF$
      EndIf 

      If _Project\WinSideL > 0  And _Project\WinSideR > 0
         CodeText$ + "      ElseIf *pMouse\X <= #WinSideL Or *pMouse\X >= \WindowW-#WinSideR        : SetCursor_(\hLeftRight)"  + #CRLF$  
      ElseIf _Project\WinSideR > 0  
         CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#WinSideR   : SetCursor_(\hLeftRight)"     + #CRLF$       
      ElseIf _Project\WinSideL > 0 
         CodeText$ + "      ElseIf *pMouse\X <= #WinSideL            : SetCursor_(\hLeftRight)"     + #CRLF$  
      EndIf 
      If _Project\WinSideT > 0  And _Project\WinSideB > 0
         CodeText$ + "      ElseIf *pMouse\Y <= #WinSideT Or *pMouse\Y >= \WindowH-#WinSideB        : SetCursor_(\hUpDown)"     + #CRLF$      
      ElseIf _Project\WinSideB > 0
         CodeText$ + "      ElseIf *pMouse\Y >= \WindowH-#WinSideB   : SetCursor_(\hUpDown)"        + #CRLF$     
      ElseIf _Project\WinSideT > 0 
         CodeText$ + "      ElseIf *pMouse\Y <= #WinSideT            : SetCursor_(\hUpDown)"        + #CRLF$     
      EndIf 
   EndIf 
   
   CodeText$ + "      EndIf "                   + #CRLF$
   If _Project\IsUseBalloonTip
      EventGadget$ = #Null$
      If _Project\IsUseSysCloseBox
         If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnCloseBox"
      EndIf 
      If _Project\IsUseSysMinimize
         If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnMinimize"
      EndIf 
      If _Project\IsUseSysMaximize
         If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnMaximize"
      EndIf 
      If _Project\IsUseSysNormalcy
         If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnNormalcy"
      EndIf
      If _Project\IsUseSysSettings
         If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnSettings"
      EndIf      

      CodeText$ + #CRLF$  
      CodeText$ + "      If _Balloon\pBalloonTip <> *pEventGadget"                                 + #CRLF$
      CodeText$ + "         Select *pEventGadget"                                                  + #CRLF$
      CodeText$ + "            Case #Null"                                                         + #CRLF$
      CodeText$ + "               _Balloon\pBalloonTip = #Null"                                    + #CRLF$
      CodeText$ + "               SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)"             + #CRLF$
      CodeText$ + "            Case " + EventGadget$                                               + #CRLF$
      CodeText$ + "               If _Balloon\pBalloonTip <> #Null And _Balloon\pBalloonTip <> *pEventGadget"  + #CRLF$
      CodeText$ + "                  _Balloon\pBalloonTip = *pEventGadget"                         + #CRLF$
      CodeText$ + "                  SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)"          + #CRLF$
      CodeText$ + "               Else "                                                           + #CRLF$
      CodeText$ + "                  _Balloon\pBalloonTip = *pEventGadget"                         + #CRLF$
      CodeText$ + "                  SetTimer_(\hWindow, #TIMER_BalloonTip, 1000, #Null)"          + #CRLF$
      CodeText$ + "               EndIf "                                                          + #CRLF$
      CodeText$ + "         EndSelect"                                                             + #CRLF$
      CodeText$ + "      EndIf"                                                                    + #CRLF$
   EndIf   
   CodeText$ + #CRLF$  
   CodeText$ + "      ;整理响应事件"            + #CRLF$
   CodeText$ + "      If \pMouseTop <> *pEventGadget : \pMouseTop = *pEventGadget : Redraw_Screen() : EndIf"   + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "   ProcedureReturn Result"      + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$
   
   CodeText$ + ";左键按下事件"                  + #CRLF$
   CodeText$ + "Procedure Screen_Hook_LBUTTONDOWN(*pMouse.POINTS)"            + #CRLF$
   CodeText$ + "   With _Screen"  + #CRLF$   
   If _Project\IsUseBalloonTip
      CodeText$ + "      If _Balloon\pBalloonTip"                                      + #CRLF$ 
      CodeText$ + "         _Balloon\pBalloonTip = #Null"                              + #CRLF$ 
      CodeText$ + "         KillTimer_(hWindow, #TIMER_BalloonTip)"                    + #CRLF$ 
      CodeText$ + "         SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)"       + #CRLF$ 
      CodeText$ + "      EndIf"   + #CRLF$ 
      CodeText$ + #CRLF$
   EndIf 
   CodeText$ + "      If     Macro_Gadget_InRect1(\btnCloseBox)  : *pEventGadget = \btnCloseBox"      + #CRLF$
   If _Project\IsUseSysMinimize
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)  : *pEventGadget = \btnMinimize"   + #CRLF$
   EndIf 
   If _Project\IsUseSysNormalcy
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnNormalcy)  : *pEventGadget = \btnNormalcy"   + #CRLF$
   EndIf 
   If _Project\IsUseSysMaximize
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnMaximize)  : *pEventGadget = \btnMaximize"   + #CRLF$
   EndIf 
   If _Project\IsUseSysSettings
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)  : *pEventGadget = \btnSettings"   + #CRLF$
   EndIf 
   ;是否启用窗体大小调整
   If _Project\IsUseSizeWindow
      If _Project\IsUseStatusBar
         CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#StatusH And *pMouse\Y >= \WindowH-#StatusH"    + #CRLF$
      Else 
         CodeText$ + "      ElseIf *pMouse\X >= \WindowW-25 And *pMouse\Y >= \WindowH-25"                + #CRLF$
      EndIf 
      CodeText$ + "          SetCursor_(\hSizing)                     "                               + #CRLF$
      CodeText$ + "          SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null) "                     + #CRLF$
      CodeText$ + "          SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTBOTTOMRIGHT, #True)"        + #CRLF$
      CodeText$ + "          ProcedureReturn #True"         + #CRLF$
      CodeText$ + #CRLF$
      CodeText$ + "      ElseIf *pMouse\X <= #WinSideL "    + #CRLF$
      CodeText$ + "          SetCursor_(\hLeftRight)"       + #CRLF$
      CodeText$ + "          SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null) "            + #CRLF$
      CodeText$ + "          SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTLEFT, #True)"      + #CRLF$
      CodeText$ + "          ProcedureReturn #True"         + #CRLF$
      CodeText$ + #CRLF$
      CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#WinSideR "                            + #CRLF$
      CodeText$ + "          SetCursor_(\hLeftRight)"       + #CRLF$
      CodeText$ + "          SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null) "            + #CRLF$
      CodeText$ + "          SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTRIGHT, #True)"     + #CRLF$
      CodeText$ + "          ProcedureReturn #True"         + #CRLF$
      CodeText$ + #CRLF$
      CodeText$ + "      ElseIf *pMouse\Y <= #WinSideT"     + #CRLF$
      CodeText$ + "          SetCursor_(\hUpDown)"          + #CRLF$
      CodeText$ + "          SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null) "            + #CRLF$
      CodeText$ + "          SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTTOP, #True)"       + #CRLF$
      CodeText$ + "          ProcedureReturn #True"         + #CRLF$
      CodeText$ + #CRLF$
      CodeText$ + "      ElseIf *pMouse\Y >= \WindowH-#WinSideB"                             + #CRLF$
      CodeText$ + "          SetCursor_(\hUpDown)"          + #CRLF$
      CodeText$ + "          SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null) "            + #CRLF$
      CodeText$ + "          SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTBOTTOM, #True)"    + #CRLF$
      CodeText$ + "          ProcedureReturn #True"         + #CRLF$
   EndIf 

   CodeText$ + "      Else"                     + #CRLF$
   CodeText$ + "         SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)"  + #CRLF$    
   CodeText$ + "      EndIf "                   + #CRLF$
   CodeText$ + #CRLF$  
   CodeText$ + "      ;整理响应事件"            + #CRLF$
   CodeText$ + "      If \pHoldDown <> *pEventGadget : \pHoldDown = *pEventGadget : Redraw_Screen() : EndIf" + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "   ProcedureReturn Result"      + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$
   
   CodeText$ + ";左键释放事件"                  + #CRLF$
   CodeText$ + "Procedure Screen_Hook_LBUTTONUP(*pMouse.POINTS)"              + #CRLF$
   CodeText$ + "   With _Screen"  + #CRLF$   
   If _Project\IsUseBalloonTip
      CodeText$ + "      If _Balloon\pBalloonTip"                                      + #CRLF$ 
      CodeText$ + "         _Balloon\pBalloonTip = #Null"                              + #CRLF$ 
      CodeText$ + "         KillTimer_(hWindow, #TIMER_BalloonTip)"                    + #CRLF$ 
      CodeText$ + "         SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)"       + #CRLF$ 
      CodeText$ + "      EndIf"   + #CRLF$ 
      CodeText$ + #CRLF$
   EndIf 

   CodeText$ + "      If Macro_Gadget_InRect1(\btnCloseBox) "                 + #CRLF$
   CodeText$ + "         *pEventGadget = \btnCloseBox "                       + #CRLF$
   CodeText$ + "         If \pHoldDown = \btnCloseBox : PostEvent(#PB_Event_CloseWindow) : EndIf"  + #CRLF$
   If _Project\IsUseSysMinimize
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)"            + #CRLF$
      CodeText$ + "         *pEventGadget = \btnMinimize"                     + #CRLF$
      CodeText$ + "         If \pHoldDown = \btnMinimize : ShowWindow_(\hWindow, 2) : EndIf    ;最小化窗体"  + #CRLF$
   EndIf 
   If _Project\IsUseSysMaximize
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnMaximize)"              + #CRLF$
      CodeText$ + "         If \pHoldDown = \btnMaximize"                        + #CRLF$
      CodeText$ + "            \btnNormalcy\IsHide = #False"                     + #CRLF$
      CodeText$ + "            \btnMaximize\IsHide = #True"                      + #CRLF$
      CodeText$ + "            SystemParametersInfo_(#SPI_GETWORKAREA, 0, RECT.RECT, 0)    ;获取桌面屏幕大小"  + #CRLF$
      CodeText$ + "            \WindowW = RECT\right-RECT\left+2"                + #CRLF$
      CodeText$ + "            \WindowH = RECT\bottom-RECT\top"                  + #CRLF$
      CodeText$ + "            Redraw_Screen()"                                  + #CRLF$
      CodeText$ + "            ShowWindow_(\hWindow, 3)       ;最大化窗体"                + #CRLF$
      CodeText$ + "            MoveWindow_(\hWindow, 0, 0, \WindowW, \WindowH, #True)"    + #CRLF$
      CodeText$ + "            \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen()"         + #CRLF$
      CodeText$ + "            ProcedureReturn"    + #CRLF$
      CodeText$ + "         EndIf "                + #CRLF$
   EndIf 
   If _Project\IsUseSysNormalcy
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnNormalcy)"              + #CRLF$
      CodeText$ + "         If \pHoldDown = \btnNormalcy"                        + #CRLF$
      CodeText$ + "            \btnNormalcy\IsHide = #True"                      + #CRLF$
      CodeText$ + "            \btnMaximize\IsHide = #False"                     + #CRLF$
      CodeText$ + "            ShowWindow_(\hWindow,1)       ;正常化窗体"        + #CRLF$
      CodeText$ + "            \pHoldDown = 0"                                   + #CRLF$
      CodeText$ + "            \WindowW = WindowWidth(#winScreen)"               + #CRLF$
      CodeText$ + "            \WindowH = WindowHeight(#winScreen)"              + #CRLF$
      CodeText$ + "            \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen()"         + #CRLF$
      CodeText$ + "            ProcedureReturn"                                  + #CRLF$
      CodeText$ + "         EndIf "                                              + #CRLF$
   EndIf
   If _Project\IsUseSysSettings
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)"              + #CRLF$
      CodeText$ + "         *pEventGadget = \btnSettings"                        + #CRLF$
   EndIf    
   
   
   CodeText$ + "      EndIf "                   + #CRLF$
   CodeText$ + #CRLF$  
   CodeText$ + "      ;整理响应事件"            + #CRLF$
   CodeText$ + "      If \pHoldDown Or \pMouseTop : \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen() : EndIf" + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "   ProcedureReturn Result"      + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$

   ;是否启用窗体大小调整
   If _Project\IsUseSizeWindow
      If _Project\IsUseSysMaximize
         CodeText$ + ";双击事件"    + #CRLF$
         CodeText$ + "Procedure Screen_Hook_LBUTTONDBLCLK(*pMouse.POINTS)"    + #CRLF$
         CodeText$ + "   With _Screen"                                        + #CRLF$
         CodeText$ + "      If *pMouse\Y < #CaptionH"                         + #CRLF$
         CodeText$ + "         If \btnNormalcy\IsHide = #True"                + #CRLF$
         CodeText$ + "            \btnNormalcy\IsHide = #False"               + #CRLF$
         CodeText$ + "            \btnMaximize\IsHide = #True"                + #CRLF$
         CodeText$ + "            SystemParametersInfo_(#SPI_GETWORKAREA, 0, RECT.RECT, 0)    ;获取桌面屏幕大小"    + #CRLF$
         CodeText$ + "            \WindowW = RECT\right-RECT\left+2"          + #CRLF$
         CodeText$ + "            \WindowH = RECT\bottom-RECT\top"            + #CRLF$
         CodeText$ + "            Redraw_Screen()"                            + #CRLF$
         CodeText$ + "            ShowWindow_(\hWindow, 3)       ;最大化窗体" + #CRLF$
         CodeText$ + "            MoveWindow_(\hWindow, 0, 0, \WindowW, \WindowH, #True)"    + #CRLF$
;          CodeText$ + "            ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, _Screen\WindowW, _Screen\WindowH)"    + #CRLF$
         CodeText$ + "            \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen()"         + #CRLF$
         CodeText$ + "         Else "                                         + #CRLF$
         CodeText$ + "            \btnNormalcy\IsHide = #True"                + #CRLF$
         CodeText$ + "            \btnMaximize\IsHide = #False"               + #CRLF$
         CodeText$ + "            ShowWindow_(\hWindow,1)       ;正常化窗体"  + #CRLF$
         CodeText$ + "            \pHoldDown = 0"                             + #CRLF$
         CodeText$ + "            \WindowW = WindowWidth(#winScreen)"         + #CRLF$
         CodeText$ + "            \WindowH = WindowHeight(#winScreen)"        + #CRLF$
;          CodeText$ + "            ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, _Screen\WindowW, _Screen\WindowH)"    + #CRLF$
         CodeText$ + "            \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen()"         + #CRLF$
         CodeText$ + "         EndIf "                + #CRLF$
         CodeText$ + "      EndIf"                    + #CRLF$
         CodeText$ + "   EndWith"                     + #CRLF$
         CodeText$ + "   ProcedureReturn Result"      + #CRLF$
         CodeText$ + "EndProcedure"                   + #CRLF$
         CodeText$ + #CRLF$
      EndIf 
   EndIf 
   If _Project\IsUseSizeWindow And _Project\IsUseBalloonTip
      CodeText$ + ";计时器事件"                    + #CRLF$
      CodeText$ + "Procedure Screen_Hook_TIMER(wParam)"                    + #CRLF$
      CodeText$ + "   Select wParam"               + #CRLF$
      CodeText$ + "      Case #TIMER_SizeWindow"   + #CRLF$
      CodeText$ + "         _Screen\WindowW = WindowWidth (#winScreen)"    + #CRLF$
      CodeText$ + "         _Screen\WindowH = WindowHeight(#winScreen)"    + #CRLF$
      CodeText$ + "         _Screen\IsSizeWindow = #True"                  + #CRLF$
      CodeText$ + "         Redraw_Screen()"                               + #CRLF$
      CodeText$ + "      Case #TIMER_BalloonTip"                           + #CRLF$
      CodeText$ + "         Screen_BalloonTip()"                           + #CRLF$
      CodeText$ + "         KillTimer_(_Screen\hWindow, #TIMER_BalloonTip)"+ #CRLF$ 
      CodeText$ + "   EndSelect"                   + #CRLF$
      CodeText$ + "   ProcedureReturn Result"      + #CRLF$
      CodeText$ + "EndProcedure"                   + #CRLF$

   ElseIf _Project\IsUseSizeWindow
      CodeText$ + ";计时器事件"                    + #CRLF$
      CodeText$ + "Procedure Screen_Hook_TIMER(wParam)"                    + #CRLF$
      CodeText$ + "   Select wParam "                                      + #CRLF$
      CodeText$ + "      Case #TIMER_SizeWindow"                           + #CRLF$
      CodeText$ + "         _Screen\WindowW = WindowWidth (#winScreen)"    + #CRLF$
      CodeText$ + "         _Screen\WindowH = WindowHeight(#winScreen)"    + #CRLF$
      CodeText$ + "         _Screen\IsSizeWindow = #True"                  + #CRLF$
      CodeText$ + "         Redraw_Screen()"                               + #CRLF$
      CodeText$ + "   EndSelect"                   + #CRLF$
      CodeText$ + "   ProcedureReturn Result"      + #CRLF$
      CodeText$ + "EndProcedure"                   + #CRLF$
      CodeText$ + #CRLF$
   ElseIf _Project\IsUseBalloonTip
      CodeText$ + ";计时器事件"                    + #CRLF$
      CodeText$ + "Procedure Screen_Hook_TIMER(wParam)"                    + #CRLF$
      CodeText$ + "   Select wParam"               + #CRLF$
      CodeText$ + "      Case #TIMER_BalloonTip"   + #CRLF$
      CodeText$ + "         Screen_BalloonTip()"   + #CRLF$
      CodeText$ + "         KillTimer_(_Screen\hWindow, #TIMER_BalloonTip)"+ #CRLF$
      CodeText$ + "   EndSelect"                   + #CRLF$
      CodeText$ + "   ProcedureReturn Result"      + #CRLF$
      CodeText$ + "EndProcedure"                   + #CRLF$
   EndIf 
   
   
   CodeText$ + ";挂钩事件"                      + #CRLF$
   CodeText$ + "Procedure Screen_HookWindow(hWindow, uMsg, wParam, lParam) "              + #CRLF$
   CodeText$ + "   With _Screen"                + #CRLF$
   CodeText$ + "      If \hWindow <> hWindow"   + #CRLF$
   CodeText$ + "         ProcedureReturn DefWindowProc_(hWindow, uMsg, wParam, lParam)"   + #CRLF$
   CodeText$ + "      EndIf"                    + #CRLF$
   CodeText$ + "      Select uMsg "             + #CRLF$
   CodeText$ + "         Case #WM_MOUSEMOVE     : Result = Screen_Hook_MOUSEMOVE    (@lParam)"  + #CRLF$
   CodeText$ + "         Case #WM_LBUTTONDOWN   : Result = Screen_Hook_LBUTTONDOWN  (@lParam)"  + #CRLF$
   CodeText$ + "         Case #WM_LBUTTONUP     : Result = Screen_Hook_LBUTTONUP    (@lParam)"  + #CRLF$
   
   
   ;是否启用窗体大小调整
   If _Project\IsUseSizeWindow Or _Project\IsUseBalloonTip
      If _Project\IsUseSizeWindow And _Project\IsUseSysMaximize
         CodeText$ + "         Case #WM_LBUTTONDBLCLK : Result = Screen_Hook_LBUTTONDBLCLK(@lParam)"  + #CRLF$
      EndIf 
      CodeText$ + "         Case #WM_TIMER         : Result = Screen_Hook_TIMER        (wParam)"      + #CRLF$ 
   EndIf 
   If _Project\IsUseSizeWindow
      CodeText$ + "         Case #WM_SIZE"                                          + #CRLF$
      If _Project\IsUseSysMaximize = #True
         CodeText$ + "            If wParam = 0 And \btnMaximize\IsHide = #True"       + #CRLF$
         CodeText$ + "               \btnNormalcy\IsHide = #True"                      + #CRLF$
         CodeText$ + "               \btnMaximize\IsHide = #False"                     + #CRLF$
         CodeText$ + "            EndIf"        + #CRLF$ 
      EndIf 
      CodeText$ + "            SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null)"  + #CRLF$
   EndIf 
   
   CodeText$ + "      EndSelect "               + #CRLF$
   CodeText$ + "      If Result = 0 "           + #CRLF$
   CodeText$ + "         Result = CallWindowProc_(\hWindowHook, hWindow, uMsg, wParam, lParam) "   + #CRLF$
   CodeText$ + "      EndIf"                    + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "   ProcedureReturn Result"      + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + #CRLF$ 
   
   ProcedureReturn CodeText$
EndProcedure

Procedure$ GenerateCode_cvsScreen()
   If _Project\IsUseCanvasImage = #False : ProcedureReturn : EndIf     ;启用画布背景

   CodeText$ + ";- =========================="  + #CRLF$
   CodeText$ + ";- [HOOK]"                      + #CRLF$
   CodeText$ + ";光标在上事件"                  + #CRLF$
   CodeText$ + "Procedure Screen_Hook_MOUSEMOVE(*pMouse.POINTS)"              + #CRLF$
   CodeText$ + "   With _Screen"  + #CRLF$
   CodeText$ + "      If     Macro_Gadget_InRect1(\btnCloseBox)  : *pEventGadget = \btnCloseBox"    + #CRLF$
   If _Project\IsUseSysMinimize
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)  : *pEventGadget = \btnMinimize" + #CRLF$
   EndIf 
   If _Project\IsUseSysNormalcy
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnNormalcy)  : *pEventGadget = \btnNormalcy" + #CRLF$
   EndIf 
   If _Project\IsUseSysMaximize
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnMaximize)  : *pEventGadget = \btnMaximize" + #CRLF$
   EndIf 
   If _Project\IsUseSysSettings
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)  : *pEventGadget = \btnSettings" + #CRLF$
   EndIf    
   ;是否启用窗体大小调整
   If _Project\IsUseSizeWindow
      If _Project\IsUseStatusBar
         CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#StatusH And *pMouse\Y >= \WindowH-#StatusH : SetCursor_(\hSizing)"     + #CRLF$
      Else 
         CodeText$ + "      ElseIf *pMouse\X >= \WindowW-25 And *pMouse\Y >= \WindowH-25 : SetCursor_(\hSizing)"                 + #CRLF$
      EndIf 
      If _Project\WinSideL > 0  And _Project\WinSideR > 0
         CodeText$ + "      ElseIf *pMouse\X <= #WinSideL Or *pMouse\X >= \WindowW-#WinSideR        : SetCursor_(\hLeftRight)"  + #CRLF$  
      ElseIf _Project\WinSideR > 0  
         CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#WinSideR   : SetCursor_(\hLeftRight)"     + #CRLF$       
      ElseIf _Project\WinSideL > 0 
         CodeText$ + "      ElseIf *pMouse\X <= #WinSideL            : SetCursor_(\hLeftRight)"     + #CRLF$  
      EndIf 
      If _Project\WinSideT > 0  And _Project\WinSideB > 0
         CodeText$ + "      ElseIf *pMouse\Y <= #WinSideT Or *pMouse\Y >= \WindowH-#WinSideB        : SetCursor_(\hUpDown)"     + #CRLF$      
      ElseIf _Project\WinSideB > 0
         CodeText$ + "      ElseIf *pMouse\Y >= \WindowH-#WinSideB   : SetCursor_(\hUpDown)"        + #CRLF$     
      ElseIf _Project\WinSideT > 0 
         CodeText$ + "      ElseIf *pMouse\Y <= #WinSideT            : SetCursor_(\hUpDown)"        + #CRLF$     
      EndIf 
   EndIf 
   CodeText$ + "      EndIf "                                                                      + #CRLF$

   If _Project\IsUseBalloonTip
      CodeText$ + #CRLF$  
      
      EventGadget$ = #Null$
      If _Project\IsUseSysCloseBox
         If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnCloseBox"
      EndIf 
      If _Project\IsUseSysMinimize
         If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnMinimize"
      EndIf 
      If _Project\IsUseSysMaximize
         If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnMaximize"
      EndIf 
      If _Project\IsUseSysNormalcy
         If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnNormalcy"
      EndIf
      If _Project\IsUseSysSettings
         If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnSettings"
      EndIf    
      
      CodeText$ + "      If _Balloon\pBalloonTip <> *pEventGadget"                                 + #CRLF$
      CodeText$ + "         Select *pEventGadget"                                                  + #CRLF$
      CodeText$ + "            Case #Null"                                                         + #CRLF$
      CodeText$ + "               _Balloon\pBalloonTip = #Null"                                    + #CRLF$
      CodeText$ + "               SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)"             + #CRLF$
      CodeText$ + "            Case " +EventGadget$                                                + #CRLF$
      CodeText$ + "               If _Balloon\pBalloonTip <> #Null And _Balloon\pBalloonTip <> *pEventGadget"  + #CRLF$
      CodeText$ + "                  _Balloon\pBalloonTip = *pEventGadget"                         + #CRLF$
      CodeText$ + "                  SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)"          + #CRLF$
      CodeText$ + "               Else "                                                           + #CRLF$
      CodeText$ + "                  _Balloon\pBalloonTip = *pEventGadget"                         + #CRLF$
      CodeText$ + "                  SetTimer_(\hWindow, #TIMER_BalloonTip, 1000, #Null)"          + #CRLF$
      CodeText$ + "               EndIf "                                                          + #CRLF$
      CodeText$ + "         EndSelect"                                                             + #CRLF$
      CodeText$ + "      EndIf"                                                                    + #CRLF$
   EndIf 
   
   CodeText$ + #CRLF$  
   CodeText$ + "      ;整理响应事件"            + #CRLF$
   CodeText$ + "      If \pMouseTop <> *pEventGadget : \pMouseTop = *pEventGadget : Redraw_Screen() : EndIf"   + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "   ProcedureReturn Result"      + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$
   
   CodeText$ + ";左键按下事件"                  + #CRLF$
   CodeText$ + "Procedure Screen_Hook_LBUTTONDOWN(*pMouse.POINTS)"            + #CRLF$
   CodeText$ + "   With _Screen"  + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      If _Balloon\pBalloonTip"                                      + #CRLF$ 
      CodeText$ + "         _Balloon\pBalloonTip = #Null"                              + #CRLF$ 
      CodeText$ + "         KillTimer_(hWindow, #TIMER_BalloonTip)"                    + #CRLF$ 
      CodeText$ + "         SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)"       + #CRLF$ 
      CodeText$ + "      EndIf"   + #CRLF$ 
      CodeText$ + #CRLF$
   EndIf 
   CodeText$ + "      If     Macro_Gadget_InRect1(\btnCloseBox)  : *pEventGadget = \btnCloseBox"      + #CRLF$
   If _Project\IsUseSysMinimize
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)  : *pEventGadget = \btnMinimize"   + #CRLF$
   EndIf 
   If _Project\IsUseSysNormalcy
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnNormalcy)  : *pEventGadget = \btnNormalcy"   + #CRLF$
   EndIf 
   If _Project\IsUseSysMaximize
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnMaximize)  : *pEventGadget = \btnMaximize"   + #CRLF$
   EndIf 
   If _Project\IsUseSysSettings
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)  : *pEventGadget = \btnSettings"   + #CRLF$
   EndIf 
   ;是否启用窗体大小调整
   If _Project\IsUseSizeWindow
      If _Project\IsUseStatusBar
         CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#StatusH And *pMouse\Y >= \WindowH-#StatusH"    + #CRLF$
      Else 
         CodeText$ + "      ElseIf *pMouse\X >= \WindowW-25 And *pMouse\Y >= \WindowH-25"                + #CRLF$
      EndIf 
      CodeText$ + "          SetCursor_(\hSizing)                     "                               + #CRLF$
      CodeText$ + "          SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null) "                     + #CRLF$
      CodeText$ + "          SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTBOTTOMRIGHT, #True)"        + #CRLF$
      CodeText$ + "          ProcedureReturn #True"         + #CRLF$
      CodeText$ + #CRLF$
      CodeText$ + "      ElseIf *pMouse\X <= #WinSideL "    + #CRLF$
      CodeText$ + "          SetCursor_(\hLeftRight)"       + #CRLF$
      CodeText$ + "          SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null) "            + #CRLF$
      CodeText$ + "          SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTLEFT, #True)"      + #CRLF$
      CodeText$ + "          ProcedureReturn #True"         + #CRLF$
      CodeText$ + #CRLF$
      CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#WinSideR "                            + #CRLF$
      CodeText$ + "          SetCursor_(\hLeftRight)"       + #CRLF$
      CodeText$ + "          SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null) "            + #CRLF$
      CodeText$ + "          SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTRIGHT, #True)"     + #CRLF$
      CodeText$ + "          ProcedureReturn #True"         + #CRLF$
      CodeText$ + #CRLF$
      CodeText$ + "      ElseIf *pMouse\Y <= #WinSideT"     + #CRLF$
      CodeText$ + "          SetCursor_(\hUpDown)"          + #CRLF$
      CodeText$ + "          SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null) "            + #CRLF$
      CodeText$ + "          SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTTOP, #True)"       + #CRLF$
      CodeText$ + "          ProcedureReturn #True"         + #CRLF$
      CodeText$ + #CRLF$
      CodeText$ + "      ElseIf *pMouse\Y >= \WindowH-#WinSideB"                             + #CRLF$
      CodeText$ + "          SetCursor_(\hUpDown)"          + #CRLF$
      CodeText$ + "          SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null) "            + #CRLF$
      CodeText$ + "          SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTBOTTOM, #True)"    + #CRLF$
      CodeText$ + "          ProcedureReturn #True"         + #CRLF$
   EndIf 

   CodeText$ + "      Else"                     + #CRLF$
   CodeText$ + "         SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)"  + #CRLF$    
   CodeText$ + "      EndIf "                   + #CRLF$
   CodeText$ + #CRLF$  
   CodeText$ + "      ;整理响应事件"            + #CRLF$
   CodeText$ + "      If \pHoldDown <> *pEventGadget : \pHoldDown = *pEventGadget : Redraw_Screen() : EndIf" + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "   ProcedureReturn Result"      + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$
   
   CodeText$ + ";左键释放事件"                  + #CRLF$
   CodeText$ + "Procedure Screen_Hook_LBUTTONUP(*pMouse.POINTS)"              + #CRLF$
   CodeText$ + "   With _Screen"  + #CRLF$   
   If _Project\IsUseBalloonTip
      CodeText$ + "      If _Balloon\pBalloonTip"                                      + #CRLF$ 
      CodeText$ + "         _Balloon\pBalloonTip = #Null"                              + #CRLF$ 
      CodeText$ + "         KillTimer_(hWindow, #TIMER_BalloonTip)"                    + #CRLF$ 
      CodeText$ + "         SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)"       + #CRLF$ 
      CodeText$ + "      EndIf"   + #CRLF$ 
      CodeText$ + #CRLF$
   EndIf 

   CodeText$ + "      If Macro_Gadget_InRect1(\btnCloseBox) "                 + #CRLF$
   CodeText$ + "         *pEventGadget = \btnCloseBox "                       + #CRLF$
   CodeText$ + "         If \pHoldDown = \btnCloseBox : PostEvent(#PB_Event_CloseWindow) : EndIf"  + #CRLF$
   If _Project\IsUseSysMinimize
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)"            + #CRLF$
      CodeText$ + "         *pEventGadget = \btnMinimize"                     + #CRLF$
      CodeText$ + "         If \pHoldDown = \btnMinimize : ShowWindow_(\hWindow, 2) : EndIf    ;最小化窗体"  + #CRLF$
   EndIf 
   If _Project\IsUseSysMaximize
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnMaximize)"              + #CRLF$
      CodeText$ + "         If \pHoldDown = \btnMaximize"                        + #CRLF$
      CodeText$ + "            \btnNormalcy\IsHide = #False"                     + #CRLF$
      CodeText$ + "            \btnMaximize\IsHide = #True"                      + #CRLF$
      CodeText$ + "            SystemParametersInfo_(#SPI_GETWORKAREA, 0, RECT.RECT, 0)    ;获取桌面屏幕大小"  + #CRLF$
      CodeText$ + "            \WindowW = RECT\right-RECT\left+2"                + #CRLF$
      CodeText$ + "            \WindowH = RECT\bottom-RECT\top"                  + #CRLF$
      CodeText$ + "            Redraw_Screen()"                                  + #CRLF$
      CodeText$ + "            ShowWindow_(\hWindow, 3)       ;最大化窗体"                + #CRLF$
      CodeText$ + "            MoveWindow_(\hWindow, 0, 0, \WindowW, \WindowH, #True)"    + #CRLF$
      CodeText$ + "            ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, \WindowW, \WindowH)"    + #CRLF$
      CodeText$ + "            \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen()"         + #CRLF$
      CodeText$ + "            ProcedureReturn"    + #CRLF$
      CodeText$ + "         EndIf "                + #CRLF$
   EndIf 
   If _Project\IsUseSysNormalcy
      CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnNormalcy)"              + #CRLF$
      CodeText$ + "         If \pHoldDown = \btnNormalcy"                        + #CRLF$
      CodeText$ + "            \btnNormalcy\IsHide = #True"                      + #CRLF$
      CodeText$ + "            \btnMaximize\IsHide = #False"                     + #CRLF$
      CodeText$ + "            ShowWindow_(\hWindow,1)       ;正常化窗体"        + #CRLF$
      CodeText$ + "            \pHoldDown = 0"                                   + #CRLF$
      CodeText$ + "            \WindowW = WindowWidth(#winScreen)"               + #CRLF$
      CodeText$ + "            \WindowH = WindowHeight(#winScreen)"              + #CRLF$
      CodeText$ + "            ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, \WindowW, \WindowH)"   + #CRLF$
      CodeText$ + "            \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen()"         + #CRLF$
      CodeText$ + "            ProcedureReturn"                                  + #CRLF$
      CodeText$ + "         EndIf "                                              + #CRLF$
   EndIf
   If _Project\IsUseSysSettings
      CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)"              + #CRLF$
      CodeText$ + "         *pEventGadget = \btnSettings"                        + #CRLF$
   EndIf    
   CodeText$ + "      EndIf "                   + #CRLF$
   CodeText$ + #CRLF$  
   CodeText$ + "      ;整理响应事件"            + #CRLF$
   CodeText$ + "      If \pHoldDown Or \pMouseTop : \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen() : EndIf" + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "   ProcedureReturn Result"      + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$
   
   
   ;是否启用窗体大小调整
   If _Project\IsUseSizeWindow
      If _Project\IsUseSysMaximize
         CodeText$ + ";双击事件"    + #CRLF$
         CodeText$ + "Procedure Screen_Hook_LBUTTONDBLCLK(*pMouse.POINTS)"    + #CRLF$
         CodeText$ + "   With _Screen"                                        + #CRLF$
         CodeText$ + "      If *pMouse\Y < #CaptionH"                         + #CRLF$
         CodeText$ + "         If \btnNormalcy\IsHide = #True"                + #CRLF$
         CodeText$ + "            \btnNormalcy\IsHide = #False"               + #CRLF$
         CodeText$ + "            \btnMaximize\IsHide = #True"                + #CRLF$
         CodeText$ + "            SystemParametersInfo_(#SPI_GETWORKAREA, 0, RECT.RECT, 0)    ;获取桌面屏幕大小"    + #CRLF$
         CodeText$ + "            \WindowW = RECT\right-RECT\left+2"          + #CRLF$
         CodeText$ + "            \WindowH = RECT\bottom-RECT\top"            + #CRLF$
         CodeText$ + "            Redraw_Screen()"                            + #CRLF$
         CodeText$ + "            ShowWindow_(\hWindow, 3)       ;最大化窗体" + #CRLF$
         CodeText$ + "            MoveWindow_(\hWindow, 0, 0, \WindowW, \WindowH, #True)"    + #CRLF$
         CodeText$ + "            ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, _Screen\WindowW, _Screen\WindowH)"    + #CRLF$
         CodeText$ + "            \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen()"         + #CRLF$
         CodeText$ + "         Else "                                         + #CRLF$
         CodeText$ + "            \btnNormalcy\IsHide = #True"                + #CRLF$
         CodeText$ + "            \btnMaximize\IsHide = #False"               + #CRLF$
         CodeText$ + "            ShowWindow_(\hWindow,1)       ;正常化窗体"  + #CRLF$
         CodeText$ + "            \pHoldDown = 0"                             + #CRLF$
         CodeText$ + "            \WindowW = WindowWidth(#winScreen)"         + #CRLF$
         CodeText$ + "            \WindowH = WindowHeight(#winScreen)"        + #CRLF$
         CodeText$ + "            ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, _Screen\WindowW, _Screen\WindowH)"    + #CRLF$
         CodeText$ + "            \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen()"         + #CRLF$
         CodeText$ + "         EndIf "                + #CRLF$
         CodeText$ + "      EndIf"                    + #CRLF$
         CodeText$ + "   EndWith"                     + #CRLF$
         CodeText$ + "   ProcedureReturn Result"      + #CRLF$
         CodeText$ + "EndProcedure"                   + #CRLF$
         CodeText$ + #CRLF$
      EndIf
   EndIf
      
   If _Project\IsUseSizeWindow And _Project\IsUseBalloonTip
      CodeText$ + ";计时器事件"                    + #CRLF$
      CodeText$ + "Procedure Screen_Hook_TIMER(wParam)"                    + #CRLF$
      CodeText$ + "   Select wParam"               + #CRLF$
      CodeText$ + "      Case #TIMER_SizeWindow"   + #CRLF$
      CodeText$ + "         _Screen\WindowW = WindowWidth (#winScreen)"    + #CRLF$
      CodeText$ + "         _Screen\WindowH = WindowHeight(#winScreen)"    + #CRLF$
      CodeText$ + "         _Screen\IsSizeWindow = #True"                  + #CRLF$
      CodeText$ + "         ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, _Screen\WindowW, _Screen\WindowH)"    + #CRLF$
      CodeText$ + "         Redraw_Screen()"                               + #CRLF$
      CodeText$ + "      Case #TIMER_BalloonTip"                           + #CRLF$
      CodeText$ + "         Screen_BalloonTip()"                           + #CRLF$
      CodeText$ + "         KillTimer_(_Screen\hWindow, #TIMER_BalloonTip)"+ #CRLF$ 
      CodeText$ + "   EndSelect"                   + #CRLF$
      CodeText$ + "   ProcedureReturn Result"      + #CRLF$
      CodeText$ + "EndProcedure"                   + #CRLF$

   ElseIf _Project\IsUseSizeWindow
      CodeText$ + ";计时器事件"                    + #CRLF$
      CodeText$ + "Procedure Screen_Hook_TIMER(wParam)"                    + #CRLF$
      CodeText$ + "   Select wParam "                                      + #CRLF$
      CodeText$ + "      Case #TIMER_SizeWindow"                           + #CRLF$
      CodeText$ + "         _Screen\WindowW = WindowWidth (#winScreen)"    + #CRLF$
      CodeText$ + "         _Screen\WindowH = WindowHeight(#winScreen)"    + #CRLF$
      CodeText$ + "         _Screen\IsSizeWindow = #True"                  + #CRLF$
      CodeText$ + "         ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, _Screen\WindowW, _Screen\WindowH)"    + #CRLF$
      CodeText$ + "         Redraw_Screen()"                               + #CRLF$
      CodeText$ + "   EndSelect"                   + #CRLF$
      CodeText$ + "   ProcedureReturn Result"      + #CRLF$
      CodeText$ + "EndProcedure"                   + #CRLF$
      CodeText$ + #CRLF$
   ElseIf _Project\IsUseBalloonTip
      CodeText$ + ";计时器事件"                    + #CRLF$
      CodeText$ + "Procedure Screen_Hook_TIMER(wParam)"                    + #CRLF$
      CodeText$ + "   Select wParam"               + #CRLF$
      CodeText$ + "      Case #TIMER_BalloonTip"   + #CRLF$
      CodeText$ + "         Screen_BalloonTip()"   + #CRLF$
      CodeText$ + "         KillTimer_(_Screen\hWindow, #TIMER_BalloonTip)"+ #CRLF$
      CodeText$ + "   EndSelect"                   + #CRLF$
      CodeText$ + "   ProcedureReturn Result"      + #CRLF$
      CodeText$ + "EndProcedure"                   + #CRLF$
      CodeText$ + #CRLF$
   EndIf 

   CodeText$ + ";挂钩事件"                      + #CRLF$
   CodeText$ + "Procedure Screen_HookGadget(hGadget, uMsg, wParam, lParam) "              + #CRLF$
   CodeText$ + "   With _Screen"                + #CRLF$
   CodeText$ + "      If \hCanvas <> hGadget"   + #CRLF$
   CodeText$ + "         ProcedureReturn DefWindowProc_(hGadget, uMsg, wParam, lParam)"   + #CRLF$
   CodeText$ + "      EndIf"                    + #CRLF$
   CodeText$ + "      Select uMsg "             + #CRLF$
   CodeText$ + "         Case #WM_MOUSEMOVE     : Result = Screen_Hook_MOUSEMOVE    (@lParam)"  + #CRLF$
   CodeText$ + "         Case #WM_LBUTTONDOWN   : Result = Screen_Hook_LBUTTONDOWN  (@lParam)"  + #CRLF$
   CodeText$ + "         Case #WM_LBUTTONUP     : Result = Screen_Hook_LBUTTONUP    (@lParam)"  + #CRLF$
   ;是否启用窗体大小调整
   If _Project\IsUseSizeWindow And _Project\IsUseSysMaximize
      CodeText$ + "         Case #WM_LBUTTONDBLCLK : Result = Screen_Hook_LBUTTONDBLCLK(@lParam)"  + #CRLF$
   EndIf 
   CodeText$ + "      EndSelect "               + #CRLF$
   CodeText$ + "      If Result = 0 "           + #CRLF$
   CodeText$ + "         Result = CallWindowProc_(\hGadgetHook, hGadget, uMsg, wParam, lParam) " + #CRLF$
   CodeText$ + "      EndIf"                    + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "   ProcedureReturn Result"      + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$

   If _Project\IsUseSizeWindow Or _Project\IsUseBalloonTip
      CodeText$ + ";挂钩事件"                      + #CRLF$
      CodeText$ + "Procedure Screen_HookWindow(hWindow, uMsg, wParam, lParam) "              + #CRLF$
      CodeText$ + "   With _Screen"                + #CRLF$
      CodeText$ + "      If \hWindow <> hWindow"   + #CRLF$
      CodeText$ + "         ProcedureReturn DefWindowProc_(hWindow, uMsg, wParam, lParam)"   + #CRLF$
      CodeText$ + "      EndIf"                    + #CRLF$
      CodeText$ + "      Select uMsg "             + #CRLF$
      CodeText$ + "         Case #WM_TIMER : Result = Screen_Hook_TIMER(wParam)"             + #CRLF$ 
      If _Project\IsUseSizeWindow
         CodeText$ + "         Case #WM_SIZE"                                          + #CRLF$
         If _Project\IsUseSysMaximize = #True
            CodeText$ + "            If wParam = 0 And \btnMaximize\IsHide = #True"       + #CRLF$
            CodeText$ + "               \btnNormalcy\IsHide = #True"                      + #CRLF$
            CodeText$ + "               \btnMaximize\IsHide = #False"                     + #CRLF$
            CodeText$ + "            EndIf"        + #CRLF$  
         EndIf 
         CodeText$ + "            SetTimer_ (\hWindow, #TIMER_SizeWindow, 10, #Null)"  + #CRLF$
      EndIf 
      CodeText$ + "      EndSelect "               + #CRLF$
      CodeText$ + "      If Result = 0 "           + #CRLF$
      CodeText$ + "         Result = CallWindowProc_(\hWindowHook, hWindow, uMsg, wParam, lParam) "   + #CRLF$
      CodeText$ + "      EndIf"                    + #CRLF$
      CodeText$ + "   EndWith"                     + #CRLF$
      CodeText$ + "   ProcedureReturn Result"      + #CRLF$
      CodeText$ + "EndProcedure"                   + #CRLF$
   EndIf 

   CodeText$ + #CRLF$
   CodeText$ + #CRLF$ 
   ProcedureReturn CodeText$
EndProcedure

;-
Procedure$ AutoCode_SystemButton_Circle(ImageID$)
   CodeText$ + "      "+ImageID$+" = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"                + #CRLF$
   CodeText$ + "      If StartVectorDrawing(ImageVectorOutput("+ImageID$+"))"  + #CRLF$
   CodeText$ + "         AddPathCircle(x+14, y+14, 15)"                 + #CRLF$
   CodeText$ + "         VectorSourceCircularGradient(x+14, y+14, 15)"  + #CRLF$
   CodeText$ + "         VectorSourceGradientColor($00000000, 0.00)"    + #CRLF$
   CodeText$ + "         VectorSourceGradientColor($00000000, 0.60)"    + #CRLF$
   CodeText$ + "         VectorSourceGradientColor($80000000, 0.80)"    + #CRLF$
   CodeText$ + "         VectorSourceGradientColor($80FFFFFF, 0.95)"    + #CRLF$
   CodeText$ + "         VectorSourceGradientColor($00000000, 1.00)"    + #CRLF$
   CodeText$ + "         FillPath() "           + #CRLF$
   CodeText$ + "         StopVectorDrawing()"   + #CRLF$
   CodeText$ + "      EndIf"                    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_SystemButton_Flat(ButtonImageID$, Color$)
   CodeText$ + "        "+ButtonImageID$+" = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
   CodeText$ + "        If StartDrawing(ImageOutput("+ButtonImageID$+"))"     + #CRLF$
   CodeText$ + "           DrawingMode(#PB_2DDrawing_AlphaBlend)"             + #CRLF$
   CodeText$ + "           "+LSet("Box(000, 000, \W, \H, "+Color$+")", 48, " ")+";背景渲染"   + #CRLF$
   CodeText$ + "           DrawAlphaImage(ImageID(\NormalcyID), 0, 0)"        + #CRLF$
   CodeText$ + "           StopDrawing()"    + #CRLF$
   CodeText$ + "        EndIf"               + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_SystemButton_Bread(ButtonImageID$, Color$)
   CodeText$ + "      "+ButtonImageID$+" = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
   CodeText$ + "      If StartDrawing(ImageOutput("+ButtonImageID$+"))"             + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                     + #CRLF$
   CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3, "+Color$+")     ;背景渲染" + #CRLF$
   CodeText$ + "         DrawAlphaImage(ImageID(\NormalcyID), 0, 0)"                + #CRLF$
   CodeText$ + "         StopDrawing()"         + #CRLF$
   CodeText$ + "      EndIf"                    + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_SystemButton_Cake(ButtonImageID$, Color$)
   CodeText$ + "      "+ButtonImageID$+" = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
   CodeText$ + "      If StartDrawing(ImageOutput("+ButtonImageID$+"))"       + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"               + #CRLF$
   CodeText$ + "         Circle(x+14, y+14, 10, "+Color$+")     ;背景渲染"    + #CRLF$
   CodeText$ + "         DrawAlphaImage(ImageID(TempImageID), 0, 0)"     + #CRLF$
   CodeText$ + "         StopDrawing()"            + #CRLF$
   CodeText$ + "      EndIf"                       + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ GenerateCode_Create_btnCloseBox()
   If _Project\IsUseSysCloseBox = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建关闭按键"                  + #CRLF$
   CodeText$ + "Procedure Create_btnCloseBox(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"               + #CRLF$
   CodeText$ + "      \IsCreate = #True"        + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"关闭窗体"+#DQUOTE$              + #CRLF$
   EndIf 
   CodeText$ + "      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf "    + #CRLF$      
   CodeText$ + "      *pColor.__ScreenColorInfo = @_Screen\DimColor[1]"             + #CRLF$
   CodeText$ + "      FontColor  = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)"  + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      CloseColor = (Alpha(#SysButton_CloseColor) << 23 & $FF000000) |(#SysButton_CloseColor & $FFFFFF)"  + #CRLF$   
         CodeText$ + "      \W = 40 : \H = 24 : i = (\W-9)/2 : j = (\H-10)/2"       + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"              + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"               + #CRLF$
         CodeText$ + "         LineXY(i+0, j+0, i+9+0, j+9, FontColor)"             + #CRLF$
         CodeText$ + "         LineXY(i+1, j+0, i+9+1, j+9, *pColor\FontColor)"     + #CRLF$
         CodeText$ + "         LineXY(i+2, j+0, i+9+2, j+9, FontColor)"             + #CRLF$
         CodeText$ + "         LineXY(i+0, j+9, i+9+0, j+0, FontColor)   "          + #CRLF$            
         CodeText$ + "         LineXY(i+1, j+9, i+9+1, j+0, *pColor\FontColor) "    + #CRLF$              
         CodeText$ + "         LineXY(i+2, j+9, i+9+2, j+0, FontColor) "            + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Flat("\MouseTopID", "#SysButton_CloseColor")
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Flat("\HoldDownID", "CloseColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      \W = 48 : \H = 23 : i = (\W-9)/2 : j = (\H-10)/2"       + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)" + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                             + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)"       + #CRLF$
         CodeText$ + "         BackColor (*pColor\ForeColor)"        + #CRLF$
         CodeText$ + "         FrontColor($000000)"                  + #CRLF$
         CodeText$ + "         LinearGradient(0, 0, 0, \H) "         + #CRLF$
         CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3)"      + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"       + #CRLF$
         CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor)"  + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"               + #CRLF$
         CodeText$ + "         LineXY(i+0, j+00, i+9+0, j+09, FontColor)"           + #CRLF$
         CodeText$ + "         LineXY(i+1, j+00, i+9+1, j+09, *pColor\FontColor)"   + #CRLF$
         CodeText$ + "         LineXY(i+2, j+00, i+9+2, j+09, FontColor)"           + #CRLF$
         CodeText$ + "         LineXY(i+0, j+09, i+9+0, j+00, FontColor)"           + #CRLF$
         CodeText$ + "         LineXY(i+1, j+09, i+9+1, j+00, *pColor\FontColor)"   + #CRLF$
         CodeText$ + "         LineXY(i+2, j+09, i+9+2, j+00, FontColor) "          + #CRLF$
         CodeText$ + "         StopDrawing()"         + #CRLF$
         CodeText$ + "      EndIf"                    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Bread("\MouseTopID", "#SysButton_CloseColor")
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Bread("\HoldDownID", "CloseColor")         
         
      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-12)/2"  + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                                        + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[X]符号"                    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"              + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"               + #CRLF$
         CodeText$ + "         LineXY(i+0, j+0, i+9+0, j+9, FontColor)"             + #CRLF$
         CodeText$ + "         LineXY(i+1, j+0, i+9+1, j+9, *pColor\FontColor)"     + #CRLF$
         CodeText$ + "         LineXY(i+2, j+0, i+9+2, j+9, FontColor)"             + #CRLF$
         CodeText$ + "         LineXY(i+0, j+9, i+9+0, j+0, FontColor)"             + #CRLF$       
         CodeText$ + "         LineXY(i+1, j+9, i+9+1, j+0, *pColor\FontColor) "    + #CRLF$              
         CodeText$ + "         LineXY(i+2, j+9, i+9+2, j+0, FontColor)"             + #CRLF$  
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\NormalcyID", "$E05060FF")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\MouseTopID", "$FF919BFF")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\HoldDownID", "$FF0D1CB5")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$         
   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ GenerateCode_Create_btnMinimize()
   If _Project\IsUseSysMinimize = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建最小化按键"                + #CRLF$
   CodeText$ + "Procedure Create_btnMinimize(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"               + #CRLF$
   CodeText$ + "      \IsCreate = #True"        + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"最小化窗体"+#DQUOTE$            + #CRLF$
   EndIf 
   CodeText$ + "      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf "    + #CRLF$      
   CodeText$ + "      *pColor.__ScreenColorInfo = @_Screen\DimColor[1]"             + #CRLF$
   CodeText$ + "      FontColor  = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)"  + #CRLF$
   CodeText$ + "      ForeColor  = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)"  + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      \W = 28 : \H = 22 : i = (\W-9)/2 : j = (\H-3)/2"    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                     + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)" + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"     + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"      + #CRLF$
         CodeText$ + "         Box(i, j+0, 09, 03, FontColor)"             + #CRLF$
         CodeText$ + "         Box(i, j+1, 09, 01, *pColor\FontColor)"     + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Flat("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Flat("\HoldDownID", "ForeColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      \W = 32 : \H = 23 : i = (\W-9)/2 : j = (\H-3)/2"         + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)"     + #CRLF$
         CodeText$ + "         BackColor (*pColor\ForeColor)"                        + #CRLF$
         CodeText$ + "         FrontColor($00000000)"                                + #CRLF$
         CodeText$ + "         LinearGradient(0, 0, 0, \H) "                         + #CRLF$
         CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3) "                     + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"     + #CRLF$
         CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor)"   + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                + #CRLF$
         CodeText$ + "         Box(i, j+0, 09, 03, FontColor)"                       + #CRLF$
         CodeText$ + "         Box(i, j+1, 09, 01, *pColor\FontColor)"               + #CRLF$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Bread("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Bread("\HoldDownID", "ForeColor")     

      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-09)/2 : j = (\H-03)/2"    + #CRLF$
         CodeText$ + "        "    + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                               + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[-]符号"                    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"     + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"      + #CRLF$
         CodeText$ + "         Box(i, j+0, 09, 03, FontColor)"             + #CRLF$
         CodeText$ + "         Box(i, j+1, 09, 01, *pColor\FontColor)"     + #CRLF$
         CodeText$ + "         StopDrawing()"                + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\NormalcyID", "$E020E080")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\MouseTopID", "$FF4ADF95")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\HoldDownID", "$FF048B48")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$   
   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ GenerateCode_Create_btnMaximize()
   If _Project\IsUseSysMaximize = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建最大化按键"                + #CRLF$
   CodeText$ + "Procedure Create_btnMaximize(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"               + #CRLF$
   CodeText$ + "      \IsCreate = #True"        + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"最大化窗体"+#DQUOTE$            + #CRLF$
   EndIf 
   CodeText$ + "      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf "    + #CRLF$      
   CodeText$ + "      *pColor.__ScreenColorInfo = @_Screen\DimColor[1]"             + #CRLF$
   CodeText$ + "      FontColor  = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)"  + #CRLF$
   CodeText$ + "      ForeColor  = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)"  + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      \W = 28 : \H = 22 : i = (\W-12)/2 : j = (\H-8)/2"                + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"       + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$
         CodeText$ + "         Box(i+00, j+00, 12, 08, *pColor\FontColor)"                   + #CRLF$
         CodeText$ + "         Box(i+01, j+00, 10, 08, FontColor)"                           + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Flat("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Flat("\HoldDownID", "ForeColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      \W = 32 : \H = 23 : i = (\W-12)/2 : j = (\H-8)/2"                + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)" + #CRLF$
         CodeText$ + "         BackColor (*pColor\ForeColor)"                                + #CRLF$
         CodeText$ + "         FrontColor($00000000)"                                        + #CRLF$
         CodeText$ + "         LinearGradient(0, 0, 0, \H) "                                 + #CRLF$
         CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3) "                             + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$
         CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor)  "         + #CRLF$
         CodeText$ + "         Box(i+00, j+00, 12, 08, *pColor\FontColor)"                   + #CRLF$
         CodeText$ + "         Box(i+01, j+00, 10, 08, FontColor)"                           + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Bread("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Bread("\HoldDownID", "ForeColor")   
         
      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-9)/2"  + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                                                    + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[□]符号"                                                      + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"                          + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"    + #CRLF$
         CodeText$ + "         Box(i+00, j+00, 12, 08, *pColor\FontColor)"                      + #CRLF$
         CodeText$ + "         Box(i+01, j+00, 10, 08, FontColor)"                              + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\NormalcyID", "$FFFF8060")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\MouseTopID", "$FFFFBA87")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\HoldDownID", "$FF993A22")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$  
   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ GenerateCode_Create_btnNormalcy()
   If _Project\IsUseSysNormalcy = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建正常化按键"                + #CRLF$
   CodeText$ + "Procedure Create_btnNormalcy(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"               + #CRLF$
   CodeText$ + "      \IsCreate = #True"        + #CRLF$
   CodeText$ + "      \IsHide   = #True"        + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"窗体正常化"+#DQUOTE$            + #CRLF$
   EndIf 
   CodeText$ + "      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf "    + #CRLF$      
   CodeText$ + "      *pColor.__ScreenColorInfo = @_Screen\DimColor[1]"             + #CRLF$
   CodeText$ + "      FontColor  = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)"  + #CRLF$
   CodeText$ + "      ForeColor  = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)"  + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      \W = 28 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2"               + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"       + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$
         CodeText$ + "         Box(i+05, j+00, 07, 06, *pColor\FontColor)"                   + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AllChannels) "                      + #CRLF$
         CodeText$ + "         Box(i+00, j+03, 09, 07, $0)"                                  + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$
         CodeText$ + "         Box(i+00, j+03, 09, 07, *pColor\FontColor)"                   + #CRLF$
         CodeText$ + "         Box(i+01, j+03, 07, 07, FontColor)  "                         + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Flat("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Flat("\HoldDownID", "ForeColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2"    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"                       + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$
         CodeText$ + "         Box(i+05, j+00, 07, 06, *pColor\FontColor)"                   + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AllChannels) "                      + #CRLF$
         CodeText$ + "         Box(i+00, j+03, 09, 07, $0)"                                  + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$
         CodeText$ + "         Box(i+00, j+03, 09, 07, *pColor\FontColor)"                   + #CRLF$
         CodeText$ + "         Box(i+01, j+03, 07, 07, FontColor)   "                        + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)" + #CRLF$
         CodeText$ + "         BackColor (*pColor\ForeColor)"                                + #CRLF$
         CodeText$ + "         FrontColor($00000000)"                                        + #CRLF$
         CodeText$ + "         LinearGradient(0, 0, 0, \H)"                                  + #CRLF$
         CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3)"                              + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$
         CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor) "          + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_Default)"                           + #CRLF$
         CodeText$ + "         DrawAlphaImage(ImageID(TempImageID), 0, 0)"                   + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Bread("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Bread("\HoldDownID", "ForeColor")   
         
      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-11)/2"    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                                                    + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[□□]符号"                                                    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"                          + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined) "   + #CRLF$
         CodeText$ + "         Box(i+05, j+00, 07, 06, *pColor\FontColor)"                      + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AllChannels) "                         + #CRLF$
         CodeText$ + "         Box(i+00, j+03, 09, 07, $0)"                                     + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"    + #CRLF$
         CodeText$ + "         Box(i+00, j+03, 09, 07, *pColor\FontColor)"                      + #CRLF$
         CodeText$ + "         Box(i+01, j+03, 07, 07, FontColor)  "                            + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\NormalcyID", "$FFFF8060")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\MouseTopID", "$FFFFBA87")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\HoldDownID", "$FF993A22")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$  
   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ GenerateCode_Create_btnSettings()
   If _Project\IsUseSysSettings = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建窗体设置按键"               + #CRLF$
   CodeText$ + "Procedure Create_btnSettings(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"              + #CRLF$
   CodeText$ + "      \IsCreate = #True"       + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"软件设置"+#DQUOTE$            + #CRLF$
   EndIf 
   CodeText$ + "      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf "    + #CRLF$      
   CodeText$ + "      *pColor.__ScreenColorInfo = @_Screen\DimColor[1]"             + #CRLF$
   CodeText$ + "      FontColor  = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)"  + #CRLF$
   CodeText$ + "      ForeColor  = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)"  + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      \W = 28 : \H = 22 : i = (\W-9)/2 : j = (\H-3)/2"    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                     + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)" + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"     + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"      + #CRLF$
         CodeText$ + "         Line(i+0, j+0, 07, 07, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+7, j+5, 06, -6, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+2, j+0, 05, 05, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+7, j+3, 04, -4, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+1, j+0, 06, 06, *pColor\FontColor)"  + #CRLF$
         CodeText$ + "         Line(i+7, j+4, 05, -5, *pColor\FontColor)"  + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Flat("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Flat("\HoldDownID", "ForeColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      \W = 32 : \H = 23 : i = (\W-9)/2 : j = (\H-3)/2"         + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)"     + #CRLF$
         CodeText$ + "         BackColor (*pColor\ForeColor)"                        + #CRLF$
         CodeText$ + "         FrontColor($00000000)"                                + #CRLF$
         CodeText$ + "         LinearGradient(0, 0, 0, \H) "                         + #CRLF$
         CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3) "                     + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"     + #CRLF$
         CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor)"   + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                + #CRLF$
         CodeText$ + "         Line(i+0, j+0, 07, 07, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+7, j+5, 06, -6, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+2, j+0, 05, 05, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+7, j+3, 04, -4, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+1, j+0, 06, 06, *pColor\FontColor)"  + #CRLF$
         CodeText$ + "         Line(i+7, j+4, 05, -5, *pColor\FontColor)"  + #CRLF$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Bread("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Bread("\HoldDownID", "ForeColor")     

      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-09)/2 : j = (\H-03)/2"    + #CRLF$
         CodeText$ + "        "    + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                               + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[V]符号"                    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"     + #CRLF$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"      + #CRLF$
         CodeText$ + "         Line(i+0, j+0, 07, 07, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+7, j+5, 06, -6, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+2, j+0, 05, 05, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+7, j+3, 04, -4, FontColor)"          + #CRLF$
         CodeText$ + "         Line(i+1, j+0, 06, 06, *pColor\FontColor)"  + #CRLF$
         CodeText$ + "         Line(i+7, j+4, 05, -5, *pColor\FontColor)"  + #CRLF$
         CodeText$ + "         StopDrawing()"                + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\NormalcyID", "$E020E080")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\MouseTopID", "$FF4ADF95")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        AutoCode_SystemButton_Cake("\HoldDownID", "$FF048B48")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$   
   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

;创建普通按键
Procedure$ GenerateCode_Create_btnGadget()
   If _Project\IsUseMessageBox = #False : ProcedureReturn : EndIf 
   CodeText$ + "Procedure Create_btnGadget(*pGadget.__GadgetInfo, X, Y, W, H, Text$)"    + #CRLF$
   CodeText$ + " "    + #CRLF$
   CodeText$ + "   With *pGadget"    + #CRLF$
   CodeText$ + "      \IsCreate = #True"    + #CRLF$
      
   *pColorMessage.__ScreenColorInfo = _Project\pMapColor("对话框按键")
   ChangeCurrentElement(_Project\ListColor(), *pColorMessage)
   Index = ListIndex(_Project\ListColor()) - 2
   CodeText$ + "      *pColor.__ScreenColorInfo = @_Screen\DimColor["+Str(Index)+"]"     + #CRLF$
   CodeText$ + "      HighColor = (Alpha(*pColor\HighColor) << 23 & $FF000000) |(*pColor\HighColor & $FFFFFF)"    + #CRLF$
   CodeText$ + "      \X = X : \Y = Y : \W = W : \H = H : \R = X+W : \B = Y+H"    + #CRLF$
   CodeText$ + "      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf "    + #CRLF$
   CodeText$ + "      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf "    + #CRLF$
   CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, W, H, 32, #PB_Image_Transparent)"    + #CRLF$
   CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"    + #CRLF$
   CodeText$ +           GenerateCode_Gradient(*pColorMessage, "0", "0", "\W", "\H")
   CodeText$ + "         DrawingMode(#PB_2DDrawing_Transparent)"    + #CRLF$
   CodeText$ + "         DrawingFont(FontID(#fntDefault))"    + #CRLF$
   CodeText$ + "         X = (W-TextWidth(Text$))/2"    + #CRLF$
   CodeText$ + "         Y = (H-TextHeight(Text$))/2"    + #CRLF$
   CodeText$ + "         DrawText(X+0, Y+0, Text$, *pColor\FontColor)"    + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)"    + #CRLF$
   CodeText$ + "         Box(0, 0, W, H, *pColor\SideColor)"    + #CRLF$
   CodeText$ + "         StopDrawing()"    + #CRLF$
   CodeText$ + "      EndIf"    + #CRLF$
   CodeText$ + "      "    + #CRLF$
   CodeText$ + "      \MouseTopID = CreateImage(#PB_Any, W, H, 32, #PB_Image_Transparent)"    + #CRLF$
   CodeText$ + "      If StartDrawing(ImageOutput(\MouseTopID))"    + #CRLF$
   CodeText$ + "         DrawAlphaImage(ImageID(\NormalcyID), 0, 0)"    + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)"    + #CRLF$
   CodeText$ + "         Box(0, 0, W, H, *pColor\HighColor)"    + #CRLF$
   CodeText$ + "         StopDrawing()"    + #CRLF$
   CodeText$ + "      EndIf"    + #CRLF$
   CodeText$ + "      "    + #CRLF$
   CodeText$ + "      \HoldDownID = CreateImage(#PB_Any, W, H, 32, #PB_Image_Transparent)"    + #CRLF$
   CodeText$ + "      If StartDrawing(ImageOutput(\HoldDownID))"    + #CRLF$
   CodeText$ + "         DrawAlphaImage(ImageID(\NormalcyID), 0, 0)"    + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)"    + #CRLF$
   CodeText$ + "         Box(0, 0, W, H, HighColor)"    + #CRLF$
   CodeText$ + "         StopDrawing()"    + #CRLF$
   CodeText$ + "      EndIf      "    + #CRLF$
   CodeText$ + "   EndWith"    + #CRLF$
   CodeText$ + "EndProcedure"  + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure


Procedure$ GenerateCode_Create()
   CodeText$ + ";-=========================="  + #CRLF$
   CodeText$ + ";-[Create]"                    + #CRLF$
   CodeText$ + GenerateCode_Create_btnCloseBox()
   CodeText$ + GenerateCode_Create_btnMinimize()
   CodeText$ + GenerateCode_Create_btnMaximize()
   CodeText$ + GenerateCode_Create_btnNormalcy()
   CodeText$ + GenerateCode_Create_btnSettings()
   CodeText$ + GenerateCode_Create_btnGadget()
   CodeText$ + ";注销控件"       + #CRLF$
   CodeText$ + "Procedure Create_Release(*pGadget.__GadgetInfo)"      + #CRLF$
   CodeText$ + "   If *pGadget = 0 : ProcedureReturn #False: EndIf"   + #CRLF$
   CodeText$ + "   If *pGadget\IsCreate = #False : ProcedureReturn #False: EndIf"                  + #CRLF$
   CodeText$ + "   With *pGadget"                                     + #CRLF$
   CodeText$ + "      \X = 0 : \Y = 0 : \R = 0: \B = 0 "              + #CRLF$
   CodeText$ + "      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf : \NormalcyID = 0"  + #CRLF$
   CodeText$ + "      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf : \MouseTopID = 0"  + #CRLF$
   CodeText$ + "      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf : \HoldDownID = 0"  + #CRLF$
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$

   CodeText$ + #CRLF$
   CodeText$ + #CRLF$ 
   ProcedureReturn CodeText$
EndProcedure


;-
Procedure$ GenerateCode_Message()
   If _Project\IsUseMessageBox = #False : ProcedureReturn : EndIf 
   CodeText$ + ";- =========================="  + #CRLF$
   CodeText$ + ";- [Message]"                   + #CRLF$
   CodeText$ + ";光标在上事件"                  + #CRLF$
   CodeText$ + "Procedure Message_Hook_MOUSEMOVE(*pMouse.POINTS)"    + #CRLF$
   CodeText$ + "   With _Message"               + #CRLF$
   CodeText$ + "      If     Macro_Gadget_InRect3(\btnMessageClose)  : *pEventGadget = \btnMessageClose"       + #CRLF$
   CodeText$ + "      ElseIf Macro_Gadget_InRect3(\btnMessageYes)    : *pEventGadget = \btnMessageYes"         + #CRLF$
   CodeText$ + "      ElseIf Macro_Gadget_InRect3(\btnMessageNo)     : *pEventGadget = \btnMessageNo"          + #CRLF$
   CodeText$ + "      ElseIf Macro_Gadget_InRect3(\btnMessageCancel) : *pEventGadget = \btnMessageCancel"      + #CRLF$
   CodeText$ + "      EndIf "                   + #CRLF$
   CodeText$ + "      ;整理响应事件"            + #CRLF$
   CodeText$ + "      If _Screen\pMouseTop <> *pEventGadget : _Screen\pMouseTop = *pEventGadget : Message_Redraw() : EndIf"    + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + ";左键按下事件"                  + #CRLF$
   CodeText$ + "Procedure Message_Hook_LBUTTONDOWN(*pMouse.POINTS)"                                            + #CRLF$
   CodeText$ + "   With _Message"               + #CRLF$
   CodeText$ + "      If     Macro_Gadget_InRect3(\btnMessageClose)  : *pEventGadget = \btnMessageClose"       + #CRLF$
   CodeText$ + "      ElseIf Macro_Gadget_InRect3(\btnMessageYes)    : *pEventGadget = \btnMessageYes"         + #CRLF$
   CodeText$ + "      ElseIf Macro_Gadget_InRect3(\btnMessageNo)     : *pEventGadget = \btnMessageNo"          + #CRLF$
   CodeText$ + "      ElseIf Macro_Gadget_InRect3(\btnMessageCancel) : *pEventGadget = \btnMessageCancel"      + #CRLF$
   CodeText$ + "      Else"                     + #CRLF$
   CodeText$ + "         SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)      "                       + #CRLF$
   CodeText$ + "      EndIf "                   + #CRLF$
   CodeText$ + "      ;整理响应事件"            + #CRLF$
   CodeText$ + "      If _Screen\pHoldDown <> *pEventGadget : _Screen\pHoldDown = *pEventGadget : Message_Redraw() : EndIf   "    + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + ";左键释放事件"                  + #CRLF$
   CodeText$ + "Procedure Message_Hook_LBUTTONUP(*pMouse.POINTS)"    + #CRLF$
   CodeText$ + "   With _Message"               + #CRLF$
   CodeText$ + "      If Macro_Gadget_InRect3(\btnMessageClose)"     + #CRLF$
   CodeText$ + "         If _Screen\pHoldDown = \btnMessageClose"    + #CRLF$
   CodeText$ + "            *pEventGadget = \btnMessageClose"        + #CRLF$
   CodeText$ + "            PostEvent(#PB_Event_Gadget, #winMessage, #btnMessageClose)"      + #CRLF$
   CodeText$ + "         EndIf "                + #CRLF$
   CodeText$ + "      ElseIf Macro_Gadget_InRect3(\btnMessageYes)"   + #CRLF$
   CodeText$ + "         If _Screen\pHoldDown = \btnMessageYes"      + #CRLF$
   CodeText$ + "            *pEventGadget = \btnMessageYes"          + #CRLF$
   CodeText$ + "            PostEvent(#PB_Event_Gadget, #winMessage, #btnMessageYes)"        + #CRLF$
   CodeText$ + "         EndIf"                 + #CRLF$
   CodeText$ + "      ElseIf Macro_Gadget_InRect3(\btnMessageNo)"    + #CRLF$
   CodeText$ + "         If _Screen\pHoldDown = \btnMessageNo"       + #CRLF$
   CodeText$ + "            *pEventGadget = \btnMessageNo"           + #CRLF$
   CodeText$ + "            PostEvent(#PB_Event_Gadget, #winMessage, #btnMessageNo)"         + #CRLF$
   CodeText$ + "         EndIf"                 + #CRLF$
   CodeText$ + "      ElseIf Macro_Gadget_InRect3(\btnMessageCancel)"+ #CRLF$
   CodeText$ + "         If _Screen\pHoldDown = \btnMessageCancel"   + #CRLF$
   CodeText$ + "            *pEventGadget = \btnMessageCancel"       + #CRLF$
   CodeText$ + "            PostEvent(#PB_Event_Gadget, #winMessage, #btnMessageCancel)"     + #CRLF$
   CodeText$ + "         EndIf"                 + #CRLF$
   CodeText$ + "      EndIf "                   + #CRLF$
   CodeText$ + "      ;整理响应事件"            + #CRLF$
   CodeText$ + "      If _Screen\pHoldDown Or _Screen\pHoldDown"     + #CRLF$
   CodeText$ + "         _Screen\pHoldDown = 0 : _Screen\pMouseTop = 0 : Message_Redraw()"   + #CRLF$
   CodeText$ + "      EndIf   "                 + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + ";挂钩事件"                      + #CRLF$
   CodeText$ + "Procedure Message_Hook(hWindow, uMsg, wParam, lParam) "    + #CRLF$
   CodeText$ + "   With _Message"               + #CRLF$
   CodeText$ + "      If \hWindow <> hWindow"   + #CRLF$
   CodeText$ + "         ProcedureReturn DefWindowProc_(hWindow, uMsg, wParam, lParam)"      + #CRLF$
   CodeText$ + "      EndIf"                    + #CRLF$
   CodeText$ + "      Select uMsg"              + #CRLF$
   CodeText$ + "         Case #WM_MOUSEMOVE     : Message_Hook_MOUSEMOVE  (@lParam)"         + #CRLF$
   CodeText$ + "         Case #WM_LBUTTONDOWN   : Message_Hook_LBUTTONDOWN(@lParam)"         + #CRLF$
   CodeText$ + "         Case #WM_LBUTTONUP     : Message_Hook_LBUTTONUP  (@lParam)"         + #CRLF$
   CodeText$ + "      EndSelect "               + #CRLF$
   CodeText$ + "      Result = CallWindowProc_(\hWindowHook, hWindow, uMsg, wParam, lParam)" + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "   ProcedureReturn Result"      + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$
   

   CodeText$ + ";绘制事件"                      + #CRLF$
   CodeText$ + "Procedure Message_Redraw()"     + #CRLF$
   CodeText$ + "   With _Message"            + #CRLF$
   CodeText$ + "      ;绘制与当前窗体与鼠标事件相关的界面"                                   + #CRLF$
   CodeText$ + "      ImageID = CreateImage(#PB_Any, \WindowW, \WindowH)"                    + #CRLF$
   CodeText$ + "      If StartDrawing(ImageOutput(ImageID))"                                 + #CRLF$
   *pColorWindow.__ScreenColorInfo = _Project\pMapColor("窗体布局")
   ChangeCurrentElement(_Project\ListColor(), *pColorWindow)
   Index = ListIndex(_Project\ListColor())
   CodeText$ + "         *pColor.__ScreenColorInfo = @_Screen\DimColor["+Str(Index)+"]"      + #CRLF$
   CodeText$ + "         DrawingFont(FontID(#fntDefault))"                                   + #CRLF$
   CodeText$ + "         Box(0, 0, \WindowW, \WindowH, *pColor\BackColor & $FFFFFF)"         + #CRLF$
   CodeText$ +           GenerateCode_Gradient(*pColorWindow, "0", "0", "\WindowW", "\WindowH")
   CodeText$ + "         Box(0, 0, \WindowW, \WindowH, *pColor\BackColor)"                   + #CRLF$
   CodeText$ + "         Box(1, \TitleH, 1, \WindowH-\TitleH-1, *pColor\HighColor)"          + #CRLF$
   CodeText$ + "         Box(1, \TitleH, \WindowW-1, 1, *pColor\HighColor)"                  + #CRLF$
   CodeText$ + #CRLF$
   *pColorCaption.__ScreenColorInfo = _Project\pMapColor("标题栏")
   ChangeCurrentElement(_Project\ListColor(), *pColorCaption)
   Index = ListIndex(_Project\ListColor())
   CodeText$ + "         *pColor.__ScreenColorInfo = @_Screen\DimColor["+Str(Index)+"]"      + #CRLF$
   CodeText$ +           GenerateCode_Gradient(*pColorCaption, "0", "0", "\WindowW", "\TitleH")
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                              + #CRLF$
   CodeText$ + "         Box(1, 0, 1, \TitleH, *pColor\HighColor)"                           + #CRLF$
   CodeText$ + "         Box(1, 1, \WindowW-1, 1, *pColor\HighColor)"                        + #CRLF$
   CodeText$ + "         Box(0, \TitleH-1, \WindowW, 1, *pColor\SideColor)"                  + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Transparent)"    + #CRLF$
   CodeText$ + "         If IsImage(_Screen\SoftwareIconID)"                                 + #CRLF$
   CodeText$ + "            DrawImage(ImageID(_Screen\SoftwareIconID), 10, (\TitleH-24)/2, 24, 24)"        + #CRLF$
   CodeText$ + "            DrawText(20+24, (\TitleH-TextHeight(\Title$))/2, \Title$, *pColor\FontColor)"  + #CRLF$
   CodeText$ + "         Else "                                                              + #CRLF$
   CodeText$ + "            DrawImage(_Screen\hDefaultIcon, 10, (\TitleH-24)/2, 24, 24)"     + #CRLF$
   CodeText$ + "            DrawText(20+24, (\TitleH-TextHeight(\Title$))/2, \Title$, *pColor\FontColor)"  + #CRLF$
   CodeText$ + "         EndIf "                      + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "         X = 40 : Y = \TitleH+10"     + #CRLF$
   CodeText$ + "         If \hMessageIcon"            + #CRLF$
   CodeText$ + "            X + 50 "                  + #CRLF$
   CodeText$ + "            If \NoticeH < 50 : Y = \TitleH+10 + (50-\NoticeH)/2 : EndIf "    + #CRLF$
   CodeText$ + "            DrawImage(\hMessageIcon, 40, \TitleH+(\WindowH-\TitleH-32-50)/2, 32, 32)"             + #CRLF$
   CodeText$ + "         EndIf "                      + #CRLF$
   CodeText$ + "         *pColor.__ScreenColorInfo = @_Screen\DimColor[0] "                  + #CRLF$
   CodeText$ + "         ForEach \ListText$()"        + #CRLF$
   CodeText$ + "            DrawText(X+0, Y+0, \ListText$(),*pColor\FontColor)"              + #CRLF$
   CodeText$ + "            Y + TextHeight(\ListText$()) + 5"                                + #CRLF$
   CodeText$ + "         Next "                       + #CRLF$
   CodeText$ + #CRLF$
   *pColorMessage.__ScreenColorInfo = _Project\pMapColor("对话框按键")
   ChangeCurrentElement(_Project\ListColor(), *pColorMessage)
   Index = ListIndex(_Project\ListColor()) - 2
   CodeText$ + "         *pColor.__ScreenColorInfo = @_Screen\DimColor["+Str(Index)+"]"      + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend) "                             + #CRLF$
   CodeText$ + "         ButtonX = \WindowW-1 - \btnMessageClose\W : ButtonY = 1  "          + #CRLF$
   CodeText$ + "         Redraw_Gadget(\btnMessageClose, ButtonX, ButtonY)"                  + #CRLF$
   CodeText$ + "         Redraw_Gadget(\btnMessageYes,   #PB_Ignore, #PB_Ignore)"            + #CRLF$
   CodeText$ + "         Redraw_Gadget(\btnMessageNo,    #PB_Ignore, #PB_Ignore)"            + #CRLF$
   CodeText$ + "         Redraw_Gadget(\btnMessageCancel,#PB_Ignore, #PB_Ignore)"            + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"       + #CRLF$
   *pColorWindow.__ScreenColorInfo = _Project\pMapColor("窗体布局")
   ChangeCurrentElement(_Project\ListColor(), *pColorWindow)
   Index = ListIndex(_Project\ListColor())
   CodeText$ + "         *pColor.__ScreenColorInfo = @_Screen\DimColor["+Str(Index)+"]"      + #CRLF$
   CodeText$ + "         Box(0, 0, \WindowW, \WindowH, *pColor\SideColor)  "                 + #CRLF$
   CodeText$ + "         StopDrawing()"               + #CRLF$
   CodeText$ + "      EndIf "                         + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "      ;将对话框图像渲染到窗体"        + #CRLF$
   CodeText$ + "      DeleteObject_(\hBackImage) "    + #CRLF$
   CodeText$ + "      If IsImage(ImageID)"            + #CRLF$
   CodeText$ + "         \hBackImage= CreatePatternBrush_(ImageID(ImageID))"                 + #CRLF$
   CodeText$ + "         If \hBackImage"              + #CRLF$
   CodeText$ + "            SetClassLongPtr_(\hWindow, #GCL_HBRBACKGROUND, \hBackImage)"     + #CRLF$
   CodeText$ + "            RedrawWindow_(\hWindow, #Null, #Null, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)"       + #CRLF$
   CodeText$ + "         EndIf "                      + #CRLF$
   CodeText$ + "      EndIf "                         + #CRLF$
   CodeText$ + "   EndWith"                           + #CRLF$
   CodeText$ + "EndProcedure"                         + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + ";初始化窗体"                          + #CRLF$
   CodeText$ + "Procedure Message_Requester(hWindow, Title$, Notice$, Flags=#PB_MessageRequester_Ok, IsEnable=#True)"   + #CRLF$
   CodeText$ + "   With _Message"                     + #CRLF$
   CodeText$ + "      If IsWindow(#winMessage) "      + #CRLF$
   CodeText$ + "         Create_Release(\btnMessageClose)"              + #CRLF$
   CodeText$ + "         Create_Release(\btnMessageYes)"                + #CRLF$
   CodeText$ + "         Create_Release(\btnMessageNo)"                 + #CRLF$
   CodeText$ + "         Create_Release(\btnMessageCancel)"             + #CRLF$
   CodeText$ + "         DeleteObject_ (\hBackImage)"                   + #CRLF$
   CodeText$ + "         ClearList(\ListText$())"                       + #CRLF$
   CodeText$ + "         If \hMessageIcon : DestroyIcon_(\hMessageIcon) : EndIf "            + #CRLF$
   CodeText$ + "         CloseWindow(#winMessage) "                     + #CRLF$
   CodeText$ + "      EndIf "                                           + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "      ;分割文本,并计算文本占用的最大宽度和最大高度"     + #CRLF$
   CodeText$ + "      TempImageID = CreateImage(#PB_Any, 100, 100)"     + #CRLF$
   CodeText$ + "      ClearList(\ListText$())"                          + #CRLF$
   CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"        + #CRLF$
   CodeText$ + "         DrawingFont(FontID(#fntDefault))"              + #CRLF$
   CodeText$ + "         For k = 1 To CountString(Notice$, #LF$)+1"     + #CRLF$
   CodeText$ + "            LineText$ = StringField(Notice$, k, #LF$)"  + #CRLF$
   CodeText$ + "            TextW = TextWidth(LineText$)"               + #CRLF$
   CodeText$ + "            If W < TextW : W = TextW : EndIf "          + #CRLF$
   CodeText$ + "            H + TextHeight(LineText$) + 5"              + #CRLF$
   CodeText$ + "            AddElement(\ListText$())"                   + #CRLF$
   CodeText$ + "            \ListText$() = LineText$"                   + #CRLF$
   CodeText$ + "         Next "                                         + #CRLF$
   CodeText$ + "         StopDrawing()"                                 + #CRLF$
   CodeText$ + "      EndIf"                                            + #CRLF$
   CodeText$ + "      FreeImage(TempImageID)"                           + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "      \NoticeH = H"                                     + #CRLF$
   CodeText$ + "      ;根据标志,定义按键名称及计算最小宽度"             + #CRLF$
   CodeText$ + "      Select Flags & $0F"                               + #CRLF$
   CodeText$ + "         Case #PB_MessageRequester_YesNo        : MinW = 240 : Button1$ = "+#DQUOTE$+"确认"+#DQUOTE$+" : Button2$ = "+#DQUOTE$+"取消"+#DQUOTE$ + #CRLF$
   CodeText$ + "         Case #PB_MessageRequester_YesNoCancel  : MinW = 340 : Button1$ = "+#DQUOTE$+"是"+#DQUOTE$+"   : Button2$ = "+#DQUOTE$+"否"+#DQUOTE$+"   : Button3$ = "+#DQUOTE$+"取消"+#DQUOTE$+ #CRLF$
   CodeText$ + "         Default : MinW = 100 : Button1$ = "+#DQUOTE$+"OK"+#DQUOTE$       + #CRLF$
   CodeText$ + "      EndSelect "                                       + #CRLF$
   CodeText$ + "      Select Flags & $F0"                               + #CRLF$
   CodeText$ + "         Case #PB_MessageRequester_Error    : W+50 : MinH = 50 : \hMessageIcon = ExtractIcon_(0, _Screen\SystemPath$+"+#DQUOTE$+"\User32.dll"+#DQUOTE$+", 3)"    + #CRLF$
   CodeText$ + "         Case $20                           : W+50 : MinH = 50 : \hMessageIcon = ExtractIcon_(0, _Screen\SystemPath$+"+#DQUOTE$+"\User32.dll"+#DQUOTE$+", 2)"    + #CRLF$
   CodeText$ + "         Case #PB_MessageRequester_Warning  : W+50 : MinH = 50 : \hMessageIcon = ExtractIcon_(0, _Screen\SystemPath$+"+#DQUOTE$+"\User32.dll"+#DQUOTE$+", 1)"    + #CRLF$
   CodeText$ + "         Case #PB_MessageRequester_Info     : W+50 : MinH = 50 : \hMessageIcon = ExtractIcon_(0, _Screen\SystemPath$+"+#DQUOTE$+"\User32.dll"+#DQUOTE$+", 4)"    + #CRLF$
   CodeText$ + "         Default : \hMessageIcon = 0  "                 + #CRLF$
   CodeText$ + "      EndSelect "                                       + #CRLF$
   CodeText$ + "      If W < MinW : W = MinW : EndIf"                   + #CRLF$
   CodeText$ + "      If H < MinH : H = MinH : EndIf"                   + #CRLF$
   CodeText$ + #CRLF$
   
   
   CodeText$ + "      ;计算对话框的宽度和高度"                   + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat  : CodeText$ + "      \TitleH = 30" + #CRLF$
      Case #ButtonStyle_Bread : CodeText$ + "      \TitleH = 30" + #CRLF$
      Case #ButtonStyle_Cake  : CodeText$ + "      \TitleH = 36" + #CRLF$
   EndSelect
   CodeText$ + "      W = W + 40 + 40  "              + #CRLF$
   CodeText$ + "      H = H + \TitleH + 20 + 50  "    + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "      ;创建对话框窗体"                + #CRLF$
   CodeText$ + "      hParent = hWindow"              + #CRLF$
   CodeText$ + "      \WindowW = W"                   + #CRLF$
   CodeText$ + "      \WindowH = H"                   + #CRLF$
   CodeText$ + "      \Flags   = Flags"               + #CRLF$
   CodeText$ + "      \Title$  = Title$"              + #CRLF$
   CodeText$ + "      \IsExitWindow = #False"         + #CRLF$
   CodeText$ + "      If hParent = 0"                 + #CRLF$
   CodeText$ + "         WindowFlags = #PB_Window_BorderLess|#PB_Window_ScreenCentered"                                    + #CRLF$
   CodeText$ + "         \hWindow = OpenWindow(#winMessage, 0, 0, W, H, "+#DQUOTE$+""+#DQUOTE$+", WindowFlags)"    + #CRLF$
   CodeText$ + "      Else "                                            + #CRLF$
   CodeText$ + "         WindowFlags = #PB_Window_BorderLess|#PB_Window_WindowCentered"                                    + #CRLF$
   CodeText$ + "         \hWindow = OpenWindow(#winMessage, 0, 0, W, H, "+#DQUOTE$+""+#DQUOTE$+", WindowFlags, hParent)"   + #CRLF$
   CodeText$ + "      EndIf"                                            + #CRLF$
   CodeText$ + "      Create_btnCloseBox(\btnMessageClose) "            + #CRLF$
   CodeText$ + "      Select \Flags & $0F"                              + #CRLF$
   CodeText$ + "         Case #PB_MessageRequester_YesNo"               + #CRLF$
   CodeText$ + "            Create_btnGadget (\btnMessageYes,   \WindowW/2-120, \WindowH-050, 100, 030, Button1$)"    + #CRLF$
   CodeText$ + "            Create_btnGadget (\btnMessageNo,    \WindowW/2+020, \WindowH-050, 100, 030, Button2$)"    + #CRLF$
   CodeText$ + "         Case  #PB_MessageRequester_YesNoCancel"        + #CRLF$
   CodeText$ + "            Create_btnGadget (\btnMessageYes,   \WindowW/2-170, \WindowH-050, 100, 030, Button1$)"    + #CRLF$
   CodeText$ + "            Create_btnGadget (\btnMessageNo,    \WindowW/2-050, \WindowH-050, 100, 030, Button2$)"    + #CRLF$
   CodeText$ + "            Create_btnGadget (\btnMessageCancel,\WindowW/2+070, \WindowH-050, 100, 030, Button3$)"    + #CRLF$
   CodeText$ + "         Default; #PB_MessageRequester_Ok"              + #CRLF$
   CodeText$ + "            Create_btnGadget (\btnMessageYes,   \WindowW/2-050, \WindowH-050, 100, 030, Button1$)"    + #CRLF$
   CodeText$ + "      EndSelect "                                       + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "      Message_Redraw()"                                 + #CRLF$
   CodeText$ + "      If IsEnable=#True"                                + #CRLF$
   CodeText$ + "         EnableWindow_(hParent, #False)  ;让父窗体不响应动作"                      + #CRLF$
   CodeText$ + "      EndIf "                                           + #CRLF$
   CodeText$ + "      \hWindowHook = SetWindowLongPtr_(\hWindow, #GWL_WNDPROC, @Message_Hook()) "  + #CRLF$
   CodeText$ + "      Repeat"                                           + #CRLF$
   CodeText$ + "         Select WindowEvent()"                          + #CRLF$
   CodeText$ + "            Case #PB_Event_CloseWindow   : \IsExitWindow = #True"                  + #CRLF$
   CodeText$ + "            Case #PB_Event_Gadget"                      + #CRLF$
   CodeText$ + "               Select EventGadget()"                    + #CRLF$
   CodeText$ + "                  Case #btnMessageClose  : \IsExitWindow = #True"                  + #CRLF$
   CodeText$ + "                  Case #btnMessageYes    : \IsExitWindow = #True : Result = #PB_MessageRequester_Yes"      + #CRLF$
   CodeText$ + "                  Case #btnMessageNo     : \IsExitWindow = #True : Result = #PB_MessageRequester_No"       + #CRLF$
   CodeText$ + "                  Case #btnMessageCancel : \IsExitWindow = #True : Result = #PB_MessageRequester_Cancel"   + #CRLF$
   CodeText$ + "               EndSelect"                   + #CRLF$
   CodeText$ + "            Default "                       + #CRLF$
   CodeText$ + "         EndSelect"                         + #CRLF$
   CodeText$ + "      Until \IsExitWindow = #True "         + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "      Create_Release(\btnMessageClose)"     + #CRLF$
   CodeText$ + "      Create_Release(\btnMessageYes)"       + #CRLF$
   CodeText$ + "      Create_Release(\btnMessageNo)"        + #CRLF$
   CodeText$ + "      Create_Release(\btnMessageCancel)"    + #CRLF$
   CodeText$ + "      DeleteObject_ (\hBackImage)"          + #CRLF$
   CodeText$ + "      ClearList(\ListText$())"              + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + "      If \hMessageIcon : DestroyIcon_(\hMessageIcon) : EndIf "      + #CRLF$
   CodeText$ + "      CloseWindow(#winMessage)"             + #CRLF$
   CodeText$ + "      If IsEnable=#True"                    + #CRLF$
   CodeText$ + "         EnableWindow_(hParent, #True)   ;恢复父窗体的响应动作"     + #CRLF$
   CodeText$ + "      EndIf "                               + #CRLF$
   CodeText$ + "   EndWith"                                 + #CRLF$
   CodeText$ + "   ProcedureReturn Result"                  + #CRLF$
   CodeText$ + "EndProcedure"                               + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure


Procedure$ GenerateCode_Common()
   CodeText$ + ";- =========================="  + #CRLF$
   CodeText$ + ";- [Common]"                    + #CRLF$
   CodeText$ + ";初始化资源"                    + #CRLF$
   CodeText$ + "Procedure Common_Initial()"              + #CRLF$

   If _Project\SoftwareIconID 
      Stuffix$ = LCase(GetExtensionPart(_Project\SoftwareIcon$))
      Select Stuffix$
         Case "bmp", "ico" : ;不无加载图像解析器
         Case "png" : CodeText$ + "   UsePNGImageDecoder()"       + #CRLF$
         Case "tga" : CodeText$ + "   UseTGAImageDecoder()"       + #CRLF$
         Case "tif" : CodeText$ + "   UseTIFFImageDecoder()"      + #CRLF$
         Case "jpg" : CodeText$ + "   UseJPEGImageDecoder()"      + #CRLF$
                      CodeText$ + "   UseJPEG2000ImageDecoder()"   + #CRLF$
      EndSelect
   EndIf 
   CodeText$ + "   LoadFont(#fntDefault, '宋体', 12)"    + #CRLF$

   CodeText$ + "   With _Screen"                + #CRLF$
   CodeText$ + "      CopyMemory_(\DimColor, ?_Bin_ScreenColor, 4*5*"+Str(ListSize(_Project\ListColor()))+")            ;获取颜色设置[DataSection]的指针"   + #CRLF$
   If _Project\SoftwareIconID 
      If _Project\IsUseIncludeIcon
         CodeText$ + "      \SoftwareIconID = CatchImage(#PB_Any, ?_BIN_SoftwareIcon)   ;加载软件图标"  + #CRLF$ 
      Else 
         CodeText$ + "      \SoftwareIconID = LoadImage(#PB_Any, #SoftwareIcon$)        ;加载软件图标"  + #CRLF$ 
      EndIf  
   EndIf 
   CodeText$ + "      \SystemPath$ = Space(255)"    + #CRLF$ 
   CodeText$ + "      Result = GetSystemDirectory_(@\SystemPath$,255)"    + #CRLF$
   CodeText$ + "      \hDefaultIcon = ExtractIcon_(0, \SystemPath$+"+#DQUOTE$+"\User32.dll"+#DQUOTE$+", 0)"    + #CRLF$
   If _Project\IsUseSizeWindow
      CodeText$ + #CRLF$
      CodeText$ + "   _Screen\hSizing    = LoadCursor_(0,#IDC_SIZENWSE) ;获取系统光标[左上-右下]"  + #CRLF$ 
      If _Project\WinSideL Or _Project\WinSideR
         CodeText$ + "   _Screen\hLeftRight = LoadCursor_(0,#IDC_SIZEWE)   ;获取系统光标[左-右]"   + #CRLF$ 
      EndIf 
      If _Project\WinSideT Or _Project\WinSideB
         CodeText$ + "   _Screen\hUpDown    = LoadCursor_(0,#IDC_SIZENS)   ;获取系统光标[上-下]"   + #CRLF$ 
      EndIf 
   EndIf 
   CodeText$ + "   EndWith"                              + #CRLF$
   CodeText$ + "EndProcedure"                            + #CRLF$
   CodeText$ + #CRLF$

   CodeText$ + ";注销/释放资源"                          + #CRLF$
   CodeText$ + "Procedure Common_Release()"              + #CRLF$
   CodeText$ + "   With _Screen"                         + #CRLF$
   CodeText$ + "      FreeFont(#fntDefault)            ;注销字体"         + #CRLF$
   If _Project\IsUseCanvasImage = #False           ;启用画布背景
      CodeText$ + "      FreeImage(#imgScreen)            ;注销背景图"       + #CRLF$
   EndIf 
   
   If _Project\SoftwareIconID 
      CodeText$ + "      If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf     ;注销软件图标"  + #CRLF$  
   EndIf 
   CodeText$ + "      DestroyIcon_(\hDefaultIcon)"   + #CRLF$
   If _Project\IsUseSizeWindow
      CodeText$ + #CRLF$
      CodeText$ + "      DestroyCursor_(\hSizing)         ;注销系统光标[左上-右下]"  + #CRLF$ 
      If _Project\WinSideL Or _Project\WinSideR
         CodeText$ + "      DestroyCursor_(\hLeftRight)      ;注销系统光标[左-右]"   + #CRLF$ 
      EndIf 
      If _Project\WinSideT Or _Project\WinSideB
         CodeText$ + "      DestroyCursor_(\hUpDown)         ;注销系统光标[上-下]"   + #CRLF$ 
      EndIf 
   EndIf 
   If _Project\IsUseSysCloseBox
      CodeText$ + "      Create_Release(\btnCloseBox)     ;注销关闭窗体小按键"       + #CRLF$
   EndIf 
   If _Project\IsUseSysMinimize
      CodeText$ + "      Create_Release(\btnMinimize)     ;注销最小化窗体小按键"     + #CRLF$
   EndIf 
   If _Project\IsUseSysNormalcy
      CodeText$ + "      Create_Release(\btnNormalcy)     ;注销正常化窗体小按键"     + #CRLF$
   EndIf    
   If _Project\IsUseSysMaximize
      CodeText$ + "      Create_Release(\btnMaximize)     ;注销最大化窗体小按键"     + #CRLF$
   EndIf  
   If _Project\IsUseSysSettings
      CodeText$ + "      Create_Release(\btnSettings)     ;注销窗体设置小按键"       + #CRLF$
   EndIf     
   If _Project\IsUseCanvasImage = #False           ;启用画布背景
      CodeText$ + "      DeleteObject_(\hBackImage)"        + #CRLF$
   EndIf 
  
   If _Project\IsUseBalloonTip
      CodeText$ + "      If _Balloon\hBackImage : DeleteObject_(_Balloon\hBackImage) : EndIf  ;释放提示文窗体背景句柄"       + #CRLF$
   EndIf 
   
   CodeText$ + "   EndWith"                              + #CRLF$
   CodeText$ + "EndProcedure"                            + #CRLF$
   CodeText$ + #CRLF$
   ;插入设置文件
   If _Project\IsUsePreference
      CodeText$ + ";加载设置文件"     + #CRLF$
      CodeText$ + "Procedure Common_LoadPrefer()"        + #CRLF$
      CodeText$ + "   OpenPreferences('设置.ini')"       + #CRLF$
      CodeText$ + "      With _Screen"                   + #CRLF$
      CodeText$ + "      PreferenceGroup('窗体设置')"    + #CRLF$
      CodeText$ + "         \WindowX = ReadPreferenceLong('WindowX', 0)"     + #CRLF$
      CodeText$ + "         \WindowY = ReadPreferenceLong('WindowY', 0)"     + #CRLF$
      CodeText$ + "         \WindowW = ReadPreferenceLong('WindowW', "+Str(_Project\WindowW)+")"   + #CRLF$
      CodeText$ + "         \WindowH = ReadPreferenceLong('WindowH', "+Str(_Project\WindowH)+")"   + #CRLF$
      CodeText$ + "   EndWith"                + #CRLF$
      CodeText$ + "   ClosePreferences()"     + #CRLF$
      CodeText$ + "EndProcedure"              + #CRLF$
      CodeText$ + #CRLF$
      CodeText$ + ";保存设置文件"            + #CRLF$
      CodeText$ + "Procedure Common_SavePrefer()"           + #CRLF$
      CodeText$ + "   If CreatePreferences('设置.ini')"     + #CRLF$
      CodeText$ + "      PreferenceComment('**********************************************')"     + #CRLF$
      CodeText$ + "      PreferenceComment('****** 这里标识一下工具名版本作者等信息 ******')"     + #CRLF$
      CodeText$ + "      PreferenceComment('**********************************************')"     + #CRLF$
      CodeText$ + "      PreferenceComment('')"             + #CRLF$
      CodeText$ + "      PreferenceComment('')"             + #CRLF$
      CodeText$ + "      PreferenceGroup('窗体设置')"       + #CRLF$
      CodeText$ + "         WritePreferenceLong('WindowX', WindowX(#winScreen))"    + #CRLF$
      CodeText$ + "         WritePreferenceLong('WindowY', WindowY(#winScreen))"    + #CRLF$
      CodeText$ + "         WritePreferenceLong('WindowW', _Screen\WindowW)"        + #CRLF$
      CodeText$ + "         WritePreferenceLong('WindowH', _Screen\WindowH)"        + #CRLF$
      CodeText$ + "      ClosePreferences()"    + #CRLF$
      CodeText$ + "   EndIf"                    + #CRLF$
      CodeText$ + "EndProcedure"                + #CRLF$
   EndIf 
   CodeText$ + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn ReplaceString(CodeText$, "'", #DQUOTE$)
EndProcedure

Procedure$ GenerateCode_MainProcess()
   CodeText$ + ";- ##########################"  + #CRLF$
   CodeText$ + ";- [Main]"                      + #CRLF$
   CodeText$ + "With _Screen"                   + #CRLF$
   CodeText$ + "   Common_Initial()                    ;初始化资源"           + #CRLF$
   If _Project\IsUsePreference
      CodeText$ + "   Common_LoadPrefer()                 ;加载设置文件"      + #CRLF$ 
   EndIf 

   CodeText$ + "   WindowFlags = #PB_Window_BorderLess|#PB_Window_ScreenCentered"   + #CRLF$ 
   CodeText$ + "   \WindowW = "+Str(_Project\WindowW)                + #CRLF$
   CodeText$ + "   \WindowH = "+Str(_Project\WindowH)                + #CRLF$                              
   CodeText$ + "   \hWindow = OpenWindow(#winScreen, 0, 0, \WindowW, \WindowH, "+#DQUOTE$+_Project\Caption$+#DQUOTE$+", WindowFlags)" + #CRLF$
   CodeText$ + "   \Title$  = GetWindowTitle(#winScreen)"                      + #CRLF$
   If _Project\IsUseCanvasImage = #True     ;启用画布背景
      CodeText$ + "   SetWindowColor(#winScreen, _Screen\DimColor[0]\BackColor & $FFFFFF)"      + #CRLF$ 
   Else   
      CodeText$ + "   ;这个结合Redraw_Screen()中注释掉的内容,可以实现对窗体刷新时,控件不闪烁."  + #CRLF$ 
      CodeText$ + "   ;ButtonGadget(1, 100, 100, 100, 050, "+#DQUOTE$+"测试按键"+#DQUOTE$+")"   + #CRLF$ 
      CodeText$ + "   ;ButtonGadget(2, 300, 100, 100, 050, "+#DQUOTE$+"测试按键"+#DQUOTE$+")"   + #CRLF$ 
   EndIf 
      
   If _Project\IsUseSysCloseBox
      CodeText$ + "   Create_btnCloseBox(\btnCloseBox)    ;创建关闭窗体小按键" + #CRLF$ 
   EndIf 
   If _Project\IsUseSysMinimize
      CodeText$ + "   Create_btnMinimize(\btnMinimize)    ;最小化窗体小按键"   + #CRLF$ 
   EndIf 
   If _Project\IsUseSysMaximize
      CodeText$ + "   Create_btnNormalcy(\btnNormalcy)    ;正常化窗体小按键"   + #CRLF$ 
   EndIf 
   If _Project\IsUseSysNormalcy
      CodeText$ + "   Create_btnMaximize(\btnMaximize)    ;最大化窗体小按键"   + #CRLF$ 
   EndIf 
   If _Project\IsUseSysSettings
      CodeText$ + "   Create_btnSettings(\btnSettings)    ;窗体设置小按键"     + #CRLF$ 
   EndIf
   
   ;使用画布后,用 EventGadget_cvsScreen() 替找 Screen_HookWindow().
   If _Project\IsUseCanvasImage = #True     ;启用画布背景
      CodeText$ + "   \hCanvas = CanvasGadget(#cvsScreen, 0, 0, \WindowW, \WindowH, #PB_Canvas_Container)"    + #CRLF$ 
      CodeText$ + "      ;这里可以添加所需要的控件..."                        + #CRLF$ 
      CodeText$ + "   CloseGadgetList()"                                      + #CRLF$ 
      CodeText$ + "   Redraw_Screen()"                                        + #CRLF$
      CodeText$ + "   \hGadgetHook = SetWindowLongPtr_(\hCanvas, #GWL_WNDPROC, @Screen_HookGadget())"  + #CRLF$ 
      If _Project\IsUseSizeWindow Or _Project\IsUseBalloonTip
         CodeText$ + "   \hWindowHook = SetWindowLongPtr_(\hWindow, #GWL_WNDPROC, @Screen_HookWindow())"  + #CRLF$    
      EndIf 
   Else    
      CodeText$ + "   Redraw_Screen()"                                        + #CRLF$
      CodeText$ + "   \hWindowHook = SetWindowLongPtr_(\hWindow, #GWL_WNDPROC, @Screen_HookWindow())"  + #CRLF$              
   EndIf
   

   CodeText$ + #CRLF$
   CodeText$ + "   Repeat"                                                    + #CRLF$
   CodeText$ + "      EventNum  = WindowEvent()"                              + #CRLF$
   CodeText$ + "      Select EventNum"                                        + #CRLF$
   
   If _Project\IsUseMessageBox
      CodeText$ + "         Case #PB_Event_CloseWindow"           + #CRLF$
      CodeText$ + "            Select EventWindow()"              + #CRLF$
      CodeText$ + "               Case #winScreen "               + #CRLF$
      CodeText$ + "                  Result = Message_Requester(\hWindow, "+#DQUOTE$+"迷路提示"+#DQUOTE$+", "+#DQUOTE$+"确定要关闭窗体么? "+#DQUOTE$+", #PB_MessageRequester_YesNo|$20)"  + #CRLF$
      CodeText$ + "                  If Result = #PB_MessageRequester_Yes"       + #CRLF$
      CodeText$ + "                     \IsExitWindow = #True"    + #CRLF$
      CodeText$ + "                  EndIf"                       + #CRLF$ 
      CodeText$ + "            EndSelect"                         + #CRLF$      
   Else 
      CodeText$ + "         Case #PB_Event_CloseWindow : \IsExitWindow = #True"  + #CRLF$
   EndIf
   CodeText$ + "         Case #Null"                                          + #CRLF$
   CodeText$ + "            If \pMouseTop Or \pHoldDown"                      + #CRLF$
   CodeText$ + "               GetCursorPos_(@Mouse.q) ;光标移境时,取消相应事件. "        + #CRLF$
   
   If _Project\IsUseCanvasImage = #True     ;启用画布背景
      CodeText$ + "               If WindowFromPoint_(Mouse) <> \hCanvas"  + #CRLF$
   Else 
      CodeText$ + "               If WindowFromPoint_(Mouse) <> \hWindow"                 + #CRLF$
   EndIf 
   
   CodeText$ + "                  \pMouseTop = 0 : \pHoldDown = 0 : Redraw_Screen()"      + #CRLF$
   CodeText$ + "               EndIf "                                        + #CRLF$
   CodeText$ + "            EndIf "                                           + #CRLF$
   CodeText$ + "      EndSelect"                                              + #CRLF$
   
   ;是否启用窗体大小调整
   If _Project\IsUseSizeWindow
      CodeText$ + "      If \IsSizeWindow = #True "                           + #CRLF$ 
      CodeText$ + "         KillTimer_(\hWindow, #TIMER_SizeWindow) "         + #CRLF$ 
      CodeText$ + "         \IsSizeWindow = #False"                           + #CRLF$ 
      CodeText$ + "      EndIf "                                              + #CRLF$ 
   EndIf 

   CodeText$ + "      Delay(1)   "                                             + #CRLF$
   CodeText$ + "   Until \IsExitWindow = #True "                               + #CRLF$
   CodeText$ + "   Common_Release()                    ;注销/释放资源"         + #CRLF$
   If _Project\IsUsePreference
      CodeText$ + "   Common_SavePrefer()                 ;保存设置文件"       + #CRLF$
   EndIf 
   CodeText$ + "EndWith"                                                       + #CRLF$
   CodeText$ + "End"                                                           + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ GenerateCode_DataSection()
   CodeText$ + ";- [DataSection]"                  + #CRLF$
   CodeText$ + "DataSection"                       + #CRLF$
   CodeText$ + "_Bin_ScreenColor:    ;背景色,前景色,字体色,边框色,高亮色" + #CRLF$
   
   ForEach _Project\ListColor()
      With _Project\ListColor()
         If _Project\ListColor()\ColorTable$ = "菜单栏" : Continue : EndIf 
         If _Project\ListColor()\ColorTable$ = "工作区" : Continue : EndIf 
         CodeText$ + "   Data.l "
         CodeText$ +   "$"+RSet(Hex(\BackColor, #PB_Long), 8, "0")
         CodeText$ + ", $"+RSet(Hex(\ForeColor, #PB_Long), 8, "0")
         CodeText$ + ", $"+RSet(Hex(\FontColor, #PB_Long), 8, "0")
         CodeText$ + ", $"+RSet(Hex(\SideColor, #PB_Long), 8, "0")
         CodeText$ + ", $"+RSet(Hex(\HighColor, #PB_Long), 8, "0")
         CodeText$ + "   ;"+_Project\ListColor()\ColorTable$+#CRLF$
      EndWith
   Next 
   If _Project\SoftwareIconID And _Project\IsUseIncludeIcon  
      CodeText$ + #CRLF$
      CodeText$ + "_BIN_SoftwareIcon:   ;软件图标文件"                     + #CRLF$ 
      CodeText$ + "   IncludeBinary "+#DQUOTE$+".\Software.ico"+#DQUOTE$   + #CRLF$ 
   EndIf 

   CodeText$ + "EndDataSection"  + #CRLF$
   CodeText$ + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure


;-
Procedure GenerateCode_Main()
   CodeText$ = ""
   CodeText$ + GenerateCode_Define()
   CodeText$ + GenerateCode_Macro()
   CodeText$ + GenerateCode_Redraw()
   CodeText$ + GenerateCode_BalloonTip()
   CodeText$ + GenerateCode_HookGadget()
   CodeText$ + GenerateCode_cvsScreen()
   CodeText$ + GenerateCode_Create()
   CodeText$ + GenerateCode_Message()
   CodeText$ + GenerateCode_Common()
   CodeText$ + GenerateCode_MainProcess()
   CodeText$ + GenerateCode_DataSection()
   SetGadgetText(#rtxSourceCode, CodeText$)
;    SetClipboardText(CodeText$)
EndProcedure















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 638
; FirstLine = 618
; Folding = -h--
; EnableXP
; Executable = 迷路代码库工具2.exe
; EnableUnicode