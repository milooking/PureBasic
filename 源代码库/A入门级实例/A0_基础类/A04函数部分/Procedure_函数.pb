;***********************************
;迷路仟整理 2019.01.28
;Procedure 函数
;***********************************

; Procedure[.<type>] name(<parameter1[.<type>]> [, <parameter2[.<type>] [= DefaultValue]>, ...]) 
;   ...
;   [ProcedureReturn value]
; EndProcedure 


;【实例1:数值变量】
Procedure Maximum(Value1, Value2)
   If Value1 > Value2
      Result = Value1
    Else
      Result = Value2
   EndIf
   ProcedureReturn Result
EndProcedure 
  
Result = Maximum(15, 30)
Debug "[实例1]: " + Result


;【实例2:字符串变量】
Procedure$ Attach(String1$, String2$)
   ProcedureReturn String1$+" "+String2$
EndProcedure 

Result$ = Attach("PureBasic", "Editor")
Debug "[实例2]: " + Result$


;【实例3:默认值】
Procedure Function(a, b, c=2)
   Debug "[实例3]: " + c
EndProcedure

Function(10, 12)      ; C可以不用填写,这时,启用的是2这个默认值
Function(10, 12, 15) 


;【实例4:指针】
Procedure Fun_Point(*pPoint.POINT)
   Debug "[实例4]: " + *pPoint\x
   Debug "[实例4]: " + *pPoint\y
EndProcedure

Point.POINT
Point\x = 99
Point\y = 11
Fun_Point(Point) ; 此处是简写,完整的写法: Fun_Point(@Point) 

;【实例5:数组】
Procedure Fun_Change5(Array DimArray(1))
   Debug "[实例5]: " + DimArray(0)
EndProcedure 

Dim DimValue(2)
DimValue(0) = 10 
Fun_Change5(DimValue())


;【实例6:链表】
Procedure Fun_Change6(List ListTest$())
   Debug "[实例6]: " + ListTest$()
EndProcedure 
  
NewList ListTest$()         
AddElement(ListTest$()) : ListTest$() = "PureBasic"
Fun_Change6(ListTest$())



;【实例7:映射】
Procedure Fun_Change7(Map MapTemp$())
   Debug "[实例7]: " + MapTemp$("1")
EndProcedure 

NewMap MapTest$()

MapTest$("1") = "迷路仟"
Fun_Change7(MapTest$())



;【实例8:Call】
Procedure Fun_Change8(Value)
   Debug "[实例8]: " + Value
EndProcedure 

Value = 12345
CallFunctionFast(@Fun_Change8(), Value)






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 92
; FirstLine = 57
; Folding = g-
; EnableXP