;***********************************
;迷路仟整理 2019.01.18
;ListIconGadget_标题栏图标1
;***********************************
Enumeration
   #winScreen 
   #lstScreen
   #imgScreen
EndEnumeration


#HDI_IMAGE           = 32
Procedure SetHeaderImage(hGadget.l, ImageIndex, Column.l, Align.l)  
  TextColumn.s = Space(255)  
  Var.LVCOLUMN
  Var\mask       = #LVCF_TEXT  
  Var\pszText    = @TextColumn  
  Var\cchTextMax = 255  
  SendMessage_(hGadget, #LVM_GETCOLUMN, Column, @Var)  
  VarHeader.HDITEM
  VarHeader\mask = #HDI_IMAGE | #HDI_FORMAT | #HDI_TEXT  
  VarHeader\fmt = #HDI_IMAGE | Align | #HDF_STRING  
  VarHeader\iImage = ImageIndex 
  VarHeader\pszText = @TextColumn  
  VarHeader\cchTextMax = Len(TextColumn)  
  hHeader = SendMessage_(hGadget, #LVM_GETHEADER, 0, 0)  
  SendMessage_(hHeader, #HDM_SETITEM, Column, @VarHeader)  
EndProcedure  


WindowFlags = #PB_Window_SystemMenu|#PB_Window_ScreenCentered
OpenWindow(#winScreen,0,0,500,250,"ListIconGadget_标题栏图标1",WindowFlags) 

   hGadget = ListIconGadget(#lstScreen,010,010,480,230,"列-1",110, #PB_ListIcon_FullRowSelect) 
   AddGadgetColumn(#lstScreen, 1, "列-2",110)
   AddGadgetColumn(#lstScreen, 2, "列-3",110)
   
   For i = 1 To 10
      AddGadgetItem (#lstScreen, -1, "子项-" + Str(i)+#LF$+"子项-" + Str(i)+#LF$+"子项-" + Str(i), 0)
   Next
    
   hSmallIcon = ImageList_Create_(16, 16, #ILC_MASK | #ILC_COLOR32, 0, 30)
   SendMessage_(hGadget, #LVM_SETIMAGELIST, #LVSIL_SMALL, hSmallIcon) 
   
   hImage = LoadImage(#imgScreen, "Small.ico")
   IconIndex = ImageList_AddIcon_(hSmallIcon, hImage)
   
   IconIndex = ImageList_AddIcon_(hSmallIcon, hImage)
   FreeImage(#imgScreen)  

   SetHeaderImage(hGadget, IconIndex, 2, 0) 
   SetHeaderImage(hGadget, IconIndex, 0, #HDF_BITMAP_ON_RIGHT) 

Repeat 
   Select WaitWindowEvent() 
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect 
Until IsExitWindow = #True

ImageList_Destroy_(hSmallIcon)  



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP
; EnableUnicode