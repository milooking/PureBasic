;***********************************
;迷路仟整理 2019.03.12
;自绘窗体_设置刷新域
;***********************************

;在最小化和关闭键之间来回移动光标,会发布,左侧按键不会闪烁,右侧按键会不时的闪烁

;-[Constant]
Enumeration
   #winScreen           ;窗体编号
   ;======
   #imgScreen           ;主界面背景图像
   #fntDefault          ;默认字体编号
EndEnumeration

#SysButton_CloseColor = $C03954FF   ;关闭按键底色
#CaptionH = 40                      ;标题栏高度

;-[Structure]
;界面/控件颜色设置
Structure __ScreenColorInfo
   BackColor.l    ;背景色
   ForeColor.l    ;前景色
   FontColor.l    ;字体色
   SideColor.l    ;边框色
   HighColor.l    ;高亮色
EndStructure

;控件基本结构
Structure __GadgetInfo
   X.l            ;左际/X坐标
   Y.l            ;上际/Y坐标
   R.l            ;右际
   B.l            ;下际
   W.l
   H.l
   ;======
   NormalcyID.i   ;正常状态下的控件图像编号
   MouseTopID.i   ;鼠标置顶时的控件图像编号
   HoldDownID.i   ;左键按下时的控件图像编号
   ;======
   IsHide.b       ;控件是否隐藏
   IsCreate.b     ;控件是否创建
   Keep.b[2]      ;保留空间/对齐
EndStructure

;主界面结构
Structure __MainScreen
   WindowW.w         ;主界面窗体宽度
   WindowH.w         ;主界面窗体高度
   hWindow.i         ;主界面窗体句柄
   hWindowHook.i     ;主界面HOOK句柄
   hBackImage.i      ;主界面背景句柄
   hDefaultIcon.i    ;软件默认图标句柄
   SoftwareIconID.l  ;软件图标编号
   ;======
   Title$            ;窗体标题
   SystemPath$       ;系统路径
   DimColor.__ScreenColorInfo[5]    ;颜色参数
   ;======
   btnCloseBox.__GadgetInfo   ;关闭窗体小按键
   btnMinimize.__GadgetInfo   ;最小化窗体小按键
   ;======
   *pMouseTop.__GadgetInfo    ;当前光标在上
   *pHoldDown.__GadgetInfo    ;当前光标按住
   *pSelected.__GadgetInfo    ;选中状态
   ;======
   IsExitWindow.b             ;关闭窗体条件
EndStructure

;-[Global]
Global _Screen.__MainScreen


;- ==========================
;- [Macro]
;[宏]判断操作域
Macro Macro_Gadget_InRect1(Gadget)
   *pMouse\X > Gadget\X And *pMouse\X < Gadget\R And *pMouse\Y > Gadget\Y And *pMouse\Y < Gadget\B
EndMacro

Macro Macro_Gadget_InRect2(Gadget)
   Gadget\IsHide = #False And *pMouse\X > Gadget\X And *pMouse\X < Gadget\R And *pMouse\Y > Gadget\Y And *pMouse\Y < Gadget\B
EndMacro

Macro Macro_Gadget_InRect3(Gadget)
   Gadget\IsCreate = #True And *pMouse\X > Gadget\X And *pMouse\X < Gadget\R And *pMouse\Y > Gadget\Y And *pMouse\Y < Gadget\B
EndMacro


;- ==========================
;- [Draw]
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

