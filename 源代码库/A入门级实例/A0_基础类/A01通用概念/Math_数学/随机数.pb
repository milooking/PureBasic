;***********************************
;迷路仟整理 2019.01.29
;Random_随机数
;***********************************
;与随机数相关的还有:
;CryptRandom()          ;加密随机(随机的是数值)
;CryptRandomData()      ;加密随机(随机的是内存数据) 
;RandomizeArray()       ;随机数组(随机的是顺序)
;RandomizeList()        ;随机链表(随机的是顺序)


;【常量随机】
Debug "====== 【常量随机】 ======"
Debug Random(100)          ;随机范围: 0至100

;【范围随机】
Debug "====== 【范围随机】 ======"
Debug Random(100, 90)      ;随机范围: 90至100

;【随机正负值】
Debug "====== 【随机正负值】 ======"
Debug Random(100, 0) - 50  ;随机范围: -50至-50

;【随机浮点值】
Debug "====== 【随机浮点值】 ======"
ValueF.f = Random(100, 0)/100   ;随机范围: 0.01至1.00
Debug StrF(ValueF, 2)


;【随机内存数据】
Debug "====== 【随机内存数据】 ======"
*MemBuffer = AllocateMemory(1000)
RandomData(*MemBuffer, 1000)  
ShowMemoryViewer(*MemBuffer, 1000)


;【随机种子】系统自带的随机,是伪随机,由随机种控制.随机数,是一种算法,初始值一样,算出来的数值流也一样
Debug "====== 【随机种子】 ======"
RandomSeed(1)           ;随机数由随机种子控制.随机总子一样,Random()的随机出来的一系列数值是顺序相同的
For k = 1 To 5
   Debug Random(100)    
Next
;每次运行得到的5个随机数固定为: 72, 18, 61, 92, 0






; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; FirstLine = 1
; EnableThread
; EnableXP