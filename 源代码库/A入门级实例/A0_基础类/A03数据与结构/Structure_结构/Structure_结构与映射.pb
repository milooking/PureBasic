;***********************************
;迷路仟整理 2019.01.28
;Structure_结构与映射
;***********************************
;PureBasic自带的结构,都是全大写的,
;为了方便记忆和辨析以及规范代码,自定义的结构建议以两个下划线为开头,如: __MainInfo

; Structure <name> [Extends <name>] [Align <numeric constant expression>]
;   ...
; EndStructure 



;【映射结构】
Structure __PersonInfo
   Name.s
   ForName.s 
   Age.w 
EndStructure

NewMap MapPerson.__PersonInfo()
With MapPerson()
   AddMapElement(MapPerson(), "1")
   \Name    = "千骨"
   \Forname = "花" 
   \Age     = 32
   
   AddMapElement(MapPerson(), "2")
   \Name    = "子画"
   \Forname = "白" 
   \Age     = 32
EndWith 

; 上面的With 相当于
;    AddMapElement(MapPerson(), "1")
;    MapPerson()\Name    = "千骨"
;    MapPerson()\Forname = "花" 
;    MapPerson()\Age     = 32
;    
;    AddMapElement(MapPerson(), "2")
;    MapPerson()\Name    = "子画"
;    MapPerson()\Forname = "白" 
;    MapPerson()\Age     = 32



;【结构映射】
Structure __Friend
   Map MapName$()
EndStructure


Friend.__Friend
Friend\MapName$("1") = "花千骨"
Friend\MapName$("2") = "白子画"

ForEach Friend\MapName$()
   Debug Friend\MapName$()
Next


;【树形映射-映射嵌套结构映射】
Structure __Gadget
   GadgetID.l
   Map MapGadget.__Gadget()
EndStructure

NewMap MapFrame.__Gadget()

AddMapElement(MapFrame(), "1")
MapFrame()\GadgetID = 1 

MapFrame()\MapGadget("1-1")\GadgetID = 1
MapFrame()\MapGadget("1-2")\GadgetID = 2

ForEach MapFrame()\MapGadget()
   Debug MapFrame()\MapGadget()\GadgetID
Next 

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP