;***********************************
;迷路仟整理 2019.01.28
;Shared_共享变量
;***********************************

;【实例1:变量】
_Value = 10

Procedure Fun_Change1()
   Shared _Value 
   Debug "[函数]: " + _Value
   _Value + 10 
EndProcedure 

Fun_Change1()
Debug "[外部]: " + _Value
  
;【实例2:指针】
*MemData = AllocateMemory(1024)
*pPoint.long = *MemData
*pPoint\l = 1000

Procedure Fun_Change2()
   Shared *MemData                     ;共享函数外的局部变量
   *MemData = AllocateMemory(1024)  
   *pPoint.long = *MemData
   Debug "[函数]: " + *pPoint\l
   *pPoint\l = 9999
EndProcedure 

Fun_Change2()
Debug "[外部]: " + *pPoint\l

;【实例3:数组】
Global Dim _DimArray(2)
_DimArray(0) = 10
  
Procedure Fun_Change3()
   Shared _DimArray()                  ;共享函数外的局部变量
   Debug "[函数]: " + _DimArray(0)
   _DimArray(0) = 20 
EndProcedure 
  
Fun_Change3()
Debug "[外部]: " + _DimArray(0) 


;【实例4:链表】
Global NewList _ListTest$()         
AddElement(_ListTest$()) : _ListTest$() = "PureBasic"
  
Procedure Fun_Change4()
   Shared _ListTest$()                 ;共享函数外的局部变量
   Debug "[函数]: " + _ListTest$()
   AddElement(_ListTest$()) : _ListTest$() = "迷路仟"
EndProcedure 
  
Fun_Change4()
Debug "[外部]: " + _ListTest$() 


;【实例5:映射】
Global NewMap _MapTest$()
_MapTest$("1") = "PureBasic"
  
Procedure Fun_Change5()
   Shared _MapTest$()                  ;共享函数外的局部变量
   Debug "[函数]: " + _MapTest$("1")
   _MapTest$("1") =  "迷路仟"
EndProcedure 
  
Fun_Change5()
Debug "[外部]: " + _MapTest$("1")












  
  
  
  
  
  
  
  
  
  
  
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP