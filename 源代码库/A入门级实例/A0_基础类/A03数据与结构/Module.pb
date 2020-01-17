;***********************************
;迷路仟整理 2019.01.28
;Module 命名空间/模块
;***********************************
; 模块是将代码部分与主代码隔离开来的一种简单方法，允许代码重用和共享，而不存在名称冲突的风险。
; 在其他一些编程语言中如.net，模块被称为“命名空间”。

; DeclareModule <name>
;   ...
; EndDeclareModule
; 
; Module <name>
;   ...
; EndModule
; 
; UseModule <name>
; UnuseModule <name>


;【实例1:简单实例】
;本段中的每个项目都可以从外部获得
DeclareModule Module_Ferrari
    #FerrariName$ = "测试内容"
    Declare CreateFerrari()
EndDeclareModule
  
;本段中的每个项都是私有的。每个名称都可以不冲突地使用
Module Module_Ferrari
   Global _Initialized = #False
   Procedure Init() ; 私有函数
      If _Initialized = #False
         _Initialized = #True
         Debug "InitFerrari()"
      EndIf
   EndProcedure  
      
   Procedure CreateFerrari()
      Init()
      Debug "CreateFerrari()"
   EndProcedure
EndModule
  
;这里的Init()函数,与Module_Ferrari中的 Init()函数不同,也不会互相起冲突,
Procedure Init() 
    Debug "Main Init()"
EndProcedure
   
   Init()
   Module_Ferrari::CreateFerrari()
   Debug Module_Ferrari::#FerrariName$

   ;现在在主程序范围中直接导入所有公共项,上面是要带前辍,启用命名空间后,可以直接使用
   Debug "------------------------------"
   UseModule Module_Ferrari
   CreateFerrari()
   Debug #FerrariName$


;【实例2:嵌套实例】
DeclareModule Module_Cars
    Global NbCars = 0
EndDeclareModule
  
Module Module_Cars 
EndModule

DeclareModule Module_Ferrary
EndDeclareModule
  
Module Module_Ferrary
   UseModule Module_Cars
   NbCars+1
EndModule

DeclareModule Module_Porche
EndDeclareModule
  
Module Module_Porche
   UseModule Module_Cars
    
   NbCars+1
EndModule
  
Debug Module_Cars::NbCars











; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 56
; FirstLine = 38
; Folding = --
; EnableXP