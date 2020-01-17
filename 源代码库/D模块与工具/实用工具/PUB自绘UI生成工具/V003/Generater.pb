



;- [Funtcion]
Procedure$ Function_Gradient(*pColor.__ScreenColorInfo, TextX$, TextY$, TextW$, TextH$)

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

Procedure$ Funtcion_SysButton_Circle(ImageID$)
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

Procedure$ Funtcion_SysButton_Flat(ButtonImageID$, Color$)
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

Procedure$ Funtcion_SysButton_Bread(ButtonImageID$, Color$)
   CodeText$ + "      "+ButtonImageID$+" = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
   CodeText$ + "      If StartDrawing(ImageOutput("+ButtonImageID$+"))"             + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                     + #CRLF$
   CodeText$ + "         RoundBox(0, -5, \W, \H+5, 3, 3, "+Color$+")     ;背景渲染" + #CRLF$
   CodeText$ + "         DrawAlphaImage(ImageID(\NormalcyID), 0, 0)"                + #CRLF$
   CodeText$ + "         StopDrawing()"         + #CRLF$
   CodeText$ + "      EndIf"                    + #CRLF$
   ProcedureReturn CodeText$
EndProcedure


Procedure$ Funtcion_SysButton_Piano(ButtonImageID$, Color$)
   CodeText$ + "      "+ButtonImageID$+" = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
   CodeText$ + "      If StartDrawing(ImageOutput("+ButtonImageID$+"))"             + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                     + #CRLF$
   CodeText$ + "         RoundBox(0, -5, \W-1, \H+5, 3, 3, "+Color$+")   ;背景渲染" + #CRLF$
   CodeText$ + "         DrawAlphaImage(ImageID(\NormalcyID), 0, 0)"                + #CRLF$
   CodeText$ + "         StopDrawing()"         + #CRLF$
   CodeText$ + "      EndIf"                    + #CRLF$
   ProcedureReturn CodeText$
EndProcedure


Procedure$ Funtcion_SysButton_Cake(ButtonImageID$, Color$)
   CodeText$ + "      "+ButtonImageID$+" = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
   CodeText$ + "      If StartDrawing(ImageOutput("+ButtonImageID$+"))"       + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"               + #CRLF$
   CodeText$ + "         Circle(x+14, y+14, 10, "+Color$+")     ;背景渲染"    + #CRLF$
   CodeText$ + "         DrawAlphaImage(ImageID(TempImageID), 0, 0)"     + #CRLF$
   CodeText$ + "         StopDrawing()"            + #CRLF$
   CodeText$ + "      EndIf"                       + #CRLF$
   ProcedureReturn CodeText$
EndProcedure


Procedure$ Funtcion_SysButton_Capsule(ButtonImageID$, BoxX$, BoxW$, Color$)
   CodeText$ + "      "+ButtonImageID$+" = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
   CodeText$ + "      If StartDrawing(ImageOutput("+ButtonImageID$+"))"             + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                     + #CRLF$
   If BoxX$ = "" And BoxW$ = ""
      CodeText$ + "         Box(-1, 0, \W+2, \H, "+Color$+")   ;背景渲染" + #CRLF$
   Else 
      CodeText$ + "         RoundBox("+BoxX$+", 0, "+BoxW$+", \H, ArcR, ArcR, "+Color$+")   ;背景渲染" + #CRLF$
   EndIf 
   CodeText$ + "         DrawAlphaImage(ImageID(\NormalcyID), 0, 0)"                + #CRLF$
   CodeText$ + "         StopDrawing()"         + #CRLF$
   CodeText$ + "      EndIf"                    + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

;-==========================
;- [Define]
Procedure$ AutoCode_Define_Constant()
   
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
         Case #ButtonStyle_Flat, #ButtonStyle_Bread, #ButtonStyle_Piano, #ButtonStyle_Capsule
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
      
      If \SoftwareIconID And \IsUseIncludeIcon = #False
         CodeText$ + "#SoftwareIcon$ = "+#DQUOTE$+\SoftwareIcon$ +#DQUOTE$     + #CRLF$  
      EndIf       
      
   EndWith
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Define_Structure()
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
      If \IsUseCanvasImage = #True          ;启用画布背景
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
         
      If _Project\IsUseSysStickyNO
         CodeText$ + "   btnStickyNO.__GadgetInfo   ;窗体置顶小按键"  + #CRLF$
         CodeText$ + "   btnStickyNC.__GadgetInfo   ;取消置顶小按键"  + #CRLF$
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
   ProcedureReturn CodeText$
