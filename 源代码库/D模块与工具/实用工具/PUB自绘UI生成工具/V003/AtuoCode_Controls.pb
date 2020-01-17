


;- [Constant]

#SysButton_Preference$ = ""+
   "      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf "    + #CRLF$ +
   "      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf "    + #CRLF$ +
   "      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf "    + #CRLF$ +  
   "      *pColor.__ScreenColorInfo = @_Screen\DimColor[1]"             + #CRLF$ +
   "      FontColor  = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)"  + #CRLF$

#Graphics_btnCloseBox$ = "" +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend)"               + #CRLF$ +
   "         LineXY(i+0, j+0, i+9+0, j+9, FontColor)"             + #CRLF$ +
   "         LineXY(i+1, j+0, i+9+1, j+9, *pColor\FontColor)"     + #CRLF$ +
   "         LineXY(i+2, j+0, i+9+2, j+9, FontColor)"             + #CRLF$ +
   "         LineXY(i+0, j+9, i+9+0, j+0, FontColor)   "          + #CRLF$ +           
   "         LineXY(i+1, j+9, i+9+1, j+0, *pColor\FontColor) "    + #CRLF$ +             
   "         LineXY(i+2, j+9, i+9+2, j+0, FontColor) "            + #CRLF$

#Graphics_btnMinimize$ = "" +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend)"      + #CRLF$ +
   "         Box(i, j+0, 09, 03, FontColor)"             + #CRLF$ +
   "         Box(i, j+1, 09, 01, *pColor\FontColor)"     + #CRLF$

#Graphics_btnMaximize$ = "" +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$ +
   "         Box(i+00, j+00, 12, 08, *pColor\FontColor)"                   + #CRLF$ +
   "         Box(i+01, j+00, 10, 08, FontColor)"                           + #CRLF$

#Graphics_btnMaximize2$ = "" +
   "         Box(i+00, j+00, 12, 08, *pColor\FontColor)"                   + #CRLF$ +
   "         Box(i+01, j+00, 10, 08, FontColor)"                           + #CRLF$

#Graphics_btnNormalcy$ = "" +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$ +
   "         Box(i+05, j+00, 07, 06, *pColor\FontColor)"                   + #CRLF$ +
   "         DrawingMode(#PB_2DDrawing_AllChannels) "                      + #CRLF$ +
   "         Box(i+00, j+03, 09, 07, $0)"                                  + #CRLF$ +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$ +
   "         Box(i+00, j+03, 09, 07, *pColor\FontColor)"                   + #CRLF$ +
   "         Box(i+01, j+03, 07, 07, FontColor)  "                         + #CRLF$

#Graphics_btnSettings$ = "" +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend)"      + #CRLF$ +
   "         Line(i+0, j+0, 07, 07, FontColor)"          + #CRLF$ +
   "         Line(i+7, j+5, 06, -6, FontColor)"          + #CRLF$ +
   "         Line(i+2, j+0, 05, 05, FontColor)"          + #CRLF$ +
   "         Line(i+7, j+3, 04, -4, FontColor)"          + #CRLF$ +
   "         Line(i+1, j+0, 06, 06, *pColor\FontColor)"  + #CRLF$ +
   "         Line(i+7, j+4, 05, -5, *pColor\FontColor)"  + #CRLF$

#Graphics_btnStickyNO$ = "" +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend)"      + #CRLF$ +
   "         Line(i+00, j+4, 05, 01, *pColor\FontColor)" + #CRLF$ +
   "         Line(i+04, j+0, 01, 09, FontColor)"         + #CRLF$ +
   "         Line(i+05, j+0, 01, 09, *pColor\FontColor)" + #CRLF$ +
   "         Line(i+06, j+2, 07, 01, *pColor\FontColor)" + #CRLF$ +
   "         Line(i+06, j+5, 07, 01, FontColor)"         + #CRLF$ +
   "         Line(i+06, j+6, 07, 01, *pColor\FontColor)" + #CRLF$ +
   "         Line(i+12, j+3, 01, 03, FontColor)"         + #CRLF$ +
   "         Line(i+13, j+2, 01, 05, *pColor\FontColor)" + #CRLF$

#Graphics_btnStickyNC$ = "" +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend)"      + #CRLF$ +
   "         Line(i+02, j+0, 01, 06, *pColor\FontColor)" + #CRLF$ +
   "         Line(i+03, j+0, 05, 01, *pColor\FontColor)" + #CRLF$ +
   "         Line(i+07, j+1, 01, 05, FontColor)"         + #CRLF$ +
   "         Line(i+08, j+0, 01, 06, *pColor\FontColor)" + #CRLF$ +
   "         Line(i+00, j+6, 11, 01, *pColor\FontColor)" + #CRLF$ +
   "         Line(i+00, j+7, 11, 01, FontColor)"         + #CRLF$ +
   "         Line(i+05, j+7, 01, 03, *pColor\FontColor)" + #CRLF$

