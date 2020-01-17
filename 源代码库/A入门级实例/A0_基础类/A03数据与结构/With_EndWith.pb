;***********************************
;迷路仟整理 2019.01.28
;With:EndWith 结构性缩写,
;***********************************
;属于宏的变种,不能嵌套使用,不能在宏中使用,不利于出错调试
;当结构成员比较多,或变量有重命名可能的情况下,使用With很方便


Structure __Person
    Name$
    Age.l
    Size.l
EndStructure


;【实例1:简单实例】
Friend.__Person
  
;完整的调用方法
   Friend\Name$ = "Yann"
   Friend\Age   = 30
   Friend\Size  = 196
   Debug Friend\Size+Friend\Size
   
;With的调用方法
With Friend
   \Name$ = "Yann"
   \Age   = 30
   \Size  = 196
   Debug \Size+\Size
EndWith
    
;【实例2:修改实例】
Friend1.__Person
Friend2.__Person

;完整的调用方法
   Friend1\Name$ = "Yann"
   Friend1\Age   = 30
   Friend1\Size  = 196
   Debug Friend1\Size+Friend1\Size
   
;如果需要改成Friend2,需要一个一个改
   Friend2\Name$ = "Yann"
   Friend2\Age   = 30
   Friend2\Size  = 196
   Debug Friend2\Size+Friend2\Size
   
;With的调用方法
With Friend1
   \Name$ = "Yann"
   \Age   = 30
   \Size  = 196
   Debug \Size+\Size
EndWith
    
;如果需要改成Friend2,就需要改一个
 ;With的调用方法
With Friend2
   \Name$ = "Yann"
   \Age   = 30
   \Size  = 196
   Debug \Size+\Size
EndWith  




;【实例3:多层结构的With】

Structure __BodyInfo
   Weight.l
   Color.l
   Texture.l
EndStructure

Structure __PersonInfo
   Name$
   Age.l
   Body.__BodyInfo[10]
EndStructure

;使用方法1
   MyFriend.__PersonInfo
   For k = 0 To 9
      With MyFriend\Body[k]
         \Weight = 50
         \Color  = 30
         \Texture = \Color*k
         Debug \Texture
      EndWith
   Next

;使用方法2,
;效果是一样,因为With是编译时编译就会自动填充完整代码,
;所以MyFriend\Body[k]可以放在For k的前面

   MyFriend.__PersonInfo
   With MyFriend\Body[k]
      For k = 0 To 9
         \Weight = 50
         \Color  = 30
         \Texture = \Color*k
         Debug \Texture
      Next
   EndWith






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 68
; FirstLine = 57
; Folding = 5
; EnableXP