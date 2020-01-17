;***********************************
;迷路仟整理 2019.01.30
;CreateXML_创建文件
;***********************************

XmlID = CreateXML(#PB_Any) 
If XmlID
   MainNodeID = CreateXMLNode(RootXMLNode(XmlID), "Zoo")    ;主节点
      ItemID = CreateXMLNode(MainNodeID, "Animal")          ;子节点
         SetXMLAttribute(ItemID, "id", "1") 
         SetXMLNodeText (ItemID, "大象") 
      ItemID = CreateXMLNode(MainNodeID, "Animal")          ;子节点
         SetXMLAttribute(ItemID, "id", "2") 
         SetXMLNodeText(ItemID, "老虎") 
   FormatXML(XmlID, #PB_XML_ReFormat)        ;内容格式化
   Debug ComposeXML(XmlID)
   SaveXML(XmlID, "测试.xml")                ;保存文件
EndIf 




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 19
; EnableXP