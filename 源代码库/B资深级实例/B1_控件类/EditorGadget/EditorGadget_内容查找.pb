;***********************************
;迷路仟整理 2019.01.17
;内容查找
;***********************************

Enumeration
   #WinScreen
   #rtxScreen
   #txtScreen
   #btnScreen
EndEnumeration

#CFM_BACKCOLOR = $4000000  
#SCF_ALL = 4  

Procedure Editor_FindText(hGadget, FindText$)  
   SendMessage_(hGadget, #EM_SETSEL, 0, 0)  
   Format.CHARFORMAT2  
   Format\cbSize = SizeOf(CHARFORMAT2)  
   Format\dwMask = #CFM_BACKCOLOR  
   Format\crBackColor = RGB(255, 255, 255)  
   SendMessage_(hGadget, #EM_SETCHARFORMAT, #SCF_ALL, Format)  
  
   Find.FINDTEXT  
   Find\chrg\cpMin = 0 
   Find\chrg\cpMax = -1  

   Result.CHARFORMAT2  
   Result\cbSize = SizeOf(CHARFORMAT2)  
   Result\dwMask = #CFM_BACKCOLOR  
   Result\crBackColor = RGB(128, 200, 200)
    
   For i = 1 To CountString(FindText$, " ")+1  
      Find\chrg\cpMin = 0  
      CurrFind$ = StringField(FindText$, i, " ")  
      Find\lpstrText = @CurrFind$  
      Repeat  
         Pos = SendMessage_(hGadget, #EM_FINDTEXT, #FR_DOWN, Find)  
         If Pos > -1  
            Find\chrg\cpMin = Pos+1  
            SendMessage_(hGadget, #EM_SETSEL, Pos, Pos + Len(CurrFind$))  
            SendMessage_(hGadget, #EM_SETCHARFORMAT, #SCF_SELECTION | #SCF_WORD, Result)  
         EndIf  
      Until Pos = -1  
   Next i  
   SendMessage_(hGadget, #EM_SETSEL, 0, 0)  
EndProcedure  

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "内容查找", WindowFlags)

EditorGadget (#rtxScreen, 005, 005, 390, 160)
SetGadgetText(#rtxScreen, "PureBasic 5.62版本"+#CRLF$+"欢迎使用[迷路PureBasic实例库工具]")

StringGadget (#txtScreen, 150, 180, 100, 020, "Purebasic")  
ButtonGadget (#btnScreen, 150, 210, 100, 030, "查找")  

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #btnScreen  
            Editor_FindText(GadgetID(#rtxScreen), GetGadgetText(#txtScreen))  
         EndIf  
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 49
; FirstLine = 2
; Folding = 0
; EnableXP