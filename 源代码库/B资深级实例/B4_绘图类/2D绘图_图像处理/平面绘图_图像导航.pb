;***********************************
;迷路仟整理 2019.02.22
;平面绘图_图像导航
;***********************************

Enumeration
   #winScreen
   #scrScreen
   #cvsScreen

   #cvsNavigate
   #imgScreen
   #imgNavigate
EndEnumeration

Structure __ScreenInfo
   NaviX.w
   NaviY.w
   NaviW.w
   NaviH.w
   NaviSale.f
   Navi.Rect
   ScrollX.w
   ScrollY.w
   ScrollW.w
   ScrollH.w
   OffsetX.w
   OffsetY.w
   IsHoldDown.b
EndStructure

Global _Screen.__ScreenInfo



;绘制窗体
Procedure Screen_RedrawNavigate()


   W = GadgetWidth (#cvsNavigate) - 10
   H = GadgetHeight(#cvsNavigate) - 10
   With _Screen
      If IsImage(#imgNavigate) = 0
         ImageW = ImageWidth (#imgScreen)
         ImageH = ImageHeight(#imgScreen)
         SaleW.f = ImageW/W
         SaleH.f = ImageH/H
         ;获得自适应比例系数
         If SaleW <= SaleH : Sale.f = SaleH : Else : Sale.f = SaleW : EndIf 
         ;重新计算图像大小及绘制位置
         \NaviSale = Sale
         \NaviW = ImageW / Sale
         \NaviH = ImageH / Sale
         \NaviX = (W-\NaviW)/2 + 5
         \NaviY = (H-\NaviH)/2 + 5
         
         \ScrollX = 0
         \ScrollY = 0
         \ScrollW = GadgetWidth (#scrScreen) - 20
         \ScrollH = GadgetHeight(#scrScreen) - 20
         CopyImage(#imgScreen, #imgNavigate)
         ResizeImage(#imgNavigate, \NaviW, \NaviH)
      EndIf 
   
      If StartDrawing(CanvasOutput(#cvsNavigate))
         Box(0, 0, W+20, H+20, $383838)   ;绘制背景
         DrawImage(ImageID(#imgNavigate), \NaviX, \NaviY)
         
         X = \NaviX + \ScrollX / \NaviSale
         Y = \NaviY + \ScrollY / \NaviSale
         W = \ScrollW / \NaviSale
         H = \ScrollH / \NaviSale
         \Navi\left = X
         \Navi\top  = Y
         \Navi\right  = X+W
         \Navi\bottom = Y+H         
         If \IsHoldDown = #True
            Color = $80FFFFFF
            DrawingMode(#PB_2DDrawing_AlphaBlend)
            Box(\NaviX, \NaviY, \NaviW, Y-\NaviY, Color)
            Box(\NaviX, Y+H, \NaviW, \NaviH+\NaviY-H-Y, Color)
            Box(\NaviX, Y, X-\NaviX, H, Color)
            Box(W+X, Y, \NaviW+\NaviX-W-X, H, Color)
         EndIf          
         
         DrawingMode(#PB_2DDrawing_Outlined)
         Box(\NaviX-1, \NaviY-1, \NaviW+2, \NaviH+2, $000000)
         Box(\NaviX-2, \NaviY-2, \NaviW+4, \NaviH+4, $E0E0E0)
         Box(X, Y, W, H, $0000FF)
         StopDrawing()
      EndIf
   EndWith
EndProcedure


Procedure EventGadget_scrScreen()
   _Screen\ScrollX = GetGadgetAttribute(#scrScreen, #PB_ScrollArea_X)
   _Screen\ScrollY = GetGadgetAttribute(#scrScreen, #PB_ScrollArea_Y)
   Screen_RedrawNavigate()
EndProcedure

Procedure EventGadget_cvsNavigate()
   With _Screen
      Select EventType()
         Case #PB_EventType_LeftButtonDown
            X = GetGadgetAttribute(#cvsNavigate, #PB_Canvas_MouseX)
            Y = GetGadgetAttribute(#cvsNavigate, #PB_Canvas_MouseY)
               If X > \Navi\left And X < \Navi\right And Y > \Navi\top And Y < \Navi\bottom
                  \OffsetX = X-\Navi\left
                  \OffsetY = Y-\Navi\top
                  \IsHoldDown = #True
                  Screen_RedrawNavigate()
               EndIf 
            
         Case #PB_EventType_LeftButtonUp
            If \IsHoldDown = #True
               \IsHoldDown = #False
               Screen_RedrawNavigate()
            EndIf 
            
         Case #PB_EventType_MouseMove 
            X = GetGadgetAttribute(#cvsNavigate, #PB_Canvas_MouseX)
            Y = GetGadgetAttribute(#cvsNavigate, #PB_Canvas_MouseY)
            If \IsHoldDown = #True
               ScrollX = (X-\OffsetX-\NaviX)
               ScrollY = (Y-\OffsetY-\NaviY) 
                       
               ScrollR = \NaviW - \ScrollW / \NaviSale      
               ScrollB = \NaviH - \ScrollH / \NaviSale          
               If ScrollX < 0 : ScrollX = 0 : EndIf 
               If ScrollY < 0 : ScrollY = 0 : EndIf 
               If ScrollX > ScrollR : ScrollX = ScrollR : EndIf 
               If ScrollY > ScrollB : ScrollY = ScrollB : EndIf             
               \ScrollX = ScrollX * \NaviSale
               \ScrollY = ScrollY * \NaviSale
               SetGadgetAttribute(#scrScreen, #PB_ScrollArea_X, \ScrollX)
               SetGadgetAttribute(#scrScreen, #PB_ScrollArea_Y, \ScrollY)
               Screen_RedrawNavigate()
            EndIf 
      EndSelect
   EndWith
EndProcedure



UsePNGImageDecoder()
hImage = LoadImage(#imgScreen, "..\桌面图像.png")
ImageW = ImageWidth (#imgScreen)
ImageH = ImageHeight(#imgScreen)
         
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 850, 500, "平面绘图_图像导航", WindowFlags)
SetWindowColor(#winScreen, $383838)
ScrollAreaGadget(#scrScreen, 000, 000, 600, 500, ImageW, ImageH, #PB_ScrollArea_Center)   
   CanvasGadget(#cvsScreen, 000, 000, ImageW, ImageH)   
   If StartDrawing(CanvasOutput(#cvsScreen))
      DrawImage(hImage, 0,0)
      StopDrawing()
   EndIf
CloseGadgetList()
CanvasGadget(#cvsNavigate, 600, 500-200, 250, 200) 
Screen_RedrawNavigate()
BindGadgetEvent(#scrScreen,   @EventGadget_scrScreen())
BindGadgetEvent(#cvsNavigate, @EventGadget_cvsNavigate())


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_SizeWindow  : Screen_RedrawNavigate()
      Case #PB_Event_Gadget
   EndSelect      
   Delay(1)
Until IsExitWindow = #True

End









; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 151
; FirstLine = 111
; Folding = -
; EnableXP