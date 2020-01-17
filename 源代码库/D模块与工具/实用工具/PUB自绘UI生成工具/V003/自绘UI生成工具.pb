;**********************************************************************
;********           迷路PureBasic自绘UI代码生成工具            ********
;********          开发者:迷路仟/Miloo [QQ:714095563]          ********
;**********************************************************************
;功能:自动生成自绘窗体界面的源代码,节省开发时间.


XIncludeFile ".\Install.pb"
XIncludeFile ".\Redraw.pb"
XIncludeFile ".\Generater.pb"



;-==========================
Procedure Attributes_AddGroup(GadgetID, Title$, Notice$)
   *pAttriGroup.__AttriGroupInfo = AddElement(_Screen\ListAttriGroup())
   _Screen\pMapAttriGroup(Title$) = *pAttriGroup
   With *pAttriGroup
      \Title$    = Title$
      \Notice$   = Notice$
      \GadgetID  = GadgetID
      \FoldState = #True
   EndWith
   ProcedureReturn *pAttriGroup
EndProcedure

Procedure Attributes_AddItem(*pAttriGroup.__AttriGroupInfo, GadgetID1, GadgetID2, Title$, Notice$)
   *pAttriItems._AttriItemsInfo = AddElement(*pAttriGroup\ListAttriItems())
   _Screen\pMapAttriItems(*pAttriGroup\Title$+"|"+Title$) = *pAttriItems
   With *pAttriItems
      \Title$    = Title$
      \Notice$   = Notice$      
      \GadgetID1 = GadgetID1
      \GadgetID2 = GadgetID2
      \pParent   = *pAttriGroup
   EndWith
   ProcedureReturn *pAttriItems
EndProcedure

Procedure Attributes_CatchColor(*pMemColor, Pos, ColorTable$)
   *pColor.__ScreenColorInfo = AddElement(_Project\ListColor())   ;窗体布局
   _Project\pMapColor(ColorTable$) = *pColor
   *pColor\ColorTable$ = ColorTable$
   CopyMemory_(*pColor, *pMemColor+Pos, 6*4) : Pos+6*4
   ProcedureReturn Pos
EndProcedure

