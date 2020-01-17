;***********************************
;迷路仟整理 2019.01.28
;Structure_结构与链表
;***********************************
;PureBasic自带的结构,都是全大写的,
;为了方便记忆和辨析以及规范代码,自定义的结构建议以两个下划线为开头,如: __MainInfo

; Structure <name> [Extends <name>] [Align <numeric constant expression>]
;   ...
; EndStructure 



;【链表结构】
Structure __PersonInfo
   Name.s
   ForName.s 
   Age.w 
EndStructure

NewList ListPerson.__PersonInfo()
With ListPerson()
   AddElement(ListPerson())
   \Name    = "千骨"
   \Forname = "花" 
   \Age     = 32
   
   AddElement(ListPerson())
   \Name    = "子画"
   \Forname = "白" 
   \Age     = 32
EndWith 

; 上面的With 相当于
;    AddElement(ListPerson())
;    ListPerson()\Name    = "千骨"
;    ListPerson()\Forname = "花" 
;    ListPerson()\Age     = 32
;    
;    AddElement(ListPerson())
;    ListPerson()\Name    = "子画"
;    ListPerson()\Forname = "白" 
;    ListPerson()\Age     = 32



;【结构链表】
Structure __Friend
   List ListName$()
EndStructure


Friend.__Friend
AddElement(Friend\ListName$()) : Friend\ListName$() = "花千骨"
AddElement(Friend\ListName$()) : Friend\ListName$() = "白子画"

ForEach Friend\ListName$()
   Debug Friend\ListName$()
Next


;【树形链表-链表嵌套结构链表】
Structure __Gadget
   GadgetID.l
   List ListGadget.__Gadget()
EndStructure

NewList ListFrame.__Gadget()

AddElement(ListFrame())
ListFrame()\GadgetID = 1 

AddElement(ListFrame()\ListGadget())
ListFrame()\ListGadget()\GadgetID = 1

AddElement(ListFrame()\ListGadget())
ListFrame()\ListGadget()\GadgetID = 2

ForEach ListFrame()\ListGadget()
   Debug ListFrame()\ListGadget()\GadgetID
Next 

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = -
; EnableXP