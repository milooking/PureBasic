;***********************************
;迷路仟整理 2019.02.18
;自绘按键控件
;***********************************

;-[Constant]

#Button_BackColor = $282828
#Button_LineColor = $B8B8B8
#Button_FontColor = $FFFFFF
#Button_HighColor = $FFFFFF
#Button_SideColor = $FFA080


Enumeration
   #winScreen
   #imgButton
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
Structure __MainSrceen
   hWindow.l
   hBackImage.i
   hWindowHook.i
   
   btnButton1.__GadgetInfo
   btnButton2.__GadgetInfo
   btnButton3.__GadgetInfo
   btnButton4.__GadgetInfo
   
   *pMouseTop.__GadgetInfo    ;当前光标在上
   *pHoldDown.__GadgetInfo    ;当前光标按住
   *pSelected.__GadgetInfo    ;选中状态: 预留兼对齐作用
EndStructure

Global _Srceen.__MainSrceen
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
Procedure Button_DrawBackImage(hWindow, ImageID)
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
Procedure Button_FreeBackImage(hBackImage)
   DeleteObject_(hBackImage)  
EndProcedure

;- ==========================
;- [Gadget]
;创建普通按键
Procedure Button_btnGadget(*pGadget.__GadgetInfo, X, Y, W, H, Text$)
   With *pGadget
      \X = X : \Y = Y : \W = W : \H = H : \R = X+W : \B = Y+H
      \NormalcyID = CreateImage(#PB_Any, W, H)
      If StartDrawing(ImageOutput(\NormalcyID))
         DrawingMode(#PB_2DDrawing_Gradient)      
         BackColor(#Button_BackColor)
         FrontColor(#Button_LineColor)
         LinearGradient(0, 0, 0, H)    
         Box(0, 0, W, H)
         DrawingMode(#PB_2DDrawing_Transparent)
         DrawingFont(FontID(#fntDefault))
         X = (W-TextWidth(Text$))/2
         Y = (H-TextHeight(Text$))/2
         DrawText(X+0, Y+0, Text$, #Button_FontColor)
         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
         Box(0, 0, W, H, $A0000000|#Button_SideColor)
         StopDrawing()
      EndIf
      
      \MouseTopID = CreateImage(#PB_Any, W, H)
      If StartDrawing(ImageOutput(\MouseTopID))
         DrawingMode(#PB_2DDrawing_Gradient)      
         BackColor(#Button_BackColor)
         FrontColor(#Button_LineColor)
         LinearGradient(0, 0, 0, H)    
         Box(0, 0, W, H)
         DrawingMode(#PB_2DDrawing_Transparent)
         DrawingFont(FontID(#fntDefault))
         DrawText(X+0, Y+0, Text$, #Button_SideColor)
         DrawingMode(#PB_2DDrawing_Outlined|#PB_2DDrawing_AlphaBlend)
         Box(0, 0, W, H, $C0000000|#Button_SideColor)
         StopDrawing()
      EndIf
      
      
      \HoldDownID = CreateImage(#PB_Any, W, H)
      If StartDrawing(ImageOutput(\HoldDownID))
         DrawingMode(#PB_2DDrawing_Gradient)      
         BackColor(#Button_BackColor)
         FrontColor(#Button_LineColor)
         LinearGradient(0, 0, 0, H)    
         Box(0, 0, W, H)
         DrawingMode(#PB_2DDrawing_Transparent)
         DrawingFont(FontID(#fntDefault))
         DrawText(X+1, Y+1, Text$, #Button_SideColor)
         DrawText(X+0, Y+0, Text$, #Button_FontColor)
         DrawingMode(#PB_2DDrawing_Outlined)
         Box(0, 0, W, H, #Button_SideColor)
         StopDrawing()
      EndIf      
   EndWith
EndProcedure

;注销控件
Procedure Button_Release(*pGadget.__GadgetInfo)
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
Procedure Button_RedrawGadget(*pGadget.__GadgetInfo)
   With *pGadget
      If *pGadget = 0 : ProcedureReturn : EndIf 
      If _Srceen\pHoldDown = *pGadget And IsImage(\HoldDownID)
         DrawAlphaImage(ImageID(\HoldDownID), \X, \Y)        
      ElseIf _Srceen\pMouseTop = *pGadget And IsImage(\MouseTopID)
         DrawAlphaImage(ImageID(\MouseTopID), \X, \Y)
      ElseIf IsImage(\NormalcyID) 
         DrawAlphaImage(ImageID(\NormalcyID), \X, \Y)
      EndIf 
   EndWith
EndProcedure

Procedure Button_Redraw()
   If StartDrawing(ImageOutput(#imgButton))
      W = ImageWidth (#imgButton)
      H = ImageHeight(#imgButton)
      Box(0,0,W,H,$F0F0F0)
      
      DrawingMode(#PB_2DDrawing_AlphaBlend)         
      Button_RedrawGadget(_Srceen\btnButton1)
      Button_RedrawGadget(_Srceen\btnButton2)
      Button_RedrawGadget(_Srceen\btnButton3)
      Button_RedrawGadget(_Srceen\btnButton4)
      StopDrawing()
      ;将对话框图像渲染到窗体
      If _Srceen\hBackImage : Button_FreeBackImage(_Srceen\hBackImage) : _Srceen\hBackImage = 0 : EndIf 
      _Srceen\hBackImage = Button_DrawBackImage(_Srceen\hWindow, #imgButton)
   EndIf     
EndProcedure

;- ==========================
;- [HOOK]
;光标在上事件
Procedure Button_Hook_MOUSEMOVE(*pMouse.POINTS)
   With _Srceen
      If     Macro_Gadget_InRect(\btnButton1)   : *pEventGadget = \btnButton1
      ElseIf Macro_Gadget_InRect(\btnButton2)   : *pEventGadget = \btnButton2
      ElseIf Macro_Gadget_InRect(\btnButton3)   : *pEventGadget = \btnButton3
      ElseIf Macro_Gadget_InRect(\btnButton4)   : *pEventGadget = \btnButton4   
      EndIf 
      ;整理响应事件
      If \pMouseTop <> *pEventGadget
         \pMouseTop = *pEventGadget
         If \pHoldDown <> *pEventGadget
            \pHoldDown = 0
         EndIf 
         Button_Redraw()
      EndIf   
   EndWith
EndProcedure

;左键按下事件
Procedure Button_Hook_LBUTTONDOWN(*pMouse.POINTS)
   With _Srceen
      If     Macro_Gadget_InRect(\btnButton1)   : *pEventGadget = \btnButton1
      ElseIf Macro_Gadget_InRect(\btnButton2)   : *pEventGadget = \btnButton2
      ElseIf Macro_Gadget_InRect(\btnButton3)   : *pEventGadget = \btnButton3
      ElseIf Macro_Gadget_InRect(\btnButton4)   : *pEventGadget = \btnButton4
      Else
         SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)      
      EndIf 
      ;整理响应事件
      If \pHoldDown <> *pEventGadget
         \pHoldDown = *pEventGadget
         Button_Redraw()
      EndIf   
   EndWith
EndProcedure

;左键释放事件
Procedure Button_Hook_LBUTTONUP(*pMouse.POINTS)
   With _Srceen
      If Macro_Gadget_InRect(\btnButton1)
         If \pHoldDown = \btnButton1
            *pEventGadget = \btnButton1
            PostEvent(#PB_Event_Gadget, #winScreen, \btnButton1)
         EndIf 
         
      ElseIf Macro_Gadget_InRect(\btnButton2)
         If \pHoldDown = \btnButton2
            *pEventGadget = \btnButton2
            PostEvent(#PB_Event_Gadget, #winScreen, \btnButton2)
         EndIf
         
      ElseIf Macro_Gadget_InRect(\btnButton3)
         If \pHoldDown = \btnButton3
            *pEventGadget = \btnButton3
            PostEvent(#PB_Event_Gadget, #winScreen, \btnButton3)
         EndIf
         
      ElseIf Macro_Gadget_InRect(\btnButton4)
         If \pHoldDown = \btnButton4
            *pEventGadget = \btnButton4
            PostEvent(#PB_Event_Gadget, #winScreen, \btnButton4)
         EndIf
      EndIf 
      
      ;整理响应事件
      \pHoldDown = 0
      Button_Redraw()
   EndWith
EndProcedure

;注销事件
Procedure Button_Hook_DESTROY()
   With _Srceen
      Button_Release(\btnButton1)
      Button_Release(\btnButton2)
      Button_Release(\btnButton3)
      Button_Release(\btnButton4)
      Button_FreeBackImage(\hBackImage)
   EndWith
EndProcedure

;挂钩事件
Procedure Button_Hook(hWindow, uMsg, wParam, lParam) 
   With _Srceen
      If \hWindow <> hWindow
         ProcedureReturn DefWindowProc_(hWindow, uMsg, wParam, lParam)
      EndIf
      Select uMsg 
         Case #WM_MOUSEMOVE     : Button_Hook_MOUSEMOVE  (@lParam)
         Case #WM_LBUTTONDOWN   : Button_Hook_LBUTTONDOWN(@lParam)
         Case #WM_LBUTTONUP     : Button_Hook_LBUTTONUP  (@lParam)
         Case #WM_DESTROY       : Button_Hook_DESTROY    () 
      EndSelect 
      Result = CallWindowProc_(\hWindowHook, hWindow, uMsg, wParam, lParam) 
   EndWith
   ProcedureReturn Result
EndProcedure


;- ##########################
;- [Demo]
LoadFont(#fntDefault, "", 12)
With _Srceen
   WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
   \hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "自绘按键控件", WindowFlags)
   CreateImage(#imgButton, 400, 250, 32)
   Button_btnGadget(\btnButton1, 100, 100, 090, 030, "测试按键1")
   Button_btnGadget(\btnButton2, 200, 100, 090, 030, "测试按键2")
   Button_btnGadget(\btnButton3, 100, 150, 090, 030, "测试按键3")
   Button_btnGadget(\btnButton4, 200, 150, 090, 030, "测试按键4")
   Button_Redraw()
   \hWindowHook = SetWindowLongPtr_(\hWindow, #GWL_WNDPROC, @Button_Hook()) 
EndWith
      
Repeat
   EventNum  = WindowEvent()
   GadgetID  = EventGadget()
   EventType = EventType()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_SizeWindow 
      Case #PB_Event_Gadget 
         Select EventGadget()
            Case _Srceen\btnButton1 : Debug "测试按键1"
            Case _Srceen\btnButton2 : Debug "测试按键2"
            Case _Srceen\btnButton3 : Debug "测试按键3"
            Case _Srceen\btnButton4 : Debug "测试按键4"
         EndSelect
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 296
; FirstLine = 269
; Folding = -0-
; EnableXP
; EnableUnicode