;***********************************
;迷路仟整理 2019.01.31
;Font_获取系统默认的字体
;***********************************

Enumeration
   #winScreen
   #lvwScreen
EndEnumeration

Global NewList ListFont$()

;枚举字体
Procedure Enum_SystemFont(*lpelf.ENUMLOGFONT, *lpntm.NEWTEXTMETRIC, FontType, lParam)  
   AddElement(ListFont$())
   ListFont$() = PeekS(@*lpelf\elfLogFont\lfFaceName[0]) 
   ProcedureReturn 1  
EndProcedure  
 
 ;获取字体,并显示到列表框中
Procedure GetSystemFont()  
   hWindow = GetDesktopWindow_()  
   hWindowDC = GetDC_(hWindow)  
   EnumFontFamilies_(hWindowDC, 0, @Enum_SystemFont(), 0)  
   ReleaseDC_ (hWindow, hWindowDC)  
   SortList(ListFont$(), 0)
   ForEach ListFont$()
      AddGadgetItem(#lvwScreen, -1,  ListFont$())
   Next 
EndProcedure  

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 500, 300, "获取系统默认的字体", WindowFlags)
ListViewGadget(#lvwScreen, 000, 000, 500, 300)

GetSystemFont()  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; FirstLine = 9
; Folding = -
; EnableXP