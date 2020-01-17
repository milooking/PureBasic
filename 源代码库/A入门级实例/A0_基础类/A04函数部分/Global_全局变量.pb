;***********************************
;迷路仟整理 2019.01.28
;Global_全局变量
;***********************************
;【注】为了规范代码,建议定义全局变量时,
;      全局变量时以下划线_开头,如Global _Value()

; Global[.<type>] <variable[.<type>]> [= <expression>] [, ...]
; 
;【实例1:变量】
Global ValueA.l, ValueB.b, ValueC, ValueD = 20
Global.f Angle, Length.b, Position  ;Angle和Position是单精浮点类型

Procedure Fun_Change1()
   Debug "[函数]: " + ValueA 
EndProcedure

ValueA = 10
Fun_Change1()



;【实例2:指针】
Global *_MemData = AllocateMemory(1024)

Procedure Fun_Change2()
   *pPoint.long = *_MemData
   Debug "[函数]: " + *pPoint\l
EndProcedure 

*pPoint.long = *_MemData
*pPoint\l = 1000
Fun_Change2()



;【实例3:数组】
Global Dim _DimArray(2)
  
Procedure Fun_Change3()
   Debug "[函数]: " + _DimArray(0)
EndProcedure 

_DimArray(0) = 10
Fun_Change3()



;【实例4:链表】
Global NewList _ListTest$()         
  
Procedure Fun_Change4()
   Debug "[函数]: " + _ListTest$()
EndProcedure 
  
AddElement(_ListTest$()) : _ListTest$() = "PureBasic"
Fun_Change4()


;【实例5:映射】
Global NewMap _MapTest$()
  
Procedure Fun_Change5()
   Debug "[函数]: " + _MapTest$("1")
EndProcedure 

_MapTest$("1") = "迷路仟"
Fun_Change5()








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 13
; Folding = -
; EnableXP