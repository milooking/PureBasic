



;-==========================
;-[Main]
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
            Select \SystemButtonSylte 
               Case #ButtonStyle_Piano 
                  ButtonX = WindowW-5 : ButtonY+1 : Interval = 0 
               Case #ButtonStyle_Capsule 
                  ButtonX = WindowW-5 : ButtonY+4 : Interval = 0 
               Default 
                  ButtonX = WindowW+0 : ButtonY+1 : Interval = -1 
            EndSelect 
            If \IsUseSysCloseBox
               ButtonX = ButtonX+Interval -_Screen\btnCloseBox\W 
               Redraw_Gadget(_Screen\btnCloseBox, ButtonX, ButtonY)
            EndIf 
            If \IsUseSysMaximize
               TempButtonX = ButtonX
               ButtonX = ButtonX+Interval-_Screen\btnMaximize\W 
               Redraw_Gadget(_Screen\btnMaximize, ButtonX, ButtonY)
               Redraw_Gadget(_Screen\btnNormalcy, ButtonX, ButtonY)
            EndIf               
            
            If \IsUseSysMinimize
               ButtonX = ButtonX+Interval-_Screen\btnMinimize\W 
               Redraw_Gadget(_Screen\btnMinimize, ButtonX, ButtonY)
            EndIf 
            
            If \IsUseSysSettings
               ButtonX = ButtonX+Interval-_Screen\btnSettings\W
               Redraw_Gadget(_Screen\btnSettings, ButtonX, ButtonY)
            EndIf   
            
            If \IsUseSysStickyNO
               TempButtonX = ButtonX
               ButtonX = ButtonX+Interval-_Screen\btnStickyNO\W :   
               Redraw_Gadget(_Screen\btnStickyNO, ButtonX, ButtonY)
               Redraw_Gadget(_Screen\btnStickyNC, ButtonX, ButtonY)
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
Macro Macro_SysButton_Preference()  
   If IsImage(*pGadget\NormalcyID) : FreeImage(*pGadget\NormalcyID) : EndIf 
   If IsImage(*pGadget\MouseTopID) : FreeImage(*pGadget\MouseTopID) : EndIf 
   If IsImage(*pGadget\HoldDownID) : FreeImage(*pGadget\HoldDownID) : EndIf
   *pGadget\NormalcyID = 0
   *pGadget\MouseTopID = 0
   *pGadget\HoldDownID = 0
   *pColor.__ScreenColorInfo = _Project\pMapColor("标题栏")
   FontColor = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)
   SideColor = (Alpha(*pColor\SideColor) << 23 & $FF000000) |(*pColor\SideColor & $FFFFFF)
   ForeColor = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)
EndMacro

