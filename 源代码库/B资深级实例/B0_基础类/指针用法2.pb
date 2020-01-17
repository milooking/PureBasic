;***********************************
;迷路仟整理 2019.03.22
;指针用法2
;***********************************
        
; 【5.用来指向数组】
Dim DimValue.l(9)
For k = 0 To 9
   DimValue(k) = k
Next 

;用DimValue(), @DimValue(), @DimValue(0) 是等效的
*pValue.long = DimValue()     
; *pValue.long = @DimValue()       
; *pValue.long = @DimValue(0)       
For k = 0 To 9
   Debug *pValue\l : *pValue+4  ;因为LONG占用四个字节,所以这个要+4
Next 
Debug ""  

Dim DimValue$(9)
For k = 0 To 9
   DimValue$(k) = "00"+Str(k)
Next 

;用DimValue$(), @DimValue$(), @DimValue$(0) 是等效的
;注意,这里不可以像【3】那样, *pPoint = DimValue$() : *pString.String = @*pPoint
*pString.String = DimValue$()     
; *pString.String = @DimValue$()       
; *pString.String = @DimValue$(0)  
For k = 0 To 9
   Debug *pString\s : *pString+4  ;因为String占用四个字节,所以这个要+4
Next 
Debug "" 


; 【6.用来指向链表】
NewList ListValue.l()
For k = 1 To 9
   *pElement.long = AddElement(ListValue()) : *pElement\l = k*11
Next 

ForEach ListValue() 
   Debug ListValue() 
Next 
Debug "" 


*pElement.long = FirstElement(ListValue())
Debug *pElement\l

*pElement.long = LastElement(ListValue())
Debug *pElement\l

*pElement.long = SelectElement(ListValue(), 5)
Debug *pElement\l
Debug "" 

NewList ListValue$()
For k = 1 To 9
   *pString.String = AddElement(ListValue$()) : *pString\s = "-"+Str(k)+"-"
Next 

ForEach ListValue$() 
   Debug ListValue$() 
Next 
Debug "" 

*pString.String = FirstElement(ListValue$())
Debug *pString\s

*pString.String = LastElement(ListValue$())
Debug *pString\s

*pString.String = SelectElement(ListValue$(), 5)
Debug *pString\s
Debug "" 

;当链表元素是个复杂结构时,很有优势

Structure __ListTestInfo
   Index.l
   X.w
   Y.w
   Text$
   Title$
   Caption$
   Notice$
   ToolTip$
EndStructure


;当结构出现大量相同类型的成员时,可以采用指针来优化代码
NewList ListTest.__ListTestInfo()
For k = 1 To 5
   AddElement(ListTest())
   ListTest()\Text$    = "Text$-"    + Str(k)
   ListTest()\Title$   = "Title$-"   + Str(k)
   ListTest()\Caption$ = "Caption$-" + Str(k)
   ListTest()\Notice$  = "Notice$-"  + Str(k)
   ListTest()\ToolTip$ = "ToolTip$-" + Str(k)
Next 

ForEach ListTest()
   Debug ListTest()\Text$ 
   Debug ListTest()\Title$  
   Debug ListTest()\Caption$
   Debug ListTest()\Notice$ 
   Debug ListTest()\ToolTip$
Next 

Debug "" 
ForEach ListTest()
   *pString.String =  @ListTest() + OffsetOf(__ListTestInfo\Text$) 
   For k = 1 To 5
      Debug *pString\s : *pString+4
   Next 
Next 
Debug "" 


; 【6.用来指向映射】
; ;用法跟链表一样
NewMap MapValue.l()

MapValue("Miloo") = 11

*pValue.long = @MapValue("Miloo") 
Debug *pValue\l

*pValue.long = FindMapElement(MapValue(), "Miloo") 
If *pValue.long
   Debug *pValue\l
EndIf 
Debug "" 


NewMap MapPoint.Point()

MapPoint("Miloo")\x = 11
MapPoint("Miloo")\y = 22

;当映射是结构体时,@MapPoint("Miloo")和MapPoint("Miloo") 是同效的.
*pPoint.Point = @MapPoint("Miloo") 
*pPoint.Point = MapPoint("Miloo") 
Debug *pPoint\x
Debug *pPoint\y

*pPoint.Point = FindMapElement(MapPoint(), "Miloo") 
Debug *pPoint\x
Debug *pPoint\y
Debug "" 


NewMap MapString$()

MapString$("Miloo") = "PureBasic"


*pString.String = @MapString$("Miloo") 
Debug *pString\s

*pString.String = FindMapElement(MapString$(), "Miloo") 
Debug *pString\s
Debug "" 



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = -
; EnableXP