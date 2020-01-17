;***********************************
;迷路仟整理 2019.01.18
;浏览器组合
;***********************************

Enumeration
   #WinScreen
   #ftvScreen
   #flvScreen
EndEnumeration

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 600,400, "浏览器组合", WindowFlags)

ExplorerTreeGadget(#ftvScreen, 010, 10, 200, 340, "*.*", #PB_Explorer_NoFiles)  
ExplorerListGadget(#flvScreen, 220, 10, 370, 340, "*.*", #PB_Explorer_NoFolders|#PB_Explorer_NoParentFolder)  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         Select EventGadget()  
            Case #ftvScreen  
               If EventType() = #PB_EventType_Change  
                  SetGadgetText(#flvScreen, GetGadgetText(#ftvScreen))       
               EndIf  
            Case #flvScreen
               If EventType() = #PB_EventType_LeftDoubleClick  
                  State = GetGadgetState(#flvScreen)
                  FileName$ = GetGadgetItemText(#flvScreen, State ,0) 
                  ShellExecute_(0, "open",GetGadgetText(#flvScreen)+FileName$,0,0,1)  
               EndIf  
         EndSelect
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = -
; EnableXP