;***********************************
;迷路仟整理 2019.01.28
;Structure_结构与数组
;***********************************
;PureBasic自带的结构,都是全大写的,
;为了方便记忆和辨析以及规范代码,自定义的结构建议以两个下划线为开头,如: __MainInfo

; Structure <name> [Extends <name>] [Align <numeric constant expression>]
;   ...
; EndStructure 


;【数组结构】
Structure __PersonInfo
   Name$
   ForName.s 
   Age.w 
EndStructure

Dim DimFriend.__PersonInfo(100)

DimFriend(0)\Name$   = "千骨"
DimFriend(0)\Forname = "花" 
DimFriend(0)\Age     = 32

DimFriend(1)\Name$   = "子画"
DimFriend(1)\Forname = "白" 
DimFriend(1)\Age     = 32



;【一维结构数组】
Structure __NameInfo
   DimName$[10]     ; 10个字符串变量,下标从0至9
   DimValue.RECT[5]  ;0-4共5个成员
EndStructure

MyName.__NameInfo
MyName\DimName$[0] = "花千骨"
MyName\DimValue[0]\left = 100
MyName\DimValue[0]\top  = 100
MyName\DimName$[9] = "白子画"

;数组嵌套结构数组
Dim DimName.__NameInfo(10, 10)
DimName(1,1)\DimName$[0] = "花千骨"


;【多维结构数组】
Structure __NoteInfo
   Array DimVal.POINT(3)      ; POINT是自带的结构
   Array DimNote$(10, 10)     ; 11x11
EndStructure

MyNote.__NoteInfo
MyNote\DimNote$(0,1) = "花千骨-白子画"
MyNote\DimNote$(1,0) = "白子画-花千骨"
MyNote\DimVal(0)\x= 10
MyNote\DimVal(0)\y= 10

;数组嵌套结构数组
Dim DimNote.__NoteInfo(10, 10)
DimNote(1,1)\DimNote$(0,1) = "花千骨-白子画"
DimNote(1,1)\DimVal(0)\x= 10


;【占位数组】
Structure __DateBase
   Year.s{4}
   Pk1.s{1}   
   Month.s{2}
   Pk2.s{1}
   Day.s{2}
EndStructure

Structure __DateInfo
    StructureUnion
      s.s{10}
      d.__DateBase
    EndStructureUnion
EndStructure

MyDate.__DateInfo 
MyDate\s =  "2019.01.28"

Debug "年="+MyDate\d\Year
Debug "月="+MyDate\d\Month
Debug "日="+MyDate\d\Day

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 18
; FirstLine = 46
; Folding = h
; EnableXP