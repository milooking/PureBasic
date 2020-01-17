;***********************************
;迷路仟整理 2019.02.10
;PathSegments_公路线样式
;***********************************

#winScreen = 0
#cvsScreen = 0

If OpenWindow(#winScreen, 0, 0, 400, 250, "PathSegments_公路线样式", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 400, 250)
   If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
   
      ;绘制一条路径,即打底
      MovePathCursor(40, 60)                 
      AddPathArc(100, 140, 160, 020, 020)    
      AddPathArc(160, 020, 220, 180, 020)
      AddPathArc(044, 117, 104, 058, 020, #PB_Path_Relative) 
      AddPathArc(280, 080, 340, 120, 020)
      AddPathLine(340, 120)                    
      VectorSourceColor(RGBA(255, 0, 0, 255))  
      Segments$ = PathSegments()                   ;记录这种路径
      StrokePath(11)                           

      Debug Segments$
      ;在相同路径上覆盖上宽度更小的白色
      AddPathSegments(Segments$)                   
      VectorSourceColor(RGBA(255, 255, 255, 255))  
      StrokePath(5)   
         
      StopVectorDrawing()
   EndIf 
   Repeat
      WinEvent = WaitWindowEvent() 
   Until WinEvent = #PB_Event_CloseWindow 
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; EnableXP