#Gradient_Bread$ = "" +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)" + #CRLF$ +
   "         BackColor (*pColor\ForeColor)"                                + #CRLF$ +
   "         FrontColor($000000)"                                          + #CRLF$ +
   "         LinearGradient(0, 0, 0, \H) "                                 + #CRLF$ +
   "         RoundBox(0, -5, \W, \H+5, 3, 3)"                              + #CRLF$ +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$ +
   "         RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor)"           + #CRLF$

#Gradient_Divide$ = "" +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)" + #CRLF$ +
   "         BackColor (*pColor\SideColor)"                                + #CRLF$ +
   "         FrontColor($000000)"                                          + #CRLF$ +
   "         LinearGradient(0, -5, 0, \H-5) "                              + #CRLF$ +
   "         Line(\W-1, 0, 1, \H-1, *pColor\SideColor)"                    + #CRLF$


#Gradient_Piano0$ = "" + ;中间
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)" + #CRLF$ +
   "         BackColor (*pColor\ForeColor)"                                + #CRLF$ +
   "         FrontColor($000000)"                                          + #CRLF$ +
   "         LinearGradient(0, 0, 0, \H) "                                 + #CRLF$ +
   "         Box(-1, -5, \W+2, \H+5)"                                      + #CRLF$ +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$ +
   "         Box(-1, -5, \W+2, \H+5, *pColor\SideColor)"                   + #CRLF$


#Gradient_Piano1$ = "" + ;右1
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)" + #CRLF$ +
   "         BackColor (*pColor\ForeColor)"                                + #CRLF$ +
   "         FrontColor($000000)"                                          + #CRLF$ +
   "         LinearGradient(0, 0, 0, \H) "                                 + #CRLF$ +
   "         RoundBox(-ArcR, -5, \W+ArcR, \H+5, 3, 3)"                     + #CRLF$ +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$ +
   "         RoundBox(-ArcR, -5, \W+ArcR, \H+5, 3, 3, *pColor\SideColor)"  + #CRLF$

#Gradient_Piano2$ = "" +  ;左右
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)" + #CRLF$ +
   "         BackColor (*pColor\ForeColor)"                                + #CRLF$ +
   "         FrontColor($000000)"                                          + #CRLF$ +
   "         LinearGradient(0, 0, 0, \H) "                                 + #CRLF$ +
   "         RoundBox(0, -5, \W, \H+5, 3, 3)"                              + #CRLF$ +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$ +
   "         RoundBox(0, -5, \W, \H+5, 3, 3, *pColor\SideColor)"           + #CRLF$


#Gradient_Piano3$ = "" +  ;左1
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)" + #CRLF$ +
   "         BackColor (*pColor\ForeColor)"                                + #CRLF$ +
   "         FrontColor($000000)"                                          + #CRLF$ +
   "         LinearGradient(0, 0, 0, \H) "                                 + #CRLF$ +
   "         RoundBox(0, -5, \W+ArcR, \H+5, 3, 3)"                         + #CRLF$ +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)" + #CRLF$ +
   "         RoundBox(0, -5, \W+ArcR, \H+5, 3, 3, *pColor\SideColor)"      + #CRLF$


#Gradient_Capsule0$ = "" + ;中间
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)"       + #CRLF$ +
   "         BackColor (*pColor\ForeColor)"                                      + #CRLF$ +
   "         FrontColor($000000)"                                                + #CRLF$ +
   "         LinearGradient(0, 0, 0, *pGadget\H)"                                + #CRLF$ +
   "         Box(-1, 0, \W+2, *pGadget\H)"                                       + #CRLF$ +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"       + #CRLF$ +
   "         Box(-1, 0, \W+2, *pGadget\H, *pColor\SideColor)"                    + #CRLF$

#Gradient_Capsule1$ = "" + ;右1
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)"       + #CRLF$ +
   "         BackColor (*pColor\ForeColor)"                                      + #CRLF$ +
   "         FrontColor($000000)"                                                + #CRLF$ +
   "         LinearGradient(0, 0, 0, *pGadget\H)"                                + #CRLF$ +
   "         RoundBox(-ArcR, 0, \W+ArcR, *pGadget\H, ArcR, ArcR)"                         + #CRLF$ +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"                + #CRLF$ +
   "         RoundBox(-ArcR, 0, \W+ArcR, *pGadget\H, ArcR-1, ArcR-1, SideColor)"          + #CRLF$ +
   "         RoundBox(-ArcR, 0, \W+ArcR, *pGadget\H, ArcR+2, ArcR+2, SideColor)"          + #CRLF$ +
   "         RoundBox(-ArcR, 0, \W+ArcR, *pGadget\H, ArcR+0, ArcR+0, *pColor\SideColor)"  + #CRLF$

