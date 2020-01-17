;***********************************
;迷路仟整理 2019.03.15
;SpecialFolder_获取系统特殊文件夹
;***********************************


#NOERROR             = 0 
#MAX_PATH            = 260 
#CSIDL_FLAG_CREATE   = $8000 
#CSIDL_ADMINTOOLS                = $30    ;当前用户管理工具
#CSIDL_ALTSTARTUP                = $1D    ;不详
#CSIDL_APPDATA                   = $1A    ;C:/Documents and Settings/username/Application Data
#CSIDL_BITBUCKET                 = $0A    ;回收站
#CSIDL_COMMON_ADMINTOOLS         = $2F    ;所有用户管理工具
#CSIDL_COMMON_ALTSTARTUP         = $1E    ;不详
#CSIDL_COMMON_APPDATA            = $23    ;【应用程序数据】C:/Documents And Settings/All Users/Application Data
#CSIDL_COMMON_DESKTOPDIRECTORY   = $19    ;【桌面】C:\Documents and Settings\All Users\Desktop. 
#CSIDL_COMMON_DOCUMENTS          = $2E    ;【我的文档】C:\Documents and Settings\All Users\Documents. 
#CSIDL_COMMON_FAVORITES          = $1F    ;【我的收藏夹】
#CSIDL_COMMON_PROGRAMS           = $17    ;【程序】 C:\Documents And Settings\All Users\Start Menu\Programs. 
#CSIDL_COMMON_STARTMENU          = $16    ;【开始菜单】 C:\Documents and Settings\All Users\Start Menu.
#CSIDL_COMMON_STARTUP            = $18    ;【启动】C:\Documents and Settings\All Users\Start Menu\Programs\Startup. 
#CSIDL_COMMON_TEMPLATES          = $2D    ;【模块】 C:\Documents and Settings\All Users\Templates. 
#CSIDL_CONTROLS                  = $03    ;【控制面板】
#CSIDL_COOKIES                   = $21    ;【Cookies】  C:/Documents and Settings/username/Cookies
#CSIDL_DESKTOP                   = $00    ;【桌面】虚拟文件夹
#CSIDL_DESKTOPDIRECTORY          = $10    ;当前用户的【桌面】: C:\Documents and Settings\username\Desktop 
#CSIDL_DRIVES                    = $11    ;【我的电脑】
#CSIDL_FAVORITES                 = $06    ;当前用户的【我的收藏夹】C:\Documents and Settings\username\Favorites. 
#CSIDL_FONTS                     = $14    ;【系统字体】C:\WINNT\Fonts. 
#CSIDL_HISTORY                   = $22    ;【历史记录】
#CSIDL_INTERNET                  = $01    ;Internet虚拟文件夹
#CSIDL_INTERNET_CACHE            = $20    ;【Cache】C:\Documents And Settings\username\Temporary Internet Files. 
#CSIDL_LOCAL_APPDATA             = $1C    ;当前用户的【应用程序数据】C:\Documents and Settings\username\Local Settings\Application Data. 
#CSIDL_MYPICTURES                = $27    ;C:\Documents and Settings\username\My Documents\My Pictures. 
#CSIDL_NETHOOD                   = $13    ;C:\Documents and Settings\username\NetHood. 
#CSIDL_NETWORK                   = $12    ;【网上邻居】
#CSIDL_PERSONAL                  = $05    ;C:\Documents and Settings\username\My Documents. 
#CSIDL_PRINTERS                  = $04    ;【打印机】
#CSIDL_PRINTHOOD                 = $1B    ;C:\Documents and Settings\username\PrintHood. 
#CSIDL_PROFILE                   = $28    ;当前用户的【用戶配置】
#CSIDL_PROGRAM_FILES             = $26    ;C:\Program Files. 
#CSIDL_PROGRAM_FILES_COMMON      = $2B    ;C:\Program Files\Common
#CSIDL_PROGRAM_FILES_COMMONX86   = $2C    ;C:\Program Files (x86)\Common
#CSIDL_PROGRAM_FILESX86          = $2A    ;C:\Program Files (x86)
#CSIDL_PROGRAMS                  = $02    ;C:\Documents and Settings\username\Start Menu\Programs.
#CSIDL_RECENT                    = $08    ;C:\Documents and Settings\username\Recent.
#CSIDL_SENDTO                    = $09    ;C:\Documents and Settings\username\SendTo
#CSIDL_STARTMENU                 = $0B    ;C:\Documents and Settings\username\Start Menu.
#CSIDL_STARTUP                   = $07    ;C:\Documents and Settings\username\Start Menu\Programs\Startup.
#CSIDL_SYSTEM                    = $25    ;C:\WINNT\SYSTEM32.
#CSIDL_SYSTEMX86                 = $29    ;C:\WINNT\SYS32X86.
#CSIDL_TEMPLATES                 = $15 
#CSIDL_WINDOWS                   = $24    ;C:\WINNT

;变量详情参考: https://www.xuebuyuan.com/zh-hant/677427.html

Procedure.s GetSpecialFolderLocation(FloderNumber) 
   Location$ = Space(#MAX_PATH) 
   Result = SHGetSpecialFolderLocation_(0, FloderNumber, @hFolderList) 
   If Result = #NOERROR 
      Result = SHGetPathFromIDList_(hFolderList, @Location$) 
      If Result
         ProcedureReturn RTrim(Location$) 
      EndIf        
      CoTaskMemFree_(hFolderList) 
   EndIf 
EndProcedure 

Debug GetSpecialFolderLocation(#CSIDL_FAVORITES)



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = -
; EnableXP
; EnableOnError