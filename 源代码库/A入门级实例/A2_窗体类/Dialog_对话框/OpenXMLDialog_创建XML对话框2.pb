;***********************************
;迷路仟整理 2019.03.15
;OpenXMLDialog_创建XML对话框2
;***********************************

#Dialog = 0
#Xml = 0

If LoadXML(#Xml, "Test.xml", #PB_UTF8) And XMLStatus(#Xml) = #PB_XML_Success
   If CreateDialog(#Dialog) And OpenXMLDialog(#Dialog, #Xml, "测试")
      Repeat
         Event = WaitWindowEvent()
      Until Event = #PB_Event_CloseWindow 
   Else  
      Debug "对话框出错: " + DialogError(#Dialog)
   EndIf
Else
   Debug "XML内容出错: " + XMLError(#Xml) + " (Line: " + XMLErrorLine(#Xml) + ")"
EndIf



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; EnableXP