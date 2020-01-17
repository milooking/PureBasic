;***********************************
;迷路仟整理 2019.01.29
;Macro_宏代码
;***********************************


;【替换关键词】
Macro MyNot
   Not
EndMacro

a = 0
If MyNot a   ; 相当于'If Not a'
   Debug "OK"
EndIf


;【替换函数】
Macro UMsgBox(Title, Body)
   MessageRequester(Title, UCase(Body), 0)
EndMacro

Text$ = "PureBasic"
UMsgBox("提示", "-"+Text$+"-")

;【替换函数,带默认值】
Macro UMsgBox2(Title, Body = "这里是默认值!")
   MessageRequester(Title, UCase(Body), 0)
EndMacro

UMsgBox2("提示")


;【替换:表达式】
Macro XCase(Type, Text)
   Type#Case(Text)
EndMacro

Debug XCase(U, "Hello")
Debug XCase(L, "Hello")


;【替换:符号】
Macro DoubleQuote
    "
EndMacro


;【替换:代码段】
Macro Assert(Expression)
   If Expression
      Debug "Assert(" + Str(Bool(Expression)) + "): " + DoubleQuote#Expression#DoubleQuote
   EndIf
EndMacro

Assert(10 <> 10) ;条件不成立不显示
Assert(10 <> 15) ;条件成立就显示






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 41
; FirstLine = 17
; Folding = --
; EnableXP