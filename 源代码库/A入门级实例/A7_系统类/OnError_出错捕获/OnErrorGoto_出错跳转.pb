;***********************************
;迷路仟整理 2019.01.26
;OnErrorExit_出错中断
;***********************************


   MessageRequester("OnError测试", "开始测试")
   OnErrorGoto(?ErrorHandler)  ;出错跳转
   
   ; 写入受保护内存
   PokeS(123, "用这种方法来产生一个错误场景.")
  
   ; 不应该显示这个
   MessageRequester("OnError实例", "代码执行完毕,一切正常.")
End

   ErrorHandler:
   MessageRequester("OnError实例", "出错跳转成功: " + ErrorMessage())
End





; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; EnableXP
; EnableOnError