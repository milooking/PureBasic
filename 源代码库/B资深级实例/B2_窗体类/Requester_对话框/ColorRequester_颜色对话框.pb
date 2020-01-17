;***********************************
;迷路仟整理 2019.02.11
;ColorRequester_颜色对话框
;***********************************

Enumeration
   #winScreen
   #btnScreen
EndEnumeration


Structure __ColorListInfo 
  Color.l[16] 
EndStructure

CustomColor.__ColorListInfo 
CustomColor\Color[0] = RGB(255,128,0) 
CustomColor\Color[1] = RGB(80,70,60) 

Procedure ChooseColorRequester(hWindow, InitColor, *pColor.__ColorListInfo) 
   Choose.ChooseColor
   Choose\LStructSize  = SizeOf(ChooseColor) 
   Choose\hwndOwner    = hWindow
   Choose\rgbResult    = InitColor 
   Choose\lpCustColors = *pColor 
   Choose\flags        = #CC_ANYCOLOR|#CC_FULLOPEN|#CC_RGBINIT 
   If ChooseColor_(@Choose)  
      ProcedureReturn Choose\rgbResult 
   Else 
      ProcedureReturn -1 
   EndIf 
EndProcedure 


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "ColorRequester_颜色对话框", WindowFlags)
ButtonGadget(#btnScreen, 150, 100, 100, 030, "关于我们")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen
            Color = ChooseColorRequester(hWindow, 0, @CustomColor)
            Debug "颜色值: 0x" + Hex(Color)
            Debug "R : " + Str(Red(Color))         
            Debug "G : " + Str(Green(Color))         
            Debug "B : " + Str(Blue(Color))
         EndIf 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 32
; FirstLine = 17
; Folding = -
; EnableXP