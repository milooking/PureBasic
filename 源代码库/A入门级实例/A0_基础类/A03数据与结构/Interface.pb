;***********************************
;迷路仟整理 2019.01.28
;Interface 对象接口,主要用于COM(组件对象模型)或DirectX动态库(DLL)
;***********************************

; Interface <name> [Extends <name>]
;   <Method[.<type>]()>
;   ...
; EndInterface



;【实例1:简单实例】
;注意: 运行会报错,因为MyCreateObject()对象不存在.
;为了访问外部对象(例如在DLL中)，
;对象的接口必须首先声明:
Interface __TestObject
   Move(x,y)
   MoveF(x.f,y.f)
   Destroy()
EndInterface

Object1.__TestObject = MyCreateObject()
Object2.__TestObject = MyCreateObject()

Object1\Move(10, 20)
Object1\Destroy()

Object2\MoveF(10.5, 20.1)
Object2\Destroy()


;【实例2:拓展实例】
  Interface Cube
    GetPosition()
    SetPosition(x)
    GetWidth()
    SetWidth(Width)
  EndInterface
  
  Interface ColoredCube Extends Cube
    GetColor()
    SetColor(Color)
  EndInterface
  
  Interface TexturedCube Extends Cube
    GetTexture()
    SetTexture(TextureID)
  EndInterface



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 31
; FirstLine = 14
; EnableXP