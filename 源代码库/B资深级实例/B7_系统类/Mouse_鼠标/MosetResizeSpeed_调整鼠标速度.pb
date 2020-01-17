;***********************************
;迷路仟整理 2019.02.01
;MosetResizeSpeed_调整鼠标速度
;***********************************

Procedure Mouse_GetSpeed() 
  SystemParametersInfo_(#SPI_GETMOUSESPEED, #Null, @Speed, #Null) 
  ProcedureReturn Speed 
EndProcedure 

Procedure Mouse_SetSpeed(Speed) 
  #SPIF_SENDCHANGE = 2 
  ProcedureReturn SystemParametersInfo_(#SPI_SETMOUSESPEED, #Null, Speed, #SPIF_SENDCHANGE) 
EndProcedure 

#winScreen = 0
#lblScreen = 1
#btnScreen = 2


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "调整鼠标速度", WindowFlags)
TextGadget  (#lblScreen, 100, 080, 200, 030, "")
ButtonGadget(#btnScreen, 150, 110, 100, 030, "移动速度x2")

Speed = Mouse_GetSpeed() 
SetGadgetText(#lblScreen, "当前鼠标移动速度:" + Str(Speed))


Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget
         Select EventGadget()
            Case #btnScreen
                  Debug "调整为2倍移动速度: " + Str(Speed*2)
                  Mouse_SetSpeed(Speed*2) 
                  SetGadgetText(#lblScreen, "速度x2: 5秒后恢复正常!")
                  Delay(1000)    
                  SetGadgetText(#lblScreen, "速度x2: 4秒后恢复正常!")
                  Delay(1000)                  
                  SetGadgetText(#lblScreen, "速度x2: 3秒后恢复正常!")
                  Delay(1000)
                  SetGadgetText(#lblScreen, "速度x2: 2秒后恢复正常!")
                  Delay(1000)
                  SetGadgetText(#lblScreen, "速度x2: 1秒后恢复正常!")
                  Delay(1000)
                  SetGadgetText(#lblScreen, "当前鼠标移动速度:" + Str(Speed))
                  Mouse_SetSpeed(Speed)
         EndSelect
   EndSelect
   Delay(1)
Until IsExitWindow = #True
Mouse_SetSpeed(Speed)
End







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; Folding = -
; EnableXP
; EnableOnError