Procedure Attributes_InitGadget()
   With _Project
      SetGadgetText(#txtWindowRealW, Str(\WindowW))
      SetGadgetText(#txtWindowRealH, Str(\WindowH))
      SetGadgetText(#txtCaptionBarX, Str(\CaptionX))
      SetGadgetText(#txtCaptionBarH, Str(\CaptionH))
      SetGadgetText(#txtCaptionName, \Caption$)

      SetGadgetText(#txtWindowSideL, Str(\WinSideL))
      SetGadgetText(#txtWindowSideR, Str(\WinSideR))
      SetGadgetText(#txtWindowSideT, Str(\WinSideT))
      SetGadgetText(#txtWindowSideB, Str(\WinSideB))
      SetGadgetText(#txtStatusBarX,  Str(\StatusX))
      SetGadgetText(#txtStatusBarH,  Str(\StatusH))
      SetGadgetText(#txtIcoToolbarY, Str(\ToolBarY))
      SetGadgetText(#txtIcoToolbarW, Str(\ToolBarW))
      SetGadgetState(#cmbSystemButton, \SystemButtonSylte)  ;系统按键风格
      SetGadgetState(#chkCanvasImage,  \IsUseCanvasImage)   ;启用画布背景
      SetGadgetState(#chkSysCloseBox,  \IsUseSysCloseBox)   ;关闭按键   
      SetGadgetState(#chkSysMinimize,  \IsUseSysMinimize)   ;最小化按键
      SetGadgetState(#chkSysMaximize,  \IsUseSysMaximize)   ;最大化按键
      SetGadgetState(#chkSysNormalcy,  \IsUseSysNormalcy)   ;正常化按键
      SetGadgetState(#chkSysSettings,  \IsUseSysSettings)   ;正常化按键
      SetGadgetState(#chkSysStickyNO,  \IsUseSysStickyNO)   ;体窗置顶按键
      
      SetGadgetState(#chkCaptionBar,   \IsUseCaptionBar)    ;启用标题栏
      SetGadgetState(#chkStatusBar,    \IsUseStatusBar)     ;启用状态栏
      SetGadgetState(#chkIcoToolbar,   \IsUseIcoToolBar)    ;启用工具栏
      SetGadgetState(#chkStatusSize,   \IsUseStatusSize)    ;启用缩放小图标
      SetGadgetState(#chkPreference,   \IsUsePreference)    ;插入设置文件
      SetGadgetState(#chkMessageBox,   \IsUseMessageBox)    ;插入信息对话框的代码
      SetGadgetState(#chkBalloonTip,   \IsUseBalloonTip)    ;设置提示文
      SetGadgetState(#chkSystemDrop,   \IsUseSystemDrop)    ;启用系统拖放
      SetGadgetState(#chkMultiFiles,   \IsUseMultiFiles)    ;启用系统拖放多个文件
      SetGadgetState(#chkIncludeIcon,  \IsUseIncludeIcon) ;启用图标资源包含
      SetGadgetState(#chkSizeWindow,   \IsUseSizeWindow)  ;是否支持窗体改变大小

      
;       \IsUseOperateArea  = #False   ;启用作业区

      
      DisableGadget(#chkMultiFiles, 1-\IsUseSystemDrop)
      DragAcceptFiles_(_Screen\hWindow, \IsUseSystemDrop)    ;设置窗体界面是否支持系统拖放.
      State = 1-\IsUseSizeWindow 
      DisableGadget(#txtWindowSideL, State)  ;左际留边
      DisableGadget(#txtWindowSideR, State)  ;右际留边
      DisableGadget(#txtWindowSideT, State)  ;顶部留边
      DisableGadget(#txtWindowSideB, State)  ;底部留边
      DisableGadget(#chkStatusSize,  State)  ;缩放小图标
      StatusBarText(#wsbScreen,  1, " 窗体大小: "+Str(\WindowW)+"x"+Str(\WindowH))

      ClearList(_Project\ListColor())
      SetGadgetState(#cmbLayoutStyle, \UIColorStyleIndex)   ;UI颜色风格
      SelectElement(_Screen\ListColorStyle(), \UIColorStyleIndex)
      *pMemColor = _Screen\ListColorStyle()\pMemColor
      Pos = Attributes_CatchColor(*pMemColor, Pos, "窗体布局")
      Pos = Attributes_CatchColor(*pMemColor, Pos, "标题栏")
      Pos = Attributes_CatchColor(*pMemColor, Pos, "状态栏")
      Pos = Attributes_CatchColor(*pMemColor, Pos, "工具栏")
      Pos = Attributes_CatchColor(*pMemColor, Pos, "对话框按键")
      ;图标资源包含   
      If FileSize(\SoftwareIcon$) > 0
         SoftwareIconID = LoadImage(#PB_Any, \SoftwareIcon$)
         If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
         If SoftwareIconID
            \SoftwareIconID = SoftwareIconID
            DisableGadget(#chkIncludeIcon, #False)
         Else 
            DisableGadget(#chkIncludeIcon, #True)
         EndIf
      Else 
         DisableGadget(#chkIncludeIcon, #True)  
      EndIf 


      If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
         *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
         ClearGadgetItems(#cmbColorsPrefer)
         ForEach \ListColor()
            AddGadgetItem(#cmbColorsPrefer, -1, \ListColor()\ColorTable$)
         Next
         SetGadgetState(#cmbColorsPrefer, 0) 
         PostEvent(#PB_Event_Gadget, #winScreen, #cmbColorsPrefer)
      EndIf 
      FirstElement(\ListColor())
      SetGadgetState(#cmbGradientType, \ListColor()\GradientTpyes)  
      State = 1-\ListColor()\IsUseGradient
      DisableGadget(#chkAniGradients, State)  
      DisableGadget(#cmbGradientType, State) 
      
      Create_btnCloseBox(_Screen\btnCloseBox)
      Create_btnMinimize(_Screen\btnMinimize)
      Create_btnMaximize(_Screen\btnMaximize)
      Create_btnNormalcy(_Screen\btnNormalcy)
      Create_btnSettings(_Screen\btnSettings) 
      Create_btnStickyNO(_Screen\btnStickyNO) 
      Create_btnStickyNC(_Screen\btnStickyNC) 
      Redraw_cvsIllustrate()
   EndWith
EndProcedure

Procedure Attributes_NewProject()
   With _Project
      If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
      ClearMap(\pMapColor())
      ClearList(\ListColor())
      \WindowW  = 600         ;当前宽度
      \WindowH  = 400         ;当前高度
      \CaptionX = 000         ;X坐标偏移
      \CaptionH = 040         ;标题栏高度
      \Caption$ = "新建工具"  ;标题栏名称
      \WinSideL = 3
      \WinSideR = 3
      \WinSideT = 3
      \WinSideB = 3
      \StatusX  = 00          ;X坐标偏移
      \StatusH  = 30          ;状态栏高度      
      \ToolBarY = 00          ;Y坐标偏移
      \ToolBarW = 60          ;工具栏高度
      
      \SystemButtonSylte = 0        ;系统按键风格
      \UIColorStyleIndex = 0        ;UI颜色风格
      \IsUseSysCloseBox  = #True    ;关闭按键      
      \IsUseSysMinimize  = #True    ;最小化按键
      \IsUseSysMaximize  = #False   ;最大化按键
      \IsUseSysNormalcy  = #False   ;正常化按键
      \IsUseSysSettings  = #False   ;正常化按键
      \IsUseSysStickyNO  = #False   ;体窗置顶按键
      ;==================
      \IsUseCanvasImage  = #True    ;启用画布背景
      \IsUseCaptionBar   = #True    ;启用标题栏
      \IsUseStatusBar    = #False   ;启用状态栏
      \IsUseIcoToolBar   = #False   ;启用工具栏
      \IsUseOperateArea  = #False   ;启用作业区
      \IsUseIncludeIcon  = #False   ;启用图标资源包含
      \IsUseSizeWindow   = #False   ;是否支持窗体改变大小   
      \IsUseStatusSize   = #False   ;启用缩放小图标
      \IsUsePreference   = #False   ;插入设置文件
      \IsUseBalloonTip   = #False   ;设置提示文 
      \IsUseMessageBox   = #False   ;插入信息对话框的代码
      \IsUseSystemDrop   = #False   ;启用系统拖放
      \IsUseMultiFiles   = #False   ;启用系统拖放多个文件
      ;==================
      \DesignFile$       = #Null$
      \CreateDate        = Date()
      ;==================
      SetWindowTitle(#winScreen, #Screen_Caption$+" - 新建自绘界面设计稿(未保存)")
      Attributes_InitGadget()
   EndWith
EndProcedure

;-==========================
;-[Designs]
Procedure Designs_SaveFile()
   With _Project
      *MemData = AllocateMemory($100000)
      PokeL(*MemData+Pos, #DesignsFile_Flags)  : Pos+4 ;MPBF
      PokeF(*MemData+Pos, 1.0)                 : Pos+4 ;版本号
      PokeL(*MemData+Pos, \CreateDate)         : Pos+4 ;创建日期
      PokeL(*MemData+Pos, Date())              : Pos+4 ;修改日期

      CopyMemory_(*MemData+Pos, _Project, 64)            : Pos+64
      CopyMemory_(*MemData+Pos, @\SystemButtonSylte, 32) : Pos+32
      Lenght = StringByteLength(\Caption$, #PB_Ascii)+1
      PokeW(*MemData+Pos, Lenght)                        : Pos+02 
      PokeS(*MemData+Pos, \Caption$, -1, #PB_Ascii)      : Pos+Lenght
      
      Lenght = StringByteLength(\SoftwareIcon$, #PB_Ascii)+1
      PokeW(*MemData+Pos, Lenght)                        : Pos+02 
      PokeS(*MemData+Pos, \SoftwareIcon$, -1, #PB_Ascii) : Pos+Lenght
      
      Lenght = StringByteLength(\SourceFile$, #PB_Ascii)+1
      PokeW(*MemData+Pos, Lenght)                        : Pos+02 
      PokeS(*MemData+Pos, \SourceFile$, -1, #PB_Ascii)   : Pos+Lenght      
      Pos+16
      Count = ListSize(\ListColor())
      PokeW(*MemData+Pos, Count)                         : Pos+02
      ForEach \ListColor()
         CopyMemory_(*MemData+Pos, \ListColor(), 8*4) : Pos+8*04
         Lenght = StringByteLength(\ListColor()\ColorTable$, #PB_Ascii)+1
         PokeW(*MemData+Pos, Lenght)                                  : Pos+02 
         PokeS(*MemData+Pos, \ListColor()\ColorTable$, -1, #PB_Ascii) : Pos+Lenght
      Next 
      FileID = CreateFile(#PB_Any, _Project\DesignFile$)
      If FileID
         WriteData(FileID, *MemData, Pos)
         CloseFile(FileID)
      EndIf 
      FreeMemory(*MemData)
      _Project\OpenSuccess = #True
      SetWindowTitle(#winScreen, #Screen_Caption$+" - "+_Project\DesignFile$)
      If _Project\SoftwareIconID And _Project\IsUseIncludeIcon  
         CopyFile(_Project\SoftwareIcon$, ".\Software."+GetExtensionPart(_Project\SoftwareIcon$))
      EndIf 
      
   EndWith
EndProcedure

Procedure Designs_OpenFile(IsInital = #False)
   With _Project
      FileSize = FileSize(_Project\DesignFile$)
      If FileSize <= 0 
         If IsInital = #False : MessageRequester("出错提示", "文件不存在!    ") : EndIf 
         ProcedureReturn #False
      EndIf 
      *MemData = AllocateMemory(FileSize+$100)
      FileID = ReadFile(#PB_Any, _Project\DesignFile$)
      If FileID
         FileSeek(FileID, 0)
         ReadData(FileID, *MemData, FileSize)
         CloseFile(FileID)
      EndIf 
      If PeekL(*MemData+Pos) <> #DesignsFile_Flags ;MPBF
         FreeMemory(*MemData)
         MessageRequester("出错提示", "无效文件!    ")
         ProcedureReturn #False
      EndIf 
      Pos+4
      If PeekF(*MemData+Pos) <> 1.0 ;版本号
         FreeMemory(*MemData)
         MessageRequester("出错提示", "无效文件!    ")
         ProcedureReturn #False
      EndIf 
      Pos+4
      If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
      ClearMap(\pMapColor())
      ClearList(\ListColor())
      \OpenSuccess = #True
      \CreateDate  = PeekL(*MemData+Pos)                  : Pos+4+4         ;创建日期;修改日期
      CopyMemory_(_Project, *MemData+Pos, 64)             : Pos+64
      CopyMemory_(@\SystemButtonSylte, *MemData+Pos, 32)  : Pos+32
      Lenght         = PeekW(*MemData+Pos)                : Pos+02 
      \Caption$      = PeekS(*MemData+Pos, -1, #PB_Ascii) : Pos+Lenght
      Lenght         = PeekW(*MemData+Pos)                : Pos+02 
      \SoftwareIcon$ = PeekS(*MemData+Pos, -1, #PB_Ascii) : Pos+Lenght
      Lenght         = PeekW(*MemData+Pos)                : Pos+02 
      \SourceFile$   = PeekS(*MemData+Pos, -1, #PB_Ascii) : Pos+Lenght 
      Pos+16 
      Count          = PeekW(*MemData+Pos)                : Pos+02 
      For k = 1 To Count
         AddElement(\ListColor())
         CopyMemory_(\ListColor(), *MemData+Pos, 8*4)     : Pos+8*04
         Lenght = PeekW(*MemData+Pos)                     : Pos+02 
         \ListColor()\ColorTable$ = PeekS(*MemData+Pos, -1, #PB_Ascii) : Pos+Lenght
         \pMapColor(\ListColor()\ColorTable$) = \ListColor()
      Next 
      FreeMemory(*MemData)
      If FileSize(\SoftwareIcon$) > 0
         \SoftwareIconID = LoadImage(#PB_Any, \SoftwareIcon$)
      EndIf 
      Attributes_InitGadget()
      SetWindowTitle(#winScreen, #Screen_Caption$+" - "+_Project\DesignFile$)
      ProcedureReturn #True
   EndWith
EndProcedure
;-==========================
;-[Function]
;获取路径
Procedure$ GetPureBasicPath(hWindow)
   LibraryID = OpenLibrary(#PB_Any,"psapi.dll")
   If LibraryID
      GetModuleFileNameEx.GetModuleFileNameExW = GetFunction(LibraryID,"GetModuleFileNameExW")
      ExeFullName$ = Space(1024)
      GetWindowThreadProcessId_(hWindow, @hProcessId)   
      hHandle = OpenProcess_(#PROCESS_ALL_ACCESS, 0, hProcessId) 
      If hHandle
         GetModuleFileNameEx(hHandle, 0, @ExeFullName$, 1024) 
         CloseHandle_(hHandle)
      EndIf   
      CloseLibrary(LibraryID)
   EndIf
   ProcedureReturn ExeFullName$
EndProcedure

Procedure Enum_Scintilla(hGadget, *pScintilla.__EnumScintilla)  
   WindowClass$ = Space(255)  
   WindowTitle$ = Space(255)  
   GetClassName_ (hGadget, WindowClass$, 255)  
   GetWindowText_(hGadget, WindowTitle$, 255)
   If WindowClass$ = "Scintilla"
      If _Screen\hScintilla = hGadget 
         *pScintilla\hGadget = hGadget
         ProcedureReturn #False
      EndIf 
      *pScintilla\MaphGadget(Str(hGadget)) = hGadget
   EndIf 
  ProcedureReturn #True   
EndProcedure 

Procedure Enum_FindGadget(hGadget, *pScintilla.__EnumScintilla)  
   WindowClass$ = Space(255)  
   WindowTitle$ = Space(255)  
   GetClassName_ (hGadget, WindowClass$, 255)  
   GetWindowText_(hGadget, WindowTitle$, 255)
   If WindowClass$ = "Scintilla"
      If FindMapElement(*pScintilla\MaphGadget(), Str(hGadget)) = 0 
         *pScintilla\hGadget = hGadget
         _Screen\hScintilla = hGadget 
      EndIf 
   EndIf 
  ProcedureReturn #True   
EndProcedure 

; 枚举窗口
Procedure Enum_PureBasicWindow(hWindow, Index)  
   Title$ = Space(255)  
   GetWindowText_(hWindow, @Title$, 255) 
   If FindString(Title$, "PureBasic", 1)
      If GetPureBasicPath(hWindow) = _Screen\Compiler$
         Scintilla.__EnumScintilla
         EnumChildWindows_(hWindow, @Enum_Scintilla(), @Scintilla)
         If Scintilla\hGadget = 0 
            SendMessage_(hWindow, #WM_COMMAND, 0, 0)  
            Delay(100)
            EnumChildWindows_(hWindow, @Enum_FindGadget(), @Scintilla) 
         EndIf 
         If Scintilla\hGadget
            Text$ = GetGadgetText(#rtxSourceCode)
            *MemData = UTF8(Text$)
            SendMessage_(Scintilla\hGadget, #WM_SETTEXT, #Null, *MemData)
            FreeMemory(*MemData)
         EndIf 
         ProcedureReturn #False
      Else 
         ProcedureReturn #True 
      EndIf 
   Else  
      ProcedureReturn #True  
   EndIf  
EndProcedure

;-==========================
;-[EventGadget]
Procedure EventGadget_cvsIllustrate()
   With _Screen
      *pEventGadget.__GadgetInfo
      Select EventType() 
         Case #PB_EventType_MouseMove
            X = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseX) - _Screen\OffsetX
            Y = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseY) - _Screen\OffsetY
            If     Macro_Gadget_InRect1(_Project\IsUseSysCloseBox, \btnCloseBox)  : *pEventGadget = \btnCloseBox  
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysMinimize, \btnMinimize)  : *pEventGadget = \btnMinimize
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysNormalcy, \btnNormalcy)  : *pEventGadget = \btnNormalcy
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysMaximize, \btnMaximize)  : *pEventGadget = \btnMaximize
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysSettings, \btnSettings)  : *pEventGadget = \btnSettings
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysStickyNO, \btnStickyNO)  : *pEventGadget = \btnStickyNO
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysStickyNO, \btnStickyNC)  : *pEventGadget = \btnStickyNC
            
            ElseIf _Project\IsUseSizeWindow And X >= 0 And Y >=0 And X <= _Project\WindowW And Y <= _Project\WindowH
               If  X >= _Project\WindowW-_Project\StatusH And Y >= _Project\WindowH-_Project\StatusH : SetCursor_(\hSizing)      
               ElseIf _Project\WinSideL > 0 And X <= _Project\WinSideL                               : SetCursor_(\hLeftRight)                
               ElseIf _Project\WinSideR > 0 And X >= _Project\WindowW-_Project\WinSideR              : SetCursor_(\hLeftRight)
               ElseIf  _Project\WinSideT > 0 And Y <= _Project\WinSideT                              : SetCursor_(\hUpDown)           
               ElseIf _Project\WinSideT > 0 And Y >= _Project\WindowH-_Project\WinSideB              : SetCursor_(\hUpDown) 
               EndIf 
            EndIf 
            
            If _Project\IsUseBalloonTip And _Balloon\pBalloonTip <> *pEventGadget
               Select *pEventGadget
                  Case #Null
                     _Balloon\pBalloonTip = #Null
                     SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)
                  Case \btnCloseBox, \btnMinimize, \btnNormalcy, \btnMaximize, \btnSettings, \btnStickyNO, \btnStickyNC
                     If _Balloon\pBalloonTip <> #Null And _Balloon\pBalloonTip <> *pEventGadget
                        _Balloon\pBalloonTip = *pEventGadget
                        SetTimer_(\hWindow, #TIMER_BalloonTip, 0010, #Null)
                     Else 
                        _Balloon\pBalloonTip = *pEventGadget
                        SetTimer_(\hWindow, #TIMER_BalloonTip, 1000, #Null)
                     EndIf 
               EndSelect
            EndIf
;             
            If \pMouseTop <> *pEventGadget : \pMouseTop = *pEventGadget : Redraw_cvsIllustrate() : EndIf   

         Case #PB_EventType_LeftButtonDown
            X = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseX) - _Screen\OffsetX
            Y = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseY) - _Screen\OffsetY
            If     Macro_Gadget_InRect1(_Project\IsUseSysCloseBox, \btnCloseBox)  : *pEventGadget = \btnCloseBox
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysMinimize, \btnMinimize)  : *pEventGadget = \btnMinimize
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysNormalcy, \btnNormalcy)  : *pEventGadget = \btnNormalcy
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysMaximize, \btnMaximize)  : *pEventGadget = \btnMaximize
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysSettings, \btnSettings)  : *pEventGadget = \btnSettings
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysStickyNO, \btnStickyNO)  : *pEventGadget = \btnStickyNO
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysStickyNO, \btnStickyNC)  : *pEventGadget = \btnStickyNC
            EndIf 
            If \pHoldDown <> *pEventGadget : \pHoldDown = *pEventGadget : Redraw_cvsIllustrate() : EndIf               
   
         Case #PB_EventType_LeftButtonUp
            X = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseX) - _Screen\OffsetX
            Y = GetGadgetAttribute(#cvsIllustrate, #PB_Canvas_MouseY) - _Screen\OffsetY
            If     Macro_Gadget_InRect1(_Project\IsUseSysCloseBox, \btnCloseBox)
               *pEventGadget = \btnCloseBox
               If _Project\IsUseMessageBox
                  PostEvent(#PB_Event_Menu, #winScreen, #wtbShowMessage)
               EndIf 
               
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysMinimize, \btnMinimize)  : *pEventGadget = \btnMinimize
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysNormalcy, \btnNormalcy)  
               *pEventGadget = \btnNormalcy
               \btnNormalcy\IsHide = #True 
               \btnMaximize\IsHide = #False 
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysMaximize, \btnMaximize)  
               *pEventGadget = \btnMaximize
               \btnNormalcy\IsHide = #False
               \btnMaximize\IsHide = #True
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysStickyNO, \btnStickyNO)  
               *pEventGadget = \btnStickyNO
               \btnStickyNO\IsHide = #True 
               \btnStickyNC\IsHide = #False  
               
            ElseIf Macro_Gadget_InRect2(_Project\IsUseSysStickyNO, \btnStickyNC)  
               *pEventGadget = \btnStickyNC
               \btnStickyNO\IsHide = #False 
               \btnStickyNC\IsHide = #True                 
               
            ElseIf Macro_Gadget_InRect1(_Project\IsUseSysSettings, \btnSettings)  
               
            EndIf 
            If \pHoldDown : \pHoldDown = 0 : Redraw_cvsIllustrate() : EndIf           
      EndSelect

      
   EndWith
EndProcedure

Procedure EventGadget_cvsAttributes()
   Select EventType()
      Case #PB_EventType_MouseMove
         X = GetGadgetAttribute(#cvsAttributes, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsAttributes, #PB_Canvas_MouseY)
         ForEach _Screen\ListAttriGroup()
            With _Screen\ListAttriGroup()
               If \Y <= Y And Y <= \B
                  StatusBarText(#wsbScreen,  2, "提示: "+ _Screen\ListAttriGroup()\Notice$)
                  ProcedureReturn 
               EndIf 
               If \FoldState = #False
                  ForEach \ListAttriItems()
                     If \ListAttriItems()\Y <= Y And Y <= \ListAttriItems()\B
                        StatusBarText(#wsbScreen,  2, "提示: "+ _Screen\ListAttriGroup()\ListAttriItems()\Notice$)
                        ProcedureReturn 
                     EndIf 
                  Next 
               EndIf 
            EndWith
         Next 

      Case #PB_EventType_LeftClick
         X = GetGadgetAttribute(#cvsAttributes, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsAttributes, #PB_Canvas_MouseY)
         ForEach _Screen\ListAttriGroup()
            With _Screen\ListAttriGroup()
               If \Y <= Y And Y <= \B
                  \FoldState = 1- \FoldState
                  ForEach \ListAttriItems()
                     HideGadget(\ListAttriItems()\GadgetID1, \FoldState)
                     If IsGadget(\ListAttriItems()\GadgetID2)
                        HideGadget(\ListAttriItems()\GadgetID2, \FoldState)
                     EndIf 
                  Next 
                  Redraw_cvsAttributes()
                  ProcedureReturn
               EndIf 
            EndWith
         Next 
   EndSelect
EndProcedure

Procedure EventGadget_srcIllustrateH()
   ScrollAreaX = GetGadgetState(#srcIllustrateH)
   If _Screen\ScrollAreaX <> ScrollAreaX
      _Screen\ScrollAreaX = ScrollAreaX
      Redraw_cvsIllustrate()
   EndIf 
EndProcedure

Procedure EventGadget_srcIllustrateV()
   ScrollAreaY = GetGadgetState(#srcIllustrateV)
   If _Screen\ScrollAreaY <> ScrollAreaY
      _Screen\ScrollAreaY = ScrollAreaY
      Redraw_cvsIllustrate()
   EndIf 
EndProcedure 

Procedure EventGadget_txtCompiler()
   If EventType() <> #PB_EventType_Change : ProcedureReturn : EndIf 
   _Screen\Compiler$ = Trim(GetGadgetText(#txtCompiler))
EndProcedure

Procedure EventGadget_btnCompiler()
   Pattern$ = "任意文件 (*.*)|*.*"
   Compiler$ = OpenFileRequester("请选择PuerBasic.exe", _Screen\Compiler$, Pattern$, 0)
   If Compiler$
      _Screen\Compiler$ = Compiler$
      SetGadgetText(#txtCompiler, Compiler$)
   EndIf 
EndProcedure

;-==========================
;-[EventWindow]
Procedure EventMenu_wtbToolSaveFile()
   State = GetToolBarButtonState(#wtbScreen, #wtbToolGenerate)
   If State = #False
      If _Project\OpenSuccess 
         Designs_SaveFile()
      Else 
         Pattern$ = "自绘界面设计稿 (*.mpb)|*.mpb"
         DesignFile$ = SaveFileRequester("保存自绘界面设计稿", _Project\Caption$, Pattern$, 0)
         If DesignFile$
            If LCase(GetExtensionPart(DesignFile$)) <> "mpb"
               DesignFile$+".mpb"
            EndIf 
            _Project\DesignFile$ = DesignFile$
            Designs_SaveFile()
         EndIf 
      EndIf 
   Else 
      If _Project\SourceFile$ <> #Null$
         mcsRichEditSaveFile_(#rtxSourceCode, _Project\SourceFile$, #PB_UTF8)
      Else 
         Pattern$ = "PureBasic源代码文件 (*.pb)|*.pb"
         SourceFile$ = SaveFileRequester("保存PureBasic源代码文件", _Project\Caption$, Pattern$, 0)
         If SourceFile$
            If LCase(GetExtensionPart(SourceFile$)) <> "pb"
               SourceFile$+".pb"
            EndIf 
            _Project\SourceFile$ = SourceFile$
            mcsRichEditSaveFile_(#rtxSourceCode, _Project\SourceFile$, #PB_UTF8)
         EndIf 
      EndIf  
   EndIf 
EndProcedure

Procedure EventMenu_wtbToolSaveAs()
   State = GetToolBarButtonState(#wtbScreen, #wtbToolGenerate)
   If State = #False
      Pattern$ = "自绘界面设计稿 (*.mpb)|*.mpb"
      If _Project\OpenSuccess 
         DesignFile$ = SaveFileRequester("自绘界面设计稿另存为", _Project\DesignFile$, Pattern$, 0)
      Else 
         DesignFile$ = SaveFileRequester("保存自绘界面设计稿", _Project\Caption$, Pattern$, 0)
      EndIf 
      If DesignFile$
         If LCase(GetExtensionPart(DesignFile$)) <> "mpb"
            DesignFile$+".mpb"
         EndIf 
         _Project\DesignFile$ = DesignFile$
         Designs_SaveFile()
      EndIf 
   Else 
      Pattern$ = "PureBasic源代码文件 (*.pb)|*.pb"
      If _Project\SourceFile$ <> #Null$
         SourceFile$ = SaveFileRequester("保存PureBasic源代码文件", _Project\Caption$, Pattern$, 0)
      Else 
         SourceFile$ = SaveFileRequester("PureBasic源代码文件另存为", _Project\Caption$, Pattern$, 0)
      EndIf 
      If SourceFile$
         If LCase(GetExtensionPart(SourceFile$)) <> "pb"
            SourceFile$+".pb"
         EndIf 
         _Project\SourceFile$ = SourceFile$
         mcsRichEditSaveFile_(#rtxSourceCode, _Project\SourceFile$, #PB_UTF8)
      EndIf 
   EndIf 
EndProcedure

Procedure EventMenu_wtbToolGenerate()
   State = GetToolBarButtonState(#wtbScreen, #wtbToolGenerate)
   _Screen\IsGenerateView = State
   DisableToolBarButton(#wtbScreen, #wtbToolNewFile,   State)
   DisableToolBarButton(#wtbScreen, #wtbToolOpenFile,  State)
   DisableToolBarButton(#wtbScreen, #wtbToolCloseFile, State)
   If _Screen\IsGenerateView
      GenerateCode_Main()
   Else 
      Redraw_cvsIllustrate()
   EndIf 
   HideGadget(#rtxSourceCode, 1-State)
   HideGadget(#cvsIllustrate, State)
EndProcedure


Procedure EventMenu_wtbToolAboutMe()
   
   ImageID = CatchImage(#PB_Any, ?_Image_PBLogo)
   
   Flags = #PB_Window_SystemMenu|#PB_Window_WindowCentered
   OpenWindow(#winVersion, 0, 0, 480, 400, "版本说明", Flags, _Screen\hWindow)
   SetGadgetFont(#PB_All, FontID(#fntDefault))
   ImageGadget (#imgVersion, 000, 000, 480, 86,  ImageID(ImageID))
   TextGadget  (#lblCompiler, 010, 095, 480, 020, "PureBasic路径:")
   StringGadget(#txtCompiler, 010, 115, 430, 020, _Screen\Compiler$)
   ButtonGadget(#btnCompiler, 450, 114, 020, 020, "…")   
   TextGadget  (#lblVersion, 010, 145, 480, 015, "历史版本:")
   EditorGadget(#rtxVersion, 010, 165, 460, 225, #PB_Editor_ReadOnly)
;    SetGadgetFont(#rtxVersion, FontID(#fntVersion))
   SetGadgetColor(#rtxVersion, #PB_Gadget_FrontColor, $7C6600)
   SetGadgetColor(#rtxVersion, #PB_Gadget_BackColor,  $DFFFFF)
   SetGadgetText(#rtxVersion, _Screen\VersionNotice$)
   BindGadgetEvent(#txtCompiler, @EventGadget_txtCompiler())
   BindGadgetEvent(#btnCompiler, @EventGadget_btnCompiler())
   Repeat
      Select WindowEvent()
         Case #PB_Event_CloseWindow   : IsExitWindow = #True
      EndSelect
   Until IsExitWindow = #True 
   CloseWindow(#winVersion)
   FreeImage(ImageID)
EndProcedure

Procedure EventWindow_EventMenu()
   Select EventMenu()
      Case #wtbToolNewFile    : Attributes_NewProject()
      Case #wtbToolCloseFile  : Attributes_NewProject()  
      Case #wtbToolSaveFile   : EventMenu_wtbToolSaveFile()
      Case #wtbToolSaveAs     : EventMenu_wtbToolSaveAs()
      Case #wtbToolAboutMe    : EventMenu_wtbToolAboutMe()
      Case #wtbToolGenerate   : EventMenu_wtbToolGenerate()
      Case #wtbShowMessage   
         Message_Requester(_Screen\hWindow, "迷路提示", "确定要关闭窗体么? ", #PB_MessageRequester_YesNo|$20)
      Case #wtbToolPureBasic
         If _Screen\IsGenerateView = #False
            GenerateCode_Main()
         EndIf 
         If _Screen\Compiler$
            CompilerID = RunProgram(_Screen\Compiler$, "", "", #PB_Program_Open)
            If CompilerID 
               CloseProgram(CompilerID) 
               EnumWindows_(@Enum_PureBasicWindow(), 0)  
            Else 
               MessageRequester("出错提示", "请在[软件说明]中设置有效的PureBasic编辑器的路径.")
            EndIf
         Else 
            MessageRequester("友情提示", "请在[软件说明]中设置PureBasic编辑器的路径.")
         EndIf 
         
      Case #wtbToolOpenFile
         Pattern$ = "自绘界面设计稿 (*.mpb)|*.mpb"
         DesignFile$ = OpenFileRequester("打开自绘界面设计稿", _Project\DesignFile$, Pattern$, 0)
         If FileSize(DesignFile$) > 0
            _Project\DesignFile$ = DesignFile$
            Designs_OpenFile()
         EndIf 
      Case #wtbToolSticky 
         _Screen\IsStickyWindow = GetToolBarButtonState(#wtbScreen, #wtbToolSticky)
         StickyWindow(#winScreen, _Screen\IsStickyWindow)
   EndSelect
   
EndProcedure

Procedure EventWindow_MOUSEWHEEL()
   Scroll.w = ((EventwParam()>>16) & $FFFF)
   Scroll = - Scroll / 120
   Select Scroll
      Case -1 
      Case 01 
      Default : ProcedureReturn
   EndSelect 
   GadgetID = GetActiveGadget()   
   Select GadgetID
      Case #txtWindowRealW, #txtWindowRealH, #txtWindowSideL, #txtWindowSideR, #txtWindowSideT, #txtWindowSideB
         Value = Val(GetGadgetText(GadgetID)) : SetGadgetText(GadgetID, Str(Value+Scroll))
         PostEvent(#PB_Event_Gadget, #winScreen, GadgetID, #PB_EventType_Change)
      Case  #txtCaptionBarX, #txtCaptionBarH, #txtStatusBarX, #txtStatusBarH, #txtIcoToolbarY, #txtIcoToolbarW
         Value = Val(GetGadgetText(GadgetID)) : SetGadgetText(GadgetID, Str(Value+Scroll))
         PostEvent(#PB_Event_Gadget, #winScreen, GadgetID, #PB_EventType_Change)
      Default
         ProcedureReturn
   EndSelect
   Redraw_cvsIllustrate()
EndProcedure

Procedure EventWindow_DragDorpFile()
   If _Project\IsUseMultiFiles
      DroppedID = EventwParam()  
      GetCount = DragQueryFile_(DroppedID, -1, "", 0) 
      For k = 0 To GetCount - 1  
         LenFileName  = DragQueryFile_(DroppedID, k, 0, 0)  
         FileName$ = Space(LenFileName)  
         DragQueryFile_(DroppedID, k, FileName$, LenFileName+1) 
         FileSize = FileSize(FileName$)
         If FileSize >= 0   
            CountFiles + 1
            Message$ + FileName$+#LFCR$
         ElseIf FileSize = -2
            CountFiles + 1
            If Right(FileName$, 1) <> "\" : FileName$ = FileName$ + "\" : EndIf  
            Message$ + FileName$+#LFCR$
         EndIf 
      Next  
      DragFinish_(DroppedID) 
      If CountFiles
         Message_Requester(_Screen\hWindow, "系统拖放文件", Message$) 
      EndIf 
   Else 
      DroppedID = EventwParam()  
      CountFiles = DragQueryFile_(DroppedID, $FFFFFFFF, "", 0) 
      If CountFiles
         LenFileName  = DragQueryFile_(DroppedID, 0, 0, 0)  
         FileName$ = Space(LenFileName)  
         DragQueryFile_(DroppedID, 0, FileName$, LenFileName+1) 
      EndIf 
      DragFinish_(DroppedID) 
      If FileSize(FileName$) >= 0 
         Message_Requester(_Screen\hWindow, "系统拖放文件", FileName$)
      EndIf 
   EndIf 
   ProcedureReturn 
EndProcedure
   
;-==========================
;-[EventGroup]
Procedure EventGroup_CanvasGadget()
   If EventType() <> #PB_EventType_LeftClick : ProcedureReturn : EndIf 
   Select EventGadget()
      Case #cvsSetBackColor To #cvsSetShadowColor 
         If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
            *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
            State = GetGadgetState(#cmbColorsPrefer)
            GadgetID = EventGadget()
            If State <> -1 
               *pColor.long = SelectElement(_Project\ListColor(), State) + (GadgetID-#cvsSetBackColor)*4
               Color = ColorRequester(*pColor\l & $FFFFFF)
               If Color <> - 1 
                  *pColor\l = (Color & $FFFFFF)|(*pColor\l & $FF000000)
                  If StartDrawing(CanvasOutput(GadgetID))
                     Box(000, 000, 020, 020, *pColor\l & $FFFFFF)
                     StopDrawing()
                  EndIf 
                  SetGadgetText(#txtSetBackColor+GadgetID-#cvsSetBackColor, "$"+RSet(Hex(*pColor\l, #PB_Long), 8, "0")) 
               EndIf 
            EndIf 
         EndIf 
   EndSelect
   If _Screen\IsGenerateView
      GenerateCode_Main()
   Else 
      Redraw_cvsIllustrate()
   EndIf 
EndProcedure

Procedure EventGroup_StringGadget()
   If EventType() <> #PB_EventType_Change : ProcedureReturn : EndIf 
   With _Project
      Select EventGadget()

         Case #txtCaptionBarX : \CaptionX = Val(GetGadgetText(#txtCaptionBarX))
         Case #txtCaptionBarH : \CaptionH = Val(GetGadgetText(#txtCaptionBarH))
         Case #txtCaptionName : \Caption$ = GetGadgetText(#txtCaptionName)
         Case #txtIcoToolbarY : \ToolBarY = Val(GetGadgetText(#txtIcoToolbarY))
         Case #txtIcoToolbarW : \ToolBarW = Val(GetGadgetText(#txtIcoToolbarW))
         Case #txtStatusBarX  : \StatusX  = Val(GetGadgetText(#txtStatusBarX))
         Case #txtStatusBarH  : \StatusH  = Val(GetGadgetText(#txtStatusBarH))
         
         Case #txtWindowSideL : \WinSideL  = Val(GetGadgetText(#txtWindowSideL)) 
         Case #txtWindowSideR : \WinSideR  = Val(GetGadgetText(#txtWindowSideR)) 
         Case #txtWindowSideT : \WinSideT  = Val(GetGadgetText(#txtWindowSideT)) 
         Case #txtWindowSideB : \WinSideB  = Val(GetGadgetText(#txtWindowSideB)) 

         Case #txtWindowRealW, #txtWindowRealH 
            \WindowW  = Val(GetGadgetText(#txtWindowRealW))
            \WindowH  = Val(GetGadgetText(#txtWindowRealH))
            StatusBarText(#wsbScreen,  1, " 窗体大小: "+Str(\WindowW)+"x"+Str(\WindowH))

         Case #txtCaptionIcon          
            SoftwareIcon$ = GetGadgetText(#txtCaptionIcon)
            SoftwareIcon$ = GetPathPart(\SoftwareIcon$)+SoftwareIcon$
            If FileSize(SoftwareIcon$) <= 0
               SoftwareIconID = LoadImage(#PB_Any, SoftwareIcon$)
               If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
               If SoftwareIconID
                  \SoftwareIconID = SoftwareIconID
                  \SoftwareIcon$  = SoftwareIcon$
                  DisableGadget(#chkIncludeIcon, #False)
               Else 
                  StatusBarText(#wsbScreen,  2, "提示: 图像文件无效: "+ SoftwareIcon$)
                  DisableGadget(#chkIncludeIcon, #True)
               EndIf
            Else 
               If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
               StatusBarText(#wsbScreen,  2, "提示: 图像文件不存在: "+ SoftwareIcon$) 
               DisableGadget(#chkIncludeIcon, #True)  
            EndIf 

         Case #txtSetBackColor To #txtSetHighColor; #txtSetShadowColor
            If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
               *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
               State = GetGadgetState(#cmbColorsPrefer)
               GadgetID = EventGadget()
               If State <> -1 
                  *pColor.long = SelectElement(_Project\ListColor(), State) + (GadgetID-#txtSetBackColor)*4
                  Color = Val(GetGadgetText(GadgetID))
                  If Color <> - 1 
                     *pColor\l = Color
                     If StartDrawing(CanvasOutput(#cvsSetBackColor+GadgetID-#txtSetBackColor))
                        Box(000, 000, 020, 020, *pColor\l & $FFFFFF)
                        StopDrawing()
                     EndIf 
                     Redraw_cvsIllustrate()
                  EndIf 
               EndIf 
            EndIf 
         Default : ProcedureReturn
      EndSelect
      If _Screen\IsGenerateView
         GenerateCode_Main()
      Else 
         Redraw_cvsIllustrate()
      EndIf 
   EndWith
EndProcedure

Procedure EventGroup_ButtonGadget()
   With _Project
      Select EventGadget()
         Case #btnCaptionIcon 
            Pattern$ = "ICON 图标 (*.ico)|*.ico|BMP图像 (*.bmp)|*.bmp|PNG图像 (*.png)|*.png|"+
                    "JPG图像 (*.jpg)|*.jpg|TGA图像 (*.tga)|*.tga|TIFF图像 (*.tif)|*.tif|"+
                    "任意图像 (*.*)|*.*"
            Pattern = 0    ; 默认选择第一个
            SoftwareIcon$ = OpenFileRequester("请选择要打开的文件", \SoftwareIcon$, Pattern$, Pattern)
            If SoftwareIcon$
               SoftwareIconID = LoadImage(#PB_Any, SoftwareIcon$)
               If SoftwareIconID
                  If IsImage(\SoftwareIconID) : FreeImage(\SoftwareIconID) : EndIf 
                  \SoftwareIconID = SoftwareIconID
                  \SoftwareIcon$  = SoftwareIcon$
                  SetGadgetText(#txtCaptionIcon, GetFilePart(SoftwareIcon$))
                  DisableGadget(#chkIncludeIcon, #False)
               Else 
                  MessageRequester("提示", "图标文件无效! ")
                  DisableGadget(#chkIncludeIcon, #True)
               EndIf 
            EndIf
         Default : ProcedureReturn
      EndSelect
      If _Screen\IsGenerateView
         GenerateCode_Main()
      Else 
         Redraw_cvsIllustrate()
      EndIf 
   EndWith
EndProcedure

Procedure EventGroup_CheckBoxGadget()
   With _Project
      GadgetID = EventGadget()
      Select GadgetID
         Case #chkPreference   : \IsUsePreference    = GetGadgetState(#chkPreference) 
         Case #chkCaptionBar   : \IsUseCaptionBar    = GetGadgetState(#chkCaptionBar)
         Case #chkStatusBar    : \IsUseStatusBar     = GetGadgetState(#chkStatusBar)
         Case #chkIcoToolbar   : \IsUseIcoToolBar    = GetGadgetState(#chkIcoToolbar)
         Case #chkStatusSize   : \IsUseStatusSize    = GetGadgetState(#chkStatusSize)
         Case #chkSysCloseBox  : \IsUseSysCloseBox   = GetGadgetState(#chkSysCloseBox)
         Case #chkSysMinimize  : \IsUseSysMinimize   = GetGadgetState(#chkSysMinimize)
         Case #chkSysStickyNO  : \IsUseSysStickyNO   = GetGadgetState(#chkSysStickyNO) 
         Case #chkCanvasImage  : \IsUseCanvasImage   = GetGadgetState(#chkCanvasImage)
         Case #chkBalloonTip   : \IsUseBalloonTip    = GetGadgetState(#chkBalloonTip)
         Case #chkMessageBox   : \IsUseMessageBox    = GetGadgetState(#chkMessageBox)  
         Case #chkSystemDrop   :  ;设置系统拖放 
            \IsUseSystemDrop    = GetGadgetState(#chkSystemDrop)
            DragAcceptFiles_(_Screen\hWindow, \IsUseSystemDrop)
            DisableGadget(#chkMultiFiles, 1-\IsUseSystemDrop)
            
         Case #chkMultiFiles   :  ;设置系统拖放 
            \IsUseMultiFiles    = GetGadgetState(#chkMultiFiles)

         Case #chkSysMaximize  
            \IsUseSysMaximize = GetGadgetState(#chkSysMaximize)
            \IsUseSysNormalcy = GetGadgetState(#chkSysMaximize)
            SetGadgetState(#chkSysNormalcy, \IsUseSysNormalcy)
         Case #chkSysNormalcy  
            \IsUseSysMaximize = GetGadgetState(#chkSysNormalcy)
            \IsUseSysNormalcy = GetGadgetState(#chkSysNormalcy)
            SetGadgetState(#chkSysMaximize, \IsUseSysMaximize)
         Case #chkSysSettings
            \IsUseSysSettings = GetGadgetState(#chkSysSettings)   
                               
         Case #chkIncludeIcon
            \IsUseIncludeIcon = GetGadgetState(#chkIncludeIcon)    
                                          
         Case #chkUseGradients, #chkAniGradients 
            State = 1-GetGadgetState(#chkUseGradients) 
            DisableGadget(#chkAniGradients, State)  
            DisableGadget(#cmbGradientType, State)   
            
            If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
               *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
               State = GetGadgetState(#cmbColorsPrefer)
               GadgetID = EventGadget()
               If State <> -1 
                  *pGadgetColor.__ScreenColorInfo = SelectElement(_Project\ListColor(), State)
                  *pGadgetColor\IsUseGradient = GetGadgetState(#chkUseGradients)
                  *pGadgetColor\IsAniGradient = GetGadgetState(#chkAniGradients)
               EndIf 
            EndIf 
         Case #chkSizeWindow   
            \IsUseSizeWindow = GetGadgetState(#chkSizeWindow) 
            State = 1-\IsUseSizeWindow
            DisableGadget(#txtWindowSideL, State)  ;左际留边
            DisableGadget(#txtWindowSideR, State)  ;右际留边
            DisableGadget(#txtWindowSideT, State)  ;顶部留边
            DisableGadget(#txtWindowSideB, State)  ;底部留边
            DisableGadget(#chkStatusSize,  State)  ;缩放小图标

         Default : ProcedureReturn
      EndSelect
      Select _Project\SystemButtonSylte 
         Case #ButtonStyle_Piano, #ButtonStyle_Capsule 
            Select GadgetID
               Case #chkSysMinimize, #chkSysStickyNO, #chkSysMaximize, #chkSysNormalcy, #chkSysSettings
                  Create_btnCloseBox(_Screen\btnCloseBox)
                  Create_btnMinimize(_Screen\btnMinimize)
                  Create_btnMaximize(_Screen\btnMaximize)
                  Create_btnNormalcy(_Screen\btnNormalcy)
                  Create_btnSettings(_Screen\btnSettings)
                  Create_btnStickyNO(_Screen\btnStickyNO)
                  Create_btnStickyNC(_Screen\btnStickyNC)
            EndSelect
      EndSelect 
      
      If _Screen\IsGenerateView
         GenerateCode_Main()
      Else 
         Redraw_cvsIllustrate()
      EndIf 
   EndWith
EndProcedure

;==========
Procedure EventGroup_cmbLayoutStyle()
   Index = GetGadgetState(#cmbLayoutStyle)
   If Index = -1 : ProcedureReturn : EndIf 
   If _Project\UIColorStyleIndex = Index : ProcedureReturn : EndIf 
   _Project\UIColorStyleIndex = Index
   ClearList(_Project\ListColor())
   SetGadgetState(#cmbLayoutStyle, _Project\UIColorStyleIndex)
   SelectElement(_Screen\ListColorStyle(), _Project\UIColorStyleIndex)
   *pMemColor = _Screen\ListColorStyle()\pMemColor
   Pos = Attributes_CatchColor(*pMemColor, Pos, "窗体布局")
   Pos = Attributes_CatchColor(*pMemColor, Pos, "标题栏")
   Pos = Attributes_CatchColor(*pMemColor, Pos, "状态栏")
   Pos = Attributes_CatchColor(*pMemColor, Pos, "工具栏")
   Pos = Attributes_CatchColor(*pMemColor, Pos, "对话框按键")

   If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
      *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
      ClearGadgetItems(#cmbColorsPrefer)
      ForEach _Project\ListColor()
         AddGadgetItem(#cmbColorsPrefer, -1, _Project\ListColor()\ColorTable$)
      Next
      SetGadgetState(#cmbColorsPrefer, 0) 
      PostEvent(#PB_Event_Gadget, #winScreen, #cmbColorsPrefer)
   EndIf 
   FirstElement(_Project\ListColor())
   SetGadgetState(#cmbGradientType, _Project\ListColor()\GradientTpyes)  
   State = 1-_Project\ListColor()\IsUseGradient
   DisableGadget(#chkAniGradients, State)  
   DisableGadget(#cmbGradientType, State)   
   Create_btnCloseBox(_Screen\btnCloseBox)
   Create_btnMinimize(_Screen\btnMinimize)
   Create_btnMaximize(_Screen\btnMaximize)
   Create_btnNormalcy(_Screen\btnNormalcy)
   Create_btnSettings(_Screen\btnSettings)
   Create_btnStickyNO(_Screen\btnStickyNO)
   Create_btnStickyNC(_Screen\btnStickyNC)
EndProcedure

Procedure EventGroup_cmbColorsPrefer()
   State = GetGadgetState(#cmbColorsPrefer)
   If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
      *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
      If State = -1 
         For GadgetID = #txtSetBackColor To #txtSetHighColor;#txtSetShadowColor
            SetGadgetText(GadgetID, "")
         Next 
      Else 
         *pGadgetColor.__ScreenColorInfo = SelectElement(_Project\ListColor(), State)
         SetGadgetState(#chkUseGradients, *pGadgetColor\IsUseGradient)
         SetGadgetState(#chkAniGradients, *pGadgetColor\IsAniGradient)
         SetGadgetState(#cmbGradientType, *pGadgetColor\GradientTpyes)  
         State = 1-*pGadgetColor\IsUseGradient
         DisableGadget(#chkAniGradients, State)  
         DisableGadget(#cmbGradientType, State)   

         *pColor.long = *pGadgetColor
         For GadgetID = #cvsSetBackColor To #cvsSetHighColor; #cvsSetShadowColor
            If StartDrawing(CanvasOutput(GadgetID))
               Box(000, 000, 020, 020, *pColor\l & $FFFFFF)
               StopDrawing()
            EndIf 
            SetGadgetText(#txtSetBackColor+GadgetID-#cvsSetBackColor, "$"+RSet(Hex(*pColor\l, #PB_Long), 8, "0")) 
            *pColor+4
         Next 
      EndIf 
   EndIf 
   
EndProcedure

Procedure EventGroup_ComboBoxGadget()
   Select EventGadget()
      Case #cmbLayoutStyle    : EventGroup_cmbLayoutStyle()   
      Case #cmbColorsPrefer   : EventGroup_cmbColorsPrefer() : ProcedureReturn         
      Case #cmbSystemButton
         SystemButtonSylte = GetGadgetState(#cmbSystemButton)
         If _Project\SystemButtonSylte <> SystemButtonSylte
            _Project\SystemButtonSylte = SystemButtonSylte
            Create_btnCloseBox(_Screen\btnCloseBox)
            Create_btnMinimize(_Screen\btnMinimize)
            Create_btnMaximize(_Screen\btnMaximize)
            Create_btnNormalcy(_Screen\btnNormalcy)
            Create_btnSettings(_Screen\btnSettings)
            Create_btnStickyNO(_Screen\btnStickyNO)
            Create_btnStickyNC(_Screen\btnStickyNC)
         EndIf 

      Case #cmbGradientType
         State = GetGadgetState(#cmbColorsPrefer)
         If State = -1 : ProcedureReturn : EndIf 
         If FindMapElement(_Screen\pMapAttriGroup(), "颜色设置")
            *pAttriGroup.__AttriGroupInfo =  _Screen\pMapAttriGroup("颜色设置")
            *pGadgetColor.__ScreenColorInfo = SelectElement(_Project\ListColor(), State)
            GradientType = GetGadgetState(#cmbGradientType)
            If GradientType >= 0 
               *pGadgetColor\GradientTpyes = GradientType
            EndIf 
         EndIf 

      Default
         ProcedureReturn
   EndSelect
   If _Screen\IsGenerateView
      GenerateCode_Main()
   Else 
      Redraw_cvsIllustrate()
   EndIf 
EndProcedure

;-==========================
;-[Callback]
Procedure Screen_SizeWindow()
   With _Screen
      \WindowW = WindowWidth (#winScreen)
      \WindowH = WindowHeight(#winScreen)
      If \WindowW <=0  Or \WindowH <= 0 : ProcedureReturn : EndIf 
      ;===============
      TableX = \WindowW-05-#Screen_AboutMilooW
      ResizeGadget(#lblScreen, TableX, #PB_Ignore, #PB_Ignore, #PB_Ignore)
      ;窗体演示界面
      CanvasW = \WindowW-15-#Screen_AttributeW
      CanvasH = \WindowH-10-StatusBarHeight(#wsbScreen)-ToolBarHeight(#wtbScreen)
      ResizeGadget(#cvsIllustrate, #PB_Ignore, #PB_Ignore, CanvasW, CanvasH)
      ResizeGadget(#rtxSourceCode, #PB_Ignore, #PB_Ignore, CanvasW, CanvasH)
         ;底部滚动条
         GadgetY = CanvasH-#Screen_ScrollBarH-4
         GadgetW = CanvasW-#Screen_ScrollBarW-4
         ResizeGadget(#srcIllustrateH, #PB_Ignore, GadgetY, GadgetW, #PB_Ignore)
         ;右侧滚动条
         GadgetX = CanvasW - #Screen_ScrollBarW-4
         GadgetH = CanvasH - #Screen_ScrollBarH-4
         ResizeGadget(#srcIllustrateV, GadgetX, #PB_Ignore, #PB_Ignore, GadgetH)
      ;===============
      ;右侧设置栏
      CanvasX = \WindowW-05-#Screen_AttributeW
      CanvasH = \WindowH-10-StatusBarHeight(#wsbScreen)-ToolBarHeight(#wtbScreen)
      ResizeGadget(#cvsAttributes, CanvasX, #PB_Ignore, #PB_Ignore, CanvasH)
   EndWith   
EndProcedure

Procedure Screen_BalloonTip()

   With _Balloon
      *pColorWindow.__ScreenColorInfo = _Project\pMapColor("窗体布局")
      If \pBalloonTip And \pBalloonTip\BalloonTip$ <> #Null$
         
         ;计算文本占用的最大宽度和最大高度
         TempImageID = CreateImage(#PB_Any, 100, 100)
         If StartDrawing(ImageOutput(TempImageID))
            DrawingFont(FontID(#fntDefault))
            TextW = TextWidth (\pBalloonTip\BalloonTip$) + 20
            TextH = TextHeight(\pBalloonTip\BalloonTip$) + 10
            StopDrawing()
         EndIf
         FreeImage(TempImageID)
         GetCursorPos_(Mouse.POINT)
         Gadget.POINT
         Gadget\X = \pBalloonTip\X + 20
         Gadget\Y = \pBalloonTip\B + 45 + _Screen\OffsetY
         ClientToScreen_(_Screen\hWindow, Gadget) 
         Mouse\y = Gadget\y
         \WindowW = TextW
         \WindowH = TextH
         
         If IsImage(#imgBalloon) = 0
            hImageScreen = CreateImage(#imgBalloon, \WindowW, \WindowH)
         ElseIf ImageWidth(#imgBalloon) <> \WindowW Or ImageHeight(#imgBalloon) <> \WindowH
            FreeImage(#imgBalloon)
            hImageScreen = CreateImage(#imgBalloon, \WindowW, \WindowH)
         Else 
            hImageScreen = ImageID(#imgBalloon)
         EndIf 
         If hImageScreen = 0 : ProcedureReturn : EndIf

         If IsWindow(#winBalloon) = #False
            \hWindow = OpenWindow(#winBalloon, 0, 0, 0, 0, "", #PB_Window_BorderLess, _Screen\hWindow)
            HideWindow(#winBalloon, #True)
         EndIf 
         
         If StartDrawing(ImageOutput(#imgBalloon))
            DrawingFont(FontID(#fntDefault))
            DrawingMode(#PB_2DDrawing_Default)
            Box(0, 0, \WindowW, \WindowH, *pColorWindow\BackColor & $FFFFFF)
            Redraw_Gradient(*pColorWindow, 0, 0, \WindowW, \WindowH)
            DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Transparent)
            DrawText(10, 05, \pBalloonTip\BalloonTip$, *pColorWindow\FontColor)
            DrawingMode(#PB_2DDrawing_AlphaBlend|#PB_2DDrawing_Outlined)
            Box(1, 1, \WindowW-2, 1, *pColorWindow\HighColor)
            Box(1, 1, 1, \WindowH-2, *pColorWindow\HighColor)
            Box(0, 0, \WindowW, \WindowH, *pColorWindow\SideColor)      
            StopDrawing()
         EndIf 
         If \hBackImage : DeleteObject_(\hBackImage) : \hBackImage = 0 : EndIf  ;释放窗体背景句柄
        
         ;将背景图像渲染到窗体
         \hBackImage= CreatePatternBrush_(hImageScreen)
         If \hBackImage
            SetClassLongPtr_(\hWindow, #GCL_HBRBACKGROUND, \hBackImage)
            RedrawWindow_(\hWindow, #Null, #Null, #RDW_INTERNALPAINT|#RDW_ERASE|#RDW_INVALIDATE)
         EndIf 
         ResizeWindow(#winBalloon, Mouse\X, Mouse\Y, \WindowW, \WindowH)
         SetActiveWindow(#winScreen)
         HideWindow(#winBalloon, #False)
         SetActiveWindow(#winScreen)

      ElseIf IsWindow(#winBalloon) 
         HideWindow(#winBalloon, #True)
      EndIf 
   EndWith
EndProcedure

;挂钩事件
Procedure Screen_Callback(hWindow, uMsg, wParam, lParam) 
   Result = #PB_ProcessPureBasicEvents
   Select uMsg
      Case #WM_TIMER
         Select wParam
            Case #TIMER_SizeWindow
               KillTimer_(hWindow, #TIMER_SizeWindow) 
               _Screen\IsTIMER_SizeWindow = #False
               Screen_SizeWindow()
               Redraw_cvsIllustrate()
               Redraw_cvsAttributes()
            Case #TIMER_BalloonTip
               Screen_BalloonTip()
               KillTimer_(hWindow, #TIMER_BalloonTip) 
         EndSelect
      Case #WM_SIZE 
         If _Screen\IsTIMER_SizeWindow
            KillTimer_(hWindow, #TIMER_SizeWindow) 
         EndIf 
         SetTimer_(hWindow, #TIMER_SizeWindow, 15, #Null)
         _Screen\IsTIMER_SizeWindow = #True
   EndSelect 
   ProcedureReturn Result 
EndProcedure 
  
Procedure Screen_HookWindow(hWindow, uMsg, wParam, lParam) 
   *pMemSkin = GetWindowLong_(hWindow, #GWL_USERDATA) 
   If *pMemSkin
      Result = CallWindowProc_(PeekL(*pMemSkin+16), hWindow, uMsg, wParam, lParam) 
   Else 
      Result = DefWindowProc_(hWindow, uMsg, wParam, lParam) 
   EndIf 
   Select uMsg
      Case #WM_DESTROY
         DeleteObject_( PeekL(*pMemSkin+12) ) 
         GlobalFree_(*pMemSkin) 
         PostQuitMessage_(0) 
      Case #WM_CTLCOLOREDIT,#WM_CTLCOLORLISTBOX
         SetTextColor_(wParam, PeekL(*pMemSkin+0) ) 
         SetBkColor_  (wParam, PeekL(*pMemSkin+4))
         Result = PeekL(*pMemSkin+12)
   EndSelect

   ProcedureReturn Result 
EndProcedure 

;-==========================
;-[Create]
Procedure CreateGadget_ComboBox(GadgetID, FrontColor, BackColor) 
   *pMemSkin = GlobalAlloc_(#Null,5*4) 
   SetWindowLong_(GadgetID(GadgetID), #GWL_USERDATA, *pMemSkin)
   PokeL(*pMemSkin+ 0, FrontColor ) 
   PokeL(*pMemSkin+ 4, BackColor )
   PokeL(*pMemSkin+12, CreateSolidBrush_(BackColor))
   PokeL(*pMemSkin+16, SetWindowLong_(GadgetID(GadgetID), #GWL_WNDPROC, @Screen_HookWindow())) 
EndProcedure

;右侧设置栏
Procedure CreateGadget_frmLayoutStyles(X, W)
   *pAttribute = Attributes_AddGroup(#cmbLayoutStyle, "窗体布局", "设置窗体大小及缩放.")
      Attributes_AddItem(*pAttribute, #chkCanvasImage,  0, "使用画布",    "创建以画布为背景的窗体(启用后ImageGadget()无效).") 
      Attributes_AddItem(*pAttribute, #txtWindowRealW,  0, "创建宽度",    "创建窗体的初始宽度.") 
      Attributes_AddItem(*pAttribute, #txtWindowRealH,  0, "创建高度",    "创建窗体的初始高度.") 
      Attributes_AddItem(*pAttribute, #chkSizeWindow,   0, "可调整大小",  "窗体支持改变大小的功能.") 
      Attributes_AddItem(*pAttribute, #txtWindowSideL,  0, "左际留边",    "为0时表示不支持窗体左侧拉伸窗体,非0表示支持.") 
      Attributes_AddItem(*pAttribute, #txtWindowSideR,  0, "右际留边",    "为0时表示不支持窗体右侧拉伸窗体,非0表示支持.") 
      Attributes_AddItem(*pAttribute, #txtWindowSideT,  0, "顶部留边",    "为0时表示不支持窗体顶部拉伸窗体,非0表示支持.") 
      Attributes_AddItem(*pAttribute, #txtWindowSideB,  0, "底部留边",    "为0时表示不支持窗体底部拉伸窗体,非0表示支持.") 
      CheckBoxGadget(#chkCanvasImage,  X+05, 001, W-10, 22, "启用")            
      ComboBoxGadget(#cmbLayoutStyle,  X+20, 001, W-20, 22) 
      StringGadget  (#txtWindowRealW,  X+05, 001, W-10, 18, "500", #PB_String_BorderLess)
      StringGadget  (#txtWindowRealH,  X+05, 001, W-10, 18, "350", #PB_String_BorderLess)
      CheckBoxGadget(#chkSizeWindow,   X+05, 001, W-10, 22, "启用")
      StringGadget  (#txtWindowSideL,  X+05, 002, W-10, 18, "3",   #PB_String_BorderLess)
      StringGadget  (#txtWindowSideR,  X+05, 002, W-10, 18, "3",   #PB_String_BorderLess)
      StringGadget  (#txtWindowSideT,  X+05, 002, W-10, 18, "3",   #PB_String_BorderLess)
      StringGadget  (#txtWindowSideB,  X+05, 002, W-10, 18, "3",   #PB_String_BorderLess)
EndProcedure

Procedure CreateGadget_frmSystemButton(X, W)
   *pAttribute = Attributes_AddGroup(#cmbSystemButton, "系统按键", "设置窗体右上角小按键.")
      Attributes_AddItem(*pAttribute, #chkSysCloseBox, 0, "关闭小按键",  "是否启用[X]关闭窗体小按键.") 
      Attributes_AddItem(*pAttribute, #chkSysMinimize, 0, "最小化按键",  "是否启用[-]最小化窗体小按键.") 
      Attributes_AddItem(*pAttribute, #chkSysMaximize, 0, "最大化按键",  "是否启用[□]最大化窗体小按键.") 
      Attributes_AddItem(*pAttribute, #chkSysNormalcy, 0, "正常化按键",  "是否启用[□]正常化窗体小按键.") 
      Attributes_AddItem(*pAttribute, #chkSysSettings, 0, "设置小按键",  "是否启用[V]窗体设置小按键.") 
      Attributes_AddItem(*pAttribute, #chkSysStickyNO, 0, "置顶小按键",  "是否启用[↑]窗体置顶小按键.") 
      ComboBoxGadget(#cmbSystemButton, X+20, 001, W-20, 22) 
      CheckBoxGadget(#chkSysCloseBox,  X+05, 001, W-10, 22, "启用")
      CheckBoxGadget(#chkSysMinimize,  X+05, 001, W-10, 22, "启用")
      CheckBoxGadget(#chkSysMaximize,  X+05, 001, W-10, 22, "启用")
      CheckBoxGadget(#chkSysNormalcy,  X+05, 001, W-10, 22, "启用")
      CheckBoxGadget(#chkSysSettings,  X+05, 001, W-10, 22, "启用")
      CheckBoxGadget(#chkSysStickyNO,  X+05, 001, W-10, 22, "启用")
EndProcedure

Procedure CreateGadget_frmCaptionBar(X, W)
   *pAttribute = Attributes_AddGroup(#chkCaptionBar, "标题栏", "设置标题栏和工具名称及图标.")
      Attributes_AddItem(*pAttribute, #txtCaptionName, 0, "标题栏名称",             "设置创建的新窗体的标题名称.") 
      Attributes_AddItem(*pAttribute, #txtCaptionIcon, #btnCaptionIcon, "界面图标", "设置创建的新窗体的图标.") 
      Attributes_AddItem(*pAttribute, #chkIncludeIcon, 0, "包含图标",               "将图标文件包含到EXE资源中,保存pb时,自动复制到同根目录.") 
      Attributes_AddItem(*pAttribute, #txtCaptionBarX, 0, "X坐标偏移",              "设置标题栏的起始位置(当大于工具栏宽度时,工具栏靠顶).")  
      Attributes_AddItem(*pAttribute, #txtCaptionBarH, 0, "标题栏高度",             "设置标题栏的高度")  
      CheckBoxGadget(#chkCaptionBar,  X+20,   001, W-20, 22, "启用")
      StringGadget  (#txtCaptionName, X+05,   002, W-10, 18, "新建工具", #PB_String_BorderLess)
      StringGadget  (#txtCaptionIcon, X+05,   002, W-25, 18, "" ,        #PB_String_BorderLess)
      ButtonGadget  (#btnCaptionIcon, X+W-20, 000, 0020, 20, "…")
      CheckBoxGadget(#chkIncludeIcon, X+05,   001, W-10, 22, "启用") 
      StringGadget  (#txtCaptionBarX, X+05,   002, W-10, 18, "0",        #PB_String_BorderLess)
      StringGadget  (#txtCaptionBarH, X+05,   002, W-10, 18, "40",       #PB_String_BorderLess) 
EndProcedure

Procedure CreateGadget_frmStatusBar(X, W)
   *pAttribute = Attributes_AddGroup(#chkStatusBar, "状态栏", "设置状态栏及窗体缩放图标.")
      Attributes_AddItem(*pAttribute, #chkStatusSize, 0, "缩放小图标",  "启用缩放窗体的小图标(前提[窗体布局]->[可调整大小]启用).") 
      Attributes_AddItem(*pAttribute, #txtStatusBarX, 0, "X坐标偏移",   "设置状态栏的起始位置.") 
      Attributes_AddItem(*pAttribute, #txtStatusBarH, 0, "状态栏高度",  "设置状态栏的高度.")  
      CheckBoxGadget(#chkStatusBar,   X+20, 001, W-20, 22, "启用")
      CheckBoxGadget(#chkStatusSize,  X+05, 001, W-10, 22, "启用")
      StringGadget  (#txtStatusBarX,  X+05, 002, W-10, 18, "30", #PB_String_BorderLess)
      StringGadget  (#txtStatusBarH,  X+05, 002, W-10, 18, "60", #PB_String_BorderLess)
EndProcedure

Procedure CreateGadget_frmIcoToolbar(X, W)
   *pAttribute = Attributes_AddGroup(#chkIcoToolbar, "工具栏", "设置窗体右侧的图标工具栏.")
      Attributes_AddItem(*pAttribute, #txtIcoToolbarY, 0, "Y坐标偏移",   "设置工具栏的起始位置(相对于标题栏的高度).") 
      Attributes_AddItem(*pAttribute, #txtIcoToolbarW, 0, "工具栏宽度",  "设置工具栏的宽度(当标题栏X坐标大于此设置时,工具栏靠顶).") 
      CheckBoxGadget(#chkIcoToolbar,  X+20, 001, W-20, 22, "启用")
      StringGadget  (#txtIcoToolbarY, X+05, 002, W-10, 18, "60",  #PB_String_BorderLess)
      StringGadget  (#txtIcoToolbarW, X+05, 002, W-10, 18, "60",  #PB_String_BorderLess) 
EndProcedure


Procedure CreateGadget_frmColorsPrefer(X, W)
   *pAttribute = Attributes_AddGroup(#cmbColorsPrefer, "颜色设置", "设置工具各种颜色参数.")
      Attributes_AddItem(*pAttribute, #chkUseGradients,   #chkAniGradients,   "渐变效果",  "支持产生渐变效果,提供正反两种渐变效果.") 
      Attributes_AddItem(*pAttribute, #cmbGradientType,   0,                  "渐变类型",  "支持产生渐变效果的类型.") 
      Attributes_AddItem(*pAttribute, #cvsSetBackColor,   #txtSetBackColor,   "背景色",    "设置背景色,支持Alpha效果.") 
      Attributes_AddItem(*pAttribute, #cvsSetForeColor,   #txtSetForeColor,   "前景色",    "设置前景色,支持Alpha效果.") 
      Attributes_AddItem(*pAttribute, #cvsSetFontColor,   #txtSetFontColor,   "字体色",    "设置字体色,支持Alpha效果.") 
      Attributes_AddItem(*pAttribute, #cvsSetSideColor,   #txtSetSideColor,   "边框色",    "设置边框色,支持Alpha效果.") 
      Attributes_AddItem(*pAttribute, #cvsSetHighColor,   #txtSetHighColor,   "高亮色",    "设置边框色,支持Alpha效果.") 
      ComboBoxGadget(#cmbColorsPrefer, X+20, 001, W-20, 22) 
      CheckBoxGadget(#chkUseGradients, X+05, 001, (W-15)/2, 22, "启用")
      CheckBoxGadget(#chkAniGradients, X+10+(W-15)/2, 001, (W-15)/2, 22, "反向")
      ComboBoxGadget(#cmbGradientType, X+00, 001, W-0, 22)
      CanvasGadget(#cvsSetBackColor,   X+02, 002, 0018, 18)
      StringGadget(#txtSetBackColor,   X+25, 002, W-30, 18, "0xFFFFFFFF", #PB_String_BorderLess)  
      CanvasGadget(#cvsSetForeColor,   X+02, 002, 0018, 18)
      StringGadget(#txtSetForeColor,   X+25, 002, W-30, 18, "0xFFFFFFFF", #PB_String_BorderLess)  
      CanvasGadget(#cvsSetFontColor,   X+02, 002, 0018, 18)
      StringGadget(#txtSetFontColor,   X+25, 002, W-30, 18, "0xFFFFFFFF", #PB_String_BorderLess)  
      CanvasGadget(#cvsSetSideColor,   X+02, 002, 0018, 18)
      StringGadget(#txtSetSideColor,   X+25, 002, W-30, 18, "0xFFFFFFFF", #PB_String_BorderLess)  
      CanvasGadget(#cvsSetHighColor,   X+02, 002, 0018, 18)
      StringGadget(#txtSetHighColor,   X+25, 002, W-30, 18, "0xFFFFFFFF", #PB_String_BorderLess)  
EndProcedure
   

Procedure CreateGadget_frmMiscellaneous(X, W)
   *pAttribute = Attributes_AddGroup(0, "杂项设置", "其它杂项设置")
      Attributes_AddItem(*pAttribute, #chkMessageBox, 0, "信息对话框",  "启用后生成代码时，自动生成[信息对话框]的代码.") 
      Attributes_AddItem(*pAttribute, #chkBalloonTip, 0, "启用提示文",  "启用提示文功能.") 
      Attributes_AddItem(*pAttribute, #chkPreference, 0, "设置文件",    "启用设置文件的加载和保存功能.") 
      Attributes_AddItem(*pAttribute, #chkSystemDrop, #chkMultiFiles, "系统拖放",    "启用后允许从桌面或文件夹拖放文件到窗体.") 
      CheckBoxGadget(#chkMessageBox, X+05, 001, W-10, 22, "启用")
      CheckBoxGadget(#chkBalloonTip, X+05, 001, W-10, 22, "启用")
      CheckBoxGadget(#chkPreference, X+05, 001, W-10, 22, "启用")
      CheckBoxGadget(#chkSystemDrop, X+05, 001, (W-15)/2, 22, "启用")
      CheckBoxGadget(#chkMultiFiles, X+10+(W-15)/2, 001, (W-15)/2, 22, "多文件")
EndProcedure

Procedure CreateGadget_Attributes()
   CanvasX = _Screen\WindowW-05-#Screen_AttributeW
   CanvasY = 05+ToolBarHeight(#wtbScreen)
   CanvasH = _Screen\WindowH-10-StatusBarHeight(#wsbScreen)-ToolBarHeight(#wtbScreen)
   SetGadgetFont(#PB_Default, FontID(#fntDefault))
   CanvasGadget(#cvsAttributes, CanvasX, CanvasY, #Screen_AttributeW, CanvasH, #PB_Canvas_Border|#PB_Canvas_Container)
;       With *pAttribute
         X = #Screen_GroupItemW : W = #Screen_GadgetItemW
         CreateGadget_frmLayoutStyles (X, W) ;窗体布局
         CreateGadget_frmSystemButton (X, W) ;系统按键
         CreateGadget_frmCaptionBar   (X, W) ;标题栏
         CreateGadget_frmStatusBar    (X, W) ;状态栏
         CreateGadget_frmIcoToolbar   (X, W) ;工具栏
         CreateGadget_frmColorsPrefer (X, W) ;颜色设置
         CreateGadget_frmMiscellaneous(X, W) ;杂项设置
;       EndWith
   CloseGadgetList()

   AddGadgetItem(#cmbSystemButton, -1, "扁平化风格") 
   AddGadgetItem(#cmbSystemButton, -1, "面包片风格")
   AddGadgetItem(#cmbSystemButton, -1, "琴键式风格")
   AddGadgetItem(#cmbSystemButton, -1, "钮扣式风格")
   AddGadgetItem(#cmbSystemButton, -1, "胶囊式风格")
;    AddGadgetItem(#cmbSystemButton, -1, "凹槽式风格")
;    AddGadgetItem(#cmbSystemButton, -1, "面板条风格")
   
   AddGadgetItem(#cmbGradientType, -1, "上下性线渐变")     
   AddGadgetItem(#cmbGradientType, -1, "左右性线渐变")   
   AddGadgetItem(#cmbGradientType, -1, "左上对角性线渐变")   
   AddGadgetItem(#cmbGradientType, -1, "右上对角性线渐变") 
   AddGadgetItem(#cmbGradientType, -1, "中心椭圆渐变")   
   AddGadgetItem(#cmbGradientType, -1, "左上椭圆渐变")   
   AddGadgetItem(#cmbGradientType, -1, "右上椭圆渐变") 
   AddGadgetItem(#cmbGradientType, -1, "左下椭圆渐变") 
   AddGadgetItem(#cmbGradientType, -1, "右下椭圆渐变") 
   SetGadgetState(#cmbGradientType, 0)
   DisableGadget(#chkSysCloseBox, #True)
   DisableGadget(#chkSysNormalcy, #True)

   ForEach _Screen\ListColorStyle()
      AddGadgetItem(#cmbLayoutStyle, -1, _Screen\ListColorStyle()\ColorStyle$)
   Next 
   
   With _Screen\pMapAttriGroup()
      ForEach _Screen\pMapAttriGroup()
         If IsGadget(\GadgetID)
            Select GadgetType(\GadgetID) 
               Case #PB_GadgetType_String
                  SetGadgetColor(\GadgetID, #PB_Gadget_BackColor, #Attribute_TitleColor)
               Case #PB_GadgetType_ComboBox
                  CreateGadget_ComboBox(\GadgetID, #Attribute_FontColor, #Attribute_TitleColor) 
                  BindGadgetEvent(\GadgetID, @EventGroup_ComboBoxGadget())
               Case #PB_GadgetType_CheckBox  
                  BindGadgetEvent(\GadgetID, @EventGroup_CheckBoxGadget())
            EndSelect
         EndIf 
      Next 
   EndWith
   With _Screen\pMapAttriItems()
      ForEach _Screen\pMapAttriItems()
         If IsGadget(\GadgetID1)
            Select GadgetType(\GadgetID1) 
               Case #PB_GadgetType_String
                  SetGadgetColor(\GadgetID1, #PB_Gadget_BackColor, #Window_BackColor)
                  BindGadgetEvent(\GadgetID1, @EventGroup_StringGadget())
               Case #PB_GadgetType_ComboBox
                  CreateGadget_ComboBox(\GadgetID1, #Attribute_FontColor, #Window_BackColor) 
                  BindGadgetEvent(\GadgetID1, @EventGroup_ComboBoxGadget())
               Case #PB_GadgetType_CheckBox  
                  BindGadgetEvent(\GadgetID1, @EventGroup_CheckBoxGadget())
               Case #PB_GadgetType_Canvas 
                  BindGadgetEvent(\GadgetID1, @EventGroup_CanvasGadget())
               Case #PB_GadgetType_Button 
                  BindGadgetEvent(\GadgetID1, @EventGroup_ButtonGadget())                  
                  
            EndSelect
            HideGadget(\GadgetID1, \pParent\FoldState)
         EndIf 
         
         If IsGadget(\GadgetID2) 
            Select GadgetType(\GadgetID2) 
               Case #PB_GadgetType_String
                  SetGadgetColor(\GadgetID2, #PB_Gadget_BackColor, #Window_BackColor)
                  BindGadgetEvent(\GadgetID2, @EventGroup_StringGadget())
               Case #PB_GadgetType_CheckBox  
                  BindGadgetEvent(\GadgetID2, @EventGroup_CheckBoxGadget())
               Case #PB_GadgetType_Button 
                  BindGadgetEvent(\GadgetID2, @EventGroup_ButtonGadget())     
            EndSelect
            HideGadget(\GadgetID2, \pParent\FoldState)
         EndIf 
      Next 
   EndWith

EndProcedure

Procedure CreateGadget_Screen()
   With _Screen
      ContainerGadget(#frmScreen, 10, 5, 305, 030)
         hGadget = ContainerGadget(#frmToolBar, 0, -2, 305, 030)
            hToolBar = CreateToolBar(#wtbScreen, hGadget)
            If hToolBar
               ImageList = SendMessage_(hToolBar, #TB_GETIMAGELIST, 0, 0)
               ImageList_SetIconSize_(ImageList, 24, 24)
            
               ToolBarImageButton(#wtbToolNewFile,    ImageID(#wtbToolNewFile)) 
               ToolBarImageButton(#wtbToolOpenFile,   ImageID(#wtbToolOpenFile)) 
               ToolBarImageButton(#wtbToolSaveFile,   ImageID(#wtbToolSaveFile)) 
               ToolBarSeparator() 
               ToolBarImageButton(#wtbToolSaveAs,     ImageID(#wtbToolSaveAs)) 
               ToolBarImageButton(#wtbToolCloseFile,  ImageID(#wtbToolCloseFile)) 
               ToolBarSeparator() 
               ToolBarImageButton(#wtbToolGenerate,   ImageID(#wtbToolGenerate), #PB_ToolBar_Toggle)         
               ToolBarImageButton(#wtbToolPureBasic,  ImageID(#wtbToolPureBasic)) 
               ToolBarSeparator() 
               ToolBarImageButton(#wtbToolSticky,     ImageID(#wtbToolSticky), #PB_ToolBar_Toggle) 
               ToolBarImageButton(#wtbToolAboutMe,    ImageID(#wtbToolAboutMe)) 
               
               ToolBarToolTip(#wtbScreen, #wtbToolNewFile,   "新建文件")
               ToolBarToolTip(#wtbScreen, #wtbToolOpenFile,  "打开文件")
               ToolBarToolTip(#wtbScreen, #wtbToolSaveFile,  "保存文件")
               ToolBarToolTip(#wtbScreen, #wtbToolSaveAs,    "文件另存为")
               ToolBarToolTip(#wtbScreen, #wtbToolCloseFile, "关闭")
               ToolBarToolTip(#wtbScreen, #wtbToolPureBasic, "在PureBasic编辑器中打开")
               ToolBarToolTip(#wtbScreen, #wtbToolGenerate,  "生成代码")
               ToolBarToolTip(#wtbScreen, #wtbToolSticky,    "工具置顶")
               ToolBarToolTip(#wtbScreen, #wtbToolAboutMe,   "软件说明")
            EndIf 
            ToolBarH = ToolBarHeight(#wtbScreen)
            ResizeGadget(#frmScreen,  #PB_Ignore, #PB_Ignore, #PB_Ignore, ToolBarH)
            ResizeGadget(#frmToolBar, #PB_Ignore, #PB_Ignore, #PB_Ignore, ToolBarH)
         CloseGadgetList()
      CloseGadgetList()
      If CreateStatusBar(#wsbScreen, \hWindow)
         AddStatusBarField(0100)
         AddStatusBarField(0150)
         AddStatusBarField(2999)
         StatusBarText(#wsbScreen,  0, "- 迷路仟作品 -", #PB_StatusBar_Center)
         StatusBarText(#wsbScreen,  1, " 窗体大小: 1024x1024")
         StatusBarText(#wsbScreen,  2, "欢迎使用【迷路PureBasic自绘UI代码生成工具】")
      EndIf
;       
      ;{
      ;===============
      TextGadget(#lblScreen, \WindowW-5-#Screen_AboutMilooW, 10, #Screen_AboutMilooW, 20, "迷路仟/Miloo [QQ:714095563]", #PB_Text_Right)
      ;窗体演示界面
      CanvasX = 05
      CanvasY = 05+ToolBarHeight(#wtbScreen)
      CanvasW = \WindowW-15-#Screen_AttributeW
      CanvasH = \WindowH-10-StatusBarHeight(#wsbScreen)-ToolBarHeight(#wtbScreen)
      CanvasGadget(#cvsIllustrate, CanvasX, CanvasY, CanvasW, CanvasH, #PB_Canvas_Border|#PB_Canvas_Container)
         ;底部滚动条
         GadgetX = 0
         GadgetY = CanvasH-#Screen_ScrollBarH-4
         GadgetW = CanvasW-#Screen_ScrollBarW-4
         ScrollBarGadget(#srcIllustrateH, GadgetX, GadgetY, GadgetW, #Screen_ScrollBarH, 0, 100, 1)
         
         ;右侧滚动条
         GadgetX = CanvasW - #Screen_ScrollBarW-4
         GadgetY = 00
         GadgetH = CanvasH - #Screen_ScrollBarH-4
         ScrollBarGadget(#srcIllustrateV, GadgetX, GadgetY, #Screen_ScrollBarW, GadgetH, 0, 100, 1, #PB_ScrollBar_Vertical)
      CloseGadgetList()
      mcsRichEditGadget_(#rtxSourceCode, CanvasX, CanvasY, CanvasW, CanvasH)
      HideGadget(#rtxSourceCode, #True)
      ;===============
      ;}
      ;右侧设置栏
      CreateGadget_Attributes()
   EndWith
   SetGadgetAttribute(#rtxSourceCode, #MCS_RichEdit_Format, #FormatType_PB)
   SetGadgetFont(#rtxSourceCode, FontID(#fntRichEdit))
   SetGadgetFont(#lblScreen,     FontID(#fntVersion))
   SetGadgetColor(#lblScreen, #PB_Gadget_FrontColor, $F48000)
   SetToolBarButtonState(#wtbScreen, #wtbToolSticky, _Screen\IsStickyWindow)
   StickyWindow(#winScreen, _Screen\IsStickyWindow)
   BindGadgetEvent(#cvsIllustrate,  @EventGadget_cvsIllustrate())
   BindGadgetEvent(#cvsAttributes,  @EventGadget_cvsAttributes())
   BindGadgetEvent(#srcIllustrateV, @EventGadget_srcIllustrateV())
   BindGadgetEvent(#srcIllustrateH, @EventGadget_srcIllustrateH())

EndProcedure  

;-==========================
;-[Main]
Procedure Main_Initial()
   UseGIFImageDecoder()
   UsePNGImageDecoder()
   UseTGAImageDecoder()
   UseTIFFImageDecoder()
   UseJPEGImageDecoder()
   UseJPEG2000ImageDecoder()
   LoadFont(#fntDefault,  "新宋体", 11)
   LoadFont(#fntRichEdit, "新宋体", 14)
   LoadFont(#fntVersion,  "新宋体", 12, #PB_Font_Bold)
   ToolIconID = CatchImage(#PB_Any, ?_ICON_ToolIcon)
   For ImageID = #wtbToolNewFile To #wtbToolAboutMe
      GrabImage(ToolIconID, ImageID, Index * 24, 0, 24, 24) : Index+1
   Next 
   FreeImage(ToolIconID)
   
   Offset = ?_End_PartSytle-?_Bin_GadgetColor
   *pMemColor = ?_Bin_GadgetColor   
   ColorColor$ = "深灰色风格,嫣红色风格,橙红色风格,土黄色风格,深紫色风格,深绿色风格,深蓝色风格,深青色风格,"
   For k = 1 To CountString(ColorColor$, ",")
      AddElement(_Screen\ListColorStyle())
      _Screen\ListColorStyle()\pMemColor   = *pMemColor
      _Screen\ListColorStyle()\ColorStyle$ = StringField(ColorColor$, k, ",")
      *pMemColor+Offset
   Next 

   _Screen\SystemPath$ = Space(255) 
   Result=GetSystemDirectory_(@_Screen\SystemPath$,255) 
   _Screen\hSoftwareIcon = ExtractIcon_(0, _Screen\SystemPath$+"\User32.dll", 0)
   _Screen\hSizing    = LoadCursor_(0,#IDC_SIZENWSE)
   _Screen\hLeftRight = LoadCursor_(0,#IDC_SIZEWE)
   _Screen\hUpDown    = LoadCursor_(0,#IDC_SIZENS)
EndProcedure

Procedure Main_Release()
   FreeFont(#fntDefault)
   FreeFont(#fntRichEdit)
   FreeFont(#fntVersion)
   With _Screen
      Create_Release(\btnCloseBox)
      Create_Release(\btnMinimize)
      Create_Release(\btnMaximize)
      Create_Release(\btnNormalcy)
      Create_Release(\btnSettings)
      Create_Release(\btnStickyNO)
      Create_Release(\btnStickyNC)
      For ImageID = #wtbToolNewFile To #wtbToolAboutMe
         If IsImage(ImageID) : FreeImage(ImageID) : EndIf 
      Next 
      DragFinish_(\hWindow) 
      FreeList(\ListColorStyle())
      If _Balloon\hBackImage : DeleteObject_(_Balloon\hBackImage) : EndIf  ;释放提示文窗体背景句柄
      DestroyIcon_(\hSoftwareIcon)
      DestroyCursor_(\hSizing) 
      DestroyCursor_(\hLeftRight) 
      DestroyCursor_(\hUpDown) 
   EndWith
EndProcedure

; 加载设置文件
Procedure Main_LoadPrefer()
   OpenPreferences("设置.ini")
   PreferenceGroup("窗体设置")
      _Screen\WindowX = ReadPreferenceLong("WindowX", 0)
      _Screen\WindowY = ReadPreferenceLong("WindowY", 0)
      _Screen\WindowW = ReadPreferenceLong("WindowW", 800)
      _Screen\WindowH = ReadPreferenceLong("WindowH", 500)
      _Screen\IsStickyWindow = ReadPreferenceLong("窗体置顶", 0)
   PreferenceGroup("编译器")
      _Screen\Compiler$ = ReadPreferenceString("编译器", "")          
      
   PreferenceGroup("设计稿")
      _Project\DesignFile$ = ReadPreferenceString("设计稿", "")      
      
   ClosePreferences()
EndProcedure

; 保存设置文件
Procedure Main_SavePrefer()
   If CreatePreferences("设置.ini")
      PreferenceComment("")
      PreferenceGroup("窗体设置")
         WritePreferenceLong("WindowX", WindowX(#winScreen))
         WritePreferenceLong("WindowY", WindowY(#winScreen))
         WritePreferenceLong("WindowW", _Screen\WindowW)
         WritePreferenceLong("WindowH", _Screen\WindowH)
         WritePreferenceLong("窗体置顶", _Screen\IsStickyWindow)
      PreferenceComment("")
      PreferenceGroup("编译器")
         WritePreferenceString("编译器", _Screen\Compiler$)  
      PreferenceComment("")
      PreferenceGroup("设计稿")
         WritePreferenceString("设计稿", _Project\DesignFile$) 
      
      
      ClosePreferences()
   EndIf 
EndProcedure

; UIDrawTool
;- ##########################
;- [Demo]        
With _Screen
   Main_Initial()
   Main_LoadPrefer()
   WindowFlags = #PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
   If \WindowX <= 0 Or \WindowY <= 0 Or \WindowW <= 500 Or \WindowH =< 300
      \WindowW = 800
      \WindowH = 500
      \hWindow = OpenWindow(#winScreen, 0, 0, \WindowW, \WindowH, #Screen_Caption$, #PB_Window_ScreenCentered|WindowFlags)
   Else 
      \hWindow = OpenWindow(#winScreen, \WindowX, \WindowY, \WindowW, \WindowH, #Screen_Caption$, WindowFlags)
   EndIf 
   WindowBounds(#winScreen, 500, 300, #PB_Ignore, #PB_Ignore)
   CreateGadget_Screen()
   Redraw_cvsAttributes()
   SetWindowCallback(@Screen_Callback())    ; 启用Callback
   If Designs_OpenFile(#True) = #False
      Attributes_NewProject()
   EndIf 
   DragAcceptFiles_(\hWindow, #False)   ;设置窗体界面是否支持系统拖放.
   
   Repeat
      WinEvent  = WindowEvent()
      Select WinEvent
         Case #PB_Event_CloseWindow 
            Select EventWindow() 
               Case #winScreen   : \IsExitWindow = #True
               Case #winMessage  : _Message\IsExitWindow = #True : _Message\MessageResult = #Null
            EndSelect 
         Case #PB_Event_Menu     : EventWindow_EventMenu()
         Case #WM_MOUSEWHEEL     : EventWindow_MOUSEWHEEL()
         Case #WM_DROPFILES      : EventWindow_DragDorpFile()
      EndSelect      
      Delay(1)
   Until \IsExitWindow = #True
EndWith

Main_Release()
Main_SavePrefer()
End








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1318
; FirstLine = 793
; Folding = 5fA96x+--
; EnableXP
; UseIcon = Image\LOGO.ico
; Executable = PUB自绘UI生成工具.exe
; EnableUnicode