;主界面自绘函数
Procedure Redraw_Screen()
   With _Screen
      If IsImage(#imgScreen) = 0
         hImageScreen = CreateImage(#imgScreen, \WindowW+200, \WindowH+200)
      ElseIf ImageWidth(#imgScreen) <> \WindowW+200 Or ImageHeight(#imgScreen) <> \WindowH+200
         FreeImage(#imgScreen)
         hImageScreen = CreateImage(#imgScreen, \WindowW+200, \WindowH+200)
      Else 
         hImageScreen = ImageID(#imgScreen)
      EndIf 
      If hImageScreen = 0 : ProcedureReturn : EndIf

      If StartDrawing(ImageOutput(#imgScreen))
         DrawingFont(FontID(#fntDefault))
         ;绘制窗体布局
         *pColor.__ScreenColorInfo = @\DimColor[0]
         DrawingMode(#PB_2DDrawing_Default)
         Box(0,0,\WindowW+200, \WindowH+200, *pColor\BackColor & $FFFFFF)
         DrawingMode(#PB_2DDrawing_AlphaBlend)
         Box(0,0,\WindowW, \WindowH, *pColor\BackColor)

         ;绘制标题栏
         *pColor.__ScreenColorInfo = @\DimColor[1]
         DrawingMode(#PB_2DDrawing_AlphaBlend)
         Box(0,0,\WindowW, #CaptionH, *pColor\BackColor)
         DrawingMode(#PB_2DDrawing_AlphaBlend)
         Box(1, 0, 1, #CaptionH, *pColor\HighColor)
         Box(1, 1, \WindowW-1, 1, *pColor\HighColor)
         Box(0, #CaptionH-1, \WindowW, 1, *pColor\SideColor)
         IconHeight = #CaptionH-8
         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Transparent)
         If IsImage(\SoftwareIconID)
            DrawImage(ImageID(\SoftwareIconID), 10, (#CaptionH-IconHeight)/2, IconHeight, IconHeight)
            DrawText(20+IconHeight, (#CaptionH-TextHeight(\Title$))/2, \Title$, *pColor\FontColor)
         Else
            DrawImage(_Screen\hDefaultIcon, 10, (#CaptionH-32)/2, IconHeight, IconHeight)
            DrawText(20+IconHeight, (#CaptionH-TextHeight(\Title$))/2, \Title$, *pColor\FontColor)
         EndIf

         ;绘制系统小按键
         ButtonY = 1 
         ButtonX = \WindowW-1-\btnCloseBox\W
         Redraw_Gadget(\btnCloseBox, ButtonX, ButtonY)
         ButtonX = ButtonX-1-\btnMinimize\W
         Redraw_Gadget(\btnMinimize, ButtonX, ButtonY)

         ;绘制主界面边框
         *pColor.__ScreenColorInfo = @\DimColor[0]
         DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
         Box(0,0,\WindowW, \WindowH, *pColor\SideColor)
         DrawingMode(#PB_2DDrawing_AlphaBlend)
         Box(1, #CaptionH, \WindowW-2, 1, *pColor\HighColor)
         Box(1, #CaptionH, 1, \WindowH-#CaptionH-1, *pColor\HighColor)
         StopDrawing()
      EndIf 

      If \hBackImage : DeleteObject_(\hBackImage) : \hBackImage = 0 : EndIf  ;释放窗体背景句柄
      ;将背景图像渲染到窗体
      \hBackImage= CreatePatternBrush_(hImageScreen)
      If \hBackImage
         ;设置刷新域,去掉窗体界面控件部分 注意:*pRectScreen.RECT, *pRgnCombine是指针,不一样
         *pRgnCombine = CreateRectRgn_(0,0,\WindowW, \WindowH)           ;设置一个大的区域
         *pRgnReserve = CreateRectRgn_(100,100,100+100,100+50)           ;设置第一个按键的区域
         CombineRgn_(*pRgnCombine,*pRgnCombine,*pRgnReserve,#RGN_DIFF)   ;在大区域中挖去按键区域
;          *pRgnReserve = CreateRectRgn_(300,100,300+100,100+50)           ;设置第二个按键的区域
;          CombineRgn_(*pRgnCombine,*pRgnCombine,*pRgnReserve,#RGN_DIFF)   ;在大区域中挖去按键区域
         SetClassLongPtr_(\hWindow, #GCL_HBRBACKGROUND, \hBackImage)
         RedrawWindow_(\hWindow, *pRectScreen, *pRgnCombine, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)
      EndIf 
   EndWith
EndProcedure


;- ==========================
;- [HOOK]
;光标在上事件
Procedure Screen_Hook_MOUSEMOVE(*pMouse.POINTS)
   With _Screen
      If     Macro_Gadget_InRect1(\btnCloseBox)  : *pEventGadget = \btnCloseBox
      ElseIf Macro_Gadget_InRect1(\btnMinimize)  : *pEventGadget = \btnMinimize
      EndIf 

      ;整理响应事件
      If \pMouseTop <> *pEventGadget : \pMouseTop = *pEventGadget : Redraw_Screen() : EndIf
   EndWith
   ProcedureReturn Result
EndProcedure

;左键按下事件
Procedure Screen_Hook_LBUTTONDOWN(*pMouse.POINTS)
   With _Screen
      If     Macro_Gadget_InRect1(\btnCloseBox)  : *pEventGadget = \btnCloseBox
      ElseIf Macro_Gadget_InRect1(\btnMinimize)  : *pEventGadget = \btnMinimize
      Else
         SendMessage_(\hWindow, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)
      EndIf 

      ;整理响应事件
      If \pHoldDown <> *pEventGadget : \pHoldDown = *pEventGadget : Redraw_Screen() : EndIf
   EndWith
   ProcedureReturn Result
EndProcedure

;左键释放事件
Procedure Screen_Hook_LBUTTONUP(*pMouse.POINTS)
   With _Screen
      If Macro_Gadget_InRect1(\btnCloseBox) 
         *pEventGadget = \btnCloseBox 
         If \pHoldDown = \btnCloseBox : PostEvent(#PB_Event_CloseWindow) : EndIf
      ElseIf Macro_Gadget_InRect1(\btnMinimize)
         *pEventGadget = \btnMinimize
         If \pHoldDown = \btnMinimize : ShowWindow_(\hWindow, 2) : EndIf    ;最小化窗体
      EndIf 

      ;整理响应事件
      If \pHoldDown Or \pMouseTop : \pHoldDown = 0 : \pMouseTop = 0 : Redraw_Screen() : EndIf
   EndWith
   ProcedureReturn Result
EndProcedure

;挂钩事件
Procedure Screen_HookWindow(hWindow, uMsg, wParam, lParam) 
   With _Screen
      If \hWindow <> hWindow
         ProcedureReturn DefWindowProc_(hWindow, uMsg, wParam, lParam)
      EndIf
      Select uMsg 
         Case #WM_MOUSEMOVE     : Result = Screen_Hook_MOUSEMOVE    (@lParam)
         Case #WM_LBUTTONDOWN   : Result = Screen_Hook_LBUTTONDOWN  (@lParam)
         Case #WM_LBUTTONUP     : Result = Screen_Hook_LBUTTONUP    (@lParam)
      EndSelect 
      If Result = 0 
         Result = CallWindowProc_(\hWindowHook, hWindow, uMsg, wParam, lParam) 
      EndIf
   EndWith
   ProcedureReturn Result
EndProcedure


;-==========================
;-[Create]
;创建关闭按键
Procedure Create_btnCloseBox(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
      *pColor.__ScreenColorInfo = @_Screen\DimColor[1]
      FontColor  = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)
      CloseColor = (Alpha(#SysButton_CloseColor) << 23 & $FF000000) |(#SysButton_CloseColor & $FFFFFF)
      \W = 40 : \H = 24 : i = (\W-9)/2 : j = (\H-10)/2

      ;绘制正常状态下的控件图像
      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
      If StartDrawing(ImageOutput(\NormalcyID))
         DrawingMode(#PB_2DDrawing_AlphaBlend)
         LineXY(i+0, j+0, i+9+0, j+9, FontColor)
         LineXY(i+1, j+0, i+9+1, j+9, *pColor\FontColor)
         LineXY(i+2, j+0, i+9+2, j+9, FontColor)
         LineXY(i+0, j+9, i+9+0, j+0, FontColor)   
         LineXY(i+1, j+9, i+9+1, j+0, *pColor\FontColor) 
         LineXY(i+2, j+9, i+9+2, j+0, FontColor) 
         StopDrawing()
      EndIf

      ;绘制鼠标置顶时的控件图像
        \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
        If StartDrawing(ImageOutput(\MouseTopID))
           DrawingMode(#PB_2DDrawing_AlphaBlend)
           Box(000, 000, \W, \H, #SysButton_CloseColor)    ;背景渲染
           DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
           StopDrawing()
        EndIf

      ;绘制左键按下时的控件图像
        \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
        If StartDrawing(ImageOutput(\HoldDownID))
           DrawingMode(#PB_2DDrawing_AlphaBlend)
           Box(000, 000, \W, \H, CloseColor)               ;背景渲染
           DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
           StopDrawing()
        EndIf

   EndWith
EndProcedure

;创建最小化按键
Procedure Create_btnMinimize(*pGadget.__GadgetInfo)
   With *pGadget
      \IsCreate = #True
      If IsImage(\NormalcyID) : FreeImage(\NormalcyID) : EndIf 
      If IsImage(\MouseTopID) : FreeImage(\MouseTopID) : EndIf 
      If IsImage(\HoldDownID) : FreeImage(\HoldDownID) : EndIf 
      *pColor.__ScreenColorInfo = @_Screen\DimColor[1]
      FontColor  = (Alpha(*pColor\FontColor) << 23 & $FF000000) |(*pColor\FontColor & $FFFFFF)
      ForeColor  = (Alpha(*pColor\ForeColor) << 23 & $FF000000) |(*pColor\ForeColor & $FFFFFF)
      \W = 28 : \H = 22 : i = (\W-9)/2 : j = (\H-3)/2

      ;绘制正常状态下的控件图像
      \NormalcyID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
      If StartDrawing(ImageOutput(\NormalcyID))
         DrawingMode(#PB_2DDrawing_AlphaBlend)
         Box(i, j+0, 09, 03, FontColor)
         Box(i, j+1, 09, 01, *pColor\FontColor)
         StopDrawing()
      EndIf

      ;绘制鼠标置顶时的控件图像
        \MouseTopID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
        If StartDrawing(ImageOutput(\MouseTopID))
           DrawingMode(#PB_2DDrawing_AlphaBlend)
           Box(000, 000, \W, \H, *pColor\ForeColor)        ;背景渲染
           DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
           StopDrawing()
        EndIf

      ;绘制左键按下时的控件图像
        \HoldDownID = CreateImage(#PB_Any, \W, \H, 32, #PB_Image_Transparent)
        If StartDrawing(ImageOutput(\HoldDownID))
           DrawingMode(#PB_2DDrawing_AlphaBlend)
           Box(000, 000, \W, \H, ForeColor)                ;背景渲染
           DrawAlphaImage(ImageID(\NormalcyID), 0, 0)
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


;- ==========================
;- [Common]
;初始化资源
Procedure Common_Initial()
   LoadFont(#fntDefault, "宋体", 12)
   With _Screen
      CopyMemory_(\DimColor, ?_Bin_ScreenColor, 4*5*5)            ;获取颜色设置[DataSection]的指针
      \SystemPath$ = Space(255)
      Result = GetSystemDirectory_(@\SystemPath$,255)
      \hDefaultIcon = ExtractIcon_(0, \SystemPath$+"\User32.dll", 0)
   EndWith
EndProcedure

;注销/释放资源
Procedure Common_Release()
   With _Screen
      FreeFont(#fntDefault)            ;注销字体
      FreeImage(#imgScreen)            ;注销背景图
      DestroyIcon_(\hDefaultIcon)
      Create_Release(\btnCloseBox)     ;注销关闭窗体小按键
      Create_Release(\btnMinimize)     ;注销最小化窗体小按键
      DeleteObject_(\hBackImage)
   EndWith
EndProcedure



;- ##########################
;- [Main]
With _Screen
   Common_Initial()                    ;初始化资源
   WindowFlags = #PB_Window_BorderLess|#PB_Window_ScreenCentered
   \WindowW = 600
   \WindowH = 400
   \hWindow = OpenWindow(#winScreen, 0, 0, \WindowW, \WindowH, "新建工具", WindowFlags)
   \Title$  = GetWindowTitle(#winScreen)
   ;这个结合Redraw_Screen()中注释掉的内容,可以实现对窗体刷新时,控件不闪烁.
   ButtonGadget(1, 100, 100, 100, 050, "不闪按键")
   ButtonGadget(2, 300, 100, 100, 050, "闪烁按键")
   Create_btnCloseBox(\btnCloseBox)    ;创建关闭窗体小按键
   Create_btnMinimize(\btnMinimize)    ;最小化窗体小按键
   Redraw_Screen()
   \hWindowHook = SetWindowLongPtr_(\hWindow, #GWL_WNDPROC, @Screen_HookWindow())

   Repeat
      EventNum  = WindowEvent()
      Select EventNum
         Case #PB_Event_CloseWindow : \IsExitWindow = #True
         Case #Null
            If \pMouseTop Or \pHoldDown
               GetCursorPos_(@Mouse.q) ;光标移境时,取消相应事件. 
               If WindowFromPoint_(Mouse) <> \hWindow
                  \pMouseTop = 0 : \pHoldDown = 0 : Redraw_Screen()
               EndIf 
            EndIf 
      EndSelect
      Delay(1)   
   Until \IsExitWindow = #True 
   Common_Release()                    ;注销/释放资源
EndWith
End


;- [DataSection]
DataSection
_Bin_ScreenColor:    ;背景色,前景色,字体色,边框色,高亮色
   Data.l $FF383838, $FF888888, $FFFFFFFF, $FF181818, $FF707070   ;窗体布局
   Data.l $FF585858, $FF888888, $FFFFFFFF, $FF282828, $FF707070   ;标题栏
   Data.l $FF585858, $FF888888, $FFFFFFFF, $FF282828, $FF707070   ;状态栏
   Data.l $FF585858, $FF888888, $FFFFFFFF, $FF282828, $FF707070   ;工具栏
   Data.l $FF585858, $FF888888, $FFFFFFFF, $FF181818, $FF888888   ;对话框按键
EndDataSection



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; Folding = ----
; EnableXP