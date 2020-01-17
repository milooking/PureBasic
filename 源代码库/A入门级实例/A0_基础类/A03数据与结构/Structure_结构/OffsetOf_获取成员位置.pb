;***********************************
;迷路仟整理 2019.01.28
;Structure_OffsetOf_获取成员位置
;***********************************
;获取结构体中成员的偏移位置,

;【获取成员位置:结构体】
Structure __PersonInfo
    Name.s
    ForName.s 
    Age.w 
EndStructure
  
Debug OffsetOf(__PersonInfo\Age) ; =8

Person.__PersonInfo

;【获取成员位置:接口结构】
Interface __ITest
   Create()
   Destroy(Flags) 
EndInterface

  
Debug OffsetOf(__ITest\Destroy()) ; =4














; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 20
; FirstLine = 1
; Folding = -
; EnableXP