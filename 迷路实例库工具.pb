
;*********************************************************
;***********   迷路PureBasic实例库工具源代码   ***********
;*********** 作者: 迷路仟/Miloo [QQ:714095563] ***********
;***********           [2019.02.11]           ************
;*********************************************************

;-[Enumeration]
#MCS_RichEdit_Format = $01   
#FormatType_PB       = $01
#Version$    = "V002"
#PreferName$ = "设置.txt"

Enumeration 
   #winScreen
   #winPerfer
   #wsbScreen
   #cmbSearch
   #btnSearch
   #chkFindName
   #chkFindCode
   #btnSticky
   #btnEditor
   #btnPerfer
   #btnForums
   #btnResult
   #btnRefresh
   #tvwScreen
   #rtxScreen
   #sptScreen
   #lstResult
   #btnFloder
#lblCompiler
#txtCompiler
#btnCompiler
#lblCodePath
#txtCodePath
#btnCodePath
#lblIEForums
#txtIEForums
#btnIEForums
#picSoftLogo
#lblPBInject
#btnPBInject

#lblNotice01
#lblNotice02
#lblNotice03

   #fntDefault
   #fntRichEdit
   #imgNormal
   #imgSticky
   #imgPrefer
   #imgSearch
   #imgEditor
   #imgFloder
   #imgForums
   #imgResult
   #imgSource
   #imgPBLogo
   #imgRefresh
   #imgPureBasic
   #imgFoderType
EndEnumeration

;-[Structure]
Structure __ToolsPrefs
   Command$
   Arguments$
   WorkingDir$
   MenuItemName$
   Shortcut.l
   ConfigLine$
   Trigger.l
   Flags.l
   ReloadSource.l
   HideEditor.l
   HideFromMenu.l
   SourceSpecific.l
   Deactivate.l
EndStructure

Structure __SourceInfo
   SortName$
   FileName$
   NodeName$
   PathName$
   FileType.l
   NodeFloor.l
   Count.l
   IsShow.l
   *pFloorElement.__SourceInfo
EndStructure

Structure __SearchInfo
   *pMemASC
   *pMemUTF
   LenghtASC.l
   LenghtUTF.l
   Search$
EndStructure

Structure __MainInfo
   WindowX.w
   WindowY.w
   WindowW.w
   WindowH.w
   StatusH.l
   Compiler$
   IEForums$
   CodePath$
   ThreadSearchID.l
   CountExamples.l
   ThreadEnum.l
   IsSticky.b
   IsFindName.b
   IsFindCode.b
   IsExitWindow.b
   IsSearching.b
EndStructure

;-[Global]
Global _Main.__MainInfo
Global NewList _ListSource.__SourceInfo()
Global NewList _ListSearch.__SearchInfo()
Global NewList _ListRecord$()


Declare Thread_SearchSource(Index)
Declare Thread_EnumSource(Index)

