;***********************************
;迷路仟整理 2019.03.04
;自绘窗体_扁平化3
;***********************************
;1.基本功能:移动窗体和关闭功能
;2.增加最小化功能
;3.增加最大化/正常化功能

;-[Constant]
; 色彩方案1
; #Screen_BackColor = $282828
; #Screen_ForeColor = $585858
; #Screen_FontColor = $FFFFFF
; #Screen_HighColor = $FFFFFF
; #Screen_LineColor = $585858
; #Screen_SideColor = $000000
; ;色彩方案2
#Screen_BackColor = $F8E0D0
#Screen_ForeColor = $FF9048
#Screen_FontColor = $FFFFFF
#Screen_HighColor = $FF9050
#Screen_LineColor = $FF9048
#Screen_SideColor = $000000


Enumeration
   #winScreen
   #imgScreen
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
   IsHide.b
   keep.b[15]
EndStructure

;对话框结构
Structure __MainScreen
   hWindow.l
   hBackImage.i
   hWindowHook.i
   WindowW.w
   WindowH.w
   Flags.l
   Title$
   TitleImageID.i
   btnCloseBox.__GadgetInfo
   btnMinimize.__GadgetInfo
   btnNormalcy.__GadgetInfo
   btnMaximize.__GadgetInfo
   
   *pMouseTop.__GadgetInfo    ;当前光标在上
   *pHoldDown.__GadgetInfo    ;当前光标按住
   *pSelected.__GadgetInfo    ;选中状态: 预留兼对齐作用
EndStructure

Global _Screen.__MainScreen

;- ==========================
;- [Macro]
;[宏]判断操作域
Macro Macro_Gadget_InRect(Gadget)
   Bool(Gadget\IsHide = #False And
        *pMouse\X > Gadget\X And
        *pMouse\X < Gadget\R And 
        *pMouse\Y > Gadget\Y And 
        *pMouse\Y < Gadget\B)
EndMacro

;- ==========================
;- [BackImage]
;绘制窗体背景
Procedure Screen_DrawBackImage(hWindow, ImageID)
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
Procedure Screen_FreeBackImage(hBackImage)
   DeleteObject_(hBackImage)  
EndProcedure


;- ==========================
;- [Gadget]

;创建关闭按键
Procedure Screen_btnCloseBox(*pGadget.__GadgetInfo, X, Y, W, H, TitleImageID)
   With *pGadget
      \X = X
      \Y = Y 
      \W = W
      \H = H 
      \R = X+W 
      \B = Y+H
      If IsImage(TitleImageID)
         ImageID = GrabImage(TitleImageID, #PB_Any, X, Y, W, H)
      Else
         ImageID = CreateImage(#PB_Any, W, H)
      EndIf 
      \NormalcyID = CopyImage(ImageID, #PB_Any)

      ;正常状态
      i = 3 : j = 6
      If StartDrawing(ImageOutput(\NormalcyID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         LineXY(15-i, 16-j, 27-i, 28-j, $E0FFFFFF)
         LineXY(16-i, 16-j, 28-i, 28-j, $80FFFFFF)
         LineXY(14-i, 16-j, 26-i, 28-j, $80FFFFFF)
         LineXY(27-i, 16-j, 15-i, 28-j, $E0FFFFFF)
         LineXY(28-i, 16-j, 16-i, 28-j, $80FFFFFF)
         LineXY(26-i, 16-j, 14-i, 28-j, $80FFFFFF)
         DrawingMode(#PB_2DDrawing_Outlined)
         Line(000, 000, W, 1, #Screen_LineColor)
         StopDrawing()
      EndIf
      
      ;光标在上状态
      \MouseTopID = CopyImage(ImageID, #PB_Any)
      i = 3 : j = 6
      If StartDrawing(ImageOutput(\MouseTopID))
         Box(0, 0, W, H, $3954FF)
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         LineXY(15-i, 16-j, 27-i, 28-j, $E0FFFFFF)
         LineXY(16-i, 16-j, 28-i, 28-j, $80FFFFFF)
         LineXY(14-i, 16-j, 26-i, 28-j, $80FFFFFF)
         LineXY(27-i, 16-j, 15-i, 28-j, $E0FFFFFF)
         LineXY(28-i, 16-j, 16-i, 28-j, $80FFFFFF)
         LineXY(26-i, 16-j, 14-i, 28-j, $80FFFFFF)
         DrawingMode(#PB_2DDrawing_Outlined)
         Line(000, 000, W, 1, #Screen_LineColor)
         StopDrawing()
      EndIf
      
      ;左键按下状态
      \HoldDownID = CopyImage(ImageID, #PB_Any)
      i = 3 : j = 6
      If StartDrawing(ImageOutput(\HoldDownID))
         Box(0, 0, W, H, $3954FF)
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         LineXY(15-i, 16-j, 27-i, 28-j, $E0FFFFFF)
         LineXY(16-i, 16-j, 28-i, 28-j, $80FFFFFF)
         LineXY(14-i, 16-j, 26-i, 28-j, $80FFFFFF)
         LineXY(27-i, 16-j, 15-i, 28-j, $E0FFFFFF)
         LineXY(28-i, 16-j, 16-i, 28-j, $80FFFFFF)
         LineXY(26-i, 16-j, 14-i, 28-j, $80FFFFFF)
         DrawingMode(#PB_2DDrawing_Outlined)
         Line(000, 000, W, 1, #Screen_LineColor)
         StopDrawing()
      EndIf      

   EndWith
EndProcedure

;创建最小化按键
Procedure Screen_btnMinimize(*pGadget.__GadgetInfo, X, Y, W, H, TitleImageID)

   With *pGadget
      \X = X : \Y = Y : \W = W : \H = H : \R = X+W : \B = Y+H
      If IsImage(TitleImageID)
         ImageID = GrabImage(TitleImageID, #PB_Any, X, Y, W, H)
      Else
         ImageID = CreateImage(#PB_Any, W, H)
      EndIf 
      \NormalcyID = CopyImage(ImageID, #PB_Any)

      i = 3 : j = 8
      If StartDrawing(ImageOutput(\NormalcyID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         Box(14-i, 23-j, 15, 03, $C0FFFFFF)
         StopDrawing()
      EndIf
     
      \MouseTopID = CopyImage(ImageID, #PB_Any)
      i = 3 : j = 8
      If StartDrawing(ImageOutput(\MouseTopID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         Box(0, 0, W, H, $20000000)
         Box(14-i, 23-j, 15, 03, $C0FFFFFF)
         StopDrawing()
      EndIf
      
      \HoldDownID = CopyImage(ImageID, #PB_Any)
      i = 3 : j = 8
      If StartDrawing(ImageOutput(\HoldDownID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         Box(0, 0, W, H, $20000000)
         Box(14-i, 23-j, 15, 03, $FFFFFFFF)
         StopDrawing()
      EndIf
      FreeImage(ImageID)
   EndWith
   ProcedureReturn *pGadget
EndProcedure

;创建正常化按键
Procedure Screen_btnNormalcy(*pGadget.__GadgetInfo, X, Y, W, H, TitleImageID)

   With *pGadget
      \X = X : \Y = Y : \W = W : \H = H : \R = X+W : \B = Y+H
      If IsImage(\NormalcyID) : ProcedureReturn : EndIf 
      \IsHide = #True
      If IsImage(TitleImageID)
         ImageID = GrabImage(TitleImageID, #PB_Any, X, Y, W, H)
      Else
         ImageID = CreateImage(#PB_Any, W, H)
      EndIf 
      \NormalcyID = CopyImage(ImageID, #PB_Any)
      i = 3 : j = 4
      If StartDrawing(ImageOutput(\NormalcyID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         Box(14-i, 18-j, 09, 02,  $A0FFFFFF)
         Box(14-i, 20-j, 02, 06,  $A0FFFFFF)
         Box(16-i, 24-j, 09, 02,  $A0FFFFFF)
         Box(23-i, 18-j, 02, 06,  $A0FFFFFF)
         Box(17-i, 14-j, 09, 02,  $A0FFFFFF)
         Box(17-i, 16-j, 02, 02,  $A0FFFFFF)
         Box(25-i, 21-j, 03, 02,  $A0FFFFFF)
         Box(26-i, 14-j, 02, 07,  $A0FFFFFF)
         StopDrawing()
      EndIf
     
      \MouseTopID = CopyImage(ImageID, #PB_Any)      
      i = 3 : j = 4
      If StartDrawing(ImageOutput(\MouseTopID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         Box(0, 0, W, H, $20000000)
         Box(14-i, 18-j, 09, 02,  $A0FFFFFF)
         Box(14-i, 20-j, 02, 06,  $A0FFFFFF)
         Box(16-i, 24-j, 09, 02,  $A0FFFFFF)
         Box(23-i, 18-j, 02, 06,  $A0FFFFFF)
         Box(17-i, 14-j, 09, 02,  $A0FFFFFF)
         Box(17-i, 16-j, 02, 02,  $A0FFFFFF)
         Box(25-i, 21-j, 03, 02,  $A0FFFFFF)
         Box(26-i, 14-j, 02, 07,  $A0FFFFFF)
         StopDrawing()
      EndIf
    
      \HoldDownID = CopyImage(ImageID, #PB_Any)      
      i = 3 : j = 4
      If StartDrawing(ImageOutput(\HoldDownID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         Box(0, 0, W, H, $20000000)
         Box(14-i, 18-j, 09, 02,  $A0FFFFFF)
         Box(14-i, 20-j, 02, 06,  $A0FFFFFF)
         Box(16-i, 24-j, 09, 02,  $A0FFFFFF)
         Box(23-i, 18-j, 02, 06,  $A0FFFFFF)
         Box(17-i, 14-j, 09, 02,  $A0FFFFFF)
         Box(17-i, 16-j, 02, 02,  $A0FFFFFF)
         Box(25-i, 21-j, 03, 02,  $A0FFFFFF)
         Box(26-i, 14-j, 02, 07,  $A0FFFFFF)
         StopDrawing()
      EndIf
      FreeImage(ImageID)
   EndWith
   ProcedureReturn *pGadget
EndProcedure

;创建最大化按键
Procedure Screen_btnMaximize(*pGadget.__GadgetInfo, X, Y, W, H, TitleImageID)

   With *pGadget
      \X = X : \Y = Y : \W = W : \H = H : \R = X+W : \B = Y+H
      If IsImage(\NormalcyID) : ProcedureReturn : EndIf 
      If IsImage(TitleImageID)
         ImageID = GrabImage(TitleImageID, #PB_Any, X, Y, W, H)
      Else
         ImageID = CreateImage(#PB_Any, W, H)
      EndIf 
;       \IsHide = #True
      \NormalcyID = CopyImage(ImageID, #PB_Any)
      i = 3 : j = 5
      If StartDrawing(ImageOutput(\NormalcyID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         Box(14-i, 15-j, 11, 02,  $A0FFFFFF)
         Box(14-i, 17-j, 02, 11,  $A0FFFFFF)
         Box(16-i, 26-j, 11, 02,  $A0FFFFFF)
         Box(25-i, 15-j, 02, 11,  $A0FFFFFF)
         StopDrawing()
      EndIf

      \MouseTopID = CopyImage(ImageID, #PB_Any)
      i = 3 : j = 5
      If StartDrawing(ImageOutput(\MouseTopID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         Box(0, 0, W, H, $20000000)
         Box(14-i, 15-j, 11, 02,  $A0FFFFFF)
         Box(14-i, 17-j, 02, 11,  $A0FFFFFF)
         Box(16-i, 26-j, 11, 02,  $A0FFFFFF)
         Box(25-i, 15-j, 02, 11,  $A0FFFFFF)
         StopDrawing()
      EndIf
      
      \HoldDownID = CopyImage(ImageID, #PB_Any)
      i = 3 : j = 5
      If StartDrawing(ImageOutput(\HoldDownID))
         DrawingMode(#PB_2DDrawing_AlphaBlend) 
         Box(0, 0, W, H, $20000000)
         Box(14-i, 15-j, 11, 02,  $A0FFFFFF)
         Box(14-i, 17-j, 02, 11,  $A0FFFFFF)
         Box(16-i, 26-j, 11, 02,  $A0FFFFFF)
         Box(25-i, 15-j, 02, 11,  $A0FFFFFF)
         StopDrawing()
      EndIf
      FreeImage(ImageID)
   EndWith
   ProcedureReturn *pGadget
EndProcedure

;注销控件
Procedure Screen_Release(*pGadget.__GadgetInfo)
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
Procedure Screen_RedrawGadget(*pGadget.__GadgetInfo)
   With *pGadget
      If *pGadget = 0 : ProcedureReturn : EndIf 
      If *pGadget\IsHide = #True : ProcedureReturn : EndIf 
      If _Screen\pMouseTop = *pGadget And IsImage(\MouseTopID)
         DrawAlphaImage(ImageID(\MouseTopID), \X, \Y)
      ElseIf IsImage(\NormalcyID) 
         DrawAlphaImage(ImageID(\NormalcyID), \X, \Y)
      EndIf 
   EndWith
EndProcedure

Procedure Screen_Redraw(IsRecreate)
   With _Screen
      If IsRecreate = #True Or IsImage(\TitleImageID) = 0
         TitleW = \WindowW
         TitleH = 48
         If IsImage(\TitleImageID) : FreeImage(\TitleImageID) : EndIf 
         \TitleImageID = CreateImage(#PB_Any, TitleW, TitleH)
         
         ;绘制标题栏背景
         If StartDrawing(ImageOutput(\TitleImageID))
            Box(0, 0, TitleW, TitleH, #Screen_ForeColor)
            DrawingMode(#PB_2DDrawing_AlphaBlend)  
            Line(0, TitleH-1, TitleW, 1, $80000000|#Screen_LineColor)
            Box(0, 0, TitleW, TitleH, $10FFFFFF)

            DrawImage(ImageID(#imgScreen), 010, 010, 32, 32)
            DrawingMode(#PB_2DDrawing_Transparent)
            DrawingFont(FontID(#fntDefault))
            X = 50 
            Y = (48-TextHeight(\Title$))/2
            DrawText(X+0, Y+0, \Title$, #Screen_FontColor)
            StopDrawing()
         EndIf
         Screen_btnCloseBox(\btnCloseBox, \WindowW-5-36*1, 0, 40, 32, \TitleImageID)
         Screen_btnNormalcy(\btnNormalcy, \WindowW-5-36*2, 0, 36, 32, \TitleImageID)
         Screen_btnMaximize(\btnMaximize, \WindowW-5-36*2, 0, 36, 32, \TitleImageID)
         Screen_btnMinimize(\btnMinimize, \WindowW-5-36*3, 0, 36, 32, \TitleImageID)
      EndIf  

      ;绘制与当前窗体与鼠标事件相关的界面
      ImageID = CreateImage(#PB_Any, \WindowW, \WindowH)
      If StartDrawing(ImageOutput(ImageID))
         DrawingMode(#PB_2DDrawing_Default) 
         Box(0,0,\WindowW, \WindowH, #Screen_BackColor)
         DrawImage(ImageID(\TitleImageID), 0, 0)
         DrawingMode(#PB_2DDrawing_Outlined)
         Box(000, 000, \WindowW, \WindowH, #Screen_LineColor)
         DrawingMode(#PB_2DDrawing_AlphaBlend)  
         Screen_RedrawGadget(\btnCloseBox)
         Screen_RedrawGadget(\btnMinimize)
         Screen_RedrawGadget(\btnNormalcy)
         Screen_RedrawGadget(\btnMaximize)

         StopDrawing()
      EndIf 
      ;将对话框图像渲染到窗体
      If \hBackImage : Screen_FreeBackImage(\hBackImage) : \hBackImage = 0 : EndIf 
      \hBackImage = Screen_DrawBackImage(\hWindow, ImageID)
      FreeImage(ImageID)
   EndWith
EndProcedure
  

;- ==========================
;- [HOOK]
;光标在上事件
Procedure Screen_Hook_MOUSEMOVE(*pMouse.POINTS)
   With _Screen
      If     Macro_Gadget_InRect(\btnCloseBox)  : *pEventGadget = \btnCloseBox
      ElseIf Macro_Gadget_InRect(\btnMinimize)  : *pEventGadget = \btnMinimize
      ElseIf Macro_Gadget_InRect(\btnNormalcy)  : *pEventGadget = \btnNormalcy
      ElseIf Macro_Gadget_InRect(\btnMaximize)  : *pEventGadget = \btnMaximize
      EndIf 
      ;整理响应事件
      If \pMouseTop <> *pEventGadget
         \pMouseTop = *pEventGadget
         Screen_Redraw(#False)
      EndIf   
   EndWith
EndProcedure

;左键按下事件
Procedure Screen_Hook_LBUTTONDOWN(*pMouse.POINTS)
   With _Screen
      If     Macro_Gadget_InRect(\btnCloseBox)  : *pEventGadget = \btnCloseBox
      ElseIf Macro_Gadget_InRect(\btnMinimize)  : *pEventGadget = \btnMinimize   
      ElseIf Macro_Gadget_InRect(\btnNormalcy)  : *pEventGadget = \btnNormalcy
      ElseIf Macro_Gadget_InRect(\btnMaximize)  : *pEventGadget = \btnMaximize
      Else
         SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)      
      EndIf 
      ;整理响应事件
      If \pHoldDown <> *pEventGadget
         \pHoldDown = *pEventGadget
         Screen_Redraw(#False)
      EndIf   
   EndWith
EndProcedure

;左键释放事件
Procedure Screen_Hook_LBUTTONUP(*pMouse.POINTS)
   With _Screen
      If Macro_Gadget_InRect(\btnCloseBox)
         If \pHoldDown = \btnCloseBox
            *pEventGadget = \btnCloseBox
            PostEvent(#PB_Event_CloseWindow)
         EndIf 
      ElseIf Macro_Gadget_InRect(\btnMinimize)
         If \pHoldDown = \btnMinimize
            *pEventGadget = \btnMinimize
            ShowWindow_(\hWindow, 2)   ;最小化窗体
         EndIf  
      ElseIf Macro_Gadget_InRect(\btnNormalcy)
         If \pHoldDown = \btnNormalcy
            *pEventGadget = \btnNormalcy
            \btnNormalcy\IsHide = #True
            \btnMaximize\IsHide = #False
            ShowWindow_(\hWindow,1)    ;正常化窗体
            \pHoldDown = *pEventGadget
            \WindowW = WindowWidth(#winScreen)
            \WindowH = WindowHeight(#winScreen)
            Screen_Redraw(#True)
            ProcedureReturn
         EndIf           
      ElseIf Macro_Gadget_InRect(\btnMaximize)
         If \pHoldDown = \btnMaximize
            *pEventGadget = \btnMaximize
            \btnNormalcy\IsHide = #False
            \btnMaximize\IsHide = #True
            SystemParametersInfo_(#SPI_GETWORKAREA, 0, RECT.RECT, 0) ;获取桌面屏幕大小
            \WindowW = RECT\right-RECT\left+2
            \WindowH = RECT\bottom-RECT\top
            Screen_Redraw(#True)
            ShowWindow_(\hWindow,3)    ;最大化窗体
            MoveWindow_(\hWindow, 0, 0, \WindowW, \WindowH, #True)
            \pHoldDown = *pEventGadget
            Screen_Redraw(#False)
            ProcedureReturn
         EndIf 
      EndIf 
      ;整理响应事件
      If \pHoldDown <> *pEventGadget
         \pHoldDown = *pEventGadget
         Screen_Redraw(#False)
      EndIf   
   EndWith
EndProcedure

;注销事件
Procedure Screen_Hook_DESTROY()
   With _Screen
      Screen_Release(\btnCloseBox)
      Screen_Release(\btnMinimize)
      If IsImage(\TitleImageID) : FreeImage(\TitleImageID) : EndIf 
   EndWith
EndProcedure

Procedure Screen_Hook_SIZE(wParam)
   With _Screen
      If wParam = 0 And _Screen\btnMaximize\IsHide = #True
         \btnNormalcy\IsHide = #True
         \btnMaximize\IsHide = #False
         \pHoldDown = 0
         \WindowW = WindowWidth(#winScreen)
         \WindowH = WindowHeight(#winScreen)
         Screen_Redraw(#True)
      EndIf 
   EndWith
EndProcedure

;挂钩事件
Procedure Screen_Hook(hWindow, uMsg, wParam, lParam) 
   With _Screen
      If \hWindow <> hWindow
         ProcedureReturn DefWindowProc_(hWindow, uMsg, wParam, lParam)
      EndIf
      Select uMsg 
         Case #WM_SIZE          : Screen_Hook_SIZE       (wParam)
         Case #WM_MOUSEMOVE     : Screen_Hook_MOUSEMOVE  (@lParam)
         Case #WM_LBUTTONDOWN   : Screen_Hook_LBUTTONDOWN(@lParam)
         Case #WM_LBUTTONUP     : Screen_Hook_LBUTTONUP  (@lParam)
         Case #WM_DESTROY       : Screen_Hook_DESTROY    () 
      EndSelect 
      Result = CallWindowProc_(\hWindowHook, hWindow, uMsg, wParam, lParam) 
   EndWith
   ProcedureReturn Result
EndProcedure


;- ##########################
;- [Demo]
LoadFont(#fntDefault, "", 12)
UsePNGImageDecoder()
LoadImage(#imgScreen, ".\PureBasic.png")
With _Screen
   WindowFlags = #PB_Window_BorderLess|#PB_Window_ScreenCentered
   \WindowW = 550
   \WindowH = 350
   \hWindow = OpenWindow(#winScreen, 0, 0, \WindowW, \WindowH, "自绘窗体_扁平化3", WindowFlags)
   \Title$ = GetWindowTitle(#winScreen)
   Screen_Redraw(#True)
   \hWindowHook = SetWindowLongPtr_(\hWindow, #GWL_WNDPROC, @Screen_Hook()) 
   Repeat
      EventNum  = WindowEvent()
      GadgetID  = EventGadget()
      EventType = EventType()
      Select EventNum
         Case #PB_Event_CloseWindow : IsExitWindow = #True 
         Case #PB_Event_SizeWindow 
         Case #PB_Event_Gadget 
      EndSelect
      Delay(1)   
   Until IsExitWindow = #True 
EndWith
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = vy--
; EnableXP
; EnableUnicode