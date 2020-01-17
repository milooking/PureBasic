;***********************************
;迷路仟整理 2019.01.28
;Enumeration 以自增枚举方式定义常量
;***********************************
;【注】为了规范代码,建议数组定义时,
;      以Dim开发,如Dim DimValue(),
;      全局变是到_Dim开头,如Global Dim _DimValue()


;常量批量定义,以自增枚举方式进行
; Enumeration [name] [<constant> [Step <constant>]] 
;   #Constant1
;   #Constant2 [= <constant>]
;   #Constant3
;   ...
; EndEnumeration
; 
; EnumerationBinary [name] [<constant>] 
;   #Constant1
;   #Constant2 [= <constant>]
;   #Constant3
;   ...
; EndEnumeration

;【实例1:常规定义】起点是0
Enumeration
   #txtEnumInfo    ;=0
   #btnEnumText    ;=1 自增1
   #btnEnumOK      ;=2 
EndEnumeration


;【实例2:初始值定义】
Enumeration 100
   #txtNextInfo    ;=100
   #btnNextText    ;=101   
   #btnNextOK      ;=102 
EndEnumeration


;【实例3:步进定义】
Enumeration 100 Step 3
   #txtPrevInfo    ;=100
   #btnPrevText    ;=103  自增3 
   #btnPrevOK      ;=106
EndEnumeration


;【实例4:赋值定义】
Enumeration 
   #txtFindInfo       ;=0
   #btnFindText = 15  ;=15  赋值   
   #btnFindOK         ;=16  自增1 
EndEnumeration


;【实例5:标签定义】常用于多个源代码文件对控件,窗体等对象的编号定义
Enumeration Gadget 
   #txtSearchInfo    ;=0
   #btnSearchText    ;=1 
   #btnSearchOK      ;=2
EndEnumeration

Enumeration Window 
   #winScreen        ;=0
   #winDialog        ;=1 
   #winRequester     ;=2
EndEnumeration

Enumeration Gadget  ;继承上一个Gadget
   #lblInputValue    ;=3
   #txtInputValue    ;=4
   #btnInputValue    ;=5
EndEnumeration


Debug #lblInputValue


;【实例6:获取下一个举枚值】
Enumeration 
   #txtEditorInfo    ;=0
   #btnEditorText    ;=1 
   #btnEditorOK      ;=2
EndEnumeration
 Debug "下一个: " + #PB_Compiler_EnumerationValue 


;【实例7:位枚举】即左移自增,起点是1
EnumerationBinary
   #Flags1  ;=01  ;左移自增
   #Flags2  ;=02
   #Flags3  ;=04
   #Flags4  ;=08
   #Flags5  ;=16
EndEnumeration

Debug #Flags5

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = f+
; EnableXP