;***********************************
;迷路仟整理 2019.01.20
;ScintillaGadget_SCI富文本控件
;***********************************

Enumeration
   #winScreen
   #sciScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "ScintillaGadget_SCI富文本控件", WindowFlags)
   If InitScintilla()
      ScintillaGadget(#sciScreen, 10, 10, 380, 230, 0)
      ScintillaSendMessage(#sciScreen, #SCI_STYLESETFORE, 0, RGB(255, 0, 0))
      *pMemString = UTF8("这是一个简单的ScintillaGadget()富文本控件的实例! "+#LF$)
      ScintillaSendMessage(#sciScreen, #SCI_SETTEXT, 0, *pMemString)
      FreeMemory(*pMemString)
      Text$ = "这里追加文本行."+#LF$
      *pMemString = UTF8(Text$)
      Lenght = StringByteLength(Text$, #PB_UTF8)
      ScintillaSendMessage(#sciScreen, #SCI_APPENDTEXT, Lenght, *pMemString)
      FreeMemory(*pMemString)
   EndIf

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
; CursorPosition = 18
; Folding = -
; EnableXP