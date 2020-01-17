;***********************************
;迷路仟整理 2019.02.01
;MouseSwapButton_切换左右键
;***********************************

Enumeration
   #winScreen
   #btnScreen1
   #btnScreen2
EndEnumeration


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "切换左右键", WindowFlags)

ButtonGadget(#btnScreen1, 150, 080, 100, 030, "左键点击:切换", #PB_Button_Toggle)
ButtonGadget(#btnScreen2, 150, 120, 100, 030, "左键点击测试")

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
         Select EventGadget()
            Case #btnScreen1 
               If GetGadgetState(#btnScreen1)
                  SwapMouseButton_(#True)
                  SetGadgetText(#btnScreen1, "右键点击:还原")
                  SetGadgetText(#btnScreen2, "右键点击测试")
               Else 
                  SwapMouseButton_(#False)
                  SetGadgetText(#btnScreen1, "左键点击:切换")
                  SetGadgetText(#btnScreen2, "左键点击测试")
               EndIf 
            
            Case #btnScreen2 : 
               Debug "影响事件!"
         EndSelect
   EndSelect
   Delay(1)
Until IsExitWindow = #True
SwapMouseButton_(#False)
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP
; EnableOnError