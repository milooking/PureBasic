;***********************************
;迷路仟整理 2019.02.10
;MoveImage_移动图像
;***********************************

#winScreen = 0
#cvsScreen = 0

Structure __ImageInfo
   ImageID.l
   Rect.rect
EndStructure

Structure __MainInfo
   *pCurrImage.__ImageInfo
   OffsetX.l
   OffsetY.l
EndStructure



Global NewList _ListImage.__ImageInfo()
Global _Main.__MainInfo

Procedure Window_Redrawing()
   If StartDrawing(CanvasOutput(#cvsScreen))
      Box(0, 0, 600, 350, $FFFFFF)
      ForEach _ListImage()
         With _ListImage()
            DrawImage(ImageID(\ImageID), \Rect\left, \Rect\top)
            If _Main\pCurrImage = _ListImage()
               DrawingMode(#PB_2DDrawing_Outlined)
               Box(\Rect\left, \Rect\top, \Rect\right-\Rect\left, \Rect\bottom-\Rect\top, $FF)
            EndIf 
         EndWith
      Next 
      StopDrawing()
   EndIf
EndProcedure

Procedure Window_LoadImage()
   With _ListImage()
      AddElement(_ListImage())
      \ImageID = LoadImage(#PB_Any, #PB_Compiler_Home + "examples/Sources/Data/PureBasicLogo.bmp")
      \Rect\left = 50
      \Rect\top  = 50
      \Rect\right  = \Rect\left + ImageWidth(\ImageID)
      \Rect\bottom = \Rect\top + ImageHeight(\ImageID)
      
      AddElement(_ListImage())
      \ImageID = LoadImage(#PB_Any, "..\PureBasic.bmp")
      \Rect\left = 150
      \Rect\top  = 150
      \Rect\right  = \Rect\left + ImageWidth(\ImageID)
      \Rect\bottom = \Rect\top  + ImageHeight(\ImageID)
   EndWith
EndProcedure

Procedure Window_EventGadget()
   Select EventType()
      Case #PB_EventType_LeftButtonDown
         X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
         ForEach _ListImage()
            With _ListImage()\Rect
               If \left < X And X < \right And \top < Y And Y < \bottom
                  _Main\pCurrImage = _ListImage()
                  _Main\OffsetX = X - \left
                  _Main\OffsetY = Y - \top
                  Window_Redrawing()
                  Break
               EndIf 
            EndWith
         Next 
      Case #PB_EventType_LeftButtonUp
         If _Main\pCurrImage
            _Main\pCurrImage = 0
            _Main\OffsetX = 0
            _Main\OffsetY = 0
            Window_Redrawing()
         EndIf 
         
      Case #PB_EventType_MouseMove
         X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
         If _Main\pCurrImage
            With _Main\pCurrImage\Rect
               \left = X - _Main\OffsetX
               \top  = Y - _Main\OffsetY
               \right  = \left + ImageWidth(_Main\pCurrImage\ImageID)
               \bottom = \top  + ImageHeight(_Main\pCurrImage\ImageID)
               Window_Redrawing()
            EndWith
         EndIf 

   EndSelect
EndProcedure

If OpenWindow(#winScreen, 0, 0, 600, 350, "MoveImage_移动图像", #PB_Window_ScreenCentered|#PB_Window_SystemMenu)
   CanvasGadget(#cvsScreen,0,0, 600, 350) 
   Window_LoadImage()
   Window_Redrawing()
   BindGadgetEvent(#cvsScreen, @Window_EventGadget())
   Repeat
      WinEvent = WaitWindowEvent() 
      Select WinEvent
         Case #PB_Event_CloseWindow : IsExitWindow = #True
      EndSelect
   Until IsExitWindow = #True
EndIf 
ForEach _ListImage()
   If IsImage(_ListImage()\ImageID) : FreeImage(_ListImage()\ImageID) : EndIf 
Next 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 9
; FirstLine = 1
; Folding = j
; EnableXP