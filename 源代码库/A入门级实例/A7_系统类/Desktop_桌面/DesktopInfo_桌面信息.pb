;***********************************
;迷路仟整理 2019.01.25
;DesktopInfo_桌面信息
;***********************************


CountDesktops = ExamineDesktops()
MessageRequester("提示", "你有 ["+Str(CountDesktops)+"] 个桌面")

For k= 0 To CountDesktops-1
   Text$ = "桌面 - "+Str(k+1)+#LF$+#LF$
   Text$ + "名称: "+DesktopName(k)+#LF$
   Text$ + "大小: "+Str(DesktopWidth(k))+"*"+Str(DesktopHeight(k))+#LF$
   Text$ + "色深: "+Str(DesktopDepth(k))+#LF$
   If DesktopFrequency(k) = 0
      Text$ + "刷新率: 默认"+#LF$+#LF$
   Else
      Text$ + "刷新率: "+Str(DesktopFrequency(k))+" Hz"+#LF$+#LF$
   EndIf
   MessageRequester("提示", Text$)
   
Next

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 5
; EnableXP