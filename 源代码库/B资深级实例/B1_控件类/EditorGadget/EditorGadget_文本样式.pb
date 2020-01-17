;***********************************
;迷路仟整理 2019.01.17
;文本样式
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
EndEnumeration

#CFM_BACKCOLOR = $4000000


Procedure Editor_SelectRow(hGadget, Row)     
   Range.CHARRANGE  
   Range\cpMin = SendMessage_(hGadget, #EM_LINEINDEX, Row-1, 0)
   Range\cpMax = SendMessage_(hGadget, #EM_LINEINDEX, Row, 0)-1
   SendMessage_(hGadget, #EM_EXSETSEL, 0, @Range)  
EndProcedure  

Procedure Editor_SetBackColor(hGadget, Color)  
  Format.CHARFORMAT2 
  Format\cbSize = SizeOf(CHARFORMAT2)  
  Format\dwMask = #CFM_BACKCOLOR  
  Format\crBackColor = Color  
  SendMessage_(hGadget, #EM_SETCHARFORMAT, #SCF_SELECTION, @Format)  
EndProcedure 

Procedure Editor_SetFontColor(hGadget, Color)  
   Format.CHARFORMAT  
   Format\cbSize = SizeOf(CHARFORMAT)  
   Format\dwMask = #CFM_COLOR  
   Format\crTextColor = Color  
   SendMessage_(hGadget, #EM_SETCHARFORMAT, #SCF_SELECTION, @Format)  
EndProcedure  

Procedure Editor_SetFontSize(hGadget, Fontsize)  
   Format.CHARFORMAT  
   Format\cbSize = SizeOf(CHARFORMAT)  
   Format\dwMask = #CFM_SIZE  
   Format\yHeight = FontSize*20  
   SendMessage_(hGadget, #EM_SETCHARFORMAT, #SCF_SELECTION, @Format)  
EndProcedure  
 
Procedure Editor_SetFontName(hGadget, FontName$)  
   Format.CHARFORMAT  
   Format\cbSize = SizeOf(CHARFORMAT)  
   Format\dwMask = #CFM_FACE  
   PokeS(@Format\szFaceName, FontName$)  
   SendMessage_(hGadget, #EM_SETCHARFORMAT, #SCF_SELECTION, @Format)  
EndProcedure  
 
Procedure Editor_SetFontStyle(hGadget, Style)  
   Format.CHARFORMAT  
   Format\cbSize = SizeOf(CHARFORMAT)  
   Format\dwMask = #CFM_ITALIC|#CFM_BOLD|#CFM_STRIKEOUT|#CFM_UNDERLINE  
   Format\dwEffects = Style  
   SendMessage_(hGadget, #EM_SETCHARFORMAT, #SCF_SELECTION, @Format)  
EndProcedure  
 
 

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "文本样式", WindowFlags)

hGadget = EditorGadget (#rtxScreen, 005, 005, 390, 200)
Text$ = "PureBasic 5.62版本"+#CRLF$+
        "欢迎使用[迷路PureBasic实例库工具]"+#CRLF$+
        "PureBasic 5.62版本"+#CRLF$+
        "欢迎使用[迷路PureBasic实例库工具]"
        
SetGadgetText(#rtxScreen, Text$)

Editor_SelectRow   (hGadget, 1)  
Editor_SetFontColor(hGadget, RGB(0,0,255))  
Editor_SetFontSize (hGadget, 12)  
Editor_SetFontStyle(hGadget, #CFM_UNDERLINE)  

Editor_SelectRow   (hGadget, 2)  
Editor_SetFontColor(hGadget, RGB(255,0,0))  
Editor_SetBackColor(hGadget, RGB(255,255,223))  
Editor_SetFontName (hGadget, "微软雅黑")  
Editor_SetFontStyle(hGadget, #CFM_ITALIC|#CFM_STRIKEOUT)  

Editor_SelectRow   (hGadget, 3)  
Editor_SetFontColor(hGadget, RGB(255,0,255))  
Editor_SetFontName (hGadget, "宋体")  
Editor_SetFontSize (hGadget, 14)  
Editor_SetFontStyle(hGadget, #CFM_BOLD)  

Editor_SelectRow   (hGadget, 4)  
Editor_SetFontColor(hGadget, RGB(0,128,0)) 
Editor_SetBackColor(hGadget, RGB(255,255,223)) 
Editor_SetFontName (hGadget, "Times New Roman")  
Editor_SetFontSize (hGadget, 16)  
Editor_SetFontStyle(hGadget, #CFM_BOLD)  

Editor_SelectRow   (hGadget, 5)  
Repeat

   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 92
; FirstLine = 61
; Folding = 0-
; EnableXP