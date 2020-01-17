;***********************************
;迷路仟整理 2019.01.17
;超级链接
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
EndEnumeration

#EN_LINK = $70B 
#ENM_LINK = $4000000 
 
Procedure Winodw_CallBack(hWindow, uMsg, wParam, lParam) 
   Result = #PB_ProcessPureBasicEvents 
   Select uMsg 
      Case #WM_NOTIFY 
         *pLink.ENLINK = lParam 
         If *pLink\nmhdr\code=#EN_LINK 
               If *pLink\msg=#WM_LBUTTONDOWN 
               *pBuffer = AllocateMemory(512) 
               Range.TEXTRANGE 
               Range\chrg\cpMin = *pLink\chrg\cpMin 
               Range\chrg\cpMax = *pLink\chrg\cpMax 
               Range\lpstrText = *pBuffer 
               SendMessage_(GadgetID(#rtxScreen), #EM_GETTEXTRANGE, 0, Range) 
               Debug PeekS(*pBuffer) 
               FreeMemory(*pBuffer) 
            EndIf 
         EndIf 
   EndSelect 
   ProcedureReturn Result 
EndProcedure 



WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "超级链接", WindowFlags)

hGadget = EditorGadget (#rtxScreen, 005, 005, 390, 200)
SetGadgetText(#rtxScreen, "PureBasic 5.62版本"+#CRLF$+"欢迎使用[迷路PureBasic实例库工具]")

Style = SendMessage_(hGadget,#EM_GETEVENTMASK,0,0)  
SendMessage_(hGadget,#EM_SETEVENTMASK, 0, Style | #ENM_LINK)  
SendMessage_(hGadget,#EM_AUTOURLDETECT,1,0)  
AddGadgetItem(#rtxScreen, -1, "PureBasic官方网站")
AddGadgetItem(#rtxScreen, -1, "http://https://www.purebasic.fr")
AddGadgetItem(#rtxScreen, -1, "欢迎登录")

SetWindowCallback(@Winodw_CallBack()) 

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
; CursorPosition = 11
; FirstLine = 24
; Folding = -
; EnableXP