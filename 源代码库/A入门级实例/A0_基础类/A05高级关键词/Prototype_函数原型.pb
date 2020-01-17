;***********************************
;迷路仟整理 2019.01.28
;Prototype_函数原型
;***********************************

; Prototype.<type> name(<parameter>, [, <parameter> [= DefaultValue]...])
;p-ascii        
;p-utf8
;p-bstr
;p-unicode
;p-variant
  
Prototype.i ProtoMessageBox(Window.i, Body$, Title$, Flags.i = 0)

If OpenLibrary(0, "User32.dll")
   MsgBox.ProtoMessageBox = GetFunction(0, "MessageBoxW")
   MsgBox(0, "你好", "提示")
EndIf



Prototype.i ProtoMessageBoxW(Window.i, Body.p-unicode, Title.p-unicode, Flags.i = 0)

If OpenLibrary(0, "User32.dll")
   MsgBox.ProtoMessageBoxW = GetFunction(0, "MessageBoxW")
   MsgBox(0, "PureBasic", "提示")
EndIf






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 17
; EnableXP