Macro Macro_SysButton_Flat(MouseTopColor, HoldDownColor)
   *pGadget\MouseTopID = CreateImage(#PB_Any, *pGadget\W, *pGadget\H, 32, #PB_Image_Transparent)
   If StartDrawing(ImageOutput(*pGadget\MouseTopID))
      DrawingMode(#PB_2DDrawing_AlphaBlend) 
      Box(000, 000, *pGadget\W, *pGadget\H, MouseTopColor)
      DrawAlphaImage(ImageID(*pGadget\NormalcyID), 0, 0)
      StopDrawing()
   EndIf
   
   *pGadget\HoldDownID = CreateImage(#PB_Any, *pGadget\W, *pGadget\H, 32, #PB_Image_Transparent)
   If StartDrawing(ImageOutput(*pGadget\HoldDownID))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      Box(000, 000, *pGadget\W, *pGadget\H, HoldDownColor)
      DrawAlphaImage(ImageID(*pGadget\NormalcyID), 0, 0)
      StopDrawing()
   EndIf
EndMacro
   
Macro Macro_SysButton_Bread(MouseTopColor, HoldDownColor)  
   *pGadget\MouseTopID = CreateImage(#PB_Any, *pGadget\W, *pGadget\H, 32, #PB_Image_Transparent)
   If StartDrawing(ImageOutput(*pGadget\MouseTopID))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      RoundBox(0, -5, *pGadget\W, *pGadget\H+5, 3, 3, MouseTopColor)  
      DrawAlphaImage(ImageID(*pGadget\NormalcyID), 0, 0)
      StopDrawing()
   EndIf
   
   *pGadget\HoldDownID = CreateImage(#PB_Any, *pGadget\W, *pGadget\H, 32, #PB_Image_Transparent)
   If StartDrawing(ImageOutput(*pGadget\HoldDownID))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      RoundBox(0, -5, *pGadget\W, *pGadget\H+5, 3, 3, HoldDownColor) 
      DrawAlphaImage(ImageID(*pGadget\NormalcyID), 0, 0)
      StopDrawing()
   EndIf
EndMacro

Macro Macro_SysButton_Piano(MouseTopColor, HoldDownColor)  
   *pGadget\MouseTopID = CreateImage(#PB_Any, *pGadget\W, *pGadget\H, 32, #PB_Image_Transparent)
   If StartDrawing(ImageOutput(*pGadget\MouseTopID))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      RoundBox(0, -5, *pGadget\W-1, *pGadget\H+5, 3, 3, MouseTopColor)  
      DrawAlphaImage(ImageID(*pGadget\NormalcyID), 0, 0)
      StopDrawing()
   EndIf
   
   *pGadget\HoldDownID = CreateImage(#PB_Any, *pGadget\W, *pGadget\H, 32, #PB_Image_Transparent)
   If StartDrawing(ImageOutput(*pGadget\HoldDownID))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      RoundBox(0, -5, *pGadget\W-1, *pGadget\H+5, 3, 3, HoldDownColor) 
      DrawAlphaImage(ImageID(*pGadget\NormalcyID), 0, 0)
      StopDrawing()
   EndIf
EndMacro



Macro Macro_SysButton_Circle()  
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
EndMacro

Macro Macro_SysButton_Cake(NormalcyColor, MouseTopColor, HoldDownColor)  
   *pGadget\NormalcyID = CreateImage(#PB_Any, *pGadget\W, *pGadget\H, 32, #PB_Image_Transparent)
   If StartDrawing(ImageOutput(*pGadget\NormalcyID))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      Circle(x+14, y+14, 10, NormalcyColor)
      DrawAlphaImage(ImageID(TempImageID), 0, 0)
      StopDrawing()
   EndIf
   
   *pGadget\MouseTopID = CreateImage(#PB_Any, *pGadget\W, *pGadget\H, 32, #PB_Image_Transparent)
   If StartDrawing(ImageOutput(*pGadget\MouseTopID))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      Circle(x+14, y+14, 10, MouseTopColor)
      DrawAlphaImage(ImageID(TempImageID), 0, 0)
      StopDrawing()
   EndIf
   
   *pGadget\HoldDownID = CreateImage(#PB_Any, *pGadget\W, *pGadget\H, 32, #PB_Image_Transparent)
   If StartDrawing(ImageOutput(*pGadget\HoldDownID))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      Circle(x+14, y+14, 10, HoldDownColor)
      DrawAlphaImage(ImageID(TempImageID), 0, 0)
      StopDrawing()
   EndIf
   FreeImage(TempImageID)    
EndMacro

Macro Macro_SysButton_Capsule(MouseTopColor, HoldDownColor)  
   *pGadget\MouseTopID = CreateImage(#PB_Any, *pGadget\W, *pGadget\H, 32, #PB_Image_Transparent)
   If StartDrawing(ImageOutput(*pGadget\MouseTopID))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      RoundBox(BoxX, 0, BoxW, *pGadget\H, ArcR, ArcR, MouseTopColor)  
      DrawAlphaImage(ImageID(*pGadget\NormalcyID), 0, 0)
      StopDrawing()
   EndIf
   
   *pGadget\HoldDownID = CreateImage(#PB_Any, *pGadget\W, *pGadget\H, 32, #PB_Image_Transparent)
   If StartDrawing(ImageOutput(*pGadget\HoldDownID))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      RoundBox(BoxX, 0, BoxW, *pGadget\H, ArcR, ArcR, HoldDownColor) 
      DrawAlphaImage(ImageID(*pGadget\NormalcyID), 0, 0)
      StopDrawing()
   EndIf
EndMacro

;-

Macro Macro_Gradient_Bread()  
   DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
   BackColor (*pColor\ForeColor)
   FrontColor($000000)
   LinearGradient(0, 0, 0, *pGadget\H) 
   RoundBox(0, -5, *pGadget\W, *pGadget\H+5, 3, 3)   
   DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
   RoundBox(0, -5, *pGadget\W, *pGadget\H+5, 3, 3, *pColor\SideColor)  
EndMacro

Macro Macro_Gradient_Divide()  
   DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
   BackColor (*pColor\SideColor)
   FrontColor($000000)
   LinearGradient(0, -5, 0, *pGadget\H-5) 
   Line(*pGadget\W-1, 0, 1, *pGadget\H-1, *pColor\SideColor)
EndMacro

Macro Macro_Gradient_Piano()  
   DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
   BackColor (*pColor\ForeColor)
   FrontColor($000000)
   LinearGradient(0, 0, 0, *pGadget\H) 
   RoundBox(BoxX, -5, BoxW, *pGadget\H+5, 3, 3)   
   DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
   RoundBox(BoxX, -5, BoxW, *pGadget\H+5, 3, 3, *pColor\SideColor)  
EndMacro


Macro Macro_Gradient_Capsule()  
   DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Gradient)
   BackColor (*pColor\ForeColor)
   FrontColor($000000)
   LinearGradient(0, 0, 0, *pGadget\H) 
   RoundBox(BoxX, 0, BoxW, *pGadget\H, ArcR, ArcR)   
   DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
   RoundBox(BoxX, 0, BoxW, *pGadget\H, ArcR-1, ArcR-1, SideColor) 
   RoundBox(BoxX, 0, BoxW, *pGadget\H, ArcR+2, ArcR+2, SideColor) 
   RoundBox(BoxX, 0, BoxW, *pGadget\H, ArcR+0, ArcR+0, *pColor\SideColor) 
EndMacro

Macro Macro_Graphics_btnCloseBox()  
   DrawingMode(#PB_2DDrawing_AlphaBlend)
   LineXY(i+0, j+00, i+9+0, j+09, FontColor)
   LineXY(i+1, j+00, i+9+1, j+09, *pColor\FontColor)
   LineXY(i+2, j+00, i+9+2, j+09, FontColor)
   LineXY(i+0, j+09, i+9+0, j+00, FontColor)
   LineXY(i+1, j+09, i+9+1, j+00, *pColor\FontColor)
   LineXY(i+2, j+09, i+9+2, j+00, FontColor) 
EndMacro

Macro Macro_Graphics_btnMinimize()  
   DrawingMode(#PB_2DDrawing_AlphaBlend)
   Box(i, j+0, 09, 03, FontColor)
   Box(i, j+1, 09, 01, *pColor\FontColor)
EndMacro

Macro Macro_Graphics_btnMaximize()  
   DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
   Box(i+00, j+00, 12, 08, *pColor\FontColor)
   Box(i+01, j+00, 10, 08, FontColor)
EndMacro


Macro Macro_Graphics_btnNormalcy()  
   DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined) 
   Box(i+05, j+00, 07, 06, *pColor\FontColor)
   DrawingMode(#PB_2DDrawing_AllChannels) 
   Box(i+00, j+03, 09, 07, $0)
   DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
   Box(i+00, j+03, 09, 07, *pColor\FontColor)
   Box(i+01, j+03, 07, 07, FontColor)  
EndMacro


Macro Macro_Graphics_btnSettings()  
   DrawingMode(#PB_2DDrawing_AlphaBlend) 
   Line(i+0, j+0, 07, 07, FontColor)
   Line(i+7, j+5, 06, -6, FontColor)
   Line(i+2, j+0, 05, 05, FontColor)
   Line(i+7, j+3, 04, -4, FontColor)
   Line(i+1, j+0, 06, 06, *pColor\FontColor)
   Line(i+7, j+4, 05, -5, *pColor\FontColor)
EndMacro

Macro Macro_Graphics_btnStickyNO()  
   DrawingMode(#PB_2DDrawing_AlphaBlend) 
   Line(i+00, j+4, 05, 01, *pColor\FontColor)
   Line(i+04, j+0, 01, 09, FontColor)
   Line(i+05, j+0, 01, 09, *pColor\FontColor)
   Line(i+06, j+2, 07, 01, *pColor\FontColor)
   Line(i+06, j+5, 07, 01, FontColor)
   Line(i+06, j+6, 07, 01, *pColor\FontColor)
   Line(i+12, j+3, 01, 03, FontColor)
   Line(i+13, j+2, 01, 05, *pColor\FontColor)
EndMacro

Macro Macro_Graphics_btnStickyNC()  
   DrawingMode(#PB_2DDrawing_AlphaBlend) 
   Line(i+02, j+0, 01, 06, *pColor\FontColor)
   Line(i+03, j+0, 05, 01, *pColor\FontColor)
   Line(i+07, j+1, 01, 05, FontColor)
   Line(i+08, j+0, 01, 06, *pColor\FontColor)
   Line(i+00, j+6, 11, 01, *pColor\FontColor)
   Line(i+00, j+7, 11, 01, FontColor)
   Line(i+05, j+7, 01, 03, *pColor\FontColor)
EndMacro


;-
;-[Main]
;创建关闭按键
Procedure Create_btnCloseBox(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate    = #True
      \BalloonTip$ = "关闭窗体"
      Macro_SysButton_Preference()
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 40 : \H = 24 : i = (\W-9)/2 : j = (\H-10)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Graphics_btnCloseBox() 
               StopDrawing()
            EndIf
            Macro_SysButton_Flat(#SysButton_CloseColor, CloseColor)
            
         Case #ButtonStyle_Bread
            \W = 48 : \H = 22 : i = (\W-9)/2 : j = (\H-10)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Bread()
               Macro_Graphics_btnCloseBox()              
               StopDrawing()
            EndIf
            Macro_SysButton_Bread(#SysButton_CloseColor, CloseColor)  
 
         Case #ButtonStyle_Piano
            \W = 48 : \H = 22 : i = (\W-9)/2 : j = (\H-10)/2 : ArcR = 5
            If _Project\IsUseSysMinimize Or _Project\IsUseSysMaximize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
               BoxX = -ArcR : BoxW = \W+ArcR
            Else 
               BoxX = 0 : \W+ArcR : BoxW = \W : i+ArcR
            EndIf 
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Piano()
               Macro_Graphics_btnCloseBox()              
               StopDrawing()
            EndIf
            Macro_SysButton_Piano(#SysButton_CloseColor, CloseColor)  
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-12)/2
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            Macro_SysButton_Circle()  
            If StartDrawing(ImageOutput(TempImageID))
               Macro_Graphics_btnCloseBox() 
               StopDrawing()
            EndIf
            Macro_SysButton_Cake($E05060FF, $FF919BFF, $FF0D1CB5)  

         Case #ButtonStyle_Capsule
            \W = 48 : \H = 24 : i = (\W-9-\H/2)/2 : j = (\H-10)/2 : ArcR = \H/2
            If _Project\IsUseSysMinimize Or _Project\IsUseSysMaximize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
               BoxX = -ArcR : BoxW = \W+ArcR
            Else 
               BoxX = 0 : \W+ArcR : BoxW = \W : i+ArcR
            EndIf 
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Capsule()  
               Macro_Graphics_btnCloseBox()                
               StopDrawing()
            EndIf
            Macro_SysButton_Capsule(#SysButton_CloseColor, CloseColor)  
            
      EndSelect 
   EndWith
EndProcedure

;创建最小化按键
Procedure Create_btnMinimize(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      \BalloonTip$ = "最小化窗体"
      Macro_SysButton_Preference()
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 28 : \H = 22 : i = (\W-9)/2 : j = (\H-3)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Graphics_btnMinimize()  
               StopDrawing()
            EndIf
            Macro_SysButton_Flat(*pColor\ForeColor, ForeColor)

         Case #ButtonStyle_Bread
            \W = 32 : \H = 22 : i = (\W-9)/2 : j = (\H-3)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Bread()
               Macro_Graphics_btnMinimize()  
               StopDrawing()
            EndIf
            Macro_SysButton_Bread(*pColor\ForeColor, ForeColor)
            
         Case #ButtonStyle_Piano
            \W = 32 : \H = 22 : i = (\W-9)/2 : j = (\H-3)/2 : ArcR = 5
            If _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
               BoxX = -ArcR : BoxW = \W+ArcR*2 
            Else 
               BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            EndIf 
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Piano()
               Macro_Gradient_Divide()
               Macro_Graphics_btnMinimize()  
               StopDrawing()
            EndIf
            Macro_SysButton_Piano(*pColor\ForeColor, ForeColor)              
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-09)/2 : j = (\H-03)/2
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            Macro_SysButton_Circle()  
            If StartDrawing(ImageOutput(TempImageID))
               Macro_Graphics_btnMinimize()  
               StopDrawing()
            EndIf
            Macro_SysButton_Cake($E020E080, $FF4ADF95, $FF048B48)  
            
         Case #ButtonStyle_Capsule
            \W = 32 : \H = 24 : i = (\W-9)/2 : j = (\H-3)/2 : ArcR = \H/2
            If _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
               BoxX = -ArcR : BoxW = \W+ArcR*2
            Else 
               BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            EndIf 
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Capsule() 
               Macro_Graphics_btnMinimize()  
               StopDrawing()
            EndIf
            Macro_SysButton_Capsule(*pColor\ForeColor, ForeColor)  
      EndSelect 
      
   EndWith
EndProcedure

;创建最大化按键
Procedure Create_btnMaximize(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      \IsHide   = #False
      \BalloonTip$ = "最大化窗体"
      Macro_SysButton_Preference()
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 28 : \H = 22 : i = (\W-12)/2 : j = (\H-8)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Graphics_btnMaximize()  
               StopDrawing()
            EndIf
            Macro_SysButton_Flat(*pColor\ForeColor, ForeColor)
            
         Case #ButtonStyle_Bread
            \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-8)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Bread()
               Macro_Graphics_btnMaximize()  
               StopDrawing()
            EndIf
            Macro_SysButton_Bread(*pColor\ForeColor, ForeColor)  
            
         Case #ButtonStyle_Piano
            \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-8)/2 : ArcR = 5
            If _Project\IsUseSysMinimize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
               BoxX = -ArcR : BoxW = \W+ArcR*2
            Else 
               BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            EndIf 
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Piano()
               Macro_Gradient_Divide()
               Macro_Graphics_btnMaximize()  
               StopDrawing()
            EndIf
            Macro_SysButton_Piano(*pColor\ForeColor, ForeColor)              
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-9)/2
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            Macro_SysButton_Circle()  
            If StartDrawing(ImageOutput(TempImageID))
               Macro_Graphics_btnMaximize()  
               StopDrawing()
            EndIf
            Macro_SysButton_Cake($FFFF8060, $FFFFBA87, $FF993A22) 
            
         Case #ButtonStyle_Capsule
            \W = 32 : \H = 24 : i = (\W-12)/2 : j = (\H-8)/2 : ArcR = \H/2
            If _Project\IsUseSysMinimize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
               BoxX = -ArcR : BoxW = \W+ArcR*2
            Else 
               BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            EndIf 
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Capsule() 
               Macro_Graphics_btnMaximize()  
               StopDrawing()
            EndIf
            Macro_SysButton_Capsule(*pColor\ForeColor, ForeColor)  
            
      EndSelect 
   EndWith
EndProcedure

;创建正常化按键
Procedure Create_btnNormalcy(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      \IsHide   = #True
      \BalloonTip$ = "窗体正常化"
      Macro_SysButton_Preference()
      
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 28 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Graphics_btnNormalcy() 
               StopDrawing()
            EndIf
            Macro_SysButton_Flat(*pColor\ForeColor, ForeColor)
            
         Case #ButtonStyle_Bread
            \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(TempImageID))
               Macro_Graphics_btnNormalcy()  
               StopDrawing()
            EndIf
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Bread()
               DrawingMode(#PB_2DDrawing_Default)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            FreeImage(TempImageID)
            Macro_SysButton_Bread(*pColor\ForeColor, ForeColor)  
            
         Case #ButtonStyle_Piano
            \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2 : ArcR = 5
            If _Project\IsUseSysMinimize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
               BoxX = -ArcR : BoxW = \W+ArcR*2
            Else 
               BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            EndIf 
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(TempImageID))
               Macro_Graphics_btnNormalcy()  
               StopDrawing()
            EndIf
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Piano()
               Macro_Gradient_Divide()
               DrawingMode(#PB_2DDrawing_Default)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            FreeImage(TempImageID)
            Macro_SysButton_Piano(*pColor\ForeColor, ForeColor)              
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-13)/2 : j = (\H-11)/2
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            Macro_SysButton_Circle()  
            If StartDrawing(ImageOutput(TempImageID))
               Macro_Graphics_btnNormalcy() 
               StopDrawing()
            EndIf
            Macro_SysButton_Cake($FFFF8060, $FFFFBA87, $FF993A22)  
            
         Case #ButtonStyle_Capsule
            \W = 32 : \H = 24 : i = (\W-12)/2 : j = (\H-10)/2 : ArcR = \H/2
            If _Project\IsUseSysMinimize Or _Project\IsUseSysSettings Or _Project\IsUseSysStickyNO
               BoxX = -ArcR : BoxW = \W+ArcR*2
            Else 
               BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            EndIf 
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(TempImageID))
               Macro_Graphics_btnNormalcy()   
               StopDrawing()
            EndIf
            
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Capsule() 
               DrawingMode(#PB_2DDrawing_Default)
               DrawAlphaImage(ImageID(TempImageID), 0, 0)
               StopDrawing()
            EndIf
            FreeImage(TempImageID)
            Macro_SysButton_Capsule(*pColor\ForeColor, ForeColor)  
            
      EndSelect 
   EndWith
EndProcedure

;创建窗体设置按键
Procedure Create_btnSettings(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      \BalloonTip$ = "软件设置"
      Macro_SysButton_Preference()
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 28 : \H = 22 : i = (\W-14)/2 : j = (\H-07)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Graphics_btnSettings()  
               StopDrawing()
            EndIf
            Macro_SysButton_Flat(*pColor\ForeColor, ForeColor)
            
         Case #ButtonStyle_Bread
            \W = 32 : \H = 22 : i = (\W-14)/2 : j = (\H-07)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Bread()
               Macro_Graphics_btnSettings()  
               StopDrawing()
            EndIf
            Macro_SysButton_Bread(*pColor\ForeColor, ForeColor)  
            
         Case #ButtonStyle_Piano
            \W = 32 : \H = 22 : i = (\W-14)/2 : j = (\H-07)/2 : ArcR = 5
            If _Project\IsUseSysStickyNO
               BoxX = -ArcR : BoxW = \W+ArcR*2
            Else 
               BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            EndIf 
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Piano()
               Macro_Gradient_Divide()
               Macro_Graphics_btnSettings()  
               StopDrawing()
            EndIf
            Macro_SysButton_Piano(*pColor\ForeColor, ForeColor)              
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-14)/2 : j = (\H-07)/2
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            Macro_SysButton_Circle()  
            If StartDrawing(ImageOutput(TempImageID))
               Macro_Graphics_btnSettings()  
               StopDrawing()
            EndIf
            Macro_SysButton_Cake($FFE43ADE, $FFFF53F8, $FF9E1799)  

         Case #ButtonStyle_Capsule
            \W = 32 : \H = 24 : i = (\W-14)/2 : j = (\H-7)/2 : ArcR = \H/2
            If _Project\IsUseSysStickyNO
               BoxX = -ArcR : BoxW = \W+ArcR*2
            Else 
               BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            EndIf 
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Capsule() 
               Macro_Graphics_btnSettings()  
               StopDrawing()
            EndIf
            Macro_SysButton_Capsule(*pColor\ForeColor, ForeColor)  
            
      EndSelect 
   EndWith
EndProcedure

;创建窗体设置按键
Procedure Create_btnStickyNO(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      \IsHide   = #False
      \BalloonTip$ = "窗体置顶"
      Macro_SysButton_Preference()
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 28 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Graphics_btnStickyNO() 
               StopDrawing()
            EndIf
            Macro_SysButton_Flat(*pColor\ForeColor, ForeColor)

         Case #ButtonStyle_Bread
            \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Bread()
               Macro_Graphics_btnStickyNO() 
               StopDrawing()
            EndIf
            Macro_SysButton_Bread(*pColor\ForeColor, ForeColor)  
            
         Case #ButtonStyle_Piano
            \W = 32 : \H = 22 : i = (\W-12)/2 : j = (\H-10)/2 : ArcR = 5
            BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Piano()
               Macro_Gradient_Divide()
               Macro_Graphics_btnStickyNO() 
               StopDrawing()
            EndIf
            Macro_SysButton_Piano(*pColor\ForeColor, ForeColor)              
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-16)/2 : j = (\H-12)/2
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            Macro_SysButton_Circle()  
            If StartDrawing(ImageOutput(TempImageID))
               Macro_Graphics_btnStickyNO() 
               StopDrawing()
            EndIf
            Macro_SysButton_Cake($FF1496fb, $FF3CA9FF, $FF037FDF)  
            
         Case #ButtonStyle_Capsule
            \W = 32 : \H = 24 : i = (\W-12)/2 : j = (\H-10)/2 : ArcR = \H/2
            BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Capsule() 
               Macro_Graphics_btnStickyNO() 
               StopDrawing()
            EndIf
            Macro_SysButton_Capsule(*pColor\ForeColor, ForeColor)  
      EndSelect 
   EndWith
EndProcedure

;创建窗体设置按键
Procedure Create_btnStickyNC(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      \IsHide   = #True
      \BalloonTip$ = "取消窗体置顶"
      Macro_SysButton_Preference()
      
      Select _Project\SystemButtonSylte
         Case #ButtonStyle_Flat 
            \W = 28 : \H = 22 : i = (\W-10)/2 : j = (\H-12)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Graphics_btnStickyNC()  
               StopDrawing()
            EndIf
            Macro_SysButton_Flat(*pColor\ForeColor, ForeColor)
            
         Case #ButtonStyle_Bread
            \W = 32 : \H = 22 : i = (\W-10)/2 : j = (\H-12)/2
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Bread()
               Macro_Graphics_btnStickyNC()  
               StopDrawing()
            EndIf
            Macro_SysButton_Bread(*pColor\ForeColor, ForeColor)  
            
         Case #ButtonStyle_Piano
            \W = 32 : \H = 22 : i = (\W-10)/2 : j = (\H-12)/2: ArcR = 5
            BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Piano()
               Macro_Gradient_Divide()
               Macro_Graphics_btnStickyNC()  
               StopDrawing()
            EndIf
            Macro_SysButton_Piano(*pColor\ForeColor, ForeColor)              
            
         Case #ButtonStyle_Cake
            \W = 36 : \H = 36 : x = (\W-30)/2 : y = (\H-30)/2 : i = (\W-12)/2 : j = (\H-12)/2
            TempImageID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            Macro_SysButton_Circle()  
            If StartDrawing(ImageOutput(TempImageID))
               Macro_Graphics_btnStickyNC()  
               StopDrawing()
            EndIf
            Macro_SysButton_Cake($FF1496fb, $FF3CA9FF, $FF037FDF)  
            
         Case #ButtonStyle_Capsule
            \W = 32 : \H = 24 : i = (\W-10)/2 : j = (\H-12)/2 : ArcR = \H/2
            BoxX = 0 : \W+ArcR : BoxW = \W+ArcR : i+ArcR-3
            \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
            If StartDrawing(ImageOutput(\NormalcyID))
               Macro_Gradient_Capsule() 
               Macro_Graphics_btnStickyNC()  
               StopDrawing()
            EndIf
            Macro_SysButton_Capsule(*pColor\ForeColor, ForeColor)  
      EndSelect 
   EndWith
EndProcedure


;创建普通按键
Procedure Create_btnGadget(*pGadget.__GadgetInfo, X, Y, W, H, Text$)
   With *pGadget
      \IsCreate = #True
      *pColor.__ScreenColorInfo = _Project\pMapColor("对话框按键")
      HighColor = (Alpha(*pColor\HighColor) << 23 & $FF000000) |(*pColor\HighColor & $FFFFFF)
      \X = X : \Y = Y : \W = W : \H = H : \R = X+W : \B = Y+H
      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : \NormalcyID = 0 : EndIf 
      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : \MouseTopID = 0 : EndIf 
      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : \HoldDownID = 0 : EndIf 
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
      \IsExitWindow = #False 
      \MessageResult = #Null
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
            Create_btnGadget (\btnMessageYes,   \WindowW/2-120, \WindowH-050, 100, 030, Button1$)
            Create_btnGadget (\btnMessageNo,    \WindowW/2+020, \WindowH-050, 100, 030, Button2$)
         Case  #PB_MessageRequester_YesNoCancel
            Create_btnGadget (\btnMessageYes,   \WindowW/2-170, \WindowH-050, 100, 030, Button1$)
            Create_btnGadget (\btnMessageNo,    \WindowW/2-050, \WindowH-050, 100, 030, Button2$)
            Create_btnGadget (\btnMessageCancel,\WindowW/2+070, \WindowH-050, 100, 030, Button3$)
         Default; #PB_MessageRequester_Ok
            Create_btnGadget (\btnMessageYes,   \WindowW/2-050, \WindowH-050, 100, 030, Button1$)            
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







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1338
; FirstLine = 1231
; Folding = 0n---X-
; EnableXP
; Executable = 迷路代码库工具2.exe
; EnableUnicode