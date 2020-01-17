;***********************************
;迷路仟整理 2019.02.16
;自绘对话框
;***********************************

;-[Constant]
#Color_BackColor = $282828
#Color_LineColor = $585858
#Color_FontColor = $FFFFFF
#Color_HighColor = $FFFFFF
#Color_SideColor = $000000



Enumeration
   #winScreen
   #winColor
   #cvsScreen1
   #cvsScreen2
   #cvsScreen3
   #cvsScreen4
   #fntDefault
EndEnumeration


      
;-[Structure]
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
   keep.b[16]
EndStructure

;对话框结构
Structure __ColorRequester
   hWindow.l
   hBackImage.i
   hWindowHook.i
   BKImage1ID.i
   BKImage2ID.i
   WindowW.w
   WindowH.w
   Color.l
   Title$
   Spectrum.l
   CurColor.l
   Index.l
   PickerX.l
   PickerY.l
   txtColorRID.l
   txtColorGID.l
   txtColorBID.l
   txtColor1ID.l
   txtColor2ID.l
   btnColorClose.__GadgetInfo
   btnPickColor.__GadgetInfo
   btnPickCancel.__GadgetInfo
   
   cvsGradient.__GadgetInfo  
   cvsSpectrum.__GadgetInfo  
    
   *pMouseTop.__GadgetInfo    ;当前光标在上
   *pHoldDown.__GadgetInfo    ;当前光标按住
   *pSelected.__GadgetInfo    ;选中状态: 预留兼对齐作用
   
EndStructure

Global _Color.__ColorRequester

;- ==========================
;- [Macro]
;[宏]判断操作域
Macro Macro_Gadget_InRect(Gadget)
   Bool(*pMouse\X > Gadget\X And
        *pMouse\X < Gadget\R And 
        *pMouse\Y > Gadget\Y And 
        *pMouse\Y < Gadget\B)
EndMacro

