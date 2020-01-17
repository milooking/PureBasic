;***********************************
;迷路仟整理 2019.01.24
;DrawVectorText_绘制矢量文本
;***********************************

#winScreen = 0
#cvsScreen = 0
#fntScreen = 0


hFont = LoadFont(#fntScreen, "宋体", 20)

If OpenWindow(#winScreen, 0, 0, 500, 250, "DrawVectorText_绘制矢量文本", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorFont(hFont, 16)
      
      Text$ = "PureBasic一套建立在'BASIC'基础上的新的'高级'语言. "         +#LFCR$+
              "无论在Amiga或PC电脑上. "                                    +#LFCR$+
              "都可以兼容其它的各种'BASIC' 编译器. "                       +#LFCR$+
              "而且学习PureBasic非常的容易! "                              +#LFCR$+
              "所以PureBasic已经获得了初学者和资深程序员的一致好评. "      +#LFCR$+
              "这套软件编译时速度相当快. 并且适用于Windows操作系统. "      +#LFCR$+
              "我们已经投入了大量的技术力量,"                              +#LFCR$+
              "致力于开发一种速度更快,"                                    +#LFCR$+
              "更可靠和更友好的系统语言. "
              
      Text$ = ReplaceString(Text$, "'", #DQUOTE$)
      MovePathCursor(25, 35)
      DrawVectorParagraph(Text$, 500, 200)

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 32
; FirstLine = 12
; EnableXP