EndProcedure

Procedure$ Generater_Define()
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
   CodeText$ + ";【注】源代码中的注释,采用<14号>[新宋体]<常规>样式进行对齐" + #CRLF$
   CodeText$ + AutoCode_Define_Constant()
   CodeText$ + AutoCode_Define_Structure()

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


;-==========================
;- [Macro]
Procedure$ Generater_Macro()

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



;-
Procedure$ Generater_EventGadget()
   If _Project\IsUseSystemDrop = #False : ProcedureReturn : EndIf 
   
   CodeText$ + ";- ##########################"  + #CRLF$
   CodeText$ + ";- [EventWindow]"               + #CRLF$
   If _Project\IsUseSystemDrop And _Project\IsUseMultiFiles
      CodeText$ + ";系统拖放文件事件[多文件模式]"         + #CRLF$
      CodeText$ + "Procedure Screen_DragDorpFile()"      + #CRLF$
      CodeText$ + "   DroppedID = EventwParam()"         + #CRLF$
      CodeText$ + "   GetCount = DragQueryFile_(DroppedID, -1, "+#DQUOTE$+#DQUOTE$+", 0)"        + #CRLF$ 
      CodeText$ + "   For k = 0 To GetCount - 1 "                                                + #CRLF$
      CodeText$ + "      LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)"            + #CRLF$  
      CodeText$ + "      FileName$ = Space(LenFileName)  "                             + #CRLF$
      CodeText$ + "      DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) "      + #CRLF$
      CodeText$ + "      FileSize = FileSize(FileName$)" + #CRLF$
      CodeText$ + "      If FileSize >= 0"               + #CRLF$
      CodeText$ + "         CountFiles + 1"              + #CRLF$
      CodeText$ + "         Debug FileName$     ;这里添加要处理的事件代码"              + #CRLF$
      CodeText$ + "      ElseIf FileSize = -2"           + #CRLF$
      CodeText$ + "         CountFiles + 1"              + #CRLF$
      CodeText$ + "         If Right(FileName$, 1) <> "+#DQUOTE$+"\"+#DQUOTE$+" : FileName$ = FileName$ + "+#DQUOTE$+"\"+#DQUOTE$+" : EndIf" + #CRLF$  
      CodeText$ + "         Debug FileName$     ;这里添加要处理的事件代码"              + #CRLF$
      CodeText$ + "      EndIf"                          + #CRLF$ 
      CodeText$ + "   Next "                             + #CRLF$
      CodeText$ + "   DragFinish_(DroppedID) "           + #CRLF$
      CodeText$ + "   If CountFiles "                    + #CRLF$
      CodeText$ + "      ;这里添加要处理的事件代码"       + #CRLF$
      CodeText$ + "   EndIf"                             + #CRLF$
      CodeText$ + "EndProcedure"                         + #CRLF$
   ElseIf _Project\IsUseSystemDrop
      CodeText$ + ";系统拖放文件事件[单文件模式]"         + #CRLF$
      CodeText$ + "Procedure Screen_DragDorpFile()"      + #CRLF$
      CodeText$ + "   DroppedID = EventwParam()"         + #CRLF$
      CodeText$ + "   CountFiles = DragQueryFile_(DroppedID, -1, "+#DQUOTE$+#DQUOTE$+", 0)"        + #CRLF$ 
      CodeText$ + "   If CountFiles"                                                   + #CRLF$
      CodeText$ + "      LenFileName  = DragQueryFile_(DroppedID, 0, 0, 0)"            + #CRLF$  
      CodeText$ + "      FileName$ = Space(LenFileName)  "                             + #CRLF$
      CodeText$ + "      DragQueryFile_(DroppedID, 0, FileName$, LenFileName+1) "      + #CRLF$
      CodeText$ + "   EndIf "                            + #CRLF$
      CodeText$ + "   DragFinish_(DroppedID) "           + #CRLF$
      CodeText$ + "   If FileSize(FileName$) >= 0 "      + #CRLF$
      CodeText$ + "      Debug FileName$     ;这里添加要处理的事件代码"                 + #CRLF$
      CodeText$ + "   EndIf"                             + #CRLF$
      CodeText$ + "EndProcedure"                         + #CRLF$
   EndIf 
   CodeText$ + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

