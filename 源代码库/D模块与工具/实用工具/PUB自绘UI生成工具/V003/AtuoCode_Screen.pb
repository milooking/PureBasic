




;-==========================
;- [Redraw]

Procedure$ AutoCode_Redraw_Gadget()
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
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Redraw_CaptionBar()
   If _Project\IsUseCaptionBar = 0 : ProcedureReturn : EndIf 
   *pColorCaption.__ScreenColorInfo = _Project\pMapColor("标题栏")
   ChangeCurrentElement(_Project\ListColor(), *pColorCaption)
   Index = ListIndex(_Project\ListColor())
   CodeText$ + "         ;绘制标题栏"         + #CRLF$
   CodeText$ + "         *pColor.__ScreenColorInfo = @\DimColor["+Str(Index)+"]"     + #CRLF$
   If _Project\CaptionX
      CodeText$ +           Function_Gradient(*pColorCaption, "#CaptionX", "0", "\WindowW-#CaptionX", "#CaptionH")
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
      CodeText$ +           Function_Gradient(*pColorCaption, "0", "0", "\WindowW", "#CaptionH")
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
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Redraw_IcoToolBar()
   With _Project
      If \IsUseIcoToolBar = #False : ProcedureReturn : EndIf 
      *pColorIcoTool.__ScreenColorInfo = \pMapColor("工具栏")
      ChangeCurrentElement(\ListColor(), *pColorIcoTool)
      Index = ListIndex(\ListColor())
      CodeText$ + "         ;绘制工具栏"         + #CRLF$
      CodeText$ + "         *pColor.__ScreenColorInfo = @\DimColor["+Str(Index)+"]"     + #CRLF$
      If (\CaptionX < \ToolBarW And \IsUseCaptionBar) Or \ToolBarY
         CodeText$ +           Function_Gradient(*pColorIcoTool, "0", "#ToolBarY", "#ToolBarW", "\WindowH-#ToolBarY")
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                                    + #CRLF$
         CodeText$ + "         Box(1, #ToolBarY, 1, \WindowH-#ToolBarY, *pColor\HighColor)"              + #CRLF$
         CodeText$ + "         Box(0, #ToolBarY, #ToolBarW, 1, *pColor\HighColor)"                       + #CRLF$
         CodeText$ + "         Box(#ToolBarW-1, #ToolBarY, 1, \WindowH-#ToolBarY, *pColor\SideColor)"    + #CRLF$
      Else 
         CodeText$ +           Function_Gradient(*pColorIcoTool, "0", "0", "#ToolBarW", "\WindowH")
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                  + #CRLF$
         CodeText$ + "         Box(1, 1, 1, \WindowH, *pColor\HighColor)"              + #CRLF$
         CodeText$ + "         Box(0, 1, #ToolBarW, 1, *pColor\HighColor)"             + #CRLF$
         CodeText$ + "         Box(#ToolBarW-1, 0, 1, \WindowH, *pColor\SideColor)"    + #CRLF$
      EndIf 
      CodeText$ + #CRLF$ 
   EndWith
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Redraw_StatusBar()
   With _Project
      If \IsUseStatusBar = #False : ProcedureReturn : EndIf 
      *pColorStatusBar.__ScreenColorInfo = \pMapColor("状态栏")
      ChangeCurrentElement(\ListColor(), *pColorStatusBar)
      Index = ListIndex(\ListColor())
      CodeText$ + "         ;绘制状态栏"         + #CRLF$
      CodeText$ + "         *pColor.__ScreenColorInfo = @\DimColor["+Str(Index)+"]"     + #CRLF$
      If \IsUseIcoToolBar Or \StatusX
         CodeText$ +           Function_Gradient(*pColorStatusBar, "#StatusX", "\WindowH-#StatusH", "\WindowW-#StatusX", "#StatusH")
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                                             + #CRLF$
         CodeText$ + "         Box(#StatusX, \WindowH-#StatusH+1, \WindowW-#StatusX-1, 1, *pColor\HighColor)"     + #CRLF$
         CodeText$ + "         Box(#StatusX, \WindowH-#StatusH+1, 1, #StatusH-2,          *pColor\HighColor)"     + #CRLF$
         CodeText$ + "         Box(#StatusX, \WindowH-#StatusH+0, \WindowW-#StatusX-0, 1, *pColor\SideColor)"     + #CRLF$
      ElseIf \IsUseIcoToolBar 
         CodeText$ +           Function_Gradient(*pColorStatusBar, "0", "\WindowH-#StatusH", "\WindowW", "#StatusH")
         CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                              + #CRLF$
         CodeText$ + "         Box(0, \WindowH-#StatusH+1, \WindowW-1, 1, *pColor\HighColor)"      + #CRLF$
         CodeText$ + "         Box(0, \WindowH-#StatusH+1, 1, #StatusH-2, *pColor\HighColor)"      + #CRLF$
         CodeText$ + "         Box(0, \WindowH-#StatusH+0, \WindowW,   1, *pColor\SideColor)"      + #CRLF$
         
      Else
         CodeText$ +           Function_Gradient(*pColorStatusBar, "0", "\WindowH-#StatusH", "\WindowW", "#StatusH")
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
   EndWith
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Redraw_SysButton()
   With _Project
      CodeText$ + "         ;绘制系统小按键"                               + #CRLF$
       ;系统按键风格
      Select \SystemButtonSylte 
         Case #ButtonStyle_Piano 
            CodeText$ + "         ButtonX = \WindowW-5-\btnCloseBox\W"        + #CRLF$
            CodeText$ + "         Redraw_Gadget(\btnCloseBox, ButtonX, 1)"    + #CRLF$
            If \IsUseSysNormalcy
               CodeText$ + "         ButtonX = ButtonX-\btnNormalcy\W"        + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnNormalcy, ButtonX, 1)" + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnMaximize, ButtonX, 1)" + #CRLF$
            EndIf 
            If \IsUseSysMinimize
               CodeText$ + "         ButtonX = ButtonX-\btnMinimize\W"        + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnMinimize, ButtonX, 1)" + #CRLF$
            EndIf 
            If \IsUseSysSettings
               CodeText$ + "         ButtonX = ButtonX-\btnSettings\W"        + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnSettings, ButtonX, 1)" + #CRLF$
            EndIf 
            If \IsUseSysStickyNO
               CodeText$ + "         ButtonX = ButtonX-\btnStickyNO\W"        + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnStickyNO, ButtonX, 1)" + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnStickyNC, ButtonX, 1)" + #CRLF$
            EndIf    
         
         Case #ButtonStyle_Capsule 
            CodeText$ + "         ButtonX = \WindowW-5-\btnCloseBox\W"        + #CRLF$
            CodeText$ + "         Redraw_Gadget(\btnCloseBox, ButtonX, 4)"    + #CRLF$
            If \IsUseSysNormalcy
               CodeText$ + "         ButtonX = ButtonX-\btnNormalcy\W"        + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnNormalcy, ButtonX, 4)" + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnMaximize, ButtonX, 4)" + #CRLF$
            EndIf 
            If \IsUseSysMinimize
               CodeText$ + "         ButtonX = ButtonX-\btnMinimize\W"        + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnMinimize, ButtonX, 4)" + #CRLF$
            EndIf 
            If \IsUseSysSettings
               CodeText$ + "         ButtonX = ButtonX-\btnSettings\W"        + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnSettings, ButtonX, 4)" + #CRLF$
            EndIf 
            If \IsUseSysStickyNO
               CodeText$ + "         ButtonX = ButtonX-\btnStickyNO\W"        + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnStickyNO, ButtonX, 4)" + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnStickyNC, ButtonX, 4)" + #CRLF$
            EndIf    
               
               
         Default
            CodeText$ + "         ButtonX = \WindowW-1-\btnCloseBox\W"        + #CRLF$
            CodeText$ + "         Redraw_Gadget(\btnCloseBox, ButtonX, 1)"    + #CRLF$
            If \IsUseSysNormalcy
               CodeText$ + "         ButtonX = ButtonX-1-\btnNormalcy\W"      + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnNormalcy, ButtonX, 1)" + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnMaximize, ButtonX, 1)" + #CRLF$
            EndIf 
            If \IsUseSysMinimize
               CodeText$ + "         ButtonX = ButtonX-1-\btnMinimize\W"      + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnMinimize, ButtonX, 1)" + #CRLF$
            EndIf 
            If \IsUseSysSettings
               CodeText$ + "         ButtonX = ButtonX-1-\btnSettings\W"      + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnSettings, ButtonX, 1)" + #CRLF$
            EndIf 
            If \IsUseSysStickyNO
               CodeText$ + "         ButtonX = ButtonX-1-\btnStickyNO\W"      + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnStickyNO, ButtonX, 1)" + #CRLF$
               CodeText$ + "         Redraw_Gadget(\btnStickyNC, ButtonX, 1)" + #CRLF$
            EndIf       
      EndSelect
      CodeText$ + #CRLF$ 
   EndWith
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Redraw_WindowSide()
   With _Project
      CodeText$ + "         ;绘制主界面边框"                                                 + #CRLF$
      CodeText$ + "         *pColor.__ScreenColorInfo = @\DimColor[0]"                       + #CRLF$
      CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"    + #CRLF$
      CodeText$ + "         Box(0,0,\WindowW, \WindowH, *pColor\SideColor)"                  + #CRLF$
      CodeText$ + "         DrawingMode(#PB_2DDrawing_AlphaBlend)"                           + #CRLF$
      If \IsUseCaptionBar And \IsUseStatusBar And \IsUseIcoToolBar
         CodeText$ + "         Box(#ToolBarW, #CaptionH, \WindowW-#ToolBarW-1, 1, *pColor\HighColor)"        + #CRLF$
         CodeText$ + "         Box(#ToolBarW, #CaptionH, 1, \WindowH-#CaptionH-#StatusH, *pColor\HighColor)" + #CRLF$
      ElseIf \IsUseCaptionBar And \IsUseStatusBar
         CodeText$ + "         Box(1, #CaptionH, \WindowW-2, 1, *pColor\HighColor)"                    + #CRLF$
         CodeText$ + "         Box(1, #CaptionH, 1, \WindowH-#CaptionH-#StatusH, *pColor\HighColor)"   + #CRLF$
      ElseIf \IsUseCaptionBar And \IsUseIcoToolBar
         CodeText$ + "         Box(#ToolBarW, #CaptionH, \WindowW-#ToolBarW-1, 1, *pColor\HighColor)"    + #CRLF$
         CodeText$ + "         Box(#ToolBarW, #CaptionH, 1, \WindowH-#CaptionH-1, *pColor\HighColor)"    + #CRLF$
      ElseIf \IsUseStatusBar And \IsUseIcoToolBar
         CodeText$ + "         Box(#ToolBarW, 1, \WindowW-#ToolBarW-1, 1, *pColor\HighColor)"   + #CRLF$
         CodeText$ + "         Box(#ToolBarW, 1, 1, \WindowH-1-#StatusH, *pColor\HighColor)"  + #CRLF$
      ElseIf \IsUseCaptionBar
         CodeText$ + "         Box(1, #CaptionH, \WindowW-2, 1, *pColor\HighColor)"           + #CRLF$
         CodeText$ + "         Box(1, #CaptionH, 1, \WindowH-#CaptionH-1, *pColor\HighColor)"   + #CRLF$
      ElseIf \IsUseStatusBar
         CodeText$ + "         Box(1, 1, \WindowW-2, 1, *pColor\HighColor)"          + #CRLF$
         CodeText$ + "         Box(1, 1, 1, \WindowH-1-#StatusH, *pColor\HighColor)" + #CRLF$
      ElseIf \IsUseIcoToolBar
         CodeText$ + "         Box(#ToolBarW, 1, \WindowW-#ToolBarW-1, 1, *pColor\HighColor)"   + #CRLF$
         CodeText$ + "         Box(#ToolBarW, 1, 1, \WindowH-2, *pColor\HighColor)"           + #CRLF$
      Else 
         CodeText$ + "         Box(1, 1, \WindowW-2, 1, *pColor\HighColor)"   + #CRLF$
         CodeText$ + "         Box(1, 1, 1, \WindowH-2, *pColor\HighColor)"   + #CRLF$
      EndIf 
      CodeText$ + "         StopDrawing()"               + #CRLF$
      CodeText$ + "      EndIf "                         + #CRLF$
   EndWith
   ProcedureReturn CodeText$
EndProcedure
   
Procedure$ Generater_Redraw()
   CodeText$ + ";- =========================="        + #CRLF$
   CodeText$ + ";- [Draw]"                            + #CRLF$
   CodeText$ + AutoCode_Redraw_Gadget()
   
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

   ;====== 窗体布局 ======
   *pColorWindow.__ScreenColorInfo = _Project\pMapColor("窗体布局")
   ChangeCurrentElement(_Project\ListColor(), *pColorWindow)
   Index = ListIndex(_Project\ListColor())
   CodeText$ + "         ;绘制窗体布局"         + #CRLF$
   CodeText$ + "         *pColor.__ScreenColorInfo = @\DimColor["+Str(Index)+"]"     + #CRLF$
   CodeText$ + "         DrawingMode(#PB_2DDrawing_Default)"            + #CRLF$ 
   CodeText$ + "         Box(0,0,\WindowW+200, \WindowH+200, *pColor\BackColor & $FFFFFF)"  + #CRLF$
   CodeText$ +           Function_Gradient(*pColorWindow, "0", "0", "\WindowW", "\WindowH")
   CodeText$ + #CRLF$   
   
   CodeText$ + AutoCode_Redraw_CaptionBar()  ; 标题栏 
   CodeText$ + AutoCode_Redraw_IcoToolBar()  ; 工具栏 
   CodeText$ + AutoCode_Redraw_StatusBar()   ; 状态栏 
   CodeText$ + AutoCode_Redraw_SysButton()   ; 系统小按键 
   CodeText$ + AutoCode_Redraw_WindowSide()  ; 绘制主界面边框

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


;-==========================
;- [Hook - Canvas]
Procedure$ HookScreen_MOUSEMOVE()
   With _Project
      CodeText$ + ";光标在上事件"                  + #CRLF$
      CodeText$ + "Procedure Screen_Hook_MOUSEMOVE(*pMouse.POINTS)"              + #CRLF$
      CodeText$ + "   With _Screen"  + #CRLF$
      CodeText$ + "      If     Macro_Gadget_InRect1(\btnCloseBox)  : *pEventGadget = \btnCloseBox"    + #CRLF$
      If \IsUseSysMinimize
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)  : *pEventGadget = \btnMinimize" + #CRLF$
      EndIf 
      If \IsUseSysNormalcy
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnNormalcy)  : *pEventGadget = \btnNormalcy" + #CRLF$
      EndIf 
      If \IsUseSysMaximize
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnMaximize)  : *pEventGadget = \btnMaximize" + #CRLF$
      EndIf 
      If \IsUseSysSettings
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)  : *pEventGadget = \btnSettings" + #CRLF$
      EndIf    
      
      If \IsUseSysStickyNO
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNO)  : *pEventGadget = \btnStickyNO" + #CRLF$
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNC)  : *pEventGadget = \btnStickyNC" + #CRLF$
      EndIf       
      
      
      ;是否启用窗体大小调整
      If \IsUseSizeWindow
         If \IsUseStatusBar
            CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#StatusH And *pMouse\Y >= \WindowH-#StatusH : SetCursor_(\hSizing)"     + #CRLF$
         Else 
            CodeText$ + "      ElseIf *pMouse\X >= \WindowW-25 And *pMouse\Y >= \WindowH-25 : SetCursor_(\hSizing)"                 + #CRLF$
         EndIf 
   
         If \WinSideL > 0  And \WinSideR > 0
            CodeText$ + "      ElseIf *pMouse\X <= #WinSideL Or *pMouse\X >= \WindowW-#WinSideR        : SetCursor_(\hLeftRight)"  + #CRLF$  
         ElseIf \WinSideR > 0  
            CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#WinSideR   : SetCursor_(\hLeftRight)"     + #CRLF$       
         ElseIf \WinSideL > 0 
            CodeText$ + "      ElseIf *pMouse\X <= #WinSideL            : SetCursor_(\hLeftRight)"     + #CRLF$  
         EndIf 
         If \WinSideT > 0  And \WinSideB > 0
            CodeText$ + "      ElseIf *pMouse\Y <= #WinSideT Or *pMouse\Y >= \WindowH-#WinSideB        : SetCursor_(\hUpDown)"     + #CRLF$      
         ElseIf \WinSideB > 0
            CodeText$ + "      ElseIf *pMouse\Y >= \WindowH-#WinSideB   : SetCursor_(\hUpDown)"        + #CRLF$     
         ElseIf \WinSideT > 0 
            CodeText$ + "      ElseIf *pMouse\Y <= #WinSideT            : SetCursor_(\hUpDown)"        + #CRLF$     
         EndIf 
      EndIf 
      
      CodeText$ + "      EndIf "                   + #CRLF$
      If \IsUseBalloonTip
         EventGadget$ = #Null$
         If \IsUseSysCloseBox
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnCloseBox"
         EndIf 
         If \IsUseSysMinimize
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnMinimize"
         EndIf 
         If \IsUseSysMaximize
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnMaximize"
         EndIf 
         If \IsUseSysNormalcy
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnNormalcy"
         EndIf
         If \IsUseSysSettings
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnSettings"
         EndIf      
         
         If \IsUseSysStickyNO
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnStickyNO, \btnStickyNC"
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
   EndWith
   ProcedureReturn CodeText$
EndProcedure

Procedure$ HookScreen_LBUTTONDOWN()
   With _Project
      CodeText$ + ";左键按下事件"                  + #CRLF$
      CodeText$ + "Procedure Screen_Hook_LBUTTONDOWN(*pMouse.POINTS)"            + #CRLF$
      CodeText$ + "   With _Screen"  + #CRLF$   
      If \IsUseBalloonTip
         CodeText$ + "      If _Balloon\pBalloonTip"                                      + #CRLF$ 
         CodeText$ + "         _Balloon\pBalloonTip = #Null"                              + #CRLF$ 
         CodeText$ + "         KillTimer_(hWindow, #TIMER_BalloonTip)"                    + #CRLF$ 
         CodeText$ + "         SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)"       + #CRLF$ 
         CodeText$ + "      EndIf"   + #CRLF$ 
         CodeText$ + #CRLF$
      EndIf 
      CodeText$ + "      If     Macro_Gadget_InRect1(\btnCloseBox)  : *pEventGadget = \btnCloseBox"      + #CRLF$
      If \IsUseSysMinimize
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)  : *pEventGadget = \btnMinimize"   + #CRLF$
      EndIf 
      If \IsUseSysNormalcy
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnNormalcy)  : *pEventGadget = \btnNormalcy"   + #CRLF$
      EndIf 
      If \IsUseSysMaximize
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnMaximize)  : *pEventGadget = \btnMaximize"   + #CRLF$
      EndIf 
      If \IsUseSysSettings
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)  : *pEventGadget = \btnSettings"   + #CRLF$
      EndIf 
      If \IsUseSysStickyNO
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNO)  : *pEventGadget = \btnStickyNO" + #CRLF$
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNC)  : *pEventGadget = \btnStickyNC" + #CRLF$
      EndIf    
      
      ;是否启用窗体大小调整
      If \IsUseSizeWindow
         If \IsUseStatusBar
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
   EndWith
   ProcedureReturn CodeText$
EndProcedure

Procedure$ HookScreen_LBUTTONUP()
   With _Project
      CodeText$ + ";左键释放事件"                  + #CRLF$
      CodeText$ + "Procedure Screen_Hook_LBUTTONUP(*pMouse.POINTS)"              + #CRLF$
      CodeText$ + "   With _Screen"  + #CRLF$   
      If \IsUseBalloonTip
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
      If \IsUseSysMinimize
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)"            + #CRLF$
         CodeText$ + "         *pEventGadget = \btnMinimize"                     + #CRLF$
         CodeText$ + "         If \pHoldDown = \btnMinimize : ShowWindow_(\hWindow, 2) : EndIf    ;最小化窗体"  + #CRLF$
      EndIf 
      If \IsUseSysMaximize
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
      If \IsUseSysNormalcy
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
      If \IsUseSysSettings
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)"              + #CRLF$
         CodeText$ + "         *pEventGadget = \btnSettings"                        + #CRLF$
      EndIf    
      
      If \IsUseSysStickyNO
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNO)"              + #CRLF$
         CodeText$ + "         *pEventGadget = \btnStickyNO"                        + #CRLF$
         CodeText$ + "         \btnStickyNO\IsHide = #True"                         + #CRLF$
         CodeText$ + "         \btnStickyNC\IsHide = #False"                        + #CRLF$
         CodeText$ + "         StickyWindow(#winScreen, #True) ;窗体置顶"           + #CRLF$
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNC)"              + #CRLF$
         CodeText$ + "         *pEventGadget = \btnStickyNC"                        + #CRLF$
         CodeText$ + "         \btnStickyNO\IsHide = #False"                        + #CRLF$
         CodeText$ + "         \btnStickyNC\IsHide = #True"                         + #CRLF$
         CodeText$ + "         StickyWindow(#winScreen, #False) ;取消置顶"          + #CRLF$
         
      EndIf    
      
      CodeText$ + "      EndIf "                   + #CRLF$
      CodeText$ + #CRLF$  
      CodeText$ + "      ;整理响应事件"            + #CRLF$
      CodeText$ + "      If \pHoldDown Or \pMouseTop : \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen() : EndIf" + #CRLF$
      CodeText$ + "   EndWith"                     + #CRLF$
      CodeText$ + "   ProcedureReturn Result"      + #CRLF$
      CodeText$ + "EndProcedure"                   + #CRLF$
      CodeText$ + #CRLF$
   EndWith
   ProcedureReturn CodeText$
