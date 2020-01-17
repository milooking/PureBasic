;***********************************
;迷路仟整理 2019.01.28
;AllocateStructure_申请结构体内存
;***********************************
;【注】为了规范代码,内存习惯以*Mem开头,全局变量以*_Mem开头,指向内存的指针以*pMem开头

Structure __PeopleInfo
   Name$
   List ListFriend$()
EndStructure

*pMemPeople.__PeopleInfo = AllocateStructure(__PeopleInfo) ;申请结构体内存,

*pMemPeople\Name$ = "花千骨"
AddElement(*pMemPeople\ListFriend$())
*pMemPeople\ListFriend$() = "白子画"

Debug *pMemPeople\Name$       
Debug *pMemPeople\ListFriend$()

FreeStructure(*pMemPeople)    ;释放结构体


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 10
; Folding = -
; EnableXP