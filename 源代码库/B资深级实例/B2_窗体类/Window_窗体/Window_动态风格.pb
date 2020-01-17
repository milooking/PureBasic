;***********************************
;迷路仟整理 2017.06.09
;窗体动态风格演示
;***********************************

; #AW_HOR_POSITIVE = $1 ;从左往右
; #AW_HOR_NEGATIVE = $2 ;从右往左
; #AW_VER_POSITIVE = $4 ;从上往下
; #AW_VER_NEGATIVE = $8 ;从下往上
; #AW_CENTER = $10      ;折叠, #AW_HIDE:向内折叠,非#AW_HIDE时:向外折叠
; #AW_HIDE = $10000     ;隐藏窗口. 
; #AW_ACTIVATE = $20000 ;激活窗口
; #AW_SLIDE = $40000    ;幻灯片动画
; #AW_BLEND = $80000    ;淡出效果, 顶级窗口有效

#winScreen = 0     
WindowW = (GetSystemMetrics_(#SM_CXSCREEN)-318)/2
WindowH = (GetSystemMetrics_(#SM_CYSCREEN)-220)/2
If OpenWindow(#winScreen,WindowW,WindowH, 318, 220,"窗体动态风格演示", #PB_Window_SystemMenu|#WS_VISIBLE) 
;    AnimateWindow_(WindowID(#winScreen),1000,#AW_HOR_POSITIVE|#AW_VER_POSITIVE) ;从左上角展开
   AnimateWindow_(WindowID(#winScreen),1000,#AW_CENTER) ;向外折叠
   Repeat 
      Select WaitWindowEvent() 
         Case #PB_Event_CloseWindow : IsExitWindow = #True
      EndSelect 
   Until IsExitWindow = #True
   AnimateWindow_(WindowID(#winScreen), 100, #AW_BLEND | #AW_HIDE) 
EndIf 
 
End 
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; EnableXP