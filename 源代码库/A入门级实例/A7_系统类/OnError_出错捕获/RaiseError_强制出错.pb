;***********************************
;迷路仟整理 2019.01.26
;RaiseError_强制出错
;***********************************


;自定义出提示
Procedure Error_Handler()
   MessageRequester("OnError测试", "跳到自定义的出错处理: " + ErrorMessage())
   End
EndProcedure

   MessageRequester("OnError测试", "开始测试")

   OnErrorCall(@Error_Handler())
   RaiseError(#PB_OnError_InvalidMemory) ;人为的产生一个内存出错
  
   ; 不应该显示这个
   MessageRequester("OnError实例", "代码执行完毕,一切正常.")

End

; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 6
; Folding = -
; EnableXP
; EnableOnError