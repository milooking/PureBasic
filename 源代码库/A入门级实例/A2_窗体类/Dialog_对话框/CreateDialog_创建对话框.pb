;***********************************
;迷路仟整理 2019.01.27
;CreateDialog_创建对话框
;***********************************

;由XML文件中的设置,动态的生成相应的窗体界面和控件.
;这个用于二次开发很实用

#XmlID = 0
#DialogID = 0

;这个回调函数在xml中有相关设置
Runtime Procedure EnableAlphaBlendingEvent() 
   Debug "启用Alpha混合复选框修改 !"
EndProcedure


If LoadXML(#XmlID, #PB_Compiler_Home + "examples/sources/Data/ui.xml") And XMLStatus(#XmlID) = #PB_XML_Success
   CreateDialog(#DialogID)
   If OpenXMLDialog(#DialogID, #XmlID, "hello", 200, 200)
      OneInstanceCheckbox = DialogGadget(#DialogID, "OneInstanceCheckbox")
      SetGadgetText(OneInstanceCheckbox, "Instance text changed")
      Repeat
         Event = WaitWindowEvent()
      Until Event = #PB_Event_CloseWindow
   Else
      Debug "创建对话框出错: " + DialogError(#DialogID)
   EndIf
  
Else
   Debug "XML文件出错: " + XMLErrorLine(#XmlID) + ": " + XMLError(#XmlID)
EndIf


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; Folding = -
; EnableXP