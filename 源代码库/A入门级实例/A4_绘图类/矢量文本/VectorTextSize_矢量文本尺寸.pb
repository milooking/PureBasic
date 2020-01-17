;***********************************
;迷路仟整理 2019.01.24
;VectorTextSize_矢量文本尺寸
;***********************************

;VectorTextWidth()
;VectorTextHeight()


#winScreen = 0
#cvsScreen = 0
#fntScreen = 0


hFont = LoadFont(#fntScreen, "宋体", 90, #PB_Font_Bold)

If OpenWindow(#winScreen, 0, 0, 500, 200, "VectorTextSize_矢量文本尺寸", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 200)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      Text$ = "PureBasic"
      VectorFont(hFont,90)
      MovePathCursor(25, 25)
      DrawVectorText(Text$)

     ;绘制矢量文本外框
      AddPathBox(25, 25, VectorTextWidth(Text$), VectorTextHeight(Text$))
      VectorSourceColor(RGBA(0, 0, 255, 255))
      DashPath(2, 10)

     ;绘制矢量文本内框
      AddPathBox(25 + VectorTextWidth (Text$, #PB_VectorText_Visible|#PB_VectorText_Offset), 
                 25 + VectorTextHeight(Text$, #PB_VectorText_Visible|#PB_VectorText_Offset), 
                 VectorTextWidth (Text$, #PB_VectorText_Visible), 
                 VectorTextHeight(Text$, #PB_VectorText_Visible))
      VectorSourceColor(RGBA(255, 0, 0, 255))
      DashPath(2, 10)    

      ;绘制矢量文本基准线
      MovePathCursor(25, 25 + VectorTextHeight(Text$, #PB_VectorText_Baseline))
      AddPathLine(VectorTextWidth(Text$), 0, #PB_Path_Relative)
      VectorSourceColor(RGBA(0, 255, 0, 255))
      DashPath(2, 10)   

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; FirstLine = 3
; EnableXP