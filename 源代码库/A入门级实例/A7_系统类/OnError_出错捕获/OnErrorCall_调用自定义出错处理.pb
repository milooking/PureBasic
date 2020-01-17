;***********************************
;迷路仟整理 2019.01.26
;OnErrorCall_调用自定义出错处理
;***********************************


;自定义出提示
Procedure Error_Handler()
   MessageRequester("OnError测试", "跳到自定义的出错处理: " + ErrorMessage())
   End
EndProcedure

   MessageRequester("OnError测试", "开始测试")

   OnErrorCall(@Error_Handler())
 
   ; 写入受保护内存
   PokeS(123, "用这种方法来产生一个错误场景.")
  
   ; 不应该显示这个
   MessageRequester("OnError实例", "代码执行完毕,一切正常.")

End


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 16
; Folding = -
; EnableXP
; EnableOnError