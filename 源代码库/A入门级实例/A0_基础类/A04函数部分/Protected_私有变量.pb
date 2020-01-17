;***********************************
;迷路仟整理 2019.01.28
;Protected_私有变量
;***********************************


;【实例1:变量】
Global _Value
_Value = 10

Procedure Fun_Change1()
   Protected _Value  ;虽然与全局变量命令一样,但有了Protected定义后,不再是全局变量,也不会引起冲突
   _Value = 20 
EndProcedure 

Fun_Change1()
Debug _Value

;【实例2:指针】
Global *MemData = AllocateMemory(1024)
*pPoint.long = *MemData
*pPoint\l = 1000

Procedure Fun_Change2()
   Protected *MemData = AllocateMemory(1024)  ;虽然与全局变量命令一样,但有了Protected定义后,不再是全局变量,也不会引起冲突
   *pPoint.long = *MemData
   *pPoint\l = 9999
EndProcedure 

Fun_Change2()
Debug *pPoint\l

;【实例3:数组】
Global Dim _DimArray(2)
_DimArray(0) = 10
  
Procedure Fun_Change3()
   Protected Dim _DimArray(2) ;虽然与全局变量命令一样,但有了Protected定义后,不再是全局变量,也不会引起冲突
   _DimArray(0) = 20 
EndProcedure 
  
Fun_Change3()
Debug _DimArray(0) 


;【实例4:链表】
Global NewList _ListTest$()
AddElement(_ListTest$()) : _ListTest$() = "PureBasic"
  
Procedure Fun_Change4()
   Protected NewList _ListTest$() ;虽然与全局变量命令一样,但有了Protected定义后,不再是全局变量,也不会引起冲突
   AddElement(_ListTest$()) : _ListTest$() = "迷路仟"
EndProcedure 
  
Fun_Change4()
Debug _ListTest$() 


;【实例5:映射】
Global NewMap _MapTest$()
_MapTest$("1") = "PureBasic"
  
Procedure Fun_Change5()
   Protected NewMap _MapTest$() ;虽然与全局变量命令一样,但有了Protected定义后,不再是全局变量,也不会引起冲突
   _MapTest$("1") =  "迷路仟"
EndProcedure 
  
Fun_Change5()
Debug _MapTest$() 












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP