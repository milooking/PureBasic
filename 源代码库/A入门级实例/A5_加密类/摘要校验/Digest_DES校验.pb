;***********************************
;迷路仟整理 2019.01.23
;Digest_DES校验
;***********************************

;非主流校验,实际应用不多


String$ = "欢迎使用 [迷路PureBasic实例库工具]! "
txtKey$ = "PureBasic"
Result$ = DESFingerprint(String$, txtKey$)
Debug "DES校验: "+Result$








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 16
; EnableXP