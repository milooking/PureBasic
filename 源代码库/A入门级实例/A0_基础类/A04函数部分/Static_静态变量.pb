;***********************************
;迷路仟整理 2019.01.28
;Static_静态变量
;***********************************



;【实例1:变量】
Global _Value
_Value = 10
Procedure Fun_Change1()
   Static _Value           ; 与外面的全局变量起隔离作用,变有记忆功能,每次调试,都可以累加
   _Value + 1
   Debug "[函数]: " + _Value
EndProcedure 

Fun_Change1()
Fun_Change1()
Fun_Change1()
Debug "[外部]: " + _Value


;【实例2:指针】
Global *MemData = AllocateMemory(1024)
*pPoint.long = *MemData
*pPoint\l = 1000

Procedure Fun_Change2()
   Static *MemData  
   If *MemData = 0
      *MemData = AllocateMemory(1024)  
   EndIf 
   *pPoint.long = *MemData
   *pPoint\l + 1111
   Debug "[函数]: " + *pPoint\l
EndProcedure 

Fun_Change2()
Fun_Change2()
Fun_Change2()
Debug "[外部]: " + *pPoint\l


;【实例3:数组】
Global Dim _DimArray(2)
_DimArray(0) = 10
  
Procedure Fun_Change3()
   Static Dim _DimArray(2) 
   _DimArray(0) + 10 
   Debug "[函数]: " + _DimArray(0)
EndProcedure 
  
Fun_Change3()
Fun_Change3()
Fun_Change3()
Debug "[外部]: " + _DimArray(0) 


;【实例4:链表】
Global NewList _ListTest$()
AddElement(_ListTest$()) : _ListTest$() = "PureBasic"
  
Procedure Fun_Change4()
   Static NewList _ListTest$() 
   AddElement(_ListTest$()) : _ListTest$() = "迷路仟"
   Debug "[函数]: " + _ListTest$()
EndProcedure 
  
Fun_Change4()
Fun_Change4()
Fun_Change4()
Debug "[外部]: " + _ListTest$() 


;【实例5:映射】
Global NewMap _MapTest$()
_MapTest$("1") = "PureBasic"
  
Procedure Fun_Change5()
   Static NewMap _MapTest$() 
   _MapTest$("1") =  "迷路仟"+Str(Random(10))
   Debug "[函数]: " + _MapTest$("1")
EndProcedure 
  
Fun_Change5()
Fun_Change5()
Fun_Change5()
Debug "[外部]: " + _MapTest$() 












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 4
; Folding = -
; EnableXP