;-

Procedure$ AutoCode_Common_Initial()
   With _Project
      CodeText$ + ";初始化资源"                    + #CRLF$
      CodeText$ + "Procedure Common_Initial()"              + #CRLF$
      If \SoftwareIconID 
         Stuffix$ = LCase(GetExtensionPart(\SoftwareIcon$))
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
      CodeText$ + "      CopyMemory_(\DimColor, ?_Bin_ScreenColor, 4*5*"+Str(ListSize(\ListColor()))+")            ;获取颜色设置[DataSection]的指针"   + #CRLF$
      If \SoftwareIconID 
         If \IsUseIncludeIcon
            CodeText$ + "      \SoftwareIconID = CatchImage(#PB_Any, ?_BIN_SoftwareIcon)   ;加载软件图标"  + #CRLF$ 
         Else 
            CodeText$ + "      \SoftwareIconID = LoadImage(#PB_Any, #SoftwareIcon$)        ;加载软件图标"  + #CRLF$ 
         EndIf  
      EndIf 
      CodeText$ + "      \SystemPath$ = Space(255)"    + #CRLF$ 
      CodeText$ + "      Result = GetSystemDirectory_(@\SystemPath$,255)"    + #CRLF$
      CodeText$ + "      \hDefaultIcon = ExtractIcon_(0, \SystemPath$+"+#DQUOTE$+"\User32.dll"+#DQUOTE$+", 0)"    + #CRLF$
      If \IsUseSizeWindow
         CodeText$ + #CRLF$
         CodeText$ + "   _Screen\hSizing    = LoadCursor_(0,#IDC_SIZENWSE) ;获取系统光标[左上-右下]"  + #CRLF$ 
         If \WinSideL Or \WinSideR
            CodeText$ + "   _Screen\hLeftRight = LoadCursor_(0,#IDC_SIZEWE)   ;获取系统光标[左-右]"   + #CRLF$ 
         EndIf 
         If \WinSideT Or \WinSideB
            CodeText$ + "   _Screen\hUpDown    = LoadCursor_(0,#IDC_SIZENS)   ;获取系统光标[上-下]"   + #CRLF$ 
         EndIf 
      EndIf 
      CodeText$ + "   EndWith"                              + #CRLF$
      CodeText$ + "EndProcedure"                            + #CRLF$
      CodeText$ + #CRLF$
   EndWith
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Common_Release()
   With _Project
      CodeText$ + ";注销/释放资源"                          + #CRLF$
      CodeText$ + "Procedure Common_Release()"              + #CRLF$
      CodeText$ + "   With _Screen"                         + #CRLF$
      CodeText$ + "      FreeFont(#fntDefault)            ;注销字体"         + #CRLF$
      If \IsUseCanvasImage = #False           ;启用画布背景
         CodeText$ + "      FreeImage(#imgScreen)            ;注销背景图"       + #CRLF$
      EndIf 
      
      If \SoftwareIconID 
         CodeText$ + "      If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf     ;注销软件图标"  + #CRLF$  
      EndIf 
      CodeText$ + "      DestroyIcon_(\hDefaultIcon)"   + #CRLF$
      If \IsUseSizeWindow
         CodeText$ + #CRLF$
         CodeText$ + "      DestroyCursor_(\hSizing)         ;注销系统光标[左上-右下]"  + #CRLF$ 
         If \WinSideL Or \WinSideR
            CodeText$ + "      DestroyCursor_(\hLeftRight)      ;注销系统光标[左-右]"   + #CRLF$ 
         EndIf 
         If \WinSideT Or \WinSideB
            CodeText$ + "      DestroyCursor_(\hUpDown)         ;注销系统光标[上-下]"   + #CRLF$ 
         EndIf 
      EndIf 
      If \IsUseSysCloseBox
         CodeText$ + "      Create_Release(\btnCloseBox)     ;注销关闭窗体小按键"       + #CRLF$
      EndIf 
      If \IsUseSysMinimize
         CodeText$ + "      Create_Release(\btnMinimize)     ;注销最小化窗体小按键"     + #CRLF$
      EndIf 
      If \IsUseSysNormalcy
         CodeText$ + "      Create_Release(\btnNormalcy)     ;注销正常化窗体小按键"     + #CRLF$
      EndIf    
      If \IsUseSysMaximize
         CodeText$ + "      Create_Release(\btnMaximize)     ;注销最大化窗体小按键"     + #CRLF$
      EndIf  
      If \IsUseSysSettings
         CodeText$ + "      Create_Release(\btnSettings)     ;注销窗体设置小按键"       + #CRLF$
      EndIf     
      
      If \IsUseSysStickyNO
         CodeText$ + "      Create_Release(\btnStickyNO)     ;注销窗体置顶小按键"       + #CRLF$
         CodeText$ + "      Create_Release(\btnStickyNC)     ;注销取消置顶小按键"       + #CRLF$
      EndIf    
      
      
      If \IsUseCanvasImage = #False           ;启用画布背景
         CodeText$ + "      DeleteObject_(\hBackImage)       ;注销窗体背景图像句柄"     + #CRLF$
      EndIf 
      If \IsUseSystemDrop = #True             ;系统拖放文件功能
         CodeText$ + "      DragFinish_(\hWindow)            ;注销系统拖放文件"         + #CRLF$
      EndIf 
      
      If \IsUseBalloonTip
         CodeText$ + "      If _Balloon\hBackImage : DeleteObject_(_Balloon\hBackImage) : EndIf  ;释放提示文窗体背景句柄"       + #CRLF$
      EndIf 
      
      CodeText$ + "   EndWith"                              + #CRLF$
      CodeText$ + "EndProcedure"                            + #CRLF$
      CodeText$ + #CRLF$
   EndWith
   ProcedureReturn CodeText$
