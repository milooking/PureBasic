;***********************************
;迷路仟整理 2019.03.14
;DragImage_拖放图像
;***********************************

Enumeration
   #winScreen
   #picSource
   #picTarget1
   #picTarget2
   #picTarget3
   
   #imgSource
   #imgTarget
EndEnumeration


hImage = LoadImage(#imgSource, "..\PureBasic.bmp")
WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 420, 250, "DragImage_拖放图像", WindowFlags)

ImageGadget(#picSource,  170, 020, 060, 060, hImage, #PB_Image_Border) 
ImageGadget(#picTarget1, 020, 120, 060, 060, 0, #PB_Image_Border) 
ImageGadget(#picTarget2, 170, 120, 060, 060, 0, #PB_Image_Border) 
ImageGadget(#picTarget3, 320, 120, 060, 060, 0, #PB_Image_Border) 
    
EnableGadgetDrop(#picTarget1, #PB_Drop_Image, #PB_Drag_Copy)
EnableGadgetDrop(#picTarget2, #PB_Drop_Image, #PB_Drag_Copy)
EnableGadgetDrop(#picTarget3, #PB_Drop_Image, #PB_Drag_Copy)
      
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      
      ;拖放源事件
      Case #PB_Event_Gadget
         If EventType() = #PB_EventType_DragStart
            Select EventGadget()
               Case #picSource
                  DragImage(hImage)
            EndSelect
         EndIf 
      
      ;拖放目标事件
      Case #PB_Event_GadgetDrop
         GadgetID = EventGadget()
         Select GadgetID
            Case #picTarget1, #picTarget2, #picTarget3
               If EventDropImage(0)
                  SetGadgetState(GadgetID, hImage)
               EndIf
         EndSelect

   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 45
; FirstLine = 15
; Folding = -
; EnableXP