;***********************************
;迷路仟整理 2019.01.24
;ConvertCoordinate_坐标值换算
;***********************************

#winScreen = 0
#cvsScreen = 0

;ConvertCoordinateX()/ConvertCoordinateX()

If OpenWindow(#winScreen, 0, 0, 500, 250, "ConvertCoordinate_坐标值换算", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen, 000, 000, 500, 250)

   Repeat
      WinEvent = WaitWindowEvent() 
      Select WinEvent
         Case #PB_Event_CloseWindow : IsExitWindow = #True
         Case #PB_Event_Gadget
            If EventGadget() = #cvsScreen
               If EventType() = #PB_EventType_LeftButtonDown
               
                  If StartVectorDrawing(CanvasVectorOutput(#cvsScreen, #PB_Unit_Point))
                     RotateCoordinates(0, 0, 30)   ;旋转坐标系
                     
                     CanvasX = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
                     CanvasY = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
                     
                     ;将鼠标的坐标转换成旋转后坐标系中的新坐标值
                     DrawingX = ConvertCoordinateX(CanvasX, CanvasY, #PB_Coordinate_Device, #PB_Coordinate_User)
                     DrawingY = ConvertCoordinateY(CanvasX, CanvasY, #PB_Coordinate_Device, #PB_Coordinate_User)
                     
                     AddPathCircle(DrawingX, DrawingY, 10)
                     VectorSourceColor(RGBA(Random(255), Random(255), Random(255), 255))
                     FillPath()
                     
                     StopVectorDrawing()
                  EndIf

               
               
               EndIf 
            EndIf 
      EndSelect
   Until IsExitWindow = #True
EndIf 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; FirstLine = 6
; EnableXP