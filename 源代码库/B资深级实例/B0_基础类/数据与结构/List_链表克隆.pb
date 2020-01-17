;***********************************
;迷路仟整理 2019.01.31
;List_链表克隆
;***********************************
;List_链表克隆的作用，主要用于DLL的输入和输出，
;因为ProcedureDLL不支持链表和映射，通过这种法，
;就可以实现DLL函数进行链表的输入和输出


NewList ListText$()        ;主体List对象
NewList ListCopy$()        ;做克隆体用的List对象

AddElement(ListText$()) : ListText$() = "中国"
AddElement(ListText$()) : ListText$() = "英国"
AddElement(ListText$()) : ListText$() = "韩国"
AddElement(ListText$()) : ListText$() = "日本"

Debug "============= 链表克隆前 ============="
Debug "[ListText$]: "
ForEach ListText$()
   Debug ListText$()
Next 

Debug "[ListCopy$]: 没有内容"
ForEach ListCopy$()
   Debug ListCopy$()
Next 
Debug "============= ******** ============="

;【开始克隆】
LastElement(ListText$())
*pListResetText = ResetList(ListText$())           ;获取ListText$()表头地址指针
*pListResetCopy = ResetList(ListCopy$())           ;获取ListCopy$()表头地址指针

*pListTableText = PeekL(*pListResetText-4)         ;获取ListText$()表头地址
*pListTableCopy = PeekL(*pListResetCopy-4)         ;获取ListCopy$()表头地址

*pMemListBackup = AllocateMemory(24)                ;备份ListCopy$()表头的内容,这样才可以释放ListCopy$()
; CopyMemory(*pListTableCopy, *pMemListBackup, 8)    ;备份
; CopyMemory(*pListTableText, *pListTableCopy, 8)    ;将ListText$()表头内容,克隆到ListCopy$()表头中,

CopyMemory(*pListTableCopy, *pMemListBackup, 24) 
CopyMemory(*pListTableText, *pListTableCopy, 24) 
PokeL(*pListTableCopy+12, *pListResetCopy) 

;注: 克隆后,两个List共享一个实体的List对象,无论对ListText$()/ListCopy$()操作,都会切换到ListText$()的实体中
;【克隆结束】

Debug ""
Debug "============= 【链表克隆后】 ============="
Debug "[ListText$]: "
ForEach ListText$()
   Debug ListText$()
Next 

Debug "[ListCopy$]: 内容出现"
ForEach ListCopy$()
   Debug ListCopy$()
Next 


;【添加元素】
AddElement(ListText$()) : ListText$() = "印度"        ;注意这里采用是的ListText$()来添加元素
AddElement(ListCopy$()) : ListCopy$() = "美国"        ;注意这里采用是的ListCopy$()来添加元素
Debug ""
Debug "============= 【克隆后添加元素】 ============="
Debug "[ListText$]: "
ForEach ListText$()
   Debug ListText$()
Next 

Debug "[ListCopy$]: 与克隆对象一致"
ForEach ListCopy$()
   Debug ListCopy$()
Next 


;【删除元素】
SelectElement(ListText$(), 3)
DeleteElement(ListText$())                ;注意这里删除的是ListText$()的元素

SelectElement(ListCopy$(), 2)
DeleteElement(ListCopy$())                ;注意这里删除的是ListCopy$()的元素

Debug ""
Debug "============= 【克隆后添加元素】 ============="
Debug "[ListText$]: "
ForEach ListText$()
   Debug ListText$()
Next 

Debug "[ListCopy$]: 与克隆对象一致"
ForEach ListCopy$()
   Debug ListCopy$()
Next 


;【调用效果】
Debug "============= 【调用效果】 ============="
SelectElement(ListText$(), 3) : Debug ListText$()
SelectElement(ListCopy$(), 1) : Debug ListCopy$()
Debug ListSize(ListText$())
Debug ListSize(ListCopy$())


;【循环效果】
Debug "============= 【调用效果】 ============="
ForEach ListText$()
   Debug ListText$() + ":" + ListCopy$()    ;克隆体不受主体的影响
Next 

;【释放克隆体】
FreeList(ListText$())
CopyMemory (*pMemListBackup, *pListTableCopy, 24)    ;还原克隆体
FreeList(ListCopy$())
FreeMemory(*pMemListBackup)

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 1
; EnableXP