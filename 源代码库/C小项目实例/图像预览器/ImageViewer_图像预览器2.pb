;***********************************
;迷路仟整理 2019.02.02
;ImageViewer_图像预览器2-矢量绘图
;***********************************
;版本2说明:
;1.图像预览和保存
;2.采用适量绘图法
;3.工具栏大图标处理

Enumeration
   #winScreen
   #wtbScreen
   #wsbScreen
   #wnmOpenImage
   #wnmCloseImage
   #wnmSaveImage
   #icoOpenImage
   #icoCloseImage
   #icoSaveImage
EndEnumeration

Structure __ScreenInfo
   ImageID.l
   FileName$
EndStructure

Global _Screen.__ScreenInfo

;使用图像插件
Procedure Screen_Initial()
   UsePNGImageDecoder()
   UseTGAImageDecoder()
   UseTIFFImageDecoder()
   UseJPEGImageDecoder()
   UseJPEG2000ImageDecoder()
   UsePNGImageEncoder()
   UseJPEGImageEncoder()
   UseJPEG2000ImageEncoder()
   
   CatchImage(#icoOpenImage,  ?_ICON_Open)
   CatchImage(#icoCloseImage, ?_ICON_Close)
   CatchImage(#icoSaveImage,  ?_ICON_Save)
   
EndProcedure

Procedure Screen_Release()
   FreeImage(#icoOpenImage)
   FreeImage(#icoCloseImage)
   FreeImage(#icoSaveImage)
   ;关闭图像
   If IsImage(_Screen\ImageID)
      FreeImage(_Screen\ImageID)
   EndIf 

EndProcedure


;绘制窗体
Procedure Screen_Redrawing()
   Y = ToolBarHeight(#wtbScreen)
   W = WindowWidth (#winScreen)
   H = WindowHeight(#winScreen)- StatusBarHeight(#wsbScreen)-Y
   If StartVectorDrawing(WindowVectorOutput(#winScreen))
      VectorSourceColor($FFFFFFFF)  ;绘制背景
      AddPathBox(0, Y, W, H)
      FillPath()
      ;判断图像是否存在
      If IsImage(_Screen\ImageID)
         ImageW = ImageWidth(_Screen\ImageID)
         ImageH = ImageHeight(_Screen\ImageID)
         ;判断图像是否超过窗体内容框
         If ImageW > W Or ImageH > H 
            ;进行缩放比较计算
            SaleW.f = W / ImageW
            SaleH.f = H / ImageH
            Sale.f = SaleW
            If SaleW > SaleH : Sale = SaleH : EndIf 
            ImageW = ImageW * Sale
            ImageH = ImageH * Sale
            ImageX = X + (W-ImageW)/2
            ImageY = Y + (H-ImageH)/2  
            ;绘制比例图像 
            MovePathCursor(ImageX, ImageY)  
            DrawVectorImage(ImageID(_Screen\ImageID), 255, ImageW, ImageH)
         Else 
            ;对图像进行居中绘制
            ImageX = X + (W-ImageW)/2
            ImageY = Y + (H-ImageH)/2
            MovePathCursor(ImageX, ImageY)  
            DrawVectorImage(ImageID(_Screen\ImageID), 255) 
         EndIf 
      EndIf 
      StopVectorDrawing()
   EndIf
EndProcedure

;菜单事件
Procedure Screen_EventMenu()
   MenuID = EventMenu()
   Select MenuID
      ;打开图像
      Case #wnmOpenImage 
         ;弹出打开文件对话框
         Pattern$ = "BMP图像 (*.bmp)|*.bmp;*.ico|PNG图像 (*.png)|*.png|"+
                    "JPG图像 (*.jpg)|*.jpg|TGA图像 (*.tga)|*.tga|TIFF图像 (*.tif)|*.tif|"+
                    "任意图像 (*.*)|*.*"
         Pattern = 5    ; 默认选择第一个
         FileName$ = OpenFileRequester("请选择要打开的图像", _Screen\FileName$, Pattern$, Pattern)
         If FileName$
            _Screen\FileName$ = FileName$
            ;如果图像存在,就注销掉
            If IsImage(_Screen\ImageID)
               FreeImage(_Screen\ImageID)
               _Screen\ImageID = 0
            EndIf 
            ;加载图像
            _Screen\ImageID = LoadImage(#PB_Any, FileName$)
            ImageW = ImageWidth(_Screen\ImageID)
            ImageH = ImageHeight(_Screen\ImageID)
            Depth  = ImageDepth(_Screen\ImageID)
            Notice$ = Str(ImageW) + " x "+ Str(ImageH) + " x "+ Str(Depth)
            StatusBarText(#wsbScreen, 1, Notice$)
            StatusBarText(#wsbScreen, 2, FileName$)
            Screen_Redrawing()
            DisableToolBarButton(#wtbScreen, #wnmCloseImage, #False)
            DisableToolBarButton(#wtbScreen, #wnmSaveImage,  #False)
         EndIf
         
      ;关闭图像
      Case #wnmCloseImage 
         ;关闭图像
         If IsImage(_Screen\ImageID)
            FreeImage(_Screen\ImageID)
            _Screen\ImageID = 0
            Screen_Redrawing()
         EndIf 
         StatusBarText(#wsbScreen, 1, "图像大小")
         StatusBarText(#wsbScreen, 2, "欢迎使用图像预览器!")
         DisableToolBarButton(#wtbScreen, #wnmCloseImage, #True)
         DisableToolBarButton(#wtbScreen, #wnmSaveImage, #True)

       
      ;保存图像
      Case #wnmSaveImage
         If IsImage(_Screen\ImageID) = 0 : ProcedureReturn : EndIf 
         ;去掉后辍
         Extension$ = GetExtensionPart(_Screen\FileName$)
         If Extension$ <> #Null$
            SaveImage$ = Left(_Screen\FileName$, Len(_Screen\FileName$)-Len(Extension$)-1)
         Else 
            SaveImage$ = _Screen\FileName$
         EndIf 
         ;弹出保存文件对话框
         Pattern$ = "BMP图像 (*.bmp)|*.bmp|PNG图像 (*.png)|*.png|JPG图像 (*.jpg)|*.jpg"
         SaveImage$ = SaveFileRequester("请选择要保存的文件", SaveImage$, Pattern$, 1)
         If SaveImage$
            Result = SelectedFilePattern()
            Select Result
               Case 0 : Suffix$ = "bmp" : Plugin = #PB_ImagePlugin_BMP
               Case 1 : Suffix$ = "png" : Plugin = #PB_ImagePlugin_PNG 
               Case 2 : Suffix$ = "jpg" : Plugin = #PB_ImagePlugin_JPEG
               Default : ProcedureReturn
            EndSelect
            ;添加后辍
            Extension$ = LCase(GetExtensionPart(SaveImage$))
            If Extension$ <> Suffix$ : SaveImage$+"."+ Suffix$ : EndIf  ;判断后辍
            ;保存图像
            _Screen\FileName$ = SaveImage$
            SaveImage(_Screen\ImageID, SaveImage$, Plugin)
            StatusBarText(#wsbScreen, 2, SaveImage$)
         EndIf 
   EndSelect
EndProcedure

;创建控件
Procedure Screen_CreateGadget(hWindow)
   hToolBar = CreateToolBar(#wtbScreen, hWindow)
   If hToolBar
      ;设置工具栏图像为24x24
      ImageList = SendMessage_(hToolBar, #TB_GETIMAGELIST, 0, 0)
      ImageList_SetIconSize_(ImageList, 24, 24)
      ToolBarImageButton(#wnmOpenImage,  ImageID(#icoOpenImage))
      ToolBarImageButton(#wnmCloseImage, ImageID(#icoCloseImage))
      ToolBarSeparator()
      ToolBarImageButton(#wnmSaveImage,  ImageID(#icoSaveImage))
   EndIf 
   ToolBarToolTip(#wtbScreen, #wnmOpenImage,  "打开图像") 
   ToolBarToolTip(#wtbScreen, #wnmCloseImage, "关闭图像") 
   ToolBarToolTip(#wtbScreen, #wnmSaveImage,  "保存图像") 
   DisableToolBarButton(#wtbScreen, #wnmCloseImage, #True)
   DisableToolBarButton(#wtbScreen, #wnmSaveImage,  #True)
   If CreateStatusBar(#wsbScreen, hWindow)
       AddStatusBarField(0100)
       AddStatusBarField(0120)
       AddStatusBarField(2999)
       StatusBarText(#wsbScreen, 0, "- 迷路仟 -", #PB_StatusBar_Center)
       StatusBarText(#wsbScreen, 1, "图像大小")
       StatusBarText(#wsbScreen, 2, "欢迎使用图像预览器!")
   EndIf
EndProcedure


Screen_Initial()
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 800, 550, "图像预览器2-矢量绘图", WindowFlags)
Screen_CreateGadget(hWindow)
Screen_Redrawing()

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_SizeWindow  : Screen_Redrawing()
      Case #PB_Event_Menu        : Screen_EventMenu()
      Case #PB_Event_Gadget
   EndSelect      
   Delay(1)
Until IsExitWindow = #True
Screen_Release()
End



;- ##########################
;- [Data]
DataSection
_ICON_Open:
   IncludeBinary ".\Open.png" 
_ICON_Save:
   IncludeBinary ".\Save.png" 
_ICON_Close:
   IncludeBinary ".\Close.png"     
EndDataSection



















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 109
; FirstLine = 87
; Folding = --
; EnableXP