#Gradient_Capsule2$ = "" +  ;左右
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)"       + #CRLF$ +
   "         BackColor (*pColor\ForeColor)"                                      + #CRLF$ +
   "         FrontColor($000000)"                                                + #CRLF$ +
   "         LinearGradient(0, 0, 0, *pGadget\H)"                                + #CRLF$ +
   "         RoundBox(0, 0, \W, *pGadget\H, ArcR, ArcR)"                         + #CRLF$ +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"       + #CRLF$ +
   "         RoundBox(0, 0, \W, *pGadget\H, ArcR-1, ArcR-1, SideColor)"          + #CRLF$ +
   "         RoundBox(0, 0, \W, *pGadget\H, ArcR+2, ArcR+2, SideColor)"          + #CRLF$ +
   "         RoundBox(0, 0, \W, *pGadget\H, ArcR+0, ArcR+0, *pColor\SideColor)"  + #CRLF$


#Gradient_Capsule3$ = "" +  ;左1
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)"       + #CRLF$ +
   "         BackColor (*pColor\ForeColor)"                                      + #CRLF$ +
   "         FrontColor($000000)"                                                + #CRLF$ +
   "         LinearGradient(0, 0, 0, *pGadget\H)"                                + #CRLF$ +
   "         RoundBox(0, 0, \W+ArcR, *pGadget\H, ArcR, ArcR)"                    + #CRLF$ +
   "         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)"             + #CRLF$ +
   "         RoundBox(0, 0, \W+ArcR, *pGadget\H, ArcR-1, ArcR-1, SideColor)"           + #CRLF$ +
   "         RoundBox(0, 0, \W+ArcR, *pGadget\H, ArcR+2, ArcR+2, SideColor)"           + #CRLF$ +
   "         RoundBox(0, 0, \W+ArcR, *pGadget\H, ArcR+0, ArcR+0, *pColor\SideColor)"   + #CRLF$

