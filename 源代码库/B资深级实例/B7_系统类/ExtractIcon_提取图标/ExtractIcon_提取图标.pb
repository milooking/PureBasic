;***********************************
;迷路仟整理 2019.03.15
;ExtractIcon_提取图标
;***********************************

Enumeration
   #winScreen
   #cvsScreen
EndEnumeration

NewList ListhIcon()
SystemPath$ = Space(255) 
Result = GetSystemDirectory_(SystemPath$,255) 

DllPath$ = SystemPath$+"\User32.dll"
DllPath$ = SystemPath$+"\SetupAPI.dll"
DllPath$ = SystemPath$+"\shell32.dll"


WindowW = 380*2
WindowH = 380
WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, WindowW, WindowH, "ExtractIcon_提取图标", WindowFlags)
CanvasGadget(#cvsScreen, 0, 0, WindowW, WindowH)

Debug "图标数量:" + ExtractIconEx_(DllPath$,-1,0,0,0) 
If StartDrawing(CanvasOutput(#cvsScreen))
   Box(0, 0, WindowW, WindowH, $FFFFFF)
   For r = 0 To 9
      For c = 0 To 19
         hIcon = ExtractIcon_(0, DllPath$, Index)
         If hIcon
            AddElement(ListhIcon()) : ListhIcon() = hIcon
            DrawImage(hIcon, 10+c*36, 10+r*36)
         Else 
            Break
         EndIf 
         Index+1
      Next 
   Next 
   StopDrawing()
EndIf 
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
   EndSelect
   Delay(1)
Until IsExitWindow = #True

ForEach ListhIcon()
   DestroyIcon_(ListhIcon())
Next 

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 25
; FirstLine = 9
; Folding = -
; EnableXP
; EnableOnError