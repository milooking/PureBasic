;***********************************
;迷路仟整理 2019.01.16
;菜单_光标在上
;***********************************


#winScreen = 0
#wmbScreen = 1
#lblScreen = 2

Procedure Window_Callback(hWindow, uMsg, wParam, lParam)  
   Result = #PB_ProcessPureBasicEvents  
   Select uMsg 
      Case #WM_MENUSELECT 
         Select wParam & $FFFF
            Case 1 : SetGadgetText(#lblScreen, "提示: 加载文件!")
            Case 2 : SetGadgetText(#lblScreen, "提示: 保存文件!")
            Case 3 : SetGadgetText(#lblScreen, "提示: 文件另存为!")
            Case 4 : SetGadgetText(#lblScreen, "提示: 退出工具!")
            Case 5 : SetGadgetText(#lblScreen, "提示: 剪切!")
            Case 6 : SetGadgetText(#lblScreen, "提示: 复制!")
            Case 7 : SetGadgetText(#lblScreen, "提示: 粘贴!")
         EndSelect
   EndSelect 
   ProcedureReturn Result  
EndProcedure  
 


WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "菜单_光标在上", WindowFlags)

If CreateMenu(#wmbScreen, hWindow)
   MenuTitle("文件(&F)")       
      MenuItem(1, "加载(&L)")  
      MenuItem(2, "保存(&S)")
      MenuItem(3, "另存为...")
      MenuBar()
      MenuItem(4, "退出(&Q)")
      
   MenuTitle("编辑(&E)") 
      MenuItem(5, "剪切")  
      MenuItem(6, "复制")   
      MenuItem(7, "粘贴")  
EndIf


TextGadget(#lblScreen, 100, 110, 200, 30, "", #PB_Text_Center)

SetWindowCallback(@Window_Callback()) 
  
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP