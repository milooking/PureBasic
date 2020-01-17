;***********************************
;迷路仟整理 2019.01.31
;MouseSelection_鼠标选择域
;***********************************

#winScreen = 0
#lblScreen = 0

Structure __SelectionInfo
   Start.POINTS
   Last.POINTS
   Rect.RECT
   Selected.l
EndStructure

Global _Selection.__SelectionInfo

Procedure Showing_Selection(x,y,width,height) 
   With _Selection\Rect
      Text$ = "选择域: " + Str(x)+","+Str(y)+" - " + Str(width)+","+Str(height)
      SetGadgetText(#lblScreen, Text$) 
   EndWith
EndProcedure  

Procedure Drawing_Selection(hWindow)  

   With _Selection
;       ;方法1
;       If \Start\x > \Last\x  
;          \Rect\left   = \Last\x  
;          \Rect\right  = \Start\x 
;       Else  
;          \Rect\left   = \Start\x  
;          \Rect\right  = \Last\x 
;       EndIf  
;       
;       If \Start\y > \Last\y  
;          \Rect\top    = \Last\y  
;          \Rect\bottom = \Start\y 
;       Else  
;          \Rect\top    = \Start\y  
;          \Rect\bottom = \Last\y 
;       EndIf 
       
      ;方法2
      \Rect\left   = \Last\x : \Rect\right  = \Start\x 
      If \Start\x < \Last\x  : Swap \Rect\left, \Rect\right : EndIf 

      \Rect\top   = \Last\y : \Rect\bottom  = \Start\y 
      If \Start\y < \Last\y  : Swap \Rect\top, \Rect\bottom : EndIf 
      
      hWindowDC = GetDC_(hWindow)  
         DrawFocusRect_(hWindowDC, @\Rect)  
      ReleaseDC_(hWindow, hWindowDC)  
   EndWith
EndProcedure  
  
Procedure Window_CallBack(hWindow, uMsg, wParam, lParam)  
   
   With _Selection
      Select uMsg  
         Case #WM_LBUTTONDOWN 
            \Selected  = 1  
;             ;方法1
;             \Start\x   = lParam & $FFFF  
;             \Start\y   = (lParam>>16) & $FFFF 
            ;方法2
            CopyMemory_(\Start, @lParam, 4) 

            GetClientRect_(hWindow,WinRect.RECT)  
            MapWindowPoints_(hWindow,0,WinRect,2)  
            ClipCursor_(WinRect) 
             
         Case #WM_LBUTTONUP  
            If \Selected > 1  
               Drawing_Selection(hWindow)  
               If \Rect\left <> \Rect\right And \Rect\top <> \Rect\bottom  
                  Showing_Selection(\Rect\left,\Rect\top,\Rect\right-\Rect\left,\Rect\bottom-\Rect\top)  
                  SetCapture_(0)  
               EndIf  
            EndIf  
            ClipCursor_(0)  
            \Selected = 0  
            
         Case #WM_MOUSEMOVE  
            If \Selected > 0 And wParam & #MK_LBUTTON  
               If \Selected > 1  
                  Drawing_Selection(hWindow)  
               Else  
                  \Selected + 1  
               EndIf  
;                ;方法1
;                \Last\X = lParam&$FFFF  
;                \Last\Y = (lParam>>16)&$FFFF 
               ;方法2
               CopyMemory_(\Last, @lParam, 4) 
               Drawing_Selection(hWindow)  
               If \Rect\left <> \Rect\right And \Rect\top <> \Rect\bottom  
                  Showing_Selection(\Rect\left,\Rect\top,\Rect\right-\Rect\left,\Rect\bottom-\Rect\top)  
               EndIf  
               SetCapture_(hWindow)  
            EndIf  
      EndSelect 
   EndWith 
   ProcedureReturn #PB_ProcessPureBasicEvents  
EndProcedure  
 
WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "鼠标选择域", WindowFlags)
TextGadget(#lblScreen, 100, 100, 200, 015, "")
SetWindowCallback(@Window_CallBack())  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1
; Folding = z
; EnableXP
; EnableOnError