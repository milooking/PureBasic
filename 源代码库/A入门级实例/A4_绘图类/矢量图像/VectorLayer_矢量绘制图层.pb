;***********************************
;迷路仟整理 2019.01.24
;VectorLayer_矢量绘制图层
;***********************************

#winScreen = 0
#cvsScreen = 0
#imgScreen = 0
#fntScreen = 0

hFont = LoadFont(#fntScreen, "宋体", 20, #PB_Font_Bold)

If OpenWindow(#winScreen, 0, 0, 500, 300, "VectorLayer_矢量绘制图层", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 300)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      
      MovePathCursor(50, 100)
      VectorFont(hFont, 90)
      VectorSourceColor(RGBA(255, 128, 0, 255))
      DrawVectorText("PureBasic")
   
        

      ; 基础层: 内容是半透明效果
      MovePathCursor(50, 50)
      AddPathCircle(75, 150, 60)      
      VectorSourceColor(RGBA(255, 0, 0, 127))
      FillPath()      
      AddPathCircle(125, 100, 60)
      VectorSourceColor(RGBA(0, 0, 255, 127))
      FillPath()    
      
      ; 子层,层效果是半透明的,内容是非透明的
      BeginVectorLayer(127)
        AddPathCircle(275, 100, 60)    
        VectorSourceColor(RGBA(255, 0, 0, 255))
        FillPath()        
        AddPathCircle(325, 150, 60)
        VectorSourceColor(RGBA(0, 0, 255, 255))
        FillPath()    
      EndVectorLayer()

      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; EnableXP