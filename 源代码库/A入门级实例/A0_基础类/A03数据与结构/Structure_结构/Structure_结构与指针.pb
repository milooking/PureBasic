;***********************************
;迷路仟整理 2019.01.28
;Structure_结构与指针
;***********************************
;PureBasic自带的结构,都是全大写的,
;为了方便记忆和辨析以及规范代码,自定义的结构建议以两个下划线为开头,如: __MainInfo

; Structure <name> [Extends <name>] [Align <numeric constant expression>]
;   ...
; EndStructure 

;【类型指针】
ValueL.l = 12345
*pValueL.long = @ValueL
Debug *pValueL\l

ValueF.f = 1.2345
*pValueF.Float = @ValueF  
Debug *pValueF\f

Value$  = "迷路仟"
*p = @Value$  
*pValueS.String = @*p ;指针的指针
Debug *pValueS\s


;【指针结构】
Structure __PixelInfo
   R.l
   G.l
   B.l
EndStructure

*MemData = AllocateMemory(1024*768*4)
*pPixel.__PixelInfo = *MemData
*pPixel\R = 255
*pPixel\G = 255
*pPixel\B = 225


;【结构指针】
Structure __ElementInfo
   *pPrevElement.__ElementInfo
   *pNextElement.__ElementInfo
   Value.l
EndStructure

NewList ListTest()
For k = 0 To 10
   AddElement(ListTest()) : ListTest() = k
Next 

*pElement.__ElementInfo = SelectElement(ListTest(), 5) - 8     ;-8是因为链表成员的真正地址,+0是链表成员的内容地址

Debug "当前链表成员: "   + *pElement\Value
Debug "上一个链表成员: " + *pElement\pPrevElement\Value
Debug "下一个链表成员: " + *pElement\pNextElement\Value
Debug "下下一个链表成员: " + *pElement\pNextElement\pNextElement\Value
Debug "下下下一个链表成员: " + *pElement\pNextElement\pNextElement\pNextElement\Value
Debug "下下下下一个链表成员: " + *pElement\pNextElement\pNextElement\pNextElement\pNextElement\Value


;【结构体内存】
Structure __PeopleInfo
    Name$
    Age.l
    List ListFriend$()
EndStructure

*People.__PeopleInfo = AllocateMemory(SizeOf(__PeopleInfo)) ;开辟一个内存,
InitializeStructure(*People, __PeopleInfo)                  ;如果结构中有List,Map,Arrary就需要InitializeStructure()一下

AddElement(*People\ListFriend$())
*People\ListFriend$() = "花千骨"
  
AddElement(*People\ListFriend$())
*People\ListFriend$() = "白子画"

ForEach *People\ListFriend$()
   Debug *People\ListFriend$()
Next


;【结构与指针】
Structure __PeopleBase
   Age.l
   Name$
EndStructure

Value$ = "测试"

People.__PeopleBase
People\Name$ = "花千骨" 
People\Age   = 15

Debug "取  值: " + Value$
Debug "取  址: 0x" + Hex(People)
Debug "相当于: 0x" + Hex(@People)
Debug "相当于: 0x" + Hex(@People\Age) ;结构体第一个成员必须为数值情况下才有效,







; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 98
; FirstLine = 71
; Folding = 7
; EnableXP