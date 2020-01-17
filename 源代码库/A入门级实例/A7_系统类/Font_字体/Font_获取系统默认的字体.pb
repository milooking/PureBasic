;***********************************
;迷路仟整理 2019.01.31
;Font_获取系统默认的字体
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #fntScreen
EndEnumeration

;加载字体
hLoadFont = LoadFont (#fntScreen, "微软雅黑", 50) 
hDefault1 = GetGadgetFont(#PB_Default)     ;窗体默认字体
hDefault2 = GetStockObject_(#SYSTEM_FONT)  ;系统默认字体

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 500, 300, "获取系统默认的字体", WindowFlags)

Debug "[微软雅黑]字体句柄: " + hLoadFont
Debug "[窗体]默认字体句柄: " + hDefault1
Debug "[系统]默认字体句柄: " + hDefault2

CanvasGadget(#cvsScreen, 000, 000, 500, 300)
If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
   VectorSourceColor(RGBA(255, 0, 0, 200))
   VectorFont(hLoadFont, 50)
   MovePathCursor(100, 015)
   DrawVectorText ("[微软雅黑]字体")

   VectorSourceColor(RGBA(0, 128, 0, 200))
   VectorFont(hDefault1, 50)
   MovePathCursor(100, 100)
   DrawVectorText ("[窗体]默认字体")
   
   VectorFont(hDefault2, 50)           ;在适量绘图模式下字体无效
   MovePathCursor(100, 200)
   DrawVectorText ("[系统]默认字体")
   StopVectorDrawing()
EndIf

If StartDrawing(CanvasOutput(#cvsScreen))
   DrawingFont(hDefault2)
   DrawText (100, 200, "[系统]默认字体: 在2D绘图模式下有效!", $FF0000, $FFFFFF)
   StopDrawing()
EndIf


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
FreeFont(#fntScreen) ;注销字体
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; FirstLine = 1
; Folding = -
; EnableXP