;***********************************
;迷路仟整理 2019.01.28
;TypeOf_获取对象类型
;***********************************


Debug "#PB_Byte      = "  + #PB_Byte      
Debug "#PB_Word      = "  + #PB_Word      
Debug "#PB_Long      = "  + #PB_Long      
Debug "#PB_String    = "  + #PB_String    
Debug "#PB_Structure = "  + #PB_Structure
Debug "#PB_Float     = "  + #PB_Float
Debug "#PB_Character = "  + #PB_Character
Debug "#PB_Double    = "  + #PB_Double
Debug "#PB_Quad      = "  + #PB_Quad
Debug "#PB_List      = "  + #PB_List
Debug "#PB_Array     = "  + #PB_Array
Debug "#PB_Integer   = "  + #PB_Integer
Debug "#PB_Map       = "  + #PB_Map
Debug "#PB_Ascii     = "  + #PB_Ascii
Debug "#PB_Unicode   = "  + #PB_Unicode
Debug "#PB_Byte      = "  + #PB_Interface

Debug "========================"

Object.l = 123

Type = TypeOf(Object)

Debug Type  ;#PB_Long


Structure Person
   Name.s
   ForName.s 
   Age.w 
EndStructure
  
If TypeOf(Person\Age) = #PB_Word
   Debug "#PB_Word"
EndIf
         
Surface.f                 
If TypeOf(Surface) = #PB_Float
   Debug "#PB_Float"
EndIf









; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 45
; FirstLine = 27
; Folding = -
; EnableXP