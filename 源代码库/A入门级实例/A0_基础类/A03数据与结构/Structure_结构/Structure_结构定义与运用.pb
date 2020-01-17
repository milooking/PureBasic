;***********************************
;迷路仟整理 2019.01.28
;Structure_结构定义与运用
;***********************************
;PureBasic自带的结构,都是全大写的,
;为了方便记忆和辨析以及规范代码,自定义的结构建议以两个下划线为开头,如: __MainInfo

; Structure <name> [Extends <name>] [Align <numeric constant expression>]
;   ...
; EndStructure 


;【实例1:简单实例】
Structure __PersonInfo
   Name.s
   ForName.s 
   Age.w 
EndStructure

MyFriend.__PersonInfo

MyFriend\Name    = "千骨"
MyFriend\Forname = "花" 
MyFriend\Age     = 32



;【实例2:嵌套结构】 :结构支持指针结构跟结构一样
Structure __WindowInfo
   *NextWindow.__WindowInfo  ;注意这里的指针结构,跟我们正在定义的结构一样,这是合法的,如果成员不是指针,就不合法
   x.w 
   y.w
   Point.Point   
EndStructure


;【实例3:结构继承】
Structure __PointInfo
   x.l 
   y.l
EndStructure

Structure __PixelPoint Extends __PointInfo
   Color.l 
EndStructure

; __PixelPoint的实例构成是这样子的:
; Structure __PixelPoint
;    x.l         ;继承自__PointInfo
;    y.l         ;继承自__PointInfo
;    Color.l 
; EndStructure

PixelPoint.__PixelPoint
PixelPoint\x = 10
PixelPoint\y = 20
PixelPoint\color = RGB(255, 0, 0)


;【实例4:结构体复制】
Structure __PointsInfo
   x.l 
   y.l
   z.l
   Note$
EndStructure

TopPoint.__PointsInfo
TopPoint\x = 10
TopPoint\y = 20
TopPoint\z = 99
TopPoint\Note$ = "测试"

LeftPoint.__PointsInfo = TopPoint  ;全结构赋值
Debug LeftPoint\x
Debug LeftPoint\y
Debug LeftPoint\z
Debug LeftPoint\Note$



;【实例5:复杂结构体复制】
Structure __PeopleBase
   Name$
   LastName$
   Map Friends$()
   Age.l
EndStructure

Student.__PeopleBase\Name$ = "千骨"
Student\LastName$ = "花"
Student\Friends$("1") = "白子画"
Student\Friends$("2") = "杀阡陌"

;如果结果中带List,Map,Arrary,要采用CopyStructure()
CopyStructure(@Student, @StudentCopy.__PeopleBase, __PeopleBase)

Debug StudentCopy\Name$
Debug StudentCopy\LastName$
Debug StudentCopy\Friends$("1")
Debug StudentCopy\Friends$("2")


;【实例6:结构对齐】
Structure __Type4Info Align 4
   Byte.b
   Word.w
   Long.l
   Float.f
EndStructure
  
  Debug OffsetOf(__Type4Info\Byte)   ; 0
  Debug OffsetOf(__Type4Info\Word)   ; 4
  Debug OffsetOf(__Type4Info\Long)   ; 8
  Debug OffsetOf(__Type4Info\Float)  ; 12

Structure __Type5Info Align 5
   Byte.b
   Word.w
   Long.l
   Float.f
EndStructure
  
  Debug OffsetOf(__Type5Info\Byte)   ; 0
  Debug OffsetOf(__Type5Info\Word)   ; 5
  Debug OffsetOf(__Type5Info\Long)   ; 10
  Debug OffsetOf(__Type5Info\Float)  ; 15


;【实例7:清空结构体】
Structure __PeopleInfo
   Name$
   LastName$
   Age.l
EndStructure

People.__PeopleInfo\Name$ = "千骨"
People\LastName$ = "花"
People\Age = 10

ClearStructure(@People, __PeopleInfo)
Debug People\Name$
Debug People\LastName$
Debug People\Age


;【实例8:重置结构体】
Structure __PersonBase
   Map Friend$()
EndStructure

Henry.__PersonBase
Henry\Friend$("1") = "白子画"
ResetStructure(@Henry, __PersonBase)
Debug Henry\Friend$("1")



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 144
; FirstLine = 92
; Folding = A9
; EnableXP