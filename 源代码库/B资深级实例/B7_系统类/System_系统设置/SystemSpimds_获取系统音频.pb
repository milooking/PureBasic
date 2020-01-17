;***********************************
;迷路仟整理 2019.03.15
;SystemSpimds_获取系统音频
;***********************************



Debug "系统星号(Stern)"  
PlaySound_("SystemAsterisk",0, #SND_ALIAS|#SND_NODEFAULT|#SND_NOWAIT|#SND_ASYNC  )  
Delay(500)  
Debug "系统感叹号(Advice)"  
PlaySound_("SystemExclamation",0, #SND_ALIAS|#SND_NODEFAULT|#SND_NOWAIT |#SND_ASYNC )  
Delay(500)  
Debug "系统退出(Systemstart)"  
PlaySound_("SystemExit",0, #SND_ALIAS|#SND_NODEFAULT|#SND_NOWAIT |#SND_ASYNC  )  
Delay(500)  
Debug "系统方面(Kritischer Abbruch)"  
PlaySound_("SystemHand",0, #SND_ALIAS|#SND_NODEFAULT|#SND_NOWAIT |#SND_ASYNC  )  
Delay(500)  
Debug "系统问题(Frage)"  
PlaySound_("SystemQuestion",0, #SND_ALIAS|#SND_NODEFAULT|#SND_NOWAIT |#SND_ASYNC  )  
Delay(500)  
Debug "系统开始(System-Start)"  
PlaySound_("SystemStart",0, #SND_ALIAS|#SND_NODEFAULT|#SND_NOWAIT|#SND_ASYNC   )  
Delay(500) 


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 26
; EnableXP
; EnableOnError