;- ==========================
;- [BackImage]
;绘制窗体背景
Procedure Color_DrawBackImage(hWindow, ImageID, IsFull=#False)
   If IsImage(ImageID)
      hBackImage= CreatePatternBrush_(ImageID(ImageID))
      If hBackImage
         SetClassLongPtr_(hWindow, #GCL_HBRBACKGROUND, hBackImage)
         If IsFull=#True
            RedrawWindow_(hWindow, #Null, #Null, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)
         Else 
            Rect.Rect
            Rect\left = 0
            Rect\top  = 0
            Rect\right  = GadgetX(_Color\txtColorRID)
            Rect\bottom = _Color\WindowH
            RedrawWindow_(hWindow, Rect, #Null, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)

            Rect\left = GadgetX(_Color\txtColorRID)
            Rect\top  = 0
            Rect\right  = _Color\WindowW
            Rect\bottom = GadgetY(_Color\txtColorRID)
            RedrawWindow_(hWindow, Rect, #Null, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)   
            
            Rect\left = GadgetX(_Color\txtColorRID)
            Rect\top  = GadgetY(_Color\txtColor2ID)+25
            Rect\right  = _Color\WindowW
            Rect\bottom = _Color\WindowH
            RedrawWindow_(hWindow, Rect, #Null, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)                        
         EndIf 
      EndIf 
   EndIf 
   ProcedureReturn hBackImage
EndProcedure

;释放窗体背景句柄
Procedure Color_FreeBackImage(hBackImage)
   DeleteObject_(hBackImage)  
EndProcedure

;- ==========================
;- [Gadget]

;创建关闭按键
Procedure Color_btnCloseBox(*pGadget.__GadgetInfo, X, Y, W, H, ImageID)
   With *pGadget
      \X = X
      \Y = Y 
      \W = W
      \H = H 
      \R = X+W 
      \B = Y+H
      If IsImage(ImageID)
         ImageID = GrabImage(ImageID, #PB_Any, X, Y, W, H)
      Else
         ImageID = CreateImage(#PB_Any, W, H)
      EndIf 
      \NormalcyID = CopyImage(ImageID, #PB_Any)

      ;正常状态
      If StartVectorDrawing(ImageVectorOutput(\NormalcyID))
         AddPathCircle(15, 18, 11)
         VectorSourceCircularGradient(15, 20, 20)
         VectorSourceGradientColor($E05060FF, 0.0)
         VectorSourceGradientColor($E05060FF, 0.6)
         VectorSourceGradientColor($FF000000, 1.0)
         FillPath() 
         StopVectorDrawing()
      EndIf
      i = 5 : j = 5-2
      If StartDrawing(ImageOutput(\NormalcyID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         LineXY(15-i, 16-j, 23-i, 24-j, $E0FFFFFF)
         LineXY(16-i, 16-j, 24-i, 24-j, $80FFFFFF)
         LineXY(14-i, 16-j, 22-i, 24-j, $80FFFFFF)
         LineXY(23-i, 16-j, 15-i, 24-j, $E0FFFFFF)
         LineXY(24-i, 16-j, 16-i, 24-j, $80FFFFFF)
         LineXY(22-i, 16-j, 14-i, 24-j, $80FFFFFF)
         DrawingMode(#PB_2DDrawing_Outlined)
         Line(000, 000, W, 1, #Color_LineColor)
         StopDrawing()
      EndIf
      
      ;光标在上状态
      \MouseTopID = CopyImage(ImageID, #PB_Any)
      If StartVectorDrawing(ImageVectorOutput(\MouseTopID))
         AddPathCircle(15, 18, 11)
         VectorSourceCircularGradient(15, 20, 20)
         VectorSourceGradientColor($FF919BFF, 0.0)
         VectorSourceGradientColor($FF919BFF, 0.6)
         VectorSourceGradientColor($FF000000, 1.0)
         FillPath() 
         StopVectorDrawing()
      EndIf
      i = 5 : j = 5-2
      If StartDrawing(ImageOutput(\MouseTopID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         LineXY(15-i, 16-j, 23-i, 24-j, $E0FFFFFF)
         LineXY(16-i, 16-j, 24-i, 24-j, $80FFFFFF)
         LineXY(14-i, 16-j, 22-i, 24-j, $80FFFFFF)
         LineXY(23-i, 16-j, 15-i, 24-j, $E0FFFFFF)
         LineXY(24-i, 16-j, 16-i, 24-j, $80FFFFFF)
         LineXY(22-i, 16-j, 14-i, 24-j, $80FFFFFF)
         DrawingMode(#PB_2DDrawing_Outlined)
         Line(000, 000, W, 1, #Color_LineColor)
         StopDrawing()
      EndIf
      
      ;左键按下状态
      \HoldDownID = CopyImage(ImageID, #PB_Any)
      If StartVectorDrawing(ImageVectorOutput(\HoldDownID))
         AddPathCircle(15, 18, 11)
         VectorSourceCircularGradient(15, 20, 20)
         VectorSourceGradientColor($FF0D1CB5, 0.0)
         VectorSourceGradientColor($FF0D1CB5, 0.6)
         VectorSourceGradientColor($FF000000, 1.0)
         FillPath() 
         StopVectorDrawing()
      EndIf
      i = 5 : j = 5-2
      If StartDrawing(ImageOutput(\HoldDownID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         LineXY(15-i, 16-j, 23-i, 24-j, $E0FFFFFF)
         LineXY(16-i, 16-j, 24-i, 24-j, $80FFFFFF)
         LineXY(14-i, 16-j, 22-i, 24-j, $80FFFFFF)
         LineXY(23-i, 16-j, 15-i, 24-j, $E0FFFFFF)
         LineXY(24-i, 16-j, 16-i, 24-j, $80FFFFFF)
         LineXY(22-i, 16-j, 14-i, 24-j, $80FFFFFF)
         DrawingMode(#PB_2DDrawing_Outlined)
         Line(000, 000, W, 1, #Color_LineColor)
         StopDrawing()
      EndIf      

   EndWith
EndProcedure

;创建普通按键
Procedure Color_btnGadget(*pGadget.__GadgetInfo, X, Y, W, H, Text$)
   With *pGadget
      \X = X : \Y = Y : \W = W : \H = H : \R = X+W : \B = Y+H
      \NormalcyID = CreateImage(#PB_Any, W, H)
      If StartDrawing(ImageOutput(\NormalcyID))
         DrawingMode(#PB_2DDrawing_Gradient)      
         BackColor(#Color_BackColor)
         FrontColor(#Color_LineColor)
         LinearGradient(0, 0, 0, H)    
         Box(0, 0, W, H)
         DrawingMode(#PB_2DDrawing_Transparent)
         DrawingFont(FontID(#fntDefault))
         X = (W-TextWidth(Text$))/2
         Y = (H-TextHeight(Text$))/2
         DrawText(X+0, Y+0, Text$, #Color_FontColor)
         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
         Box(0, 0, W, H, $40000000|#Color_HighColor)
         StopDrawing()
      EndIf
      
      \MouseTopID = CreateImage(#PB_Any, W, H)
      If StartDrawing(ImageOutput(\MouseTopID))
         DrawingMode(#PB_2DDrawing_Gradient)      
         BackColor(#Color_BackColor)
         FrontColor(#Color_LineColor)
         LinearGradient(0, 0, 0, H)    
         Box(0, 0, W, H)
         DrawingMode(#PB_2DDrawing_Transparent)
         DrawingFont(FontID(#fntDefault))
         DrawText(X+0, Y+0, Text$, #Color_FontColor)
         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
         Box(0, 0, W, H, $80000000|#Color_HighColor)
         StopDrawing()
      EndIf
      
      
      \HoldDownID = CreateImage(#PB_Any, W, H)
      If StartDrawing(ImageOutput(\HoldDownID))
         DrawingMode(#PB_2DDrawing_Gradient)      
         BackColor(#Color_BackColor)
         FrontColor(#Color_LineColor)
         LinearGradient(0, 0, 0, H)    
         Box(0, 0, W, H)
         DrawingMode(#PB_2DDrawing_Transparent)
         DrawingFont(FontID(#fntDefault))
         DrawText(X+0, Y+0, Text$, #Color_FontColor)
         DrawingMode(#PB_2DDrawing_Outlined)
         Box(0, 0, W, H, #Color_SideColor)
         StopDrawing()
      EndIf      
   EndWith
EndProcedure

;注销控件
Procedure Color_Release(*pGadget.__GadgetInfo)
   If *pGadget = 0 : ProcedureReturn #False: EndIf 
   With *pGadget
      \X = 0 : \Y = 0 : \R = 0: \B = 0 
      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf : \NormalcyID = 0
      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf : \MouseTopID = 0
      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf : \HoldDownID = 0
   EndWith
EndProcedure

;- ==========================
;- [Draw]
;[控件]绘制背景
Procedure Color_RedrawGadget(*pGadget.__GadgetInfo)
   With *pGadget
      If *pGadget = 0 : ProcedureReturn : EndIf 
      If _Color\pMouseTop = *pGadget And IsImage(\MouseTopID)
         DrawAlphaImage(ImageID(\MouseTopID), \X, \Y)
      ElseIf IsImage(\NormalcyID) 
         DrawAlphaImage(ImageID(\NormalcyID), \X, \Y)
      EndIf 
   EndWith
EndProcedure

Procedure Color_Redraw(RedrawMode=0, PosY = #PB_Ignore)

   With _Color
      If RedrawMode = -1 Or IsImage(\BKImage1ID) = 0
         TitleW = \WindowW
         TitleH = 36
         imgTitleID = CreateImage(#PB_Any, TitleW, TitleH)
         ;绘制标题栏背景
         If StartDrawing(ImageOutput(imgTitleID))
            DrawingMode(#PB_2DDrawing_Gradient)      
            FrontColor(#Color_BackColor)
            BackColor(#Color_LineColor)
            LinearGradient(0, 0, 0, TitleH)    
            Box(0, 0, TitleW, TitleH)
            DrawingMode(#PB_2DDrawing_AlphaBlend)  
            Line(0, TitleH-2, TitleW, 1, $40000000|#Color_LineColor)
            Box(0, 0, TitleW, TitleH, $10FFFFFF)
            StopDrawing()
         EndIf
         
         ;绘制标题栏关闭按键背景
         If StartVectorDrawing(ImageVectorOutput(imgTitleID))
            Pos = 25
            AddPathCircle(TitleW-Pos, (TitleH-30)/2+15, 15)
            VectorSourceCircularGradient(TitleW-Pos, (TitleH-30)/2+15, 15)
            VectorSourceGradientColor($FF000000, 0.0)
            VectorSourceGradientColor($80000000, 0.8)
            VectorSourceGradientColor($30FFFFFF, 1.0)
            FillPath() 
            StopVectorDrawing()
         EndIf 
         Color_btnCloseBox(\btnColorClose, \WindowW-40*1, 0, 36, 36, imgTitleID)
         
         ;绘制与当前窗体与鼠标事件无关的界面
         If IsImage(\BKImage1ID) : FreeImage(\BKImage1ID) : EndIf 
         If IsImage(\BKImage1ID) = 0
             \BKImage1ID = CreateImage(#PB_Any, \WindowW, \WindowH)
         EndIf 
         If StartDrawing(ImageOutput(\BKImage1ID))
            Box(000, 000, \WindowW, \WindowH, #Color_BackColor)
            DrawImage(ImageID(imgTitleID), 0, 0)

             ;====== ColorIndex域 ======
            X = 50+256
            Y = 20+036
            DrawingMode(#PB_2DDrawing_Default)  
            Box(X, Y, 025, 256, $FFFFFF)
            For B = 000 To 255 Step 06 : Line(X, Y, 025, 1, RGB(255, 000, B)) : Y+1 : Next 
            For R = 255 To 000 Step -6 : Line(X, Y, 025, 1, RGB(R, 000, 255)) : Y+1 : Next 
            For G = 000 To 255 Step 06 : Line(X, Y, 025, 1, RGB(000, G, 255)) : Y+1 : Next 
            For B = 255 To 000 Step -6 : Line(X, Y, 025, 1, RGB(000, 255, B)) : Y+1 : Next 
            For R = 000 To 255 Step 06 : Line(X, Y, 025, 1, RGB(R, 255, 000)) : Y+1 : Next 
            For G = 255 To 000 Step -6 : Line(X, Y, 025, 1, RGB(255, G, 000)) : Y+1 : Next 
            \cvsSpectrum\X = 40+256-7
            \cvsSpectrum\Y = 20+036-7
            \cvsSpectrum\R = 50+256+45+14
            \cvsSpectrum\B = 20+036+258+14
            StopDrawing()
         EndIf  
         FreeImage(imgTitleID)
      EndIf 
      
      If RedrawMode <> 0 Or IsImage(\BKImage2ID) = 0
         ;绘制与当前窗体与鼠标事件无关的界面
         If IsImage(\BKImage2ID) = 0
             \BKImage2ID = CreateImage(#PB_Any, \WindowW, \WindowH)
         EndIf 
         If StartDrawing(ImageOutput(\BKImage2ID))
            DrawImage(ImageID(\BKImage1ID), 0, 0)
            If PosY <> #PB_Ignore
               \Spectrum = Point(50+256+10, PosY)
               \Index = PosY
            EndIf 
            ;====== Gradient域 ======
            X = 20
            Y = 20+36
            Box(X, Y, 256, 256, $F0F0F0)
            ;左右红色渐变
            DrawingMode(#PB_2DDrawing_Gradient)      
            BackColor($FFFFFF)
            FrontColor(\Spectrum)
            LinearGradient(X, Y, 255, Y)    
            Box(X, Y, 256, 256)
            
            ;上下透明度渐变
            DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)      
            BackColor ($00000000)
            FrontColor($FF000000)
            LinearGradient(X, Y, X, 255)    
            Box(X, Y, 256, 256)
            \cvsGradient\X = X-5
            \cvsGradient\Y = Y-5
            \cvsGradient\R = X+256+10
            \cvsGradient\B = Y+256+10

            ;绘制边框
            DrawingMode(#PB_2DDrawing_Outlined)
            X = 20
            Y = 20+36
            Box(X-1, Y-1, 256+2, 256+2, #Color_LineColor)

            X = 50+256
            Y = 20+036
            Box(X-1, Y-1, 025+2, 258+2, #Color_LineColor)            
            Box(000, 000, \WindowW, \WindowH, #Color_LineColor)
            
            DrawingMode(#PB_2DDrawing_Transparent)
            DrawingFont(FontID(#fntDefault))
            X = 20 
            Y = (35-TextHeight(\Title$))/2
            DrawText(X+0, Y+0, \Title$, #Color_FontColor)
              StopDrawing()
         EndIf          

      EndIf 
      
      
      ;绘制与当前窗体与鼠标事件相关的界面
      ImageID = CreateImage(#PB_Any, \WindowW, \WindowH)
      If StartDrawing(ImageOutput(ImageID))
         DrawImage(ImageID(\BKImage2ID), 0, 0)
         DrawingMode(#PB_2DDrawing_AlphaBlend)         
         Color_RedrawGadget(\btnColorClose)
         DrawingMode(#PB_2DDrawing_Default) 
         
         \CurColor = Point(\PickerX, \PickerY)
;          \Spectrum = Point(30, \Index)
         X = 50+256
         Y = 0
         LineXY(X-2, Y+\Index-0, X-6, Y+\Index-4, #Color_HighColor)
         LineXY(X-2, Y+\Index-0, X-6, Y+\Index+4, #Color_HighColor)
         LineXY(X-8, Y+\Index-4, X-6, Y+\Index-4, #Color_HighColor)
         LineXY(X-8, Y+\Index+4, X-6, Y+\Index+4, #Color_HighColor)
         LineXY(X-9, Y+\Index-3, X-9, Y+\Index+3, #Color_HighColor)
         X = 50+256+24
         LineXY(X+2, Y+\Index-0, X+6, Y+\Index-4, #Color_HighColor)
         LineXY(X+2, Y+\Index-0, X+6, Y+\Index+4, #Color_HighColor)
         LineXY(X+8, Y+\Index-4, X+6, Y+\Index-4, #Color_HighColor)
         LineXY(X+8, Y+\Index+4, X+6, Y+\Index+4, #Color_HighColor)
         LineXY(X+9, Y+\Index-3, X+9, Y+\Index+3, #Color_HighColor)
         Box(360, 046, 055, 025, \CurColor) 
         Box(415, 046, 055, 025, \Color) 
         DrawingMode(#PB_2DDrawing_Outlined) 
         X = 20+000
         Y = 20+036
         Circle(0+\PickerX, 0+\PickerY, 08, #Color_HighColor)
         Circle(0+\PickerX, 0+\PickerY, 09, #Color_LineColor)   
         Box(360+0, 046+0, 110+0, 025+0, #Color_LineColor) 
         Box(360-1, 046-1, 110+2, 025+2, #Color_HighColor)
         
         DrawingMode(#PB_2DDrawing_Transparent)
         DrawingFont(FontID(#fntDefault))
         DrawText(360, 090, "R:", #Color_HighColor)
         DrawText(360, 120, "G:", #Color_HighColor)
         DrawText(360, 150, "B:", #Color_HighColor)
         
         DrawText(352, 180, "0x:", #Color_HighColor)
         DrawText(352, 210, " $:", #Color_HighColor)  
  
         Color_RedrawGadget(\btnPickColor)
         Color_RedrawGadget(\btnPickCancel)
         
         StopDrawing()
      EndIf 
      R = Red(\CurColor)
      G = Green(\CurColor)
      B = Blue(\CurColor)
      SetGadgetText(\txtColorRID, Str(R))
      SetGadgetText(\txtColorGID, Str(G))
      SetGadgetText(\txtColorBID, Str(B))
      SetGadgetText(\txtColor1ID, RSet(Hex(RGB(B,G,R)), 6, "0"))
      SetGadgetText(\txtColor2ID, RSet(Hex(\CurColor), 6, "0"))
      
      
      ;将对话框图像渲染到窗体
      If \hBackImage : Color_FreeBackImage(\hBackImage) : \hBackImage = 0 : EndIf 
      \hBackImage = Color_DrawBackImage(\hWindow, ImageID)
      FreeImage(ImageID)
   EndWith
   
EndProcedure


;- ==========================
;- [HOOK]
;光标在上事件
Procedure Color_Hook_MOUSEMOVE(*pMouse.POINTS)
   With _Color
      If Macro_Gadget_InRect(\btnColorClose)      : *pEventGadget = \btnColorClose
      ElseIf Macro_Gadget_InRect(\btnPickColor)   : *pEventGadget = \btnPickColor
      ElseIf Macro_Gadget_InRect(\btnPickCancel)  : *pEventGadget = \btnPickCancel
      ElseIf Macro_Gadget_InRect(\cvsGradient)  
         *pEventGadget = \cvsGradient
         If \pHoldDown = *pEventGadget
            \pMouseTop = *pEventGadget
            If *pMouse\X >= 20 And *pMouse\X <= 255+20 : \PickerX = *pMouse\X : EndIf 
            If *pMouse\Y >= 56 And *pMouse\Y <= 255+56 : \PickerY = *pMouse\Y : EndIf 
            Color_Redraw(#False)
            ProcedureReturn
         EndIf 
      ElseIf Macro_Gadget_InRect(\cvsSpectrum)  
         *pEventGadget = \cvsSpectrum
         If \pHoldDown = *pEventGadget
            If *pMouse\Y >= 20+36 And *pMouse\Y<=255+20+36
               \pMouseTop = *pEventGadget
               Color_Redraw(#True, *pMouse\Y)
               ProcedureReturn
            EndIf 
         EndIf 
      Else 
         \pHoldDown = 0
      EndIf 
      ;整理响应事件
      
      If \pMouseTop <> *pEventGadget
         \pMouseTop = *pEventGadget
         Color_Redraw(#False)
      EndIf   
   EndWith
EndProcedure

;左键按下事件
Procedure Color_Hook_LBUTTONDOWN(*pMouse.POINTS)
   With _Color
      If Macro_Gadget_InRect(\btnColorClose)      : *pEventGadget = \btnColorClose
      ElseIf Macro_Gadget_InRect(\btnPickColor)   : *pEventGadget = \btnPickColor
      ElseIf Macro_Gadget_InRect(\btnPickCancel)  : *pEventGadget = \btnPickCancel
      ElseIf Macro_Gadget_InRect(\cvsGradient)
         *pEventGadget = \cvsGradient
         If *pMouse\X >= 20 And *pMouse\X <= 255+20 : \PickerX = *pMouse\X : EndIf 
         If *pMouse\Y >= 56 And *pMouse\Y <= 255+56 : \PickerY = *pMouse\Y : EndIf 
         \pHoldDown = *pEventGadget
         Color_Redraw(#False)
         ProcedureReturn
      ElseIf Macro_Gadget_InRect(\cvsSpectrum)    
         *pEventGadget = \cvsSpectrum
         If *pMouse\Y >= 20+36 And *pMouse\Y<=255+20+36
            \pHoldDown = *pEventGadget
            Color_Redraw(#True, *pMouse\Y)
            ProcedureReturn
         EndIf 
      Else
         SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)      
      EndIf 
      ;整理响应事件
      If \pHoldDown <> *pEventGadget
         \pHoldDown = *pEventGadget
         Color_Redraw(#False)
      EndIf   
   EndWith
EndProcedure

;左键释放事件
Procedure Color_Hook_LBUTTONUP(*pMouse.POINTS)
   With _Color
      If Macro_Gadget_InRect(\btnColorClose)
         If \pHoldDown = \btnColorClose
            *pEventGadget = \btnColorClose
            PostEvent(#PB_Event_Gadget, #winColor, \btnColorClose)
         EndIf 
      ElseIf Macro_Gadget_InRect(\btnPickColor) 
         If \pHoldDown = \btnPickColor
            *pEventGadget = \btnPickColor
            PostEvent(#PB_Event_Gadget, #winColor, \btnPickColor)
         EndIf 
      ElseIf Macro_Gadget_InRect(\btnPickCancel) 
         If \pHoldDown = \btnPickCancel
            *pEventGadget = \btnPickCancel
            PostEvent(#PB_Event_Gadget, #winColor, \btnPickCancel)
         EndIf 
      ElseIf Macro_Gadget_InRect(\cvsGradient)
         *pEventGadget = \cvsGradient
      ElseIf Macro_Gadget_InRect(\cvsSpectrum) 
         *pEventGadget = \cvsSpectrum
      EndIf 
      
      ;整理响应事件
;       If \pHoldDown <> *pEventGadget
         \pHoldDown = 0
         Color_Redraw(#False)
;       EndIf   
   EndWith
EndProcedure

;注销事件
Procedure Color_Hook_DESTROY()
   With _Color
      Color_Release(\btnColorClose)
      Color_Release(\btnPickColor)
      Color_Release(\btnPickCancel)
      Color_FreeBackImage(\hBackImage)
;       If IsImage(\BKImageID) : FreeImage(\BKImageID) : EndIf 
   EndWith
EndProcedure

;挂钩事件
Procedure Color_Hook(hWindow, uMsg, wParam, lParam) 
   With _Color
      If \hWindow <> hWindow
         ProcedureReturn DefWindowProc_(hWindow, uMsg, wParam, lParam)
      EndIf
      Select uMsg 
         Case #WM_MOUSEMOVE     : Color_Hook_MOUSEMOVE  (@lParam)
         Case #WM_LBUTTONDOWN   : Color_Hook_LBUTTONDOWN(@lParam)
         Case #WM_LBUTTONUP     : Color_Hook_LBUTTONUP  (@lParam)
         Case #WM_DESTROY       : Color_Hook_DESTROY    () 
      EndSelect 
      Result = CallWindowProc_(\hWindowHook, hWindow, uMsg, wParam, lParam) 
   EndWith
   ProcedureReturn Result
EndProcedure

;- **************************
;初始化窗体
Procedure Color_Requester(hWindow, Color)

   With _Color
      If IsWindow(#winColor) : CloseWindow(#winColor) : EndIf 
      R = Red  (Color)
      G = Green(Color)
      B = Blue (Color)
      Max = R : If Max < G : Max = G : EndIf  : If Max < B : Max = B : EndIf 
      Min = R : If Min > G : Min = G : EndIf  : If Min > B : Min = B : EndIf 
      
      
      ;创建对话框窗体
      hParent = hWindow
      \WindowW = 480
      \WindowH = 296+36
      \Color   = Color
      \CurColor= Color
      \PickerX = 20
      \PickerY = 56
      \Index   = 20+036
      \Spectrum= $0000FF
      \Title$  = "迷路HSV取色器"
      If hParent = 0
         WindowFlags = #PB_Window_BorderLess|#PB_Window_ScreenCentered
         \hWindow = OpenWindow(#winColor, 0, 0, \WindowW, \WindowH, "", WindowFlags)
      Else 
         WindowFlags = #PB_Window_BorderLess|#PB_Window_WindowCentered
         \hWindow = OpenWindow(#winColor, 0, 0, \WindowW, \WindowH, "", WindowFlags, hParent)
      EndIf 

      Color_btnGadget (\btnPickColor,  \WindowW-120, \WindowH-090, 100, 030, "确定")
      Color_btnGadget (\btnPickCancel, \WindowW-120, \WindowH-050, 100, 030, "取消")

      
      \txtColorRID = StringGadget(#PB_Any, 380, 090-2, 040, 020, Str(Red(\Color)))
      \txtColorGID = StringGadget(#PB_Any, 380, 120-2, 040, 020, Str(Green(\Color)))
      \txtColorBID = StringGadget(#PB_Any, 380, 150-2, 040, 020, Str(Blue(\Color)))
      \txtColor1ID = StringGadget(#PB_Any, 380, 180-2, 080, 020, Hex(\Color))
      \txtColor2ID = StringGadget(#PB_Any, 380, 210-2, 080, 020, Hex(\Color))      

      SetGadgetFont(\txtColorRID, FontID(#fntDefault))
      SetGadgetFont(\txtColorGID, FontID(#fntDefault))
      SetGadgetFont(\txtColorBID, FontID(#fntDefault))
      SetGadgetFont(\txtColor1ID, FontID(#fntDefault))
      SetGadgetFont(\txtColor2ID, FontID(#fntDefault))

      EnableWindow_(hParent, #False)  ;让父窗体不响应动作
      Color_Redraw(-1)
      \hWindowHook = SetWindowLongPtr_(\hWindow, #GWL_WNDPROC, @Color_Hook()) 
      Repeat
         Select WindowEvent()
            Case #PB_Event_CloseWindow   : IsCloseWindow = #True
            Case #PB_Event_Gadget
               Select EventGadget()
                  Case \btnColorClose  : IsCloseWindow = #True
                  Case \btnPickColor   : IsCloseWindow = #True
                  Case \btnPickCancel  : IsCloseWindow = #True
               EndSelect
            Default 
         EndSelect
      Until IsCloseWindow = #True Or Result
      CloseWindow(#winColor)
      EnableWindow_(hParent, #True)   ;恢复父窗体的响应动作
   EndWith
   ProcedureReturn Result
EndProcedure

;- ##########################
;- [Demo]
LoadFont(#fntDefault, "", 12)
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "自绘对话框", WindowFlags)
CanvasGadget(#cvsScreen1, 100, 100, 030, 030)
CanvasGadget(#cvsScreen2, 150, 100, 030, 030)
CanvasGadget(#cvsScreen3, 200, 100, 030, 030)
CanvasGadget(#cvsScreen4, 250, 100, 030, 030)


Color_Requester(hWindow, $FF0000)
Repeat
   EventNum  = WindowEvent()
   GadgetID  = EventGadget()
   EventType = EventType()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_SizeWindow 
      Case #PB_Event_Gadget 
         Select EventGadget()
            Case #cvsScreen1

            Case #cvsScreen2

            Case #cvsScreen3

         EndSelect
      
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 641
; FirstLine = 421
; Folding = k9-
; EnableXP
; EnableUnicode