;***********************************
;迷路仟整理 2019.01.21
;设置/获取控件属性
;***********************************

Enumeration
   #winScreen
   #lstScreen
   #imgScreen
EndEnumeration

;各种支持设置属性的控件及属性类型,具体说明要参考帮助文档
; ButtonImageGadget()      ;#PB_Button_Image,#PB_Button_PressedImage
; CalendarGadget()         ;#PB_Calendar_Minimum,#PB_Calendar_Maximum
; CanvasGadget()           ;#PB_Canvas_MouseX,#PB_Canvas_MouseY,#PB_Canvas_Buttons,#PB_Canvas_Modifiers,#PB_Canvas_WheelDelta,
                           ;#PB_Canvas_Key,#PB_Canvas_Input,#PB_Canvas_Image,#PB_Canvas_Clip,#PB_Canvas_Cursor,#PB_Canvas_CustomCursor  
; DateGadget()             ;#PB_Date_Minimum,#PB_Date_Maximum
; EditorGadget()           ;#PB_Editor_ReadOnly,#PB_Editor_WordWrap 
; ExplorerListGadget()     ;#PB_Explorer_DisplayMode
; ListIconGadget()         ;#PB_ListIcon_DisplayMode
; OpenGLGadget()           ;#PB_OpenGL_MouseX,#PB_OpenGL_MouseY,#PB_OpenGL_Buttons,#PB_OpenGL_Modifiers,#PB_OpenGL_WheelDelta,
                           ;#PB_OpenGL_Key,#PB_OpenGL_Input,#PB_OpenGL_Cursor,#PB_OpenGL_CustomCursor,#PB_OpenGL_SetContext,#PB_OpenGL_FlipBuffers
; PanelGadget()            ;#PB_Panel_ItemWidth,#PB_Panel_ItemHeight,#PB_Panel_TabHeight
; ProgressBarGadget()      ;#PB_ProgressBar_Minimum,#PB_ProgressBar_Maximum
; ScrollAreaGadget()       ;#PB_ScrollArea_InnerWidth,#PB_ScrollArea_InnerHeight,#PB_ScrollArea_X,#PB_ScrollArea_Y,#PB_ScrollArea_ScrollStep
; ScrollBarGadget()        ;#PB_ScrollBar_Minimum,#PB_ScrollBar_Maximum,#PB_ScrollBar_PageLength
; SpinGadget()             ;#PB_Spin_Minimum,#PB_Spin_Maximum
; SplitterGadget()         ;#PB_Splitter_FirstMinimumSize,#PB_Splitter_SecondMinimumSize,#PB_Splitter_FirstGadget,#PB_Splitter_SecondGadget
; StringGadget()           ;#PB_String_MaximumLength
; TrackBarGadget()         ;#PB_TrackBar_Minimum,#PB_TrackBar_Maximum
; WebGadget()              ;#PB_Web_ScrollX,#PB_Web_ScrollY,#PB_Web_BlockPopups,#PB_Web_BlockPopupMenu,#PB_Web_NavigationCallback

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "设置/获取控件属性", WindowFlags)

hImage = LoadImage(#imgScreen, "PureBasic.ico")                          
ListIconGadget(#lstScreen, 010, 010, 380, 230, "内容", 100) 
SetGadgetAttribute(#lstScreen, #PB_ListIcon_DisplayMode, #PB_ListIcon_LargeIcon)
For Row = 1 To 100 
   AddGadgetItem(#lstScreen, Row, "子项-"+Str(Row), hImage)
Next

Debug "Attribute = " + GetGadgetAttribute(#lstScreen, #PB_ListIcon_DisplayMode)


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 11
; Folding = -
; EnableXP