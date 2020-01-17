;***********************************
;迷路仟整理 2019.03.28
;CanvasGadget_拖放效果
;***********************************

Enumeration
   #winScreen
   #cvsScreen1
   #cvsScreen2
EndEnumeration

Procedure EventGadget_cvsScreen1()

   Select EventType()
      Case #PB_EventType_MouseMove  
         If GetGadgetAttribute(#cvsScreen1, #PB_Canvas_Buttons) = #PB_Canvas_LeftButton
            DragPrivate(1, #PB_Drag_Copy)
         EndIf 
   EndSelect
EndProcedure

Procedure EventWindow_GadgetDrop()
   Select EventGadget()
      Case #cvsScreen2
         If StartDrawing(CanvasOutput(#cvsScreen1))
            ImageID = GrabDrawingImage(#PB_Any, 000, 000, 180, 180)
            StopDrawing()
         EndIf 
         If ImageID
            If StartDrawing(CanvasOutput(#cvsScreen2))
               DrawImage(ImageID(ImageID), 0, 0)
               StopDrawing()
            EndIf 
            FreeImage(ImageID)
         EndIf 
   EndSelect
EndProcedure

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "CanvasGadget_拖放效果", WindowFlags)
CanvasGadget(#cvsScreen1, 010, 010, 180, 180)
CanvasGadget(#cvsScreen2, 200, 010, 180, 180)
If StartDrawing(CanvasOutput(#cvsScreen1))
   For x = 0 To 85 Step 10
      Box(x, y, 180-2*x, 180-2*y, RGB(Random(255), Random(255), Random(255)))
      y + 10
   Next
   StopDrawing()
EndIf

EnableGadgetDrop(#cvsScreen1, #PB_Drop_Private, #PB_Drag_Copy, 1)
EnableGadgetDrop(#cvsScreen2, #PB_Drop_Private, #PB_Drag_Copy, 1)
BindGadgetEvent(#cvsScreen1, @EventGadget_cvsScreen1()) 
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_GadgetDrop  : EventWindow_GadgetDrop()
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 37
; Folding = 6
; EnableXP