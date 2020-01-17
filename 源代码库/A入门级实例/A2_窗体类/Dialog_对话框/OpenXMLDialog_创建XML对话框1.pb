;***********************************
;迷路仟整理 2019.01.27
;OpenXMLDialog_创建XML对话框1
;***********************************

#XmlEncoding = #PB_UTF8
#Dialog = 0
#Xml = 0
XMLText$ =  "<window id='#PB_Any' name='测试' text='测试' minwidth='auto' minheight='auto' flags='#PB_Window_ScreenCentered | #PB_Window_SystemMenu | #PB_Window_SizeGadget'>" +
            "  <panel>" +
            "    <tab text='分页1'>" +
            "      <vbox expand='item:2'>" +
            "        <hbox>" +
            "          <button text='按键1'/>" +
            "          <checkbox text='选项框'/>" +
            "          <button text='按键2'/>" +
            "        </hbox>" +
            "        <editor text='内容' height='150'/>" +
            "      </vbox>" +
            "    </tab>" +
            "    <tab text='分页2'>" +
            "    </tab>" +
            "  </panel>" +
            "</window>"
If CatchXML(#Xml, @XMLText$, StringByteLength(XMLText$), 0, #XmlEncoding) And XMLStatus(#Xml) = #PB_XML_Success
 
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
; CursorPosition = 25
; FirstLine = 3
; EnableXP