EndProcedure
   
Procedure$ HookScreen_LBUTTONDBLCLK()
   ;是否启用窗体大小调整
   If _Project\IsUseSizeWindow = #False : ProcedureReturn : EndIf
   If _Project\IsUseSysMaximize = #False : ProcedureReturn : EndIf
   
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
   CodeText$ + "            \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen()"         + #CRLF$
   CodeText$ + "         Else "                                         + #CRLF$
   CodeText$ + "            \btnNormalcy\IsHide = #True"                + #CRLF$
   CodeText$ + "            \btnMaximize\IsHide = #False"               + #CRLF$
   CodeText$ + "            ShowWindow_(\hWindow,1)       ;正常化窗体"  + #CRLF$
   CodeText$ + "            \pHoldDown = 0"                             + #CRLF$
   CodeText$ + "            \WindowW = WindowWidth(#winScreen)"         + #CRLF$
   CodeText$ + "            \WindowH = WindowHeight(#winScreen)"        + #CRLF$
   CodeText$ + "            \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen()"         + #CRLF$
   CodeText$ + "         EndIf "                + #CRLF$
   CodeText$ + "      EndIf"                    + #CRLF$
   CodeText$ + "   EndWith"                     + #CRLF$
   CodeText$ + "   ProcedureReturn Result"      + #CRLF$
   CodeText$ + "EndProcedure"                   + #CRLF$
   CodeText$ + #CRLF$

EndProcedure

Procedure$ HookScreen_TIMER()
   
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
      CodeText$ + #CRLF$
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
      CodeText$ + #CRLF$
   EndIf 
   ProcedureReturn CodeText$
EndProcedure

;- [Hook - Canvas]
Procedure$ Generater_HookScreen()
   If _Project\IsUseCanvasImage = #True : ProcedureReturn : EndIf     ;启用画布背景
   CodeText$ + ";- =========================="  + #CRLF$
   CodeText$ + ";- [HOOK]"                      + #CRLF$
   CodeText$ + HookScreen_MOUSEMOVE()     ;光标在上事件
   CodeText$ + HookScreen_LBUTTONDOWN()   ;左键按下事件
   CodeText$ + HookScreen_LBUTTONUP()     ;左键释放事件
   CodeText$ + HookScreen_LBUTTONDBLCLK() ;双击事件
   CodeText$ + HookScreen_TIMER()         ;计时器事件
   
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


