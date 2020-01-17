;***********************************
;迷路仟整理 2019.01.15
;XML文件的加载与保存
;***********************************

; 加载XML文件
; 采用递归法，将节点进行分组加载
Procedure XML_EnumNode(*CurrNode, SubLevel)
   If XMLNodeType(*CurrNode) = #PB_XML_Normal
      ; XML行成员
      NodeText$ = GetXMLNodeName(*CurrNode)
      If ExamineXMLAttributes(*CurrNode)
         While NextXMLAttribute(*CurrNode)               ; 枚举节点属性
            AttrNames$ = XMLAttributeName (*CurrNode)    ; 获取节点属性名称
            AttrNotes$ = XMLAttributeValue(*CurrNode)    ; 获取节点属性内容
         Wend
      EndIf
      ; 枚举子节点
      *ChildNode = ChildXMLNode(*CurrNode)
      While *ChildNode <> 0
         XML_EnumNode(*ChildNode, SubLevel+1)
         *ChildNode = NextXMLNode(*ChildNode)
      Wend
   EndIf
EndProcedure

; 加载XML文件
Procedure XML_LoadXMLFile(XMLFile$, Flags)
   XMLFileID = LoadXML( #PB_Any, XMLFile$, Flags)
   If XMLFileID And XMLStatus(XMLFileID) = #PB_XML_Success
      *MainNode = MainXMLNode(XMLFileID)
      If *MainNode : XML_EnumNode(*MainNode, 0) : EndIf
      ProcedureReturn #True
   Else
      ProcedureReturn #False
   EndIf
EndProcedure


; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = 9
; EnableXP