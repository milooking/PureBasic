;***********************************
;迷路仟整理 2019.02.16
;自绘对话框
;***********************************

;-[Constant]
;色彩方案1
; #Message_BackColor = $282828
; #Message_ForeColor = $585858
; #Message_FontColor = $FFFFFF
; #Message_HighColor = $FFFFFF
; #Message_LineColor = $585858
; #Message_SideColor = $000000
;色彩方案2
#Message_BackColor = $F8E0D0
#Message_ForeColor = $FF9048
#Message_FontColor = $000000
#Message_HighColor = $FF9050
#Message_LineColor = $FF9048
#Message_SideColor = $000000


Enumeration
   #winScreen
   #winMessage
   #btnScreen1
   #btnScreen2
   #btnScreen3
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
Structure __MessageRequester
   hWindow.l
   hBackImage.i
   hWindowHook.i
   WindowW.w
   WindowH.w
   Flags.l
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
   Button1$
   Button2$
   Button3$
   
EndStructure

Global _Message.__MessageRequester

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
Procedure Message_DrawBackImage(hWindow, ImageID)
   If IsImage(ImageID)
      hBackImage= CreatePatternBrush_(ImageID(ImageID))
      If hBackImage
         SetClassLongPtr_(hWindow, #GCL_HBRBACKGROUND, hBackImage)
         RedrawWindow_(hWindow, #Null, #Null, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)
      EndIf 
   EndIf 
   ProcedureReturn hBackImage
EndProcedure

;释放窗体背景句柄
Procedure Message_FreeBackImage(hBackImage)
   DeleteObject_(hBackImage)  
EndProcedure

;- ==========================
;- [Gadget]

;创建关闭按键
Procedure Message_btnCloseBox(*pGadget.__GadgetInfo, X, Y, W, H, ImageID)
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
         Line(000, 000, W, 1, #Message_LineColor)
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
         Line(000, 000, W, 1, #Message_LineColor)
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
         Line(000, 000, W, 1, #Message_LineColor)
         StopDrawing()
      EndIf      

   EndWith
EndProcedure

;创建普通按键
Procedure Message_btnGadget(*pGadget.__GadgetInfo, X, Y, W, H, Text$)
   With *pGadget
      \X = X : \Y = Y : \W = W : \H = H : \R = X+W : \B = Y+H
      \NormalcyID = CreateImage(#PB_Any, W, H)
      If StartDrawing(ImageOutput(\NormalcyID))
         DrawingMode(#PB_2DDrawing_Gradient)      
         BackColor(#Message_BackColor)
         FrontColor(#Message_ForeColor)
         LinearGradient(0, 0, 0, H)    
         Box(0, 0, W, H)
         DrawingMode(#PB_2DDrawing_Transparent)
         DrawingFont(FontID(#fntDefault))
         X = (W-TextWidth(Text$))/2
         Y = (H-TextHeight(Text$))/2
         DrawText(X+0, Y+0, Text$, #Message_FontColor)
         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
         Box(0, 0, W, H, $40000000|#Message_HighColor)
         StopDrawing()
      EndIf
      
      \MouseTopID = CreateImage(#PB_Any, W, H)
      If StartDrawing(ImageOutput(\MouseTopID))
         DrawingMode(#PB_2DDrawing_Gradient)      
         BackColor(#Message_BackColor)
         FrontColor(#Message_ForeColor)
         LinearGradient(0, 0, 0, H)    
         Box(0, 0, W, H)
         DrawingMode(#PB_2DDrawing_Transparent)
         DrawingFont(FontID(#fntDefault))
         DrawText(X+0, Y+0, Text$, #Message_FontColor)
         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
         Box(0, 0, W, H, $80000000|#Message_HighColor)
         StopDrawing()
      EndIf
      
      
      \HoldDownID = CreateImage(#PB_Any, W, H)
      If StartDrawing(ImageOutput(\HoldDownID))
         DrawingMode(#PB_2DDrawing_Gradient)      
         BackColor(#Message_BackColor)
         FrontColor(#Message_ForeColor)
         LinearGradient(0, 0, 0, H)    
         Box(0, 0, W, H)
         DrawingMode(#PB_2DDrawing_Transparent)
         DrawingFont(FontID(#fntDefault))
         DrawText(X+0, Y+0, Text$, #Message_FontColor)
         DrawingMode(#PB_2DDrawing_Outlined)
         Box(0, 0, W, H, #Message_SideColor)
         StopDrawing()
      EndIf      
   EndWith
EndProcedure

;注销控件
Procedure Message_Release(*pGadget.__GadgetInfo)
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
Procedure Message_RedrawGadget(*pGadget.__GadgetInfo)
   With *pGadget
      If *pGadget = 0 : ProcedureReturn : EndIf 
      If _Message\pMouseTop = *pGadget And IsImage(\MouseTopID)
         DrawAlphaImage(ImageID(\MouseTopID), \X, \Y)
      ElseIf IsImage(\NormalcyID) 
         DrawAlphaImage(ImageID(\NormalcyID), \X, \Y)
      EndIf 
   EndWith
EndProcedure

Procedure Message_Redraw(IsRecreate)

   With _Message
      If IsRecreate = #True Or IsImage(\BKImageID) = 0
         TitleW = \WindowW
         TitleH = 36
         imgTitleID = CreateImage(#PB_Any, TitleW, TitleH)
         ;绘制标题栏背景
         If StartDrawing(ImageOutput(imgTitleID))
            DrawingMode(#PB_2DDrawing_Gradient)      
            FrontColor(#Message_BackColor)
            BackColor(#Message_ForeColor)
            LinearGradient(0, 0, 0, TitleH)    
            Box(0, 0, TitleW, TitleH)
            DrawingMode(#PB_2DDrawing_AlphaBlend)  
            Line(0, TitleH-2, TitleW, 1, $80000000|#Message_LineColor)
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
         Message_btnCloseBox(\btnMessageClose, \WindowW-40*1, 0, 36, 36, imgTitleID)
         
         Select \Flags 
            Case #PB_MessageRequester_Ok
               Message_btnGadget (\btnMessageYes,   \WindowW/2-050, \WindowH-050, 100, 030, \Button1$)
    
            Case #PB_MessageRequester_YesNo
               Message_btnGadget (\btnMessageYes,   \WindowW/2-120, \WindowH-050, 100, 030, \Button1$)
               Message_btnGadget (\btnMessageNo,    \WindowW/2+020, \WindowH-050, 100, 030, \Button2$)
               
            Case  #PB_MessageRequester_YesNoCancel
               Message_btnGadget (\btnMessageYes,   \WindowW/2-170, \WindowH-050, 100, 030, \Button1$)
               Message_btnGadget (\btnMessageNo,    \WindowW/2-050, \WindowH-050, 100, 030, \Button2$)
               Message_btnGadget (\btnMessageCancel,\WindowW/2+070, \WindowH-050, 100, 030, \Button3$)
         EndSelect 
         
         ;绘制与当前窗体与鼠标事件无关的界面
         If IsImage(\BKImageID) : FreeImage(\BKImageID) : EndIf 
         \BKImageID = CreateImage(#PB_Any, \WindowW, \WindowH)
         If StartDrawing(ImageOutput(\BKImageID))
            Box(000, 000, \WindowW, \WindowH, #Message_BackColor)
            DrawImage(ImageID(imgTitleID), 0, 0)
            DrawingMode(#PB_2DDrawing_Outlined)
            Box(000, 000, \WindowW, \WindowH, #Message_LineColor)
            DrawingMode(#PB_2DDrawing_Transparent)
            DrawingFont(FontID(#fntDefault))
            X = 20 
            Y = (35-TextHeight(\Title$))/2
            DrawText(X+0, Y+0, \Title$, #Message_FontColor)
            X = 40 
            Y = 45
            ForEach \ListText$()
               DrawText(X+0, Y+0, \ListText$(),#Message_FontColor)
               Y + TextHeight(\ListText$()) + 5
            Next 
            StopDrawing()
         EndIf          
         FreeImage(imgTitleID)
      EndIf 
      
      
      ;绘制与当前窗体与鼠标事件相关的界面
      ImageID = CreateImage(#PB_Any, \WindowW, \WindowH)
      If StartDrawing(ImageOutput(ImageID))
         DrawImage(ImageID(\BKImageID), 0, 0)
         DrawingMode(#PB_2DDrawing_AlphaBlend)         
         Message_RedrawGadget(\btnMessageClose)
         Message_RedrawGadget(\btnMessageYes)
         Message_RedrawGadget(\btnMessageNo)
         Message_RedrawGadget(\btnMessageCancel)
         StopDrawing()
      EndIf 
      
      ;将对话框图像渲染到窗体
      If \hBackImage : Message_FreeBackImage(\hBackImage) : \hBackImage = 0 : EndIf 
      \hBackImage = Message_DrawBackImage(\hWindow, ImageID)
      FreeImage(ImageID)
   EndWith
   
EndProcedure


;- ==========================
;- [HOOK]
;光标在上事件
Procedure Message_Hook_MOUSEMOVE(*pMouse.POINTS)
   With _Message
      If     Macro_Gadget_InRect(\btnMessageClose)  : *pEventGadget = \btnMessageClose
      ElseIf Macro_Gadget_InRect(\btnMessageYes)    : *pEventGadget = \btnMessageYes
      ElseIf Macro_Gadget_InRect(\btnMessageNo)     : *pEventGadget = \btnMessageNo
      ElseIf Macro_Gadget_InRect(\btnMessageCancel) : *pEventGadget = \btnMessageCancel   
      EndIf 
      ;整理响应事件
      If \pMouseTop <> *pEventGadget
         \pMouseTop = *pEventGadget
         Message_Redraw(#False)
      EndIf   
   EndWith
EndProcedure

;左键按下事件
Procedure Message_Hook_LBUTTONDOWN(*pMouse.POINTS)
   With _Message
      If     Macro_Gadget_InRect(\btnMessageClose)  : *pEventGadget = \btnMessageClose
      ElseIf Macro_Gadget_InRect(\btnMessageYes)    : *pEventGadget = \btnMessageYes
      ElseIf Macro_Gadget_InRect(\btnMessageNo)     : *pEventGadget = \btnMessageNo
      ElseIf Macro_Gadget_InRect(\btnMessageCancel) : *pEventGadget = \btnMessageCancel
      Else
         SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)      
      EndIf 
      ;整理响应事件
      If \pHoldDown <> *pEventGadget
         \pHoldDown = *pEventGadget
         Message_Redraw(#False)
      EndIf   
   EndWith
EndProcedure

;左键释放事件
Procedure Message_Hook_LBUTTONUP(*pMouse.POINTS)
   With _Message
      If Macro_Gadget_InRect(\btnMessageClose)
         If \pHoldDown = \btnMessageClose
            *pEventGadget = \btnMessageClose
            PostEvent(#PB_Event_Gadget, #winMessage, \btnMessageClose)
         EndIf 
         
      ElseIf Macro_Gadget_InRect(\btnMessageYes)
         If \pHoldDown = \btnMessageYes
            *pEventGadget = \btnMessageYes
            PostEvent(#PB_Event_Gadget, #winMessage, \btnMessageYes)
         EndIf
         
      ElseIf Macro_Gadget_InRect(\btnMessageNo)
         If \pHoldDown = \btnMessageNo
            *pEventGadget = \btnMessageNo
            PostEvent(#PB_Event_Gadget, #winMessage, \btnMessageNo)
         EndIf
         
      ElseIf Macro_Gadget_InRect(\btnMessageCancel)
         If \pHoldDown = \btnMessageCancel
            *pEventGadget = \btnMessageCancel
            PostEvent(#PB_Event_Gadget, #winMessage, \btnMessageCancel)
         EndIf
      EndIf 
      
      ;整理响应事件
      If \pHoldDown <> *pEventGadget
         \pHoldDown = *pEventGadget
;          Message_Redraw(#False)
      EndIf   
   EndWith
EndProcedure

;注销事件
Procedure Message_Hook_DESTROY()
   With _Message
      Message_Release(\btnMessageClose)
      Message_Release(\btnMessageYes)
      Message_Release(\btnMessageNo)
      Message_Release(\btnMessageCancel)
      Message_FreeBackImage(\hBackImage)
;       If IsImage(\BKImageID) : FreeImage(\BKImageID) : EndIf 
      ClearList(\ListText$())
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
         Case #WM_DESTROY       : Message_Hook_DESTROY    () 
      EndSelect 
      Result = CallWindowProc_(\hWindowHook, hWindow, uMsg, wParam, lParam) 
   EndWith
   ProcedureReturn Result
EndProcedure





;- **************************
;初始化窗体
Procedure Message_Requester(hWindow, Title$, Notice$, Flags=#PB_MessageRequester_Ok)

   With _Message
      If IsWindow(#winMessage) : CloseWindow(#winMessage) : EndIf 
      
      ;分割文本,并计算文本占用的最大宽度和最大高度
      TempImageID = CreateImage(#PB_Any, 100, 100)
      ClearList(\ListText$())
      If StartDrawing(ImageOutput(TempImageID))
         DrawingFont(FontID(#fntDefault))
         H = 60
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

      ;根据标志,定义按键名称及计算最小宽度
      Select Flags 
         Case #PB_MessageRequester_Ok
            If W < 100 :  W = 100 : EndIf 
            \Button1$ = "OK"
            
         Case #PB_MessageRequester_YesNo
            If W < 240 :  W = 240 : EndIf 
            \Button1$ = "确认"
            \Button2$ = "取消"
            
         Case  #PB_MessageRequester_YesNoCancel
            If W < 340 :  W = 340 : EndIf
            \Button1$ = "是"
            \Button2$ = "否"
            \Button3$ = "取消"
      EndSelect 
      ;计算对话框的宽度和高度
      W = W + 40 + 40  
      H = H + 60 + 00  
      
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
      Message_Redraw(#True)
      EnableWindow_(hParent, #False)  ;让父窗体不响应动作
      \hWindowHook = SetWindowLongPtr_(\hWindow, #GWL_WNDPROC, @Message_Hook()) 
      Repeat
         Select WindowEvent()
            Case #PB_Event_CloseWindow   : IsCloseWindow = #True
            Case #PB_Event_Gadget
               Select EventGadget()
                  Case \btnMessageClose  : IsCloseWindow = #True
                  Case \btnMessageYes    : Result = #PB_MessageRequester_Yes
                  Case \btnMessageNo     : Result = #PB_MessageRequester_No
                  Case \btnMessageCancel : Result = #PB_MessageRequester_Cancel
               EndSelect
            Default 
         EndSelect
      Until IsCloseWindow = #True Or Result
      CloseWindow(#winMessage)
      EnableWindow_(hParent, #True)   ;恢复父窗体的响应动作
   EndWith
   ProcedureReturn Result
EndProcedure

;- ##########################
;- [Demo]
LoadFont(#fntDefault, "", 12)
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "自绘对话框", WindowFlags)
ButtonGadget(#btnScreen1, 050, 050, 300, 030, "对话框: #PB_MessageRequester_Ok")
ButtonGadget(#btnScreen2, 050, 100, 300, 030, "对话框: #PB_MessageRequester_YesNo")
ButtonGadget(#btnScreen3, 050, 150, 300, 030, "对话框: #PB_MessageRequester_YesNoCancel")
Repeat
   EventNum  = WindowEvent()
   GadgetID  = EventGadget()
   EventType = EventType()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_SizeWindow 
      Case #PB_Event_Gadget 
         Select EventGadget()
            Case #btnScreen1
               Debug Message_Requester(hWindow, "友情提示", "自绘对话框"+#LF$+"#PB_MessageRequester_Ok", #PB_MessageRequester_Ok)
            Case #btnScreen2
               Debug Message_Requester(hWindow, "友情提示", "自绘对话框"+#LF$+"#PB_MessageRequester_YesNo", #PB_MessageRequester_YesNo)
            Case #btnScreen3
               Debug Message_Requester(hWindow, "友情提示", "自绘对话框"+#LF$+"#PB_MessageRequester_YesNoCancel", #PB_MessageRequester_YesNoCancel)
         EndSelect

   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 581
; FirstLine = 209
; Folding = MYg
; EnableXP
; EnableUnicode