;-==========================
;- [Hook - Screen]
Procedure$ HookCanvas_MOUSEMOVE()
   With _Project
      CodeText$ + ";光标在上事件"                  + #CRLF$
      CodeText$ + "Procedure Screen_Hook_MOUSEMOVE(*pMouse.POINTS)"              + #CRLF$
      CodeText$ + "   With _Screen"  + #CRLF$
      CodeText$ + "      If     Macro_Gadget_InRect1(\btnCloseBox)  : *pEventGadget = \btnCloseBox"    + #CRLF$
      If \IsUseSysMinimize
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)  : *pEventGadget = \btnMinimize" + #CRLF$
      EndIf 
      If \IsUseSysNormalcy
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnNormalcy)  : *pEventGadget = \btnNormalcy" + #CRLF$
      EndIf 
      If \IsUseSysMaximize
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnMaximize)  : *pEventGadget = \btnMaximize" + #CRLF$
      EndIf 
      If \IsUseSysSettings
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)  : *pEventGadget = \btnSettings" + #CRLF$
      EndIf    
      If \IsUseSysStickyNO
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNO)  : *pEventGadget = \btnStickyNO" + #CRLF$
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNC)  : *pEventGadget = \btnStickyNC" + #CRLF$
      EndIf  
      
      ;是否启用窗体大小调整
      If \IsUseSizeWindow
         If \IsUseStatusBar
            CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#StatusH And *pMouse\Y >= \WindowH-#StatusH : SetCursor_(\hSizing)"     + #CRLF$
         Else 
            CodeText$ + "      ElseIf *pMouse\X >= \WindowW-25 And *pMouse\Y >= \WindowH-25 : SetCursor_(\hSizing)"                 + #CRLF$
         EndIf 
         If \WinSideL > 0  And \WinSideR > 0
            CodeText$ + "      ElseIf *pMouse\X <= #WinSideL Or *pMouse\X >= \WindowW-#WinSideR        : SetCursor_(\hLeftRight)"  + #CRLF$  
         ElseIf \WinSideR > 0  
            CodeText$ + "      ElseIf *pMouse\X >= \WindowW-#WinSideR   : SetCursor_(\hLeftRight)"     + #CRLF$       
         ElseIf \WinSideL > 0 
            CodeText$ + "      ElseIf *pMouse\X <= #WinSideL            : SetCursor_(\hLeftRight)"     + #CRLF$  
         EndIf 
         If \WinSideT > 0  And \WinSideB > 0
            CodeText$ + "      ElseIf *pMouse\Y <= #WinSideT Or *pMouse\Y >= \WindowH-#WinSideB        : SetCursor_(\hUpDown)"     + #CRLF$      
         ElseIf \WinSideB > 0
            CodeText$ + "      ElseIf *pMouse\Y >= \WindowH-#WinSideB   : SetCursor_(\hUpDown)"        + #CRLF$     
         ElseIf \WinSideT > 0 
            CodeText$ + "      ElseIf *pMouse\Y <= #WinSideT            : SetCursor_(\hUpDown)"        + #CRLF$     
         EndIf 
      EndIf 
      CodeText$ + "      EndIf "                                                                      + #CRLF$
   
      If \IsUseBalloonTip
         CodeText$ + #CRLF$  
         
         EventGadget$ = #Null$
         If \IsUseSysCloseBox
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnCloseBox"
         EndIf 
         If \IsUseSysMinimize
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnMinimize"
         EndIf 
         If \IsUseSysMaximize
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnMaximize"
         EndIf 
         If \IsUseSysNormalcy
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnNormalcy"
         EndIf
         If \IsUseSysSettings
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnSettings"
         EndIf    
         If \IsUseSysStickyNO
            If EventGadget$ <>  #Null$ : EventGadget$ + ", " : EndIf : EventGadget$ + "\btnStickyNO, \btnStickyNC"
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
   EndWith
   ProcedureReturn CodeText$
EndProcedure

Procedure$ HookCanvas_LBUTTONDOWN()
   With _Project
      CodeText$ + ";左键按下事件"                  + #CRLF$
      CodeText$ + "Procedure Screen_Hook_LBUTTONDOWN(*pMouse.POINTS)"            + #CRLF$
      CodeText$ + "   With _Screen"  + #CRLF$
      If \IsUseBalloonTip
         CodeText$ + "      If _Balloon\pBalloonTip"                                      + #CRLF$ 
         CodeText$ + "         _Balloon\pBalloonTip = #Null"                              + #CRLF$ 
         CodeText$ + "         KillTimer_(hWindow, #TIMER_BalloonTip)"                    + #CRLF$ 
         CodeText$ + "         SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)"       + #CRLF$ 
         CodeText$ + "      EndIf"   + #CRLF$ 
         CodeText$ + #CRLF$
      EndIf 
      CodeText$ + "      If     Macro_Gadget_InRect1(\btnCloseBox)  : *pEventGadget = \btnCloseBox"      + #CRLF$
      If \IsUseSysMinimize
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)  : *pEventGadget = \btnMinimize"   + #CRLF$
      EndIf 
      If \IsUseSysNormalcy
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnNormalcy)  : *pEventGadget = \btnNormalcy"   + #CRLF$
      EndIf 
      If \IsUseSysMaximize
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnMaximize)  : *pEventGadget = \btnMaximize"   + #CRLF$
      EndIf 
      If \IsUseSysSettings
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)  : *pEventGadget = \btnSettings"   + #CRLF$
      EndIf 
      If \IsUseSysStickyNO
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNO)  : *pEventGadget = \btnStickyNO" + #CRLF$
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNC)  : *pEventGadget = \btnStickyNC" + #CRLF$
      EndIf  
      
      ;是否启用窗体大小调整
      If \IsUseSizeWindow
         If \IsUseStatusBar
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
   EndWith
   ProcedureReturn CodeText$
EndProcedure

Procedure$ HookCanvas_LBUTTONUP()
   With _Project
      CodeText$ + ";左键释放事件"                  + #CRLF$
      CodeText$ + "Procedure Screen_Hook_LBUTTONUP(*pMouse.POINTS)"              + #CRLF$
      CodeText$ + "   With _Screen"  + #CRLF$   
      If \IsUseBalloonTip
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
      If \IsUseSysMinimize
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnMinimize)"            + #CRLF$
         CodeText$ + "         *pEventGadget = \btnMinimize"                     + #CRLF$
         CodeText$ + "         If \pHoldDown = \btnMinimize : ShowWindow_(\hWindow, 2) : EndIf    ;最小化窗体"  + #CRLF$
      EndIf 
      If \IsUseSysMaximize
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
      If \IsUseSysNormalcy
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
      If \IsUseSysSettings
         CodeText$ + "      ElseIf Macro_Gadget_InRect1(\btnSettings)"              + #CRLF$
         CodeText$ + "         *pEventGadget = \btnSettings"                        + #CRLF$
      EndIf    
      
      If \IsUseSysStickyNO
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNO)"              + #CRLF$
         CodeText$ + "         *pEventGadget = \btnStickyNO"                        + #CRLF$
         CodeText$ + "         \btnStickyNO\IsHide = #True"                         + #CRLF$
         CodeText$ + "         \btnStickyNC\IsHide = #False"                        + #CRLF$
         CodeText$ + "         StickyWindow(#winScreen, #True) ;窗体置顶"           + #CRLF$
         CodeText$ + "      ElseIf Macro_Gadget_InRect2(\btnStickyNC)"              + #CRLF$
         CodeText$ + "         *pEventGadget = \btnStickyNC"                        + #CRLF$
         CodeText$ + "         \btnStickyNO\IsHide = #False"                        + #CRLF$
         CodeText$ + "         \btnStickyNC\IsHide = #True"                         + #CRLF$
         CodeText$ + "         StickyWindow(#winScreen, #False) ;取消置顶"          + #CRLF$
      EndIf    
      
      CodeText$ + "      EndIf "                   + #CRLF$
      CodeText$ + #CRLF$  
      CodeText$ + "      ;整理响应事件"            + #CRLF$
      CodeText$ + "      If \pHoldDown Or \pMouseTop : \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen() : EndIf" + #CRLF$
      CodeText$ + "   EndWith"                     + #CRLF$
      CodeText$ + "   ProcedureReturn Result"      + #CRLF$
      CodeText$ + "EndProcedure"                   + #CRLF$
      CodeText$ + #CRLF$
   EndWith
   ProcedureReturn CodeText$
EndProcedure

Procedure$ HookCanvas_LBUTTONDBLCLK()
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
   ProcedureReturn CodeText$
EndProcedure

Procedure$ HookCanvas_TIMER()
   With _Project
      If \IsUseSizeWindow And \IsUseBalloonTip
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
   
      ElseIf \IsUseSizeWindow
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
      ElseIf \IsUseBalloonTip
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
   EndWith
   ProcedureReturn CodeText$
EndProcedure

;- [Hook - Screen]
Procedure$ Generater_HookCanvas()
   If _Project\IsUseCanvasImage = #False : ProcedureReturn : EndIf     ;启用画布背景
   CodeText$ + ";- =========================="  + #CRLF$
   CodeText$ + ";- [HOOK]"                      + #CRLF$
   CodeText$ + HookCanvas_MOUSEMOVE()        ;光标在上事件
   CodeText$ + HookCanvas_LBUTTONDOWN()      ;左键按下事件
   CodeText$ + HookCanvas_LBUTTONUP()        ;左键释放事件
   CodeText$ + HookCanvas_LBUTTONDBLCLK()    ;双击事件
   CodeText$ + HookCanvas_TIMER()            ;计时器事件

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





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 184
; FirstLine = 34
; Folding = wfe-
; EnableXP
; Executable = 迷路代码库工具2.exe
; EnableUnicode