;-
;- [SystemButton]
Procedure$ AutoCode_Create_btnCloseBox()
   If _Project\IsUseSysCloseBox = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建关闭按键"                  + #CRLF$
   CodeText$ + "Procedure Create_btnCloseBox(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"               + #CRLF$
   CodeText$ + "      \IsCreate = #True"        + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"关闭窗体"+#DQUOTE$              + #CRLF$
   EndIf 
   CodeText$ + #SysButton_Preference$ 
        
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      CloseColor = (Alpha(#SysButton_CloseColor) << 23 & $FF000000) |(#SysButton_CloseColor & $FFFFFF)"  + #CRLF$   
         CodeText$ + "      \W = 40 : \H = 24 : i = (\W-09)/2 : j = (\H-10)/2"       + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"              + #CRLF$
         CodeText$ +           #Graphics_btnCloseBox$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\MouseTopID", "#SysButton_CloseColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\HoldDownID", "CloseColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      CloseColor = (Alpha(#SysButton_CloseColor) << 23 & $FF000000) |(#SysButton_CloseColor & $FFFFFF)"  + #CRLF$   
         CodeText$ + "      \W = 48 : \H = 22 : i = (\W-09)/2 : j = (\H-10)/2"       + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)" + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                             + #CRLF$
         CodeText$ +           #Gradient_Bread$
         CodeText$ +           #Graphics_btnCloseBox$
         CodeText$ + "         StopDrawing()"         + #CRLF$
         CodeText$ + "      EndIf"                    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\MouseTopID", "#SysButton_CloseColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\HoldDownID", "CloseColor")         

   Case #ButtonStyle_Piano
         CodeText$ + "      CloseColor = (Alpha(#SysButton_CloseColor) << 23 & $FF000000) |(#SysButton_CloseColor & $FFFFFF)"  + #CRLF$   
         If _Project\IsUseSysMinimize Or _Project\IsUseSysMaximize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
            CodeText$ + "      ArcR = 5 : \W = 48 : \H = 22 : i = (\W-09)/2 : j = (\H-10)/2" + #CRLF$
            Gradient_Piano$ = #Gradient_Piano1$
         Else 
            CodeText$ + "      ArcR = 5 : \W = 48+ArcR  : \H = 22 : i = (\W+ArcR-09)/2 : j = (\H-10)/2" + #CRLF$
            Gradient_Piano$ = #Gradient_Piano2$
         EndIf 
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)" + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                             + #CRLF$
         CodeText$ +           Gradient_Piano$
         CodeText$ +           #Graphics_btnCloseBox$
         CodeText$ + "         StopDrawing()"         + #CRLF$
         CodeText$ + "      EndIf"                    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\MouseTopID", "#SysButton_CloseColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\HoldDownID", "CloseColor")   

      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-12)/2"  + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                                        + #CRLF$
         CodeText$ +        Funtcion_SysButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[X]符号"                    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"              + #CRLF$
         CodeText$ +           #Graphics_btnCloseBox$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\NormalcyID", "$E05060FF")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\MouseTopID", "$FF919BFF")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\HoldDownID", "$FF0D1CB5")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$   
         
      Case #ButtonStyle_Capsule
         CodeText$ + "      CloseColor = (Alpha(#SysButton_CloseColor) << 23 & $FF000000) |(#SysButton_CloseColor & $FFFFFF)"  + #CRLF$   
         If _Project\IsUseSysMinimize Or _Project\IsUseSysMaximize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
            CodeText$ + "      \W = 48 : \H = 24 : ArcR = \H/2 : i = (\W-09-ArcR)/2 : j = (\H-10)/2" + #CRLF$
            Gradient_Capsule$ = #Gradient_Capsule1$
            BoxX$ = "-ArcR"
            BoxW$ = "\W+ArcR"
         Else 
            CodeText$ + "      \H = 24 : ArcR = \H/2 : \W = 48+ArcR : i = (\W+ArcR-09)/2 : j = (\H-10)/2" + #CRLF$
            Gradient_Capsule$ = #Gradient_Capsule2$
            BoxX$ = "0"
            BoxW$ = "\W"
         EndIf 
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)" + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                             + #CRLF$
         CodeText$ +           Gradient_Capsule$
         CodeText$ +           #Graphics_btnCloseBox$
         CodeText$ + "         StopDrawing()"         + #CRLF$
         CodeText$ + "      EndIf"                    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\MouseTopID", BoxX$, BoxW$, "#SysButton_CloseColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\HoldDownID", BoxX$, BoxW$, "CloseColor")   

   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Create_btnMinimize()
   If _Project\IsUseSysMinimize = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建最小化按键"                + #CRLF$
   CodeText$ + "Procedure Create_btnMinimize(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"               + #CRLF$
   CodeText$ + "      \IsCreate = #True"        + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"最小化窗体"+#DQUOTE$            + #CRLF$
   EndIf 
   CodeText$ + #SysButton_Preference$   
   CodeText$ + "      ForeColor  = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)"  + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      \W = 28 : \H = 22 : i = (\W-09)/2 : j = (\H-03)/2"    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                     + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)" + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"     + #CRLF$
         CodeText$ +           #Graphics_btnMinimize$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\HoldDownID", "ForeColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      \W = 32 : \H = 22 : i = (\W-09)/2 : j = (\H-03)/2"         + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           #Gradient_Bread$
         CodeText$ +           #Graphics_btnMinimize$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\HoldDownID", "ForeColor")     

      Case #ButtonStyle_Piano
         If _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
            CodeText$ + "      \W = 32 : \H = 22 : i = (\W-09)/2 : j = (\H-03)/2" + #CRLF$
            Gradient_Piano$ = #Gradient_Piano0$
         Else 
            CodeText$ + "      ArcR = 5 : \W = 32+ArcR  : \H = 22 : i = (\W+ArcR-09)/2-3 : j = (\H-03)/2" + #CRLF$
            Gradient_Piano$ = #Gradient_Piano3$
         EndIf 
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           Gradient_Piano$
         CodeText$ +           #Gradient_Divide$
         CodeText$ +           #Graphics_btnMinimize$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\HoldDownID", "ForeColor")     
      
      
      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-09)/2 : j = (\H-03)/2"    + #CRLF$
         CodeText$ + "        "    + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                               + #CRLF$
         CodeText$ +        Funtcion_SysButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[-]符号"                    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"     + #CRLF$
         CodeText$ +           #Graphics_btnMinimize$
         CodeText$ + "         StopDrawing()"                + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\NormalcyID", "$E020E080")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\MouseTopID", "$FF4ADF95")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\HoldDownID", "$FF048B48")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$  
         
      Case #ButtonStyle_Capsule
         If _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
            CodeText$ + "      \W = 32 : \H = 24 : i = (\W-09)/2 : j = (\H-03)/2" + #CRLF$
            Gradient_Capsule$ = #Gradient_Capsule0$
            BoxX$ = ""
            BoxW$ = ""
         Else 
            CodeText$ + "      \H = 24 : ArcR = \H/2 : \W = 32+ArcR : i = (\W+ArcR-09)/2-3 : j = (\H-03)/2" + #CRLF$
            Gradient_Capsule$ = #Gradient_Capsule3$
            BoxX$ = "0"
            BoxW$ = "\W+ArcR"
         EndIf 
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           Gradient_Capsule$
         CodeText$ +           #Graphics_btnMinimize$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\MouseTopID", BoxX$, BoxW$, "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\HoldDownID", BoxX$, BoxW$, "ForeColor")    
      
   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Create_btnMaximize()
   If _Project\IsUseSysMaximize = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建最大化按键"                + #CRLF$
   CodeText$ + "Procedure Create_btnMaximize(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"               + #CRLF$
   CodeText$ + "      \IsCreate = #True"        + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"最大化窗体"+#DQUOTE$            + #CRLF$
   EndIf 
   CodeText$ + #SysButton_Preference$   
   CodeText$ + "      ForeColor  = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)"  + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      \W = 28 : \H = 22 : i = (\W-12)/2 : j = (\H-08)/2"                + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"       + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ +           #Graphics_btnMaximize$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\HoldDownID", "ForeColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-08)/2"                + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ +           #Gradient_Bread$
         CodeText$ +           #Graphics_btnMaximize2$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\HoldDownID", "ForeColor")   
         
      Case #ButtonStyle_Piano
         If _Project\IsUseSysMinimize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
            CodeText$ + "      \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-08)/2" + #CRLF$
            Gradient_Piano$ = #Gradient_Piano0$
         Else 
            CodeText$ + "      ArcR = 5 : \W = 32+ArcR  : \H = 22 : i = (\W+ArcR-12)/2-3 : j = (\H-08)/2" + #CRLF$
            Gradient_Piano$ = #Gradient_Piano3$
         EndIf 
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ +           Gradient_Piano$
         CodeText$ +           #Gradient_Divide$
         CodeText$ +           #Graphics_btnMaximize$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\HoldDownID", "ForeColor")   
         
      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-09)/2"  + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                                                    + #CRLF$
         CodeText$ +        Funtcion_SysButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[□]符号"                                                      + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"                          + #CRLF$
         CodeText$ +           #Graphics_btnMaximize$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\NormalcyID", "$FFFF8060")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\MouseTopID", "$FFFFBA87")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\HoldDownID", "$FF993A22")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$  
         
      Case #ButtonStyle_Capsule
         If _Project\IsUseSysMinimize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
            CodeText$ + "      \W = 32 : \H = 24 : i = (\W-12)/2 : j = (\H-08)/2" + #CRLF$
            Gradient_Capsule$ = #Gradient_Capsule0$
            BoxX$ = ""
            BoxW$ = ""
         Else 
            CodeText$ + "      \H = 24 : ArcR = \H/2 : \W = 32+ArcR : i = (\W+ArcR-12)/2-3 : j = (\H-08)/2" + #CRLF$
            Gradient_Capsule$ = #Gradient_Capsule3$
            BoxX$ = "0"
            BoxW$ = "\W+ArcR"
         EndIf 
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ +           Gradient_Capsule$
         CodeText$ +           #Graphics_btnMaximize$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\MouseTopID", BoxX$, BoxW$, "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\HoldDownID", BoxX$, BoxW$, "ForeColor")   
      
   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Create_btnNormalcy()
   If _Project\IsUseSysNormalcy = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建正常化按键"                + #CRLF$
   CodeText$ + "Procedure Create_btnNormalcy(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"               + #CRLF$
   CodeText$ + "      \IsCreate = #True"        + #CRLF$
   CodeText$ + "      \IsHide   = #True"        + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"窗体正常化"+#DQUOTE$            + #CRLF$
   EndIf 
   CodeText$ + #SysButton_Preference$   
   CodeText$ + "      ForeColor  = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)"  + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      \W = 28 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2"               + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"       + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ +           #Graphics_btnNormalcy$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\HoldDownID", "ForeColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2"    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"                       + #CRLF$
         CodeText$ +           #Graphics_btnNormalcy$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ +           #Gradient_Bread$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_Default)"                           + #CRLF$
         CodeText$ + "         DrawAlphaImage(ImageID(TempImageID), 0, 0)"                   + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\HoldDownID", "ForeColor")   
         
      Case #ButtonStyle_Piano
         If _Project\IsUseSysMinimize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
            CodeText$ + "      \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2" + #CRLF$
            Gradient_Piano$ = #Gradient_Piano0$
         Else 
            CodeText$ + "      ArcR = 5 : \W = 32+ArcR  : \H = 22 : i = (\W+ArcR-12)/2-3 : j = (\H-10)/2" + #CRLF$
            Gradient_Piano$ = #Gradient_Piano3$
         EndIf 
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"                       + #CRLF$
         CodeText$ +           #Graphics_btnNormalcy$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ +           Gradient_Piano$
         CodeText$ +           #Gradient_Divide$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_Default)"                           + #CRLF$
         CodeText$ + "         DrawAlphaImage(ImageID(TempImageID), 0, 0)"                   + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\HoldDownID", "ForeColor")   
         
         
      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-11)/2"    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                                                    + #CRLF$
         CodeText$ +        Funtcion_SysButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[□□]符号"                                                    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"                          + #CRLF$
         CodeText$ +           #Graphics_btnNormalcy$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\NormalcyID", "$FFFF8060")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\MouseTopID", "$FFFFBA87")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\HoldDownID", "$FF993A22")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$  
         
      Case #ButtonStyle_Capsule
         If _Project\IsUseSysMinimize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
            CodeText$ + "      \W = 32 : \H = 24 : i = (\W-12)/2 : j = (\H-10)/2" + #CRLF$
            Gradient_Capsule$ = #Gradient_Capsule0$
            BoxX$ = ""
            BoxW$ = ""
         Else 
            CodeText$ + "      \H = 24 : ArcR = \H/2 : \W = 32+ArcR  : i = (\W+ArcR-12)/2-3 : j = (\H-10)/2" + #CRLF$
            Gradient_Capsule$ = #Gradient_Capsule3$
            BoxX$ = "0"
            BoxW$ = "\W+ArcR"
         EndIf 
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                       + #CRLF$
         CodeText$ + "      TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"                       + #CRLF$
         CodeText$ +           #Graphics_btnNormalcy$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"                       + #CRLF$
         CodeText$ +           Gradient_Capsule$
         CodeText$ + "         DrawingMode(#PB_2DDrawing_Default)"                           + #CRLF$
         CodeText$ + "         DrawAlphaImage(ImageID(TempImageID), 0, 0)"                   + #CRLF$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\MouseTopID", BoxX$, BoxW$, "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\HoldDownID", BoxX$, BoxW$, "ForeColor")   
   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Create_btnSettings()
   If _Project\IsUseSysSettings = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建窗体设置按键"               + #CRLF$
   CodeText$ + "Procedure Create_btnSettings(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"              + #CRLF$
   CodeText$ + "      \IsCreate = #True"       + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"软件设置"+#DQUOTE$            + #CRLF$
   EndIf 
   CodeText$ + #SysButton_Preference$   
   CodeText$ + "      ForeColor  = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)"  + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      \W = 28 : \H = 22 : i = (\W-14)/2 : j = (\H-07)/2"    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                     + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)" + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"     + #CRLF$
         CodeText$ +           #Graphics_btnSettings$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\HoldDownID", "ForeColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      \W = 32 : \H = 22 : i = (\W-14)/2 : j = (\H-07)/2"         + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           #Gradient_Bread$
         CodeText$ +           #Graphics_btnSettings$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\HoldDownID", "ForeColor")     

      Case #ButtonStyle_Piano
         If _Project\IsUseSysStickyNO
            CodeText$ + "      \W = 32 : \H = 22 : i = (\W-14)/2 : j = (\H-07)/2" + #CRLF$
            Gradient_Piano$ = #Gradient_Piano0$
         Else 
            CodeText$ + "      ArcR = 5 : \W = 32+ArcR  : \H = 22 : i = (\W+ArcR-14)/2-3 : j = (\H-07)/2" + #CRLF$
            Gradient_Piano$ = #Gradient_Piano3$
         EndIf 
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           Gradient_Piano$
         CodeText$ +           #Gradient_Divide$
         CodeText$ +           #Graphics_btnSettings$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\HoldDownID", "ForeColor")    


      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-14)/2 : j = (\H-07)/2"    + #CRLF$
         CodeText$ + "        "    + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                               + #CRLF$
         CodeText$ +        Funtcion_SysButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[V]符号"                    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"     + #CRLF$
         CodeText$ +           #Graphics_btnSettings$
         CodeText$ + "         StopDrawing()"                + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\NormalcyID", "$FFE43ADE")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\MouseTopID", "$FFFF53F8")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\HoldDownID", "$FF9E1799")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$  

      Case #ButtonStyle_Capsule
         If _Project\IsUseSysStickyNO
            CodeText$ + "      \W = 32 : \H = 24 : i = (\W-14)/2 : j = (\H-07)/2" + #CRLF$
            Gradient_Capsule$ = #Gradient_Capsule0$
            BoxX$ = ""
            BoxW$ = ""
         Else 
            CodeText$ + "      \H = 24 : ArcR = \H/2 : \W = 32+ArcR : i = (\W+ArcR-14)/2-3 : j = (\H-07)/2" + #CRLF$
            Gradient_Capsule$ = #Gradient_Capsule3$
            BoxX$ = "0"
            BoxW$ = "\W+ArcR"
         EndIf 
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           Gradient_Capsule$
         CodeText$ +           #Graphics_btnSettings$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\MouseTopID", BoxX$, BoxW$, "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\HoldDownID", BoxX$, BoxW$, "ForeColor")    
      
   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Create_btnStickyNO()
   If _Project\IsUseSysStickyNO = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建窗体置顶按键"               + #CRLF$
   CodeText$ + "Procedure Create_btnStickyNO(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"              + #CRLF$
   CodeText$ + "      \IsCreate = #True"       + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"窗体置顶"+#DQUOTE$            + #CRLF$
   EndIf 
   CodeText$ + #SysButton_Preference$   
   CodeText$ + "      ForeColor  = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)"  + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      \W = 28 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2"    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                     + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)" + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"     + #CRLF$
         CodeText$ +           #Graphics_btnStickyNO$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\HoldDownID", "ForeColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2"         + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           #Gradient_Bread$
         CodeText$ +           #Graphics_btnStickyNO$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\HoldDownID", "ForeColor")     

      Case #ButtonStyle_Piano
         CodeText$ + "      ArcR = 5 : \W = 32+ArcR  : \H = 22 : i = (\W+ArcR-12)/2-3 : j = (\H-10)/2" + #CRLF$
         Gradient_Piano$ = #Gradient_Piano3$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           Gradient_Piano$
         CodeText$ +           #Gradient_Divide$
         CodeText$ +           #Graphics_btnStickyNO$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\HoldDownID", "ForeColor")    

      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-16)/2 : j = (\H-12)/2"    + #CRLF$
         CodeText$ + "        "    + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                               + #CRLF$
         CodeText$ +        Funtcion_SysButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[V]符号"                    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"     + #CRLF$
         CodeText$ +           #Graphics_btnStickyNO$
         CodeText$ + "         StopDrawing()"                + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\NormalcyID", "$FF1496fb")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\MouseTopID", "$FF3CA9FF")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\HoldDownID", "$FF037FDF")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$  
            
      Case #ButtonStyle_Capsule
         CodeText$ + "      \H = 24 : ArcR = \H/2 : \W = 32+ArcR : i = (\W+ArcR-10)/2-3 : j = (\H-12)/2" + #CRLF$
         Gradient_Capsule$ = #Gradient_Capsule3$
         BoxX$ = "0"
         BoxW$ = "\W+ArcR"
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           Gradient_Capsule$
         CodeText$ +           #Graphics_btnStickyNO$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\MouseTopID", BoxX$, BoxW$, "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\HoldDownID", BoxX$, BoxW$, "ForeColor")    
         
   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Create_btnStickyNC()
   If _Project\IsUseSysStickyNO = #False : ProcedureReturn : EndIf 
   CodeText$ + ";创建取消窗体置顶按键"               + #CRLF$
   CodeText$ + "Procedure Create_btnStickyNC(*pGadget.__GadgetInfo)"                + #CRLF$
   CodeText$ + "   With *pGadget"              + #CRLF$
   CodeText$ + "      \IsCreate = #True"       + #CRLF$
   CodeText$ + "      \IsHide   = #True"       + #CRLF$
   If _Project\IsUseBalloonTip
      CodeText$ + "      \BalloonTip$ = "+#DQUOTE$+"取消窗体置顶"+#DQUOTE$           + #CRLF$
   EndIf 
   CodeText$ + #SysButton_Preference$   
   CodeText$ + "      ForeColor  = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)"  + #CRLF$
   Select _Project\SystemButtonSylte
      Case #ButtonStyle_Flat
         CodeText$ + "      \W = 28 : \H = 22 : i = (\W-12)/2 : j = (\H-12)/2"    + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                     + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)" + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"     + #CRLF$
         CodeText$ +           #Graphics_btnStickyNC$
         CodeText$ + "         StopDrawing()"               + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Flat("\HoldDownID", "ForeColor")
         
      Case #ButtonStyle_Bread
         CodeText$ + "      \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-12)/2"         + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           #Gradient_Bread$
         CodeText$ +           #Graphics_btnStickyNC$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Bread("\HoldDownID", "ForeColor")     

      Case #ButtonStyle_Piano
         CodeText$ + "      ArcR = 5 : \W = 32+ArcR  : \H = 22 : i = (\W+ArcR-12)/2-3 : j = (\H-12)/2" + #CRLF$
         Gradient_Piano$ = #Gradient_Piano3$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           Gradient_Piano$
         CodeText$ +           #Gradient_Divide$
         CodeText$ +           #Graphics_btnStickyNC$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\MouseTopID", "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Piano("\HoldDownID", "ForeColor")     

      Case #ButtonStyle_Cake
         CodeText$ + "      \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-12)/2 : j = (\H-12)/2"    + #CRLF$
         CodeText$ + "        "    + #CRLF$
         CodeText$ + "      ;绘制背景小圆圈"                               + #CRLF$
         CodeText$ +        Funtcion_SysButton_Circle("TempImageID")
         CodeText$ + "      ;绘制[V]符号"                    + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(TempImageID))"     + #CRLF$
         CodeText$ +           #Graphics_btnStickyNC$
         CodeText$ + "         StopDrawing()"                + #CRLF$
         CodeText$ + "      EndIf"                          + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\NormalcyID", "$FF1496fb")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\MouseTopID", "$FF3CA9FF")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Cake("\HoldDownID", "$FF037FDF")
         CodeText$ + "      FreeImage(TempImageID)"         + #CRLF$
         CodeText$ + #CRLF$ 
             
      Case #ButtonStyle_Capsule
         CodeText$ + "      \H = 24 : ArcR = \H/2 : \W = 32+ArcR : i = (\W+ArcR-10)/2-3 : j = (\H-12)/2" + #CRLF$
         Gradient_Capsule$ = #Gradient_Capsule3$
         BoxX$ = "0"
         BoxW$ = "\W+ArcR"
            
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制正常状态下的控件图像"                                 + #CRLF$
         CodeText$ + "      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)"  + #CRLF$
         CodeText$ + "      If StartDrawing(ImageOutput(\NormalcyID))"               + #CRLF$
         CodeText$ +           Gradient_Capsule$
         CodeText$ +           #Graphics_btnStickyNC$
         CodeText$ + "         StopDrawing()"             + #CRLF$
         CodeText$ + "      EndIf"                        + #CRLF$
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制鼠标置顶时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\MouseTopID", BoxX$, BoxW$, "*pColor\ForeColor")
         CodeText$ + #CRLF$
         CodeText$ + "      ;绘制左键按下时的控件图像"      + #CRLF$
         CodeText$ +        Funtcion_SysButton_Capsule("\HoldDownID", BoxX$, BoxW$, "ForeColor")     
         
   EndSelect
   CodeText$ + "   EndWith"      + #CRLF$
   CodeText$ + "EndProcedure"    + #CRLF$
   CodeText$ + #CRLF$
   ProcedureReturn CodeText$