;-
;-***************************
;-[Screen]
Procedure Screen_LoadPrefer()
   OpenPreferences(#PreferName$)
      With _Main
      PreferenceGroup("窗体")
         \WindowX  = ReadPreferenceLong ("窗体X", 0)
         \WindowY  = ReadPreferenceLong ("窗体Y", 0)
         \WindowW  = ReadPreferenceLong ("窗体W", 900)
         \WindowH  = ReadPreferenceLong ("窗体H", 600)
         \IsSticky = ReadPreferenceLong ("置顶", 0)
         \IsFindName = ReadPreferenceLong ("文件名", 0)
         \IsFindCode = ReadPreferenceLong ("源代码", 1)
      PreferenceGroup("设置")
         \Compiler$ = ReadPreferenceString("PUB路径",  "D:\Program Files (x86)\PureBasic-5.62-x86\PureBasic.exe")
         \CodePath$ = ReadPreferenceString("源码路径", ".\源代码库\")
         \IEForums$ = ReadPreferenceString("官方论坛", "https://www.purebasic.fr/english/search.php")
      PreferenceGroup("记录") 
         For Idx = 1 To 30
            Record$ = ReadPreferenceString("记录-"+Str(Idx), "")
            If Record$ <> #Null$
               AddElement(_ListRecord$())
               _ListRecord$() = Record$
            EndIf 
         Next 
      EndWith
   ClosePreferences()
EndProcedure

Procedure Screen_SavePrefer()
   If CreatePreferences(#PreferName$)
      With _Main
         PreferenceGroup("窗体")
            WritePreferenceLong ("窗体X", \WindowX)
            WritePreferenceLong ("窗体Y", \WindowY)
            WritePreferenceLong ("窗体W", \WindowW)
            WritePreferenceLong ("窗体H", \WindowH)
            WritePreferenceLong ("置顶",  GetGadgetState(#btnSticky))
            WritePreferenceLong ("文件名",GetGadgetState(#chkFindName))
            WritePreferenceLong ("源代码",GetGadgetState(#chkFindCode))
         PreferenceGroup("设置") 
            WritePreferenceString("PUB路径",  \Compiler$)
            WritePreferenceString("源码路径", \CodePath$)
            WritePreferenceString("官方论坛", \IEForums$)
         PreferenceGroup("记录")   
            ForEach _ListRecord$()  
               Idx+1 : WritePreferenceString("记录-"+Str(Idx), _ListRecord$())
            Next 
         ClosePreferences() 
      EndWith
   EndIf 
EndProcedure

Procedure Screen_Initialize()
   UsePNGImageDecoder()
   CatchImage(#imgNormal, ?_PNG_Normal)
   CatchImage(#imgSticky, ?_PNG_Sticky)
   CatchImage(#imgPrefer, ?_PNG_Prefer)
   CatchImage(#imgSearch, ?_PNG_Search)
   CatchImage(#imgEditor, ?_PNG_Editor)
   CatchImage(#imgFloder, ?_PNG_Floder)
   CatchImage(#imgForums, ?_PNG_Forums)
   CatchImage(#imgResult, ?_PNG_Result)
   CatchImage(#imgSource, ?_PNG_Source)
   CatchImage(#imgPBLogo, ?_PNG_PBLogo)
   CatchImage(#imgRefresh, ?_PNG_Refresh)
   LoadFont(#fntDefault,  "宋体", 12)
   LoadFont(#fntRichEdit, "宋体", 14)
EndProcedure

Procedure Screen_Release()
   FreeImage(#imgNormal)
   FreeImage(#imgSticky)
   FreeImage(#imgPrefer)
   FreeImage(#imgSearch)
   FreeImage(#imgEditor)
   FreeImage(#imgFloder)
   FreeImage(#imgForums)
   FreeImage(#imgResult)
   FreeImage(#imgSource)
   FreeImage(#imgPBLogo)
   FreeImage(#imgRefresh)
   FreeFont(#fntDefault)
   FreeFont(#fntRichEdit)
EndProcedure


;-
;-[EventGaget]

Procedure EventGaget_ShowNode(*pMemNode.__SourceInfo, Index=0)
   With _ListSource()
      If *pMemNode = 0 
         ForEach _ListSource()
            If \NodeFloor <> 0 : Continue : EndIf  
            If \FileType = 0
               AddGadgetItem(#tvwScreen, -1, \NodeName$, ImageID(#imgFloder), \NodeFloor)
               SetGadgetItemData(#tvwScreen, Index, _ListSource())
               Index+1
               If \Count
                  AddGadgetItem(#tvwScreen, -1, "Temp-"+Str(\Count), ImageID(#imgEditor), \NodeFloor+1)
                  SetGadgetItemData(#tvwScreen, Index, 0)
                  Index+1
               EndIf 
            Else 
               AddGadgetItem(#tvwScreen, -1, \NodeName$, ImageID(#imgEditor), \NodeFloor)
               SetGadgetItemData(#tvwScreen, Index, _ListSource())
               Index+1
            EndIf
         Next 
         ProcedureReturn 
      EndIf
      If *pMemNode\IsShow = #True : ProcedureReturn : EndIf 
      ForEach _ListSource()
         If \pFloorElement <> *pMemNode : Continue : EndIf  
         If \FileType = 0
            Index+1
            If GetGadgetItemData(#tvwScreen, Index) = 0 
               RemoveGadgetItem(#tvwScreen, Index)
            EndIf  
            AddGadgetItem(#tvwScreen, Index, \NodeName$, ImageID(#imgFloder), \NodeFloor)
            SetGadgetItemData(#tvwScreen, Index, _ListSource())
            If \Count
               Index+1
               AddGadgetItem(#tvwScreen, Index, "Temp-"+Str(\Count), ImageID(#imgEditor), \NodeFloor+1)
               SetGadgetItemData(#tvwScreen, Index, 0)
            EndIf 
         Else 
            Index+1
            If GetGadgetItemData(#tvwScreen, Index) = 0 
               RemoveGadgetItem(#tvwScreen, Index)
            EndIf  
            AddGadgetItem(#tvwScreen, Index, \NodeName$, ImageID(#imgEditor), \NodeFloor)
            SetGadgetItemData(#tvwScreen, Index, _ListSource())
         EndIf
      Next 
      *pMemNode\IsShow = #True
   EndWith
EndProcedure



Procedure EventGaget_tvwScreen()
   State = GetGadgetState(#tvwScreen)
   If State < 0 : ProcedureReturn : EndIf 
   Select EventType() 
      Case #PB_EventType_LeftClick
         *pSource.__SourceInfo = GetGadgetItemData(#tvwScreen, State) 
         If *pSource
            If *pSource\FileType = 0 
               HideGadget(#btnEditor, #True)
               HideGadget(#btnFloder, #False)
            Else 
               HideGadget(#btnEditor, #False)
               HideGadget(#btnFloder, #True)
            EndIf 
         EndIf
          
      Case #PB_EventType_LeftDoubleClick
         *pSource.__SourceInfo = GetGadgetItemData(#tvwScreen, State) 
         If *pSource
            If *pSource\FileType 
               StatusBarText(#wsbScreen, 2, "当前文件: "+*pSource\FileName$) 
               mcsRichEditLoadFile_(#rtxScreen, *pSource\FileName$)
            Else 
               EventGaget_ShowNode(*pSource, State)
            EndIf 
         EndIf 
         
      Case #PB_EventType_RightDoubleClick
         *pSource.__SourceInfo = GetGadgetItemData(#tvwScreen, State) 
         If *pSource
            If *pSource\FileType = 0
               ShellExecute_(0, "open",  @*pSource\FileName$, 0, 0, #SW_SHOW) 
            EndIf 
         EndIf          
   EndSelect
EndProcedure

Procedure EventGaget_lstResult()
   State = GetGadgetState(#lstResult)
   If State < 0 : ProcedureReturn : EndIf 
   Select EventType() 
      Case #PB_EventType_LeftDoubleClick
         *pSource.__SourceInfo = GetGadgetItemData(#lstResult, State) 
         If *pSource
            StatusBarText(#wsbScreen, 2, "当前文件: "+*pSource\FileName$) 
            mcsRichEditLoadFile_(#rtxScreen, *pSource\FileName$)
         EndIf 
      Case #PB_EventType_RightClick
         *pSource.__SourceInfo = GetGadgetItemData(#lstResult, State) 
         If *pSource
            If *pSource\IsShow = #False
               *pParent.__SourceInfo = *pSource
               NewList ListParent()
               While *pParent And *pParent\pFloorElement
                  InsertElement(ListParent()) 
                  ListParent() =  *pParent\pFloorElement
                  Debug *pParent\pFloorElement\FileName$
                  *pParent = *pParent\pFloorElement
               Wend
               Debug ""
               ForEach ListParent()
                  *pParent.__SourceInfo = ListParent()
                  Debug *pParent\FileName$
               
                  For k = 0 To CountGadgetItems(#tvwScreen)-1
                     If ListParent() = GetGadgetItemData(#tvwScreen, k)
                        SetGadgetState(#tvwScreen, k)
                        
                        EventGaget_ShowNode(ListParent(), k)
                        SetGadgetItemState(#tvwScreen, k, #PB_Tree_Expanded)
                        Break
                     EndIf 
                  Next 
               Next 
               FreeList(ListParent())
            EndIf
            For k = 0 To CountGadgetItems(#tvwScreen)-1
               If *pSource = GetGadgetItemData(#tvwScreen, k)
                  SetGadgetState(#tvwScreen, k)
                  Break
               EndIf 
            Next 
            SetGadgetState(#btnResult, #False)
            SetGadgetAttribute(#sptScreen, #PB_Splitter_FirstGadget, #tvwScreen)
            HideGadget(#tvwScreen, #False)
            HideGadget(#lstResult, #True)
         EndIf 
   EndSelect
EndProcedure




Procedure EventGaget_btnSticky()
   _Main\IsSticky = GetGadgetState(#btnSticky)
   StickyWindow  (#winScreen, _Main\IsSticky)
EndProcedure

Procedure EventGaget_btnEditor()
   State = GetGadgetState(#tvwScreen)
   If State < 0 : ProcedureReturn : EndIf 
   *pSource.__SourceInfo = GetGadgetItemData(#tvwScreen, State) 
   If *pSource\FileType = 0
      ShellExecute_(0, "open",  @*pSource\FileName$, 0, 0, #SW_SHOW) 
   Else 
      CompilerID = RunProgram(_Main\Compiler$, *pSource\FileName$, "", #PB_Program_Open)
      If CompilerID : CloseProgram(CompilerID) : EndIf
   EndIf 
EndProcedure

Procedure EventGaget_chkFindName()
   _Main\IsFindName = GetGadgetState(#chkFindName)
   _Main\IsFindCode = GetGadgetState(#chkFindCode)
   If _Main\IsFindName = #False And _Main\IsFindCode = #False
      _Main\IsFindCode = #True
      SetGadgetState(#chkFindCode, #True)
   EndIf 
EndProcedure

Procedure EventGaget_chkFindCode()
   _Main\IsFindName = GetGadgetState(#chkFindName)
   _Main\IsFindCode = GetGadgetState(#chkFindCode)
   If _Main\IsFindName = #False And _Main\IsFindCode = #False
      _Main\IsFindName = #True
      SetGadgetState(#chkFindName, #True)
   EndIf 
EndProcedure

Procedure EventGaget_btnResult()
   If GetGadgetState(#btnResult)
      SetGadgetAttribute(#sptScreen, #PB_Splitter_FirstGadget, #lstResult)
      HideGadget(#tvwScreen, #True)
      HideGadget(#lstResult, #False)
   Else 
      SetGadgetAttribute(#sptScreen, #PB_Splitter_FirstGadget, #tvwScreen)
      HideGadget(#tvwScreen, #False)
      HideGadget(#lstResult, #True)
   EndIf 
EndProcedure

Procedure EventGaget_btnForums()
   mcsOpenFolder_(_Main\IEForums$)
EndProcedure

Procedure EventGaget_btnSearch()

   _Main\IsSearching = #False
   While IsThread(_Main\ThreadSearchID)
      Delay(1)
   Wend
   _Main\IsFindName = GetGadgetState(#chkFindName)
   _Main\IsFindCode = GetGadgetState(#chkFindCode)
   FullSearch$ = GetGadgetText(#cmbSearch)
   
   ForEach _ListSearch()
      FreeMemory(_ListSearch()\pMemASC)
      FreeMemory(_ListSearch()\pMemUTF)
   Next 
   ClearList(_ListSearch())
   
   For k = 1 To CountString(FullSearch$, " ")+1
      Text$ = StringField(FullSearch$, k, " ")
      If Text$ <> #Null$
         AddElement(_ListSearch())
         With _ListSearch()
            \Search$ = Text$
            \LenghtASC = StringByteLength(Text$, #PB_Ascii)
            \LenghtUTF = StringByteLength(Text$, #PB_UTF8)
            \pMemASC = AllocateMemory(\LenghtASC+2)
            \pMemUTF = AllocateMemory(\LenghtUTF+2)
            PokeS(\pMemASC, Text$, -1, #PB_Ascii)
            PokeS(\pMemUTF, Text$, -1, #PB_UTF8)
         EndWith
      EndIf 
   Next 
   If ListSize(_ListSearch()) = 0
      MessageRequester("提示", "没有发现有效的查找内容! ")
      ProcedureReturn 
   EndIf 
   _Main\IsSearching = #True
   ClearGadgetItems(#lstResult)
   SetGadgetAttribute(#sptScreen, #PB_Splitter_FirstGadget, #lstResult)
   HideGadget(#tvwScreen, #True)
   HideGadget(#lstResult, #False)
   SetGadgetState(#lstResult, #True)
   Idx = ListSize(_ListRecord$()) -1
   ForEach _ListRecord$()
      If _ListRecord$() = FullSearch$
         RemoveGadgetItem(#cmbSearch, Idx)
         DeleteElement(_ListRecord$()) : Break 
         Idx-1
      EndIf 
   Next 
   FirstElement(_ListRecord$())
   InsertElement(_ListRecord$())
   _ListRecord$() = FullSearch$
   AddGadgetItem(#cmbSearch, 0, FullSearch$)
   SetGadgetText(#cmbSearch, FullSearch$)
   _Main\ThreadSearchID = CreateThread(@Thread_SearchSource(), Index)
   
EndProcedure

Procedure EventGaget_btnRefresh()
   If IsThread(_Main\ThreadEnum) = 0 
      _Main\ThreadEnum = CreateThread(@Thread_EnumSource(), Index)
   EndIf 
EndProcedure

;-
Procedure EventGaget_txtIEForums()
   If EventType() <> #PB_EventType_Change : ProcedureReturn : EndIf 
   _Main\IEForums$ = Trim(GetGadgetText(#txtIEForums))
EndProcedure

Procedure EventGaget_txtCompiler()
   If EventType() <> #PB_EventType_Change : ProcedureReturn : EndIf 
   _Main\Compiler$ = Trim(GetGadgetText(#txtCompiler))
EndProcedure

Procedure EventGaget_btnCompiler()
   Pattern$ = "任意文件 (*.*)|*.*"
   Compiler$ = OpenFileRequester("请选择PuerBasic.exe", _Main\Compiler$, Pattern$, 0)
   If Compiler$
      _Main\Compiler$ = Compiler$
      SetGadgetText(#txtCompiler, Compiler$)
   EndIf 
EndProcedure

Procedure EventGaget_btnCodePath()
   CodePath$ = PathRequester("请选择源代码库", _Main\CodePath$)
   If CodePath$
      _Main\CodePath$ = CodePath$
      SetGadgetText(#txtCodePath, CodePath$)
   EndIf 
EndProcedure

Procedure EventGaget_txtCodePath()
   If EventType() <> #PB_EventType_Change : ProcedureReturn : EndIf 
   _Main\CodePath$ = Trim(GetGadgetText(#txtCodePath))
EndProcedure

Procedure EventGaget_btnPBInject()

   MessageRequester("提示", "如果要找到PureBasic代码编码软件的话,请先关闭!")
   
   FileName$ = GetHomeDirectory() + "AppData\Roaming\PureBasic\Tools.prefs"
   Debug FileName$
   If FileSize(FileName$) > 0 
      Directory$ = GetCurrentDirectory()
      Debug "Directory$ = " + Directory$
      NewList ListTools.__ToolsPrefs()
      OpenPreferences(FileName$)
         PreferenceGroup("ToolsInfo")
            ToolCount = ReadPreferenceLong("ToolCount", 0)

         For Index = 0 To ToolCount-1
            If PreferenceGroup("Tool_"+Str(Index))
               AddElement(ListTools())
               With ListTools()
                  \Command$         = ReadPreferenceString("Command",        "")
                  \Arguments$       = ReadPreferenceString("Arguments",      "")
                  \WorkingDir$      = ReadPreferenceString("WorkingDir",     "")
                  \MenuItemName$    = ReadPreferenceString("MenuItemName",   "")
                  \Shortcut         = ReadPreferenceLong  ("Shortcut",       0)
                  \ConfigLine$      = ReadPreferenceString("ConfigLine",     "")
                  \Trigger          = ReadPreferenceLong  ("Trigger",        0)
                  \Flags            = ReadPreferenceLong  ("Flags",          0)
                  \ReloadSource     = ReadPreferenceLong  ("ReloadSource",   0)
                  \HideEditor       = ReadPreferenceLong  ("HideEditor",     0)
                  \HideFromMenu     = ReadPreferenceLong  ("HideFromMenu",   0)
                  \SourceSpecific   = ReadPreferenceLong  ("SourceSpecific", 0)
                  \Deactivate       = ReadPreferenceLong  ("Deactivate",     0)
                  If \Command$ = Directory$+"迷路代码库工具.exe"
                     IsFind = #True
                  EndIf 
                  Debug \Command$
               EndWith
    
            EndIf 
         Next 
      ClosePreferences()
      
      If IsFind = #True
         MessageRequester("提示", "工具已经存在!不需要重复注入! ")
         ProcedureReturn
      Else 
         AddElement(ListTools())
         With ListTools()
            \Command$         = Directory$+"迷路代码库工具.exe"
            \Arguments$       = ""
            \WorkingDir$      = Directory$
            \MenuItemName$    = "迷路代码库工具"
            \Shortcut         = 131184
            \ConfigLine$      = ""
            \Trigger          = 0
            \Flags            = 0
            \ReloadSource     = 0
            \HideEditor       = 0
            \HideFromMenu     = 0
            \SourceSpecific   = 0
            \Deactivate       = 0
         EndWith
         If CreatePreferences(FileName$)
            PreferenceComment(";  PureBasic IDE ToolsMenu Configuration")
            PreferenceComment("")
            PreferenceGroup("ToolsInfo")
               WritePreferenceLong("ToolCount", ListSize(ListTools()))
   
            Index = 0 
            ForEach ListTools()
               PreferenceComment("")
               PreferenceComment("")
               PreferenceGroup("Tool_"+Str(Index))
               With ListTools()
                  WritePreferenceString("Command",        \Command$ )
                  WritePreferenceString("Arguments",      \Arguments$)
                  WritePreferenceString("WorkingDir",     \WorkingDir$)
                  WritePreferenceString("MenuItemName",   \MenuItemName$)
                  WritePreferenceLong  ("Shortcut",       \Shortcut )
                  WritePreferenceString("ConfigLine",     \ConfigLine$)
                  WritePreferenceLong  ("Trigger",        \Trigger )
                  WritePreferenceLong  ("Flags",          \Flags) 
                  WritePreferenceLong  ("ReloadSource",   \ReloadSource)
                  WritePreferenceLong  ("HideEditor",     \HideEditor)
                  WritePreferenceLong  ("HideFromMenu",   \HideFromMenu)
                  WritePreferenceLong  ("SourceSpecific", \SourceSpecific)
                  WritePreferenceLong  ("Deactivate",     \Deactivate)
               EndWith
   
               Index + 1
            Next 
            ClosePreferences()
         EndIf
         MessageRequester("提示", "工具已经成功! ")
      EndIf 
   EndIf 

EndProcedure


Procedure EventGaget_btnPerfer()
   WindowFlags = #PB_Window_WindowCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
   hWindow = OpenWindow(#winPerfer, 0, 0, 500, 280, "工具设置", WindowFlags, WindowID(#winScreen))
   SetGadgetFont(#PB_Default,  #PB_Default)
   ImageGadget (#picSoftLogo, 010, 010, 055, 020, ImageID(#imgPBLogo))  

    
   TextGadget  (#lblCompiler, 010, 013+90, 055, 020, "PUB 路径:")
   StringGadget(#txtCompiler, 065, 010+90, 400, 020, _Main\Compiler$)
   ButtonGadget(#btnCompiler, 470, 010+90, 020, 020, "…")
   
   TextGadget  (#lblCodePath, 010, 038+90, 055, 020, "源代码库:")
   StringGadget(#txtCodePath, 065, 035+90, 400, 020, _Main\CodePath$)
   ButtonGadget(#btnCodePath, 470, 035+90, 020, 020, "…")
   
   TextGadget  (#lblIEForums, 010, 063+90, 055, 020, "官方论坛:")
   StringGadget(#txtIEForums, 065, 060+90, 400, 020, _Main\IEForums$)
   ButtonGadget(#btnIEForums, 470, 060+90, 020, 020, "□")
   
   TextGadget  (#lblPBInject, 010, 060+120, 480, 020, "将本工具注入到PureBasic编辑软件拓展工具中.[Ctrl+F1]可以打开本工具!")
   ButtonGadget(#btnPBInject, 440, 055+120, 050, 025, "注入") 
  
   Text$ = "本工具当前共收录了["+Str(_Main\CountExamples)+"]个实例. 后期会持续更新,敬请关注Q群更新动向!"
   TextGadget  (#lblNotice01, 010, 090+120, 480, 020, "开发人员: 迷路仟 [QQ:714095563] 欢迎提供更多实用的实例.")
   TextGadget  (#lblNotice02, 010, 110+120, 480, 020, Text$)
   TextGadget  (#lblNotice03, 010, 130+120, 480, 020, "本工具旨在帮助初学者快的学习和掌握PureBasic,以及充当资深程序员源代码查询工具.")
   
   SetGadgetColor(#lblNotice01, #PB_Gadget_FrontColor, $F00000)
   SetGadgetColor(#lblPBInject, #PB_Gadget_FrontColor, $F000F0)
   
   BindGadgetEvent(#btnPBInject, @EventGaget_btnPBInject())
   BindGadgetEvent(#btnCompiler, @EventGaget_btnCompiler())
   BindGadgetEvent(#txtCompiler, @EventGaget_txtCompiler())
   BindGadgetEvent(#btnCodePath, @EventGaget_btnCodePath())
   BindGadgetEvent(#txtCodePath, @EventGaget_txtCodePath())
   BindGadgetEvent(#txtIEForums, @EventGaget_txtIEForums())
   BindGadgetEvent(#btnIEForums, @EventGaget_btnForums())
   
EndProcedure

;-
;-[Screen]
Procedure Screen_CreateGadget(hWindow)

   WindowBounds(#winScreen, 500, 250, #PB_Ignore, #PB_Ignore) 
   If CreateStatusBar(#wsbScreen, hWindow)
      AddStatusBarField(0100)
      AddStatusBarField(0160)
      AddStatusBarField(3999)
      StatusBarText(#wsbScreen, 0, " -迷路出品- ", #PB_StatusBar_Center)
      StatusBarText(#wsbScreen, 1, "PureBasic 5.62版本") 
      StatusBarText(#wsbScreen, 2, "欢迎使用[迷路PureBasic实例库工具]") 
   EndIf
   SendMessage_(StatusBarID(#wsbScreen), #WM_SETFONT, FontID(#fntDefault), #True)

   With _Main
      \StatusH = StatusBarHeight(#wsbScreen)
      SetGadgetFont(#PB_Default,  FontID(#fntDefault))
      CheckBoxGadget   (#chkFindName, 010, 005, 080, 025, "文件名")
      CheckBoxGadget   (#chkFindCode, 100, 005, 080, 025, "源代码")
      ComboBoxGadget   (#cmbSearch,   190, 005, 300, 025, #PB_ComboBox_Editable)
      ButtonImageGadget(#btnSearch,   500, 003, 028, 028, ImageID(#imgSearch))
      ButtonImageGadget(#btnResult,   535, 003, 028, 028, ImageID(#imgResult), #PB_Button_Toggle)
      ButtonImageGadget(#btnRefresh,  570, 003, 028, 028, ImageID(#imgRefresh))      
      ButtonImageGadget(#btnEditor,   605, 003, 028, 028, ImageID(#imgEditor))
      ButtonImageGadget(#btnFloder,   605, 003, 028, 028, ImageID(#imgFloder))  
   
      ButtonImageGadget(#btnForums,   \WindowW-105, 003, 028, 028, ImageID(#imgForums))
      ButtonImageGadget(#btnSticky,   \WindowW-070, 003, 028, 028, ImageID(#imgNormal), #PB_Button_Toggle)
      ButtonImageGadget(#btnPerfer,   \WindowW-035, 003, 028, 028, ImageID(#imgPrefer))

      GadgetFlags =  #PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection
      ListIconGadget    (#lstResult, 000, 000, \WindowW, \WindowH, "文件名", 200, GadgetFlags)
      TreeGadget        (#tvwScreen, 000, 000, \WindowW, \WindowH, #PB_Tree_AlwaysShowSelection)
      mcsRichEditGadget_(#rtxScreen, 000, 000, \WindowW, \WindowH)
      SplitterGadget(#sptScreen, 005, 035, \WindowW-10, \WindowH-40-\StatusH, #tvwScreen, #rtxScreen,  #PB_Splitter_Vertical|#PB_Splitter_FirstFixed)
      
      AddGadgetColumn(#lstResult, 1, "路径", 400)
      HideGadget(#lstResult, #True)
      HideGadget(#btnEditor, #True)
      HideGadget(#btnFloder, #True)
      
      
      SetGadgetAttribute(#rtxScreen, #MCS_RichEdit_Format, #FormatType_PB)
      SetGadgetColor(#lstResult, #PB_Gadget_BackColor, $F0DCD2)
      SetGadgetColor(#tvwScreen, #PB_Gadget_BackColor, $DFFFDF)
      SetGadgetState(#sptScreen, 250)
      SetGadgetAttribute(#btnSticky, #PB_Button_PressedImage, ImageID(#imgSticky))
      SetGadgetAttribute(#btnResult, #PB_Button_PressedImage, ImageID(#imgSource))
      StickyWindow  (#winScreen, \IsSticky)
      SetGadgetState(#btnSticky, \IsSticky)
      SetGadgetState(#chkFindName, \IsFindName)
      SetGadgetState(#chkFindCode, \IsFindCode)
      
      SetGadgetFont(#rtxScreen, FontID(#fntRichEdit))
      GadgetToolTip(#btnSearch, "查找源代码文件")
      GadgetToolTip(#btnEditor, "从PureBasic IDE打开源代码文件")
      GadgetToolTip(#btnFloder, "打开文件夹所处的位置")
      GadgetToolTip(#btnForums, "前往PureBasic的官方论坛")
      GadgetToolTip(#btnSticky, "设置窗体置顶")
      GadgetToolTip(#btnPerfer, "软件设置")
      
      
      ForEach _ListRecord$()
         AddGadgetItem(#cmbSearch, -1, _ListRecord$())
      Next 
      
      BindGadgetEvent(#chkFindName, @EventGaget_chkFindName())
      BindGadgetEvent(#chkFindCode, @EventGaget_chkFindCode())
      BindGadgetEvent(#btnRefresh,  @EventGaget_btnRefresh())
      BindGadgetEvent(#btnPerfer,   @EventGaget_btnPerfer())
      BindGadgetEvent(#btnResult,   @EventGaget_btnResult())
      BindGadgetEvent(#btnEditor,   @EventGaget_btnEditor())
      BindGadgetEvent(#btnFloder,   @EventGaget_btnEditor())
      BindGadgetEvent(#btnSticky,   @EventGaget_btnSticky())
      BindGadgetEvent(#btnSearch,   @EventGaget_btnSearch())
      BindGadgetEvent(#btnForums,   @EventGaget_btnForums())
      BindGadgetEvent(#tvwScreen,   @EventGaget_tvwScreen())
      BindGadgetEvent(#lstResult,   @EventGaget_lstResult())
   EndWith
EndProcedure

Procedure Screen_SizeWindow (hWindow)
   With _Main
      WindowW = WindowWidth (#winScreen)
      WindowH = WindowHeight(#winScreen)
      If WindowW > 0 And WindowH > 0 
         \WindowW = WindowW
         \WindowH = WindowH
         ResizeGadget(#sptScreen, #PB_Ignore, #PB_Ignore, \WindowW-10, \WindowH-40-\StatusH)
         If WindowW >=  640+70
            ComboW = 300
            ResizeGadget(#cmbSearch, #PB_Ignore, #PB_Ignore, ComboW, #PB_Ignore)
            ResizeGadget(#btnSearch, 500, #PB_Ignore, #PB_Ignore, #PB_Ignore)
            ResizeGadget(#btnResult, 535, #PB_Ignore, #PB_Ignore, #PB_Ignore)
            ResizeGadget(#btnRefresh,570, #PB_Ignore, #PB_Ignore, #PB_Ignore)
            ResizeGadget(#btnEditor, 605, #PB_Ignore, #PB_Ignore, #PB_Ignore)
            ResizeGadget(#btnFloder, 605, #PB_Ignore, #PB_Ignore, #PB_Ignore)
         Else 
            ComboW = WindowW - (640+70-300)
            ResizeGadget(#cmbSearch, #PB_Ignore, #PB_Ignore, ComboW, #PB_Ignore)
            ResizeGadget(#btnSearch, ComboW+200, #PB_Ignore, #PB_Ignore, #PB_Ignore)
            ResizeGadget(#btnResult, ComboW+235, #PB_Ignore, #PB_Ignore, #PB_Ignore)
            ResizeGadget(#btnRefresh,ComboW+270, #PB_Ignore, #PB_Ignore, #PB_Ignore)            
            ResizeGadget(#btnEditor, ComboW+305, #PB_Ignore, #PB_Ignore, #PB_Ignore)
            ResizeGadget(#btnFloder, ComboW+305, #PB_Ignore, #PB_Ignore, #PB_Ignore)

         EndIf 
         ResizeGadget(#btnForums, \WindowW-105, #PB_Ignore, #PB_Ignore, #PB_Ignore)
         ResizeGadget(#btnSticky, \WindowW-070, #PB_Ignore, #PB_Ignore, #PB_Ignore)
         ResizeGadget(#btnPerfer, \WindowW-035, #PB_Ignore, #PB_Ignore, #PB_Ignore)
      EndIf 
   EndWith
EndProcedure

Procedure Screen_MoveWindow (hWindow)
   WindowX = WindowX(#winScreen)
   WindowY = WindowY(#winScreen)
   If WindowX > 0 And WindowY > 0 
      _Main\WindowX = WindowX
      _Main\WindowY = WindowY
   EndIf 
EndProcedure

Procedure Screen_CloseWindow(hWindow)
   WindowID = EventWindow()
   If WindowID = #winScreen
      _Main\IsExitWindow = #True
   Else 
      CloseWindow(WindowID)
   EndIf 
EndProcedure

;-
;-[Thread]
Procedure Funciton_EnumSource(FilePath$, Floor, *pFloorElement)
   DirID = ExamineDirectory(#PB_Any, FilePath$, "*.*") 
   If DirID 
      While NextDirectoryEntry(DirID)  
         FileName$ = DirectoryEntryName(DirID) 
         If DirectoryEntryType(DirID) = #PB_DirectoryEntry_File 
            If LCase(GetExtensionPart(FileName$)) = "pb"
               Count + 1
               FullName$ = FilePath$+FileName$
               *pElement.__SourceInfo = AddElement(_ListSource())
               *pElement\SortName$ = FilePath$+Chr($FF)+FileName$
               *pElement\FileName$ = FullName$
               *pElement\PathName$ = FilePath$
               *pElement\NodeName$ = FileName$
               *pElement\NodeFloor = Floor
               *pElement\FileType  = 1
               *pElement\pFloorElement = *pFloorElement
               _Main\CountExamples + 1
            EndIf 
         ElseIf DirectoryEntryName(DirID) = "." 
         ElseIf DirectoryEntryName(DirID) = ".."  
         Else   
            FullName$ = FilePath$+FileName$+"\"
            *pElement.__SourceInfo = AddElement(_ListSource())
            *pElement\SortName$ = FilePath$+FileName$+"\"
            *pElement\FileName$ = FullName$
            *pElement\PathName$ = FilePath$
            *pElement\NodeName$ = FileName$
            *pElement\NodeFloor = Floor
            *pElement\FileType  = 0
            *pElement\pFloorElement  = *pFloorElement
            FloorCount = Funciton_EnumSource(FullName$, Floor+1, *pElement)  
            *pElement\Count     = FloorCount
            Count + FloorCount
         EndIf  
      Wend  
      FinishDirectory(DirID)  
   EndIf  
   ProcedureReturn Count  
EndProcedure  

Procedure Thread_EnumSource(Index)
   _Main\CountExamples = 0
   ClearList(_ListSource())
   Time = mcsGetTime_()
   Funciton_EnumSource(_Main\CodePath$, 0, 0)
   Debug mcsGetTime_(Time)
   SortStructuredList(_ListSource(), 00, 00, #PB_String)
   ClearGadgetItems(#tvwScreen)
   ClearGadgetItems(#lstResult)
   ClearGadgetItems(#rtxScreen)
   EventGaget_ShowNode(0)
   StatusBarText(#wsbScreen, 2, "本工具收录了["+Str(_Main\CountExamples)+"]个源代码实例! ---- 欢迎使用[迷路PureBasic实例库工具]") 
   Debug mcsGetTime_(Time)
EndProcedure

Procedure Thread_SearchSource(Index)
   With _ListSource()
      If _Main\IsFindName And _Main\IsFindCode
         *MemData = AllocateMemory($1000000)
         ForEach _ListSource()
            If _Main\IsSearching = #False : Break : EndIf 
            If FindString(\NodeName$, _ListSearch()\Search$)
               AddGadgetItem(#lstResult, -1, \NodeName$+#LF$+\PathName$)
               SetGadgetItemData(#lstResult, Index, _ListSource())
               Index+1
            Else 
               FileID = ReadFile(#PB_Any, \FileName$)
               If FileID
                  FileSize = FileSize(\FileName$)
                  ReadData(FileID, *MemData, FileSize)
                  CloseFile(FileID)
                  ForEach _ListSearch()
                     If _Main\IsSearching = #False : Break 2 : EndIf 
                     For k = 0 To FileSize-_ListSearch()\LenghtASC-1
                        If CompareMemory(*MemData+k, _ListSearch()\pMemASC, _ListSearch()\LenghtASC)
                           AddGadgetItem(#lstResult, -1, \NodeName$+#LF$+\PathName$)
                           SetGadgetItemData(#lstResult, Index, _ListSource())
                           Index+1
                           Break
                        ElseIf CompareMemory(*MemData+k, _ListSearch()\pMemUTF, _ListSearch()\LenghtUTF)
                           AddGadgetItem(#lstResult, -1, \NodeName$+#LF$+\PathName$)
                           SetGadgetItemData(#lstResult, Index, _ListSource())
                           Index+1
                           Break
                        EndIf  
                     Next 
                  Next 
               EndIf 
            EndIf 
         Next 
         FreeMemory(*MemData)
      ElseIf _Main\IsFindName 
         ForEach _ListSource()
            If _Main\IsSearching = #False : Break : EndIf 
            If FindString(\NodeName$, _ListSearch()\Search$)
               AddGadgetItem(#lstResult, -1, \NodeName$+#LF$+\PathName$)
               SetGadgetItemData(#lstResult, Index, _ListSource())
               Index+1
            EndIf 
         Next 
      ElseIf _Main\IsFindCode 
         *MemData = AllocateMemory($1000000)
         ForEach _ListSource()
            If _Main\IsSearching = #False : Break : EndIf 
            FileID = ReadFile(#PB_Any, \FileName$)
            If FileID
               FileSize = FileSize(\FileName$)
               ReadData(FileID, *MemData, FileSize)
               CloseFile(FileID)
               ForEach _ListSearch()
                  If _Main\IsSearching = #False : Break 2: EndIf 
                  For k = 0 To FileSize-_ListSearch()\LenghtASC-1
                     If CompareMemory(*MemData+k, _ListSearch()\pMemASC, _ListSearch()\LenghtASC)
                        AddGadgetItem(#lstResult, -1, \NodeName$+#LF$+\PathName$)
                        SetGadgetItemData(#lstResult, Index, _ListSource())
                        Index+1
                        Break
                     ElseIf CompareMemory(*MemData+k, _ListSearch()\pMemUTF, _ListSearch()\LenghtUTF)
                        AddGadgetItem(#lstResult, -1, \NodeName$+#LF$+\PathName$)
                        SetGadgetItemData(#lstResult, Index, _ListSource())
                        Index+1
                        Break
                     EndIf  
                  Next 
               Next 
            EndIf 
         Next 
         FreeMemory(*MemData)
      EndIf 
   EndWith
   
   SetGadgetState(#btnResult, #True)
   SetGadgetAttribute(#sptScreen, #PB_Splitter_FirstGadget, #lstResult)
   HideGadget(#tvwScreen, #True)
   HideGadget(#lstResult, #False)
   If _Main\IsSearching = #True
      StatusBarText(#wsbScreen, 2, "共找到 "+Str(Index)+"个源代码文件! ") 
      MessageRequester("提示", "共找到 "+Str(Index)+"个源代码文件! ")
   Else 
      StatusBarText(#wsbScreen, 2, "没有找到符合条件的源代码文件! ") 
      MessageRequester("提示", "没有找到符合条件的源代码文件! ")
   EndIf 
   _Main\IsSearching = #False
   _Main\ThreadSearchID = 0
EndProcedure



Procedure Window_Callback(hWindow, uMsg, *wParam, *lParam)
   *NMT.NM_TREEVIEW = *lParam
   Select uMsg
      Case #WM_NOTIFY 
         Select *NMT\hdr\code
            Case #TVN_ITEMEXPANDED
               GadgetID = *NMT\hdr\idFrom
               State = *NMT\itemNew\lParam
               If *NMT\action = 2
                  *pSource.__SourceInfo = GetGadgetItemData(GadgetID, State) 
                  If *pSource And *pSource\FileType = 0
                     EventGaget_ShowNode(*pSource, State)
                  EndIf 
               EndIf 
         EndSelect 
   EndSelect
   ProcedureReturn #PB_ProcessPureBasicEvents 
EndProcedure 


;-
;-***************************
;-[Main]
Screen_Initialize()
Screen_LoadPrefer()
WindowTitle$ = "迷路PureBasic实例库工具 - "+#Version$+" [PureBasic 国内交流群: 6248988]"
WindowFlags = #PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
With _Main
   If \WindowX <= 0 Or \WindowY <= 0 
      hWindow = OpenWindow(#winScreen, 0, 0, \WindowW, \WindowH, WindowTitle$, #PB_Window_ScreenCentered|WindowFlags)
      \WindowX = WindowX(#winScreen)
      \WindowY = WindowY(#winScreen)
   Else 
      hWindow = OpenWindow(#winScreen, \WindowX, \WindowY, \WindowW, \WindowH, WindowTitle$, WindowFlags)
   EndIf 
   Screen_CreateGadget(hWindow)
   \ThreadEnum = CreateThread(@Thread_EnumSource(), Index)
   SetWindowCallback(@Window_Callback())
   Repeat
      EventNum  = WindowEvent()
      GadgetID  = EventGadget()
      EventType = EventType()
      Select EventNum
         Case #PB_Event_CloseWindow : Screen_CloseWindow(hWindow)
         Case #PB_Event_SizeWindow  : Screen_SizeWindow (hWindow)
         Case #PB_Event_MoveWindow  : Screen_MoveWindow (hWindow)
      EndSelect
      Delay(1)   
   Until \IsExitWindow = #True
   Screen_SavePrefer()
   Screen_Release()
EndWith
End


;- ##########################
;- [Data]
DataSection
_PNG_Normal:
   IncludeBinary ".\Image\Normal.png" 
_PNG_Sticky:
   IncludeBinary ".\Image\Sticky.png" 
_PNG_Editor:
   IncludeBinary ".\Image\Editor.png"    
_PNG_Prefer:
   IncludeBinary ".\Image\Prefer.png" 
_PNG_Search:
   IncludeBinary ".\Image\Search.png"  
_PNG_Floder:
   IncludeBinary ".\Image\Floder.png" 
_PNG_Forums:
   IncludeBinary ".\Image\Forums.png"   
_PNG_Result:
   IncludeBinary ".\Image\Result.png"      
_PNG_Source:
   IncludeBinary ".\Image\Source.png"  
_PNG_PBLogo:
   IncludeBinary ".\Image\PBLogo.png"     
_PNG_Refresh:
   IncludeBinary ".\Image\Refresh.png"            
EndDataSection







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 488
; FirstLine = 384
; Folding = k-4----
; EnableXP
; UseIcon = Image\LOGO.ico
; Executable = 迷路代码库工具.exe
; EnableUnicode