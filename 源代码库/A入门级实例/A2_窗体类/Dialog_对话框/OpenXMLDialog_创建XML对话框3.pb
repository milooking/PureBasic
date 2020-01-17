;***********************************
;迷路仟整理 2019.01.27
;OpenXMLDialog_创建XML对话框3
;***********************************

#XmlEncoding = #PB_UTF8
#Dialog = 0
#Xml = 0

If CatchXML(#Xml, ?_XML_Test, ?_End_Test-?_XML_Test, 0, #XmlEncoding) And XMLStatus(#Xml) = #PB_XML_Success
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

DataSection
_XML_Test:
   IncludeBinary ".\Test.xml" 
_End_Test:
   
EndDataSection


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP