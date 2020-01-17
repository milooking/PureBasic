;***********************************
;迷路仟整理 2019.01.28
;Structure_SizeOf_获取结构大小
;***********************************


;【计算变量大小】
Char.c ='!'
Debug "SizeOf(Char)  = " + SizeOf(Char)    ; =2
Ascii.a ='!'
Debug "SizeOf(Ascii) = " + SizeOf(Ascii)   ; =1


;【计算结构大小:数值成员】
Structure __ValueInfo
   ValueB.b
   ValueW.w
   ValueL.l
   ValueF.f
EndStructure


Debug "SizeOf(__ValueInfo) = " + SizeOf(__ValueInfo)  ; =11  可以SizeOf()结构
TempValue.__ValueInfo
Debug "SizeOf(TempValue)   = "   + SizeOf(TempValue)  ; =11  可以直接SizeOf()变量


;【计算结构大小:字符串成员】
Structure __StringInfo
   Surnames$
EndStructure


Debug "SizeOf(__StringInfo) = " + SizeOf(__StringInfo) ; =4
TempString.__StringInfo
TempString\Surnames$ = "花千骨"
;无论字符串是否有内容,或内容多长,成员大小均了4字节,
;因为在结构体中的字符串成员,只是一个字符串地址的指针.
Debug "SizeOf(TempString)   = " + SizeOf(TempString)   ; =4 

;【计算结构大小:一维数组成员】
Structure __LineColor
   DimPixel.l[1024]
EndStructure
Debug "SizeOf(__LineColor) = " + SizeOf(__LineColor) ;=4096= 1024*4


;【计算结构大小:多维数组成员】
Structure __ColorInfo
   Array DimPixel.l(1024-1,768-1)
EndStructure
;无论多唯数组成员是否有内容,或多唯数组成员数量多少,结构体中的多唯数组成员,大小均了12字节,
;因为在结构体中的多唯数组成员,只是一个指向具体多唯数组的一个指针
;(严格的说,结构体中的多唯数组成员是该多唯数组的头部结构).
Debug "SizeOf(__ColorInfo) = " + SizeOf(__ColorInfo) ; =12


;【计算结构大小:链表成员】
Structure __PeopleInfo
   List ListFriend$()
EndStructure

Debug "SizeOf(__PeopleInfo)= " +  SizeOf(__PeopleInfo) ;= 8
TempPeople.__PeopleInfo
AddElement(TempPeople\ListFriend$()) : TempPeople\ListFriend$() = "花千骨"
AddElement(TempPeople\ListFriend$()) : TempPeople\ListFriend$() = "白子画"
AddElement(TempPeople\ListFriend$()) : TempPeople\ListFriend$() = "杀阡陌"
AddElement(TempPeople\ListFriend$()) : TempPeople\ListFriend$() = "东方彧卿"

Debug "SizeOf(TempPeople)  = " +  SizeOf(TempPeople)  ;= 8  
;无论链表成员是否有内容,或链表成员数量多少,结构体中的链表成员,大小均了8字节,
;因为在结构体中的链表成员,只是一个指向具体链表的一个指针
;(严格的说,结构体中的链表成员是该链表的头部结构).


;【计算结构大小:映射成员】
Structure __PeopleBase
   Map MapFriend$()
EndStructure

Debug "SizeOf(__PeopleBase) = " +   SizeOf(__PeopleBase) ;= 4
BasePeople.__PeopleBase
BasePeople\MapFriend$("1") = "花千骨"
BasePeople\MapFriend$("2") = "白子画"
BasePeople\MapFriend$("3") = "杀阡陌"
BasePeople\MapFriend$("4") = "东方彧卿"

Debug "SizeOf(BasePeople)   = " +   SizeOf(BasePeople)  ;= 4 
 ;无论映射成员是否有内容,或映射成员数量多少,结构体中的映射成员,大小均了4字节,
;因为在结构体中的映射成员,只是一个指向具体映射的一个指针
;(严格的说,结构体中的映射成员是该映射的头部结构).


;【计算结构大小:内存指针成员】
Structure __ImageData
   *pMemData
EndStructure

Debug "SizeOf(__ImageData) = " +   SizeOf(__ImageData)   ;= 4 
Image.__ImageData
Image\pMemData = AllocateMemory(1024*768*4)
Debug "SizeOf(Image)       = " +   SizeOf(Image)         ;= 4 
 ;无论内存指针成员是否有内容,或内存指针成员数量多少,结构体中的内存指针成员,大小均了4字节x86,或8字节x64,
;因为在结构体中的内存指针成员,只是一个指向具体内存指针的一个指针


;【计算结构大小:嵌套指针成员】
Structure __ElementInfo
   *pNextElement.__ElementInfo
EndStructure

Debug "SizeOf(__ElementInfo) = " +   SizeOf(__ElementInfo)   ;= 4 ;跟内存指针成员一样


;【计算结构大小:嵌套定义】
Structure __DataInfo
   StructureUnion
      Byte.b
      Long.l
      DimVal.b[5]
   EndStructureUnion
EndStructure
Debug "SizeOf(__DataInfo) = " +   SizeOf(__DataInfo)   ;= 5 ;按最大的成员计


;【计算结构大小:对齐定义】
Structure __TypeInfo Align 9
   Byte.b
EndStructure

Debug "SizeOf(__TypeInfo) = " +   SizeOf(__TypeInfo)  ;9


;【计算结构大小:拓展定义】
Structure __AreaInfo Extends RECT
   GadgetID.l
EndStructure

Debug "SizeOf(__AreaInfo) = " +   SizeOf(__AreaInfo)  ;20

; 结构的实现成员是这样的
; Structure __AreaInfo
;    left.l
;    top.l
;    right.l
;    bottom.l
;    GadgetID.l
; EndStructure










; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 123
; FirstLine = 125
; Folding = --
; EnableXP