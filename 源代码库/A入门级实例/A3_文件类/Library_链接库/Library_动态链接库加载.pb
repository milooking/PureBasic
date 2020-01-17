;***********************************
;迷路仟整理 2019.01.15
;加载动态链接库
;***********************************


; 加载动态链接库
LibraryID = OpenLibrary(#PB_Any, "USER32.DLL")
If LibraryID
   *MessageBox = GetFunction(LibraryID, "MessageBoxW")
   If *MessageBox
      CallFunctionFast(*MessageBox, 0, @"Body", @"Title", 0)
   EndIf
   CloseLibrary(LibraryID)
EndIf


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 3
; EnableXP