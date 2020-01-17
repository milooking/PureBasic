;***********************************
;迷路仟整理 2019.01.24
;IsInsidePath_矢量路径判断
;***********************************

#winScreen = 0
#cvsScreen = 0
#imgScreen = 0
#fntScreen = 0


Procedure Window_Redrawing()  
    x = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
    y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
    If StartVectorDrawing(CanvasVectorOutput(#cvsScreen))
      VectorSourceColor(RGBA(255, 255, 255, 255))     ; 绘制背景色
      FillVectorOutput()
      
      AddPathEllipse(250, 150, 150, 75)               ; 绘制一个路径
      
      If IsInsideStroke(x, y, 20, #PB_Path_Default, #PB_Coordinate_Device)   ; 判断鼠标是否在路径之内
         VectorSourceColor(RGBA(0, 255, 0, 255))
      Else
         VectorSourceColor(RGBA(0, 0, 255, 255))
      EndIf
      StrokePath(20)                                  ; 填充路径
      StopVectorDrawing()
    EndIf      
EndProcedure



If OpenWindow(#winScreen, 0, 0, 500, 300, "IsInsidePath_矢量路径判断", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 300)
   Window_Redrawing()
   Repeat
      WinEvent = WaitWindowEvent() 
      Select WinEvent
         Case #PB_Event_CloseWindow : IsExitWindow = #True
         Case #PB_Event_Gadget
            If EventGadget() = 0 And EventType() = #PB_EventType_MouseMove
               Window_Redrawing()
            EndIf 
      EndSelect
   Until IsExitWindow = #True
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; FirstLine = 1
; Folding = -
; EnableXP