EndProcedure
   
   
Procedure$ Generater_Common()
   CodeText$ + ";- =========================="  + #CRLF$
   CodeText$ + ";- [Common]"                    + #CRLF$
   CodeText$ + AutoCode_Common_Initial()
   CodeText$ + AutoCode_Common_Release()
   
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

;-

Procedure$ Generater_MainProcess()
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
   If _Project\IsUseSysStickyNO
      CodeText$ + "   Create_btnStickyNO(\btnStickyNO)    ;窗体置顶小按键"     + #CRLF$
      CodeText$ + "   Create_btnStickyNC(\btnStickyNC)    ;取消置顶小按键"     + #CRLF$
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
   
   If _Project\IsUseSystemDrop   ;启用系统文件拖放
      CodeText$ + "   DragAcceptFiles_(\hWindow, #True)   ;设置窗体界面是否支持系统拖放."  + #CRLF$ 
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
   If _Project\IsUseSystemDrop   ;启用系统文件拖放
      CodeText$ + "        Case #WM_DROPFILES          : Screen_DragDorpFile()"  + #CRLF$
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

Procedure$ Generater_DataSection()
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
XIncludeFile ".\AtuoCode_Screen.pb"
XIncludeFile ".\AtuoCode_Controls.pb"

Procedure GenerateCode_Main()
   CodeText$ = ""
   CodeText$ + Generater_Define()
   CodeText$ + Generater_Macro()
   CodeText$ + Generater_Redraw()
   CodeText$ + Generater_BalloonTip()
   CodeText$ + Generater_HookScreen()
   CodeText$ + Generater_HookCanvas()
   CodeText$ + Generater_Create()
   CodeText$ + Generater_Message()
   CodeText$ + Generater_EventGadget()
   CodeText$ + Generater_Common()
   CodeText$ + Generater_MainProcess()
   CodeText$ + Generater_DataSection()
   SetGadgetText(#rtxSourceCode, CodeText$)
EndProcedure















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 205
; FirstLine = 181
; Folding = 8vv-
; EnableXP
; Executable = 迷路代码库工具2.exe
; EnableUnicode