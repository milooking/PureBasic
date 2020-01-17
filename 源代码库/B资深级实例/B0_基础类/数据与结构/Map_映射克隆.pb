;***********************************
;迷路仟整理 2019.01.31
;Map_映射克隆
;***********************************
;Map_映射克隆的作用，主要用于DLL的输入和输出，
;因为ProcedureDLL不支持链表和映射，通过这种法，
;就可以实现DLL函数进行映射的输入和输出

NewMap MapText$()          ;主体Map对象
NewMap MapCopy$()          ;做克隆体用的Map对象


MapText$("CHI") = "中国"
MapText$("ENG") = "英国"
MapText$("KOR") = "韩国"
MapText$("JPN") = "日本"


Debug "============= 映射克隆前 ============="
Debug "[MapText$]: "
ForEach MapText$()
   Debug MapText$()
Next 

Debug "[MapCopy$]: 没有内容"
ForEach MapCopy$()
   Debug MapCopy$()
Next 
Debug "============= ******** ============="

;【开始克隆】
*pMapResetText = ResetMap(MapText$())              ;获取MapText$()表头地址指针
*pMapResetCopy = ResetMap(MapCopy$())              ;获取MapCopy$()表头地址指针


*pMemMapBackup = AllocateMemory(16)                ;备份MapCopy$()表头的内容,这样才可以释放MapCopy$()
CopyMemory(*pMapResetCopy, *pMemMapBackup, 16)     ;备份
CopyMemory(*pMapResetText, *pMapResetCopy, 16)     ;将MapText$()表头内容,克隆到MapCopy$()表头中,
;注: 克隆后,两个Map共享一个实体的Map对象,无论对MapText$()/MapCopy$()操作,都会切换到MapText$()的实体中
;【克隆结束】

Debug ""
Debug "============= 【映射克隆后】 ============="
Debug "[MapText$]: "
ForEach MapText$()
   Debug MapText$()
Next 

Debug "[MapCopy$]: 内容出现"
ForEach MapCopy$()
   Debug MapCopy$()
Next 


;【添加元素】
MapText$("IND") = "印度"        ;注意这里采用是的MapText$()来添加元素
MapCopy$("USA") = "美国"        ;注意这里采用是的MapCopy$()来添加元素
Debug ""
Debug "============= 【克隆后添加元素】 ============="
Debug "[MapText$]: "
ForEach MapText$()
   Debug MapText$()
Next 

Debug "[MapCopy$]: 与克隆对象一致"
ForEach MapCopy$()
   Debug MapCopy$()
Next 


;【删除元素】
DeleteMapElement(MapText$(), "JPN")       ;注意这里删除的是MapText$()的元素
DeleteMapElement(MapText$(), "KOR")       ;注意这里删除的是MapCopy$()的元素
Debug ""
Debug "============= 【克隆后添加元素】 ============="
Debug "[MapText$]: "
ForEach MapText$()
   Debug MapText$()
Next 

Debug "[MapCopy$]: 与克隆对象一致"
ForEach MapCopy$()
   Debug MapCopy$()
Next 


;【调用效果】
Debug "============= 【调用效果】 ============="
If FindMapElement(MapText$(), "CHI") : Debug MapText$() : EndIf 
If FindMapElement(MapCopy$(), "USA") : Debug MapCopy$() : EndIf 
Debug MapSize(MapText$())
Debug MapSize(MapCopy$())  ;注意这里不一致

;【循环效果】
Debug "============= 【调用效果】 ============="
ForEach MapText$()
   Debug MapText$() + ":" + MapCopy$()             ;克隆体不受主体的影响
Next 

;【释放克隆体】
FreeMap(MapText$())
CopyMemory(*pMemMapBackup, *pMapResetCopy, 16)     ;还原克隆体
FreeMap(MapCopy$())
FreeMemory(*pMemMapBackup)









; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 96
; FirstLine = 89
; EnableXP