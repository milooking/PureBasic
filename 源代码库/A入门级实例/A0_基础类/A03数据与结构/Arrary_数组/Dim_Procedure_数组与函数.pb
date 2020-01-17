;***********************************
;迷路仟整理 2019.01.28
;Dim_Procedure 数组与函数
;***********************************
;【注】为了规范代码,建议定义数组时,
;      以Dim开头,如Dim DimValue(),
;      全局变量时到_Dim开头,如Global Dim _DimValue()

;数组有两种形式,
;一种是独立变量的,下标从0开始至定义值,如DimValue(10), 共有11个成员
;一种是结构构数组,下标从0开始至定义值-1, 如DimValue[10], 只有10个成员

;当数组成为变量时,支持输入,同时也支持输出,
;即可以将变量传递到函数内部,也可以当返回值传递到函数外部
;以下列举函数与数组的10种用法


;【单维数组做变量】
;函数变量: 单维数组做变量
Debug ""
Debug "函数变量: 单维数组做变量"
Procedure Test_Array1(Array DimNumber(1))  ;这里的1是指1维,不是下标
   For k = 0 To 9
      DimNumber(k) = k
   Next
EndProcedure

Dim DimNumber1(10)            ;1维数组
Test_Array1(DimNumber1())     ;调用时不需要使用下标

Debug DimNumber1(1)
Debug DimNumber1(5)

;【多维数组做变量】
;函数变量: 多维数组做变量
Debug ""
Debug "函数变量: 多维数组做变量"
Procedure Test_Array2(Array DimNumber(3))  ;这里的3是指3维,不是下标
   For x = 0 To 10
      For y = 0 To 10
         For z = 0 To 10
            Index+1
            DimNumber(x, y, z) = Index
         Next
      Next
   Next
EndProcedure

Dim DimNumber2(10, 10, 10)        ;3维数组
Test_Array2(DimNumber2())         ;调用时不需要使用下标
Debug DimNumber2(1,1,1)
Debug DimNumber2(2,2,2)


;【结构数组做变量1】
Debug ""
Debug "结构数组做变量1"
Structure __ArrayParam
   DimNumber.l[100]
EndStructure

ProcedureDLL Test_Array4(*pNumber.__ArrayParam) 
   For k = 0 To 100-1
      *pNumber\DimNumber[k] = k
   Next 
EndProcedure

Dim DimNumber4.l(99)
Test_Array4(DimNumber4())
Debug DimNumber4(55)


;【结构数组做变量2】
Debug ""
Debug "结构数组做变量2"
Structure __ArrayNumber
   Array DimNumber.l(10,10,10)
EndStructure

Procedure Test_Array5(*pNumber.__ArrayNumber) 
   For x = 0 To 10
      For y = 0 To 10
         For z = 0 To 10
            Index+1
            *pNumber\DimNumber(x, y, z) = Index
         Next
      Next
   Next
EndProcedure

Number.__ArrayNumber    ;这里不能直接采用多维数组(5.62目前不支持),只能采用结构数组,否则会报错,
Test_Array5(@Number)

Debug Number\DimNumber(1,1,1)
Debug Number\DimNumber(2,2,2)



;【数组指针用法1】
Debug ""
Debug "函数变量: 数组指针1"
;注意: 数组不支持DLL,但可以将数组视一个内存块进行处理
;数据指针法,也一样可以用于Procedure
ProcedureDLL Test_Array6(*pDimNumber) 
   *pArray.Long = *pDimNumber
   ;注意,For下限要跟数组下限一致
   For x = 0 To 10
      For y = 0 To 10
         For z = 0 To 10
            Index+1
            *pArray\l = Index
            *pArray+4 
         Next
      Next
   Next
EndProcedure

Dim DimNumber6.l(10, 10, 10)        ;3维数组
Test_Array6(DimNumber6())         ;调用时不需要使用下标
Debug DimNumber6(1,1,1)
Debug DimNumber6(2,2,2)


;【数组指针用法2】
Debug ""
Debug "函数变量: 数组指针2"
;注意: 数组不支持DLL,但可以将数组视一个内存块进行处理
;数据指针法,也一样可以用于Procedure
ProcedureDLL Test_Array7(*pDimNumber) 
   Dim DimNumber(10, 10, 10)                       ;3维数组
   CopySize = 11*11*11*4
   CopyMemory(*pDimNumber, DimNumber(), CopySize)  ;把*pDimNumber复制到DimNumber()
   For x = 0 To 10
      For y = 0 To 10
         For z = 0 To 10
            Index+1
            DimNumber(x,y,z) = Index
         Next
      Next
   Next
   CopyMemory(DimNumber(), *pDimNumber, CopySize)   ;把DimNumber()复制到*pDimNumber
EndProcedure

Dim DimNumber7(10, 10, 10)        ;3维数组
Test_Array7(DimNumber7())         ;调用时不需要使用下标
Debug DimNumber7(1,1,1)
Debug DimNumber7(2,2,2)



;【函数的数组返回值-复制法】
Debug ""
Debug "函数的数组返回值-复制法"
Procedure Test_Array8() 
   Static Dim DimNumber(10, 10, 10)    ;3维数组
   For x = 0 To 10
      For y = 0 To 10
         For z = 0 To 10
            Index+1
            DimNumber(x,y,z) = Index
         Next
      Next
   Next
   ProcedureReturn DimNumber()
EndProcedure

Dim DimNumber8(10, 10, 10)        ;3维数组
*pDimNumber = Test_Array8() 
CopySize = 11*11*11*4
CopyMemory(*pDimNumber, DimNumber8(), CopySize)

Debug DimNumber8(1,1,1)
Debug DimNumber8(2,2,2)


;【函数的单维数组返回值-结构指针法】
Debug ""
Debug "函数的单维数组返回值-结构指针法"
Procedure Test_Array9() 
   Static Dim DimNumber.l(100)   ;
   For k = 0 To 100
      DimNumber(k) = k
   Next
   ProcedureReturn DimNumber()
EndProcedure

Structure __ArrayInfo
   DimNumber.l[100]
EndStructure

*pArray.__ArrayInfo = Test_Array9()
Debug *pArray\DimNumber[1]


;【函数的多维数组返回值-结构指针法2】   ;这里不能直接采用多维数组(5.62目前不支持),只能采用结构数组,否则会报错,
Debug ""
Debug "函数的多维数组返回值-结构指针法"
Structure __Array2Info
   Array DimNumber.l(10,10,10)
EndStructure

Procedure Test_Array10() 
   Static Number.__Array2Info   
   For x = 0 To 10
      For y = 0 To 10
         For z = 0 To 10
            Index+1
            Number\DimNumber(x,y,z) = Index
         Next
      Next
   Next
   ProcedureReturn @Number
EndProcedure

*pArray2.__Array2Info = Test_Array10()
Debug *pArray2\DimNumber(1,1,1)
Debug *pArray2\DimNumber(2,2,2)







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; Folding = Qw+
; EnableXP