EndProcedure

;创建普通按键
Procedure$ AutoCode_Create_btnGadget()
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
   CodeText$ +           Function_Gradient(*pColorMessage, "0", "0", "\W", "\H")
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

;- [SystemButton]
Procedure$ Generater_Create()

   CodeText$ + ";-=========================="  + #CRLF$
   CodeText$ + ";-[Create]"                    + #CRLF$
   CodeText$ + AutoCode_Create_btnCloseBox()
   CodeText$ + AutoCode_Create_btnMinimize()
   CodeText$ + AutoCode_Create_btnMaximize()
   CodeText$ + AutoCode_Create_btnNormalcy()
   CodeText$ + AutoCode_Create_btnSettings()
   CodeText$ + AutoCode_Create_btnStickyNO()
   CodeText$ + AutoCode_Create_btnStickyNC()
   
   
   CodeText$ + AutoCode_Create_btnGadget()
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
;-==========================
;- [BalloonTip]
Procedure$ Generater_BalloonTip()

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
   CodeText$ +              Function_Gradient(*pColorWindow, "0", "0", "\WindowW", "\WindowH") 
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



;-
Procedure$ AutoCode_Message_Hook()
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
   ProcedureReturn CodeText$
EndProcedure

Procedure$ AutoCode_Message_Redraw()
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
   CodeText$ +           Function_Gradient(*pColorWindow, "0", "0", "\WindowW", "\WindowH")
   CodeText$ + "         Box(0, 0, \WindowW, \WindowH, *pColor\BackColor)"                   + #CRLF$
   CodeText$ + "         Box(1, \TitleH, 1, \WindowH-\TitleH-1, *pColor\HighColor)"          + #CRLF$
   CodeText$ + "         Box(1, \TitleH, \WindowW-1, 1, *pColor\HighColor)"                  + #CRLF$
   CodeText$ + #CRLF$
   *pColorCaption.__ScreenColorInfo = _Project\pMapColor("标题栏")
   ChangeCurrentElement(_Project\ListColor(), *pColorCaption)
   Index = ListIndex(_Project\ListColor())
   CodeText$ + "         *pColor.__ScreenColorInfo = @_Screen\DimColor["+Str(Index)+"]"      + #CRLF$
   CodeText$ +           Function_Gradient(*pColorCaption, "0", "0", "\WindowW", "\TitleH")
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
   ProcedureReturn CodeText$
EndProcedure
   
Procedure$ AutoCode_Message_Inital()

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
   ProcedureReturn CodeText$
EndProcedure

Procedure$ Generater_Message()
   If _Project\IsUseMessageBox = #False : ProcedureReturn : EndIf 
   CodeText$ + ";- =========================="  + #CRLF$
   CodeText$ + ";- [Message]"                   + #CRLF$
   CodeText$ + AutoCode_Message_Hook()       ;挂钩事件
   CodeText$ + AutoCode_Message_Redraw()     ;绘制事件

   CodeText$ + ";初始化窗体"                          + #CRLF$
   CodeText$ + "Procedure Message_Requester(hWindow, Title$, Notice$, Flags=#PB_MessageRequester_Ok, IsEnable=#True)"   + #CRLF$
   CodeText$ + "   With _Message"                     + #CRLF$
   CodeText$ +         AutoCode_Message_Inital()      ;初始化窗体
   CodeText$ + "      ;创建对话框窗体"                 + #CRLF$
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








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 520
; FirstLine = 517
; Folding = -j0
; EnableXP
; Executable = 迷路代码库工具2.exe
; EnableUnicode