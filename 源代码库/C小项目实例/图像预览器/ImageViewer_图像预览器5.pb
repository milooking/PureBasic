;***********************************
;迷路仟整理 2019.02.03
;ImageViewer_图像预览器5
;***********************************
;版本3说明:
;1.图像预览和保存
;2.采用适量绘图法
;3.工具栏大图标处理
;4.添加图像旋转处理
;5.添加拖放加载功能
;6.添加滚动域功能
;7.添加缩放与还原功能


Enumeration
   #winScreen
   #wtbScreen
   #wsbScreen
   #scrScreen
   #cvsScreen
   #wnmOpenImage
   #wnmCloseImage
   #wnmSaveImage
   #wnmTurnLeft
   #wnmTurnRight
   #wnmZoomIn
   #wnmZoomOut
   #wnmNormal

   #icoOpenImage
   #icoCloseImage
   #icoSaveImage
   #icoTurnLeft
   #icoTurnRight
   #icoZoomIn
   #icoZoomOut
   #icoNormal
EndEnumeration

Structure __ScreenInfo
   ImageID.l
   FileName$
   ImageZoom.l
EndStructure

Global _Screen.__ScreenInfo

;初始化
Procedure Screen_Initial()
   UseGIFImageDecoder()
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
   CatchImage(#icoTurnLeft,   ?_ICON_TurnL)
   CatchImage(#icoTurnRight,  ?_ICON_TurnR)
   CatchImage(#icoZoomIn,     ?_ICON_ZoomI)
   CatchImage(#icoZoomOut,    ?_ICON_ZoomO)
   CatchImage(#icoNormal,     ?_ICON_Normal)

EndProcedure

;注销
Procedure Screen_Release()
   FreeImage(#icoOpenImage)
   FreeImage(#icoCloseImage)
   FreeImage(#icoSaveImage)
   FreeImage(#icoTurnLeft)
   FreeImage(#icoTurnRight)
   FreeImage(#icoZoomIn)
   FreeImage(#icoZoomOut)
   FreeImage(#icoNormal)
   
   ;关闭图像
   If IsImage(_Screen\ImageID)
      FreeImage(_Screen\ImageID)
   EndIf 
EndProcedure

;-
;绘制窗体
Procedure Screen_Redrawing()
   W = GadgetWidth(#cvsScreen)
   H = GadgetHeight(#cvsScreen)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor($FFFFFFFF)  ;绘制背景
      AddPathBox(0, 0, W, H)
      FillPath()
      ;判断图像是否存在
      If IsImage(_Screen\ImageID)
         MovePathCursor(0, 0)  
         DrawVectorImage(ImageID(_Screen\ImageID), 255, W, H) 
      EndIf 
      StopVectorDrawing()
   EndIf
EndProcedure

;加载图像
Procedure EventMenu_OpenImage(FileName$)
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
   StatusBarText(#wsbScreen, 3, FileName$)
   DisableToolBarButton(#wtbScreen, #wnmCloseImage, #False)
   DisableToolBarButton(#wtbScreen, #wnmSaveImage,  #False)
   DisableToolBarButton(#wtbScreen, #wnmTurnLeft,   #False)
   DisableToolBarButton(#wtbScreen, #wnmTurnRight,  #False)
   DisableToolBarButton(#wtbScreen, #wnmZoomOut,    #False)
   DisableToolBarButton(#wtbScreen, #wnmZoomIn,     #False)   
   DisableToolBarButton(#wtbScreen, #wnmNormal,     #False)   
   SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerWidth,  ImageW)
   SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerHeight, ImageH)
   ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, ImageW, ImageH)
   _Screen\ImageZoom = 100
   StatusBarText(#wsbScreen, 2, "缩放: "+Str(_Screen\ImageZoom)+"%")
   Screen_Redrawing()
EndProcedure

;关闭图像
Procedure EventMenu_CloseImage()

   If IsImage(_Screen\ImageID)
      FreeImage(_Screen\ImageID)
      _Screen\ImageID = 0
      Screen_Redrawing()
   EndIf 
   StatusBarText(#wsbScreen, 1, "图像大小")
   StatusBarText(#wsbScreen, 3, "欢迎使用图像预览器!")
   DisableToolBarButton(#wtbScreen, #wnmCloseImage, #True)
   DisableToolBarButton(#wtbScreen, #wnmSaveImage,  #True)
   DisableToolBarButton(#wtbScreen, #wnmTurnLeft,   #True)
   DisableToolBarButton(#wtbScreen, #wnmTurnRight,  #True)
   DisableToolBarButton(#wtbScreen, #wnmZoomOut,    #True)
   DisableToolBarButton(#wtbScreen, #wnmZoomIn,     #True)   
   DisableToolBarButton(#wtbScreen, #wnmNormal,     #True)   
   
   SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerWidth,  0)
   SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerHeight, 0)
   ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, 0, 0)
   
EndProcedure

;保存图像
Procedure EventMenu_SaveImage()
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
      StatusBarText(#wsbScreen, 3, SaveImage$)
   EndIf 
EndProcedure

Procedure Event_SizeWindow()
   Y = ToolBarHeight(#wtbScreen)
   W = WindowWidth (#winScreen)
   H = WindowHeight(#winScreen)- StatusBarHeight(#wsbScreen)-Y
   ResizeGadget(#scrScreen, #PB_Ignore, #PB_Ignore, W, H)
   Screen_Redrawing()
EndProcedure

;-
;菜单事件
Procedure Screen_EventMenu()
   MenuID = EventMenu()
   Select MenuID
      Case #wnmZoomOut
         Select _Screen\ImageZoom
            Case 0005 : _Screen\ImageZoom = 0010
            Case 0010 : _Screen\ImageZoom = 0015
            Case 0015 : _Screen\ImageZoom = 0020
            Case 0020 : _Screen\ImageZoom = 0030
            Case 0030 : _Screen\ImageZoom = 0050
            Case 0050 : _Screen\ImageZoom = 0070
            Case 0070 : _Screen\ImageZoom = 0100
            Case 0100 : _Screen\ImageZoom = 0150
            Case 0150 : _Screen\ImageZoom = 0200
            Case 0200 : _Screen\ImageZoom = 0300
            Case 0300 : _Screen\ImageZoom = 0500
            Case 0500 : _Screen\ImageZoom = 0700
            Case 0700 : _Screen\ImageZoom = 1000
            Default : ProcedureReturn 
         EndSelect
         ImageW = ImageWidth(_Screen\ImageID)  * _Screen\ImageZoom / 100
         ImageH = ImageHeight(_Screen\ImageID) * _Screen\ImageZoom / 100
         SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerWidth,  ImageW)
         SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerHeight, ImageH)
         ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, ImageW, ImageH)
         StatusBarText(#wsbScreen, 2, "缩放: "+Str(_Screen\ImageZoom)+"%")
         Screen_Redrawing()
         
      Case #wnmZoomIn   
         Select _Screen\ImageZoom
            Case 0010 : _Screen\ImageZoom = 0005
            Case 0015 : _Screen\ImageZoom = 0010
            Case 0020 : _Screen\ImageZoom = 0015
            Case 0030 : _Screen\ImageZoom = 0020
            Case 0050 : _Screen\ImageZoom = 0030
            Case 0070 : _Screen\ImageZoom = 0050
            Case 0100 : _Screen\ImageZoom = 0070
            Case 0150 : _Screen\ImageZoom = 0100
            Case 0200 : _Screen\ImageZoom = 0150
            Case 0300 : _Screen\ImageZoom = 0200
            Case 0500 : _Screen\ImageZoom = 0300
            Case 0700 : _Screen\ImageZoom = 0500
            Case 1000 : _Screen\ImageZoom = 0700
            Default : ProcedureReturn 
         EndSelect
         ImageW = ImageWidth(_Screen\ImageID)  * _Screen\ImageZoom / 100
         ImageH = ImageHeight(_Screen\ImageID) * _Screen\ImageZoom / 100
         SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerWidth,  ImageW)
         SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerHeight, ImageH)
         ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, ImageW, ImageH)
         StatusBarText(#wsbScreen, 2, "缩放: "+Str(_Screen\ImageZoom)+"%")
         Screen_Redrawing()
      
      Case #wnmNormal
         _Screen\ImageZoom = 100
         ImageW = ImageWidth(_Screen\ImageID)  * _Screen\ImageZoom / 100
         ImageH = ImageHeight(_Screen\ImageID) * _Screen\ImageZoom / 100
         SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerWidth,  ImageW)
         SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerHeight, ImageH)
         ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, ImageW, ImageH)
         StatusBarText(#wsbScreen, 2, "缩放: "+Str(_Screen\ImageZoom)+"%")
         Screen_Redrawing()
         
      ;图像左转
      Case #wnmTurnLeft
         If IsImage(_Screen\ImageID) = 0 : ProcedureReturn : EndIf 
         ImageH = ImageWidth(_Screen\ImageID)
         ImageW = ImageHeight(_Screen\ImageID)
         ImageID = CreateImage(#PB_Any, ImageW, ImageH)
         If StartVectorDrawing(ImageVectorOutput(ImageID))
            MovePathCursor(0, ImageH-1) 
            RotateCoordinates(0, 0, -90)
            DrawVectorImage(ImageID(_Screen\ImageID), 255) 
            StopVectorDrawing()
            SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerWidth,  ImageW)
            SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerHeight, ImageH)
            ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, ImageW, ImageH)
         EndIf
         FreeImage(_Screen\ImageID)
         _Screen\ImageID = ImageID
         Screen_Redrawing()
         
      Case #wnmTurnRight
         If IsImage(_Screen\ImageID) = 0 : ProcedureReturn : EndIf 
         ImageH = ImageWidth(_Screen\ImageID)
         ImageW = ImageHeight(_Screen\ImageID)
         ImageID = CreateImage(#PB_Any, ImageW, ImageH)
         If StartVectorDrawing(ImageVectorOutput(ImageID))
            MovePathCursor(ImageW-1, 0) 
            RotateCoordinates(ImageW, 0, 90)
            DrawVectorImage(ImageID(_Screen\ImageID), 255) 
            StopVectorDrawing()
            SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerWidth,  ImageW)
            SetGadgetAttribute(#scrScreen, #PB_ScrollArea_InnerHeight, ImageH)
            ResizeGadget(#cvsScreen, #PB_Ignore, #PB_Ignore, ImageW, ImageH)
         EndIf
         FreeImage(_Screen\ImageID)
         _Screen\ImageID = ImageID
         Screen_Redrawing()
         
      ;打开图像
      Case #wnmOpenImage 
         ;弹出打开文件对话框
         Pattern$ = "BMP图像 (*.bmp)|*.bmp;*.ico|PNG图像 (*.png)|*.png|"+
                    "JPG图像 (*.jpg)|*.jpg|TGA图像 (*.tga)|*.tga|TIFF图像 (*.tif)|*.tif|"+
                    "任意图像 (*.*)|*.*"
         Pattern = 5    ; 默认选择第一个
         FileName$ = OpenFileRequester("请选择要打开的图像", _Screen\FileName$, Pattern$, Pattern)
         If FileName$
            EventMenu_OpenImage(FileName$)
         EndIf
         
      ;关闭图像
      Case #wnmCloseImage 
         EventMenu_CloseImage()
   
   
      ;保存图像
      Case #wnmSaveImage
         EventMenu_SaveImage()
   EndSelect
EndProcedure

;获取系统拖放文件(单文件)
Procedure Screen_DragDorpFile() 
   DroppedID = EventwParam()  
   CountFiles = DragQueryFile_(DroppedID, $FFFFFFFF, "", 0) 
   If CountFiles
      LenFileName  = DragQueryFile_(DroppedID, 0, 0, 0)  
      FileName$ = Space(LenFileName)  
      DragQueryFile_(DroppedID, 0, FileName$, LenFileName+1) 
   EndIf 
   DragFinish_(DroppedID) 
   If FileSize(FileName$) > 0 
      EventMenu_OpenImage(FileName$)
   EndIf 
   ProcedureReturn 
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
      ToolBarSeparator()
      ToolBarImageButton(#wnmTurnLeft,   ImageID(#icoTurnLeft))
      ToolBarImageButton(#wnmTurnRight,  ImageID(#icoTurnRight))
      ToolBarSeparator()
      ToolBarImageButton(#wnmZoomOut,    ImageID(#icoZoomOut))
      ToolBarImageButton(#wnmZoomIn,     ImageID(#icoZoomIn))
      ToolBarSeparator()
      ToolBarImageButton(#wnmNormal,     ImageID(#icoNormal))
   EndIf 
   ToolBarToolTip(#wtbScreen, #wnmOpenImage,  "打开图像") 
   ToolBarToolTip(#wtbScreen, #wnmCloseImage, "关闭图像") 
   ToolBarToolTip(#wtbScreen, #wnmSaveImage,  "保存图像") 
   ToolBarToolTip(#wtbScreen, #wnmTurnLeft,   "图像左转") 
   ToolBarToolTip(#wtbScreen, #wnmTurnRight,  "图像右转") 
   
   ToolBarToolTip(#wtbScreen, #wnmZoomOut,    "扩大图像") 
   ToolBarToolTip(#wtbScreen, #wnmZoomIn,     "缩小图像") 
   ToolBarToolTip(#wtbScreen, #wnmNormal,     "图像原始大小") 

   DisableToolBarButton(#wtbScreen, #wnmCloseImage, #True)
   DisableToolBarButton(#wtbScreen, #wnmSaveImage,  #True)
   DisableToolBarButton(#wtbScreen, #wnmTurnLeft,   #True)
   DisableToolBarButton(#wtbScreen, #wnmTurnRight,  #True)
   DisableToolBarButton(#wtbScreen, #wnmZoomOut,    #True)
   DisableToolBarButton(#wtbScreen, #wnmZoomIn,     #True)   
   DisableToolBarButton(#wtbScreen, #wnmNormal,     #True)   
   
   If CreateStatusBar(#wsbScreen, hWindow)
       AddStatusBarField(0100)
       AddStatusBarField(0120)
       AddStatusBarField(0090)
       AddStatusBarField(2999)
       StatusBarText(#wsbScreen, 0, "- 迷路仟 -", #PB_StatusBar_Center)
       StatusBarText(#wsbScreen, 1, "图像大小")
       StatusBarText(#wsbScreen, 2, "缩放: 100%")
       StatusBarText(#wsbScreen, 3, "欢迎使用图像预览器!")
   EndIf
   Y = ToolBarHeight(#wtbScreen)
   W = WindowWidth (#winScreen)
   H = WindowHeight(#winScreen)- StatusBarHeight(#wsbScreen)-Y
   ScrollAreaGadget(#scrScreen, 0, Y, W, H, 0, 0, 1, #PB_ScrollArea_Center)
      CanvasGadget(#cvsScreen, 0,0, 0, 0)
      SetGadgetColor(#scrScreen, #PB_Gadget_BackColor, $484848)
   CloseGadgetList()
EndProcedure


Screen_Initial()
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 800, 550, "图像预览器5", WindowFlags)
Screen_CreateGadget(hWindow)
Screen_Redrawing()
DragAcceptFiles_(hWindow, #True) ;设置窗体界面是否支持系统拖放.

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_SizeWindow  : Event_SizeWindow()
      Case #PB_Event_Menu        : Screen_EventMenu()
      Case #WM_DROPFILES         : Screen_DragDorpFile()
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
_ICON_TurnL:
   IncludeBinary ".\TurnL.png"   
_ICON_TurnR:
   IncludeBinary ".\TurnR.png"   
_ICON_ZoomO:
   IncludeBinary ".\ZoomO.png"   
_ICON_ZoomI:
   IncludeBinary ".\ZoomI.png"   
_ICON_Normal:
   IncludeBinary ".\Normal.png"             
EndDataSection



















; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 409
; FirstLine = 321
; Folding = -o-
; EnableXP