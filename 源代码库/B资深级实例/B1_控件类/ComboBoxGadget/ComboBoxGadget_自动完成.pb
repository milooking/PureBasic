;***********************************
;迷路仟整理 2019.01.17
;下拉控件自动完成
;***********************************

Enumeration
   #WinScreen
   #cmbScreen
EndEnumeration


Procedure ComboBox_Autocomplete(GadgetID)  
   Shared LenTextSave.l  
   Shared GadgetSave.l  
   
   TextTyped.s = UCase(GetGadgetText(GadgetID))  
   LenTextTyped.l = Len(TextTyped)  
   
   If GadgetID = GadgetSave And LenTextTyped <= LenTextSave  
      LenTextSave = LenTextTyped  
   ElseIf LenTextTyped  
      GadgetSave = -1  
      MaxItem.l = CountGadgetItems(GadgetID) - 1  
      For Item.l = 0 To MaxItem  
         If TextTyped = UCase(Left(GetGadgetItemText(GadgetID, Item, 0), LenTextTyped))  
            SetGadgetState(GadgetID, Item)  
            hComboEdit.l = ChildWindowFromPoint_(GadgetID(GadgetID), 5|5<<32)  
            SendMessage_(hComboEdit, #EM_SETSEL, LenTextTyped, -1)  
            LenTextSave = LenTextTyped  
            GadgetSave = GadgetID  
            Item = MaxItem  
         EndIf  
      Next  
   EndIf  
EndProcedure  
 

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget
hWindow = OpenWindow(#WinScreen, 0, 0, 400, 250, "下拉控件自动完成", WindowFlags)


KeyWord$ = "Enumeration Structure Procedure Procedure$ ProcedureDLL Interface "+
           "Module Import ImportC Macro DataSection "+
           "EndEnumeration EndStructure EndProcedure EndInterface "+
           "EndModule EndImport EndImportC EndMacro EndDataSection "+
           "If Else ElseIf EndIf Select Case Default EndSelect "+
           "For To Step ForEach Next While Wend Repeat Until ForEver With EndWith "+     
           "ProcedureReturn Break Continue Gosub Return Swap Goto End Runtime Threaded "+
           "StructureUnion EndStructureUnion IncludeFile XIncludeFile IncludeBinary IncludePath "+   
           "Declare DeclareC DeclareCDLL DeclareDLL "+
           "Global Define Protected Shared Static Prototype Pseudotype "+
           "Extends NewList List NewMap Map Dim ReDim Array Data Restore Read "+
           "Debug DebugLevel DisableDebugger CallDebugger EnableDebugger "+
           "CompilerIf CompilerEndIf CompilerElse CompilerElseIf "+
           "CompilerSelect CompilerCase CompilerEndSelect "+
           "CompilerError EnableExplicit EnableASM DisableASM "

hGadget = ComboBoxGadget(#cmbScreen, 120, 050, 160, 20, #PB_ComboBox_Editable)
 
For k = 1 To CountString(KeyWord$, " ")
   AddGadgetItem(#cmbScreen, -1, StringField(KeyWord$, k, " ")) 
Next
  
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_Gadget 
         If EventGadget() = #cmbScreen And EventType() = #PB_EventType_Change
            ComboBox_Autocomplete(#cmbScreen)  
         EndIf 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = 0
; EnableXP