;***********************************
;迷路仟整理 2019.01.20
;分页控件页面尺寸
;***********************************


Enumeration
   #winScreen
   #pnlScreen
EndEnumeration



WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "分页控件页面尺寸", WindowFlags)
hGadget = PanelGadget(#pnlScreen, 10, 10, 380, 230)
   AddGadgetItem (#pnlScreen, -1, "分页项1")
   AddGadgetItem (#pnlScreen, -1, "分页项2")
CloseGadgetList()

Index = 0 
Item.TC_ITEM\mask = #TCIF_PARAM  
If SendMessage_(hGadget, #TCM_GETITEM, Index, @Item)  
   GetClientRect_(Item\lParam,Rect.RECT)  
   Debug "页面尺寸-宽: " + Str(Rect\right-Rect\left)
   Debug "页面尺寸-高: " + Str(Rect\bottom-Rect\top)
EndIf  
   

Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
   EndSelect
   Delay(1)
Until IsExitWindow = #True

End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 28
; Folding = -
; EnableXP