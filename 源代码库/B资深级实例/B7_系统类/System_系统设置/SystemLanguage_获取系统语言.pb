;***********************************
;迷路仟整理 2019.03.15
;SystemLanguage_获取系统语言
;***********************************


Procedure$ GetSystemLanguage()
   Language = GetUserDefaultLCID_()
   Language_Main = Language & $FF
   Language_Sub  = Language >> 8 & $ff
   Select Language_Main
      Case $00: Language$="Neutral"
         Select Language_Sub
            Case $01: SubLanguage$="Default"
            Case $02: SubLanguage$="System Default"
         EndSelect
      Case $01: Language$="Arabic"
         Select Language_Sub
            Case $01: SubLanguage$="Arabia"
            Case $02: SubLanguage$="Iraq"
            Case $03: SubLanguage$="Egypt" 
            Case $04: SubLanguage$="Libya" 
            Case $05: SubLanguage$="Algeria" 
            Case $06: SubLanguage$="Morocco" 
            Case $07: SubLanguage$="Tunisia" 
            Case $08: SubLanguage$="Oman" 
            Case $09: SubLanguage$="Yemen" 
            Case $10: SubLanguage$="Syria" 
            Case $11: SubLanguage$="Jordan" 
            Case $12: SubLanguage$="Lebanon" 
            Case $13: SubLanguage$="Kuwait" 
            Case $14: SubLanguage$="U.A.E." 
            Case $15: SubLanguage$="Bahrain"
            Case $16: SubLanguage$="Qatar"
         EndSelect
      Case $02: Language$="Bulgarian"
      Case $03: Language$="Catalan"  
      Case $04: Language$="Chinese"
         Select Language_Sub
            Case $01: SubLanguage$="Traditional"
            Case $02: SubLanguage$="Simplified"
            Case $03: SubLanguage$="Hong Kong SAR, PRC"
            Case $04: SubLanguage$="Singapore"
            Case $05: SubLanguage$="Macau"
         EndSelect
      Case $05: Language$="Czech"
      Case $06: Language$="Danish" 
      Case $07: Language$="German" 
         Select Language_Sub
            Case $01: SubLanguage$=""
            Case $02: SubLanguage$="Swiss"
            Case $03: SubLanguage$="Austrian"
            Case $04: SubLanguage$="Luxembourg"
            Case $05: SubLanguage$="Liechtenstein"
         EndSelect
      Case $08: Language$="Greek" 
      Case $09: Language$="English"
         Select Language_Sub
            Case $01: SubLanguage$="US"
            Case $02: SubLanguage$="UK"
            Case $03: SubLanguage$="Australian"
            Case $04: SubLanguage$="Canadian"
            Case $05: SubLanguage$="New Zealand"
            Case $06: SubLanguage$="Ireland"
            Case $07: SubLanguage$="South Africa"
            Case $08: SubLanguage$="Jamaica"
            Case $09: SubLanguage$="Caribbean"
            Case $0a: SubLanguage$="Belize"
            Case $0b: SubLanguage$="Trinidad" 
            Case $0c: SubLanguage$="Zimbabwe"
            Case $0d: SubLanguage$="Philippines"
         EndSelect
      Case $0a: Language$="Spanish"
         Select Language_Sub
            Case $01: SubLanguage$="Castilian" 
            Case $02: SubLanguage$="Mexican" 
            Case $03: SubLanguage$="Modern"
            Case $04: SubLanguage$="Guatemala"
            Case $05: SubLanguage$="Costa Rica"
            Case $06: SubLanguage$="Panama"
            Case $07: SubLanguage$="Dominican Republic"
            Case $08: SubLanguage$="Venezuela"
            Case $09: SubLanguage$="Colombia"
            Case $0a: SubLanguage$="Peru"
            Case $0b: SubLanguage$="Argentina"
            Case $0c: SubLanguage$="Ecuador"
            Case $0d: SubLanguage$="Chile"
            Case $0e: SubLanguage$="Uruguay"
            Case $0f: SubLanguage$="Paraguay" 
            Case $10: SubLanguage$="Bolivia"
            Case $11: SubLanguage$="El Salvador"
            Case $12: SubLanguage$="Honduras"
            Case $13: SubLanguage$="Nicaragua"
            Case $14: SubLanguage$="Puerto Rico"
         EndSelect
      Case $0b: Language$="Finnish" 
      Case $0c: Language$="French" 
         Select Language_Sub
            Case $01: SubLanguage$="" 
            Case $02: SubLanguage$="Belgian"
            Case $03: SubLanguage$="Canadian"
            Case $04: SubLanguage$="Swiss"
            Case $05: SubLanguage$="Luxembourg"
            Case $06: SubLanguage$="Monaco"
         EndSelect
      Case $0d: Language$="Hebrew" 
      Case $0e: Language$="Hungarian" 
      Case $0f: Language$="Icelandic" 
      Case $10: Language$="Italian"
           If Language_Sub=$02: SubLanguage$="Swiss" :EndIf
      Case $11: Language$="Japanese" 
      Case $12: Language$="Korean" 
      Case $13: Language$="Dutch"
         If Language_Sub=$02: SubLanguage$="Belgian" :EndIf
      Case $14: Language$="Norwegian"
         Select Language_Sub
            Case $01: SubLanguage$="Norwegian"
            Case $02: SubLanguage$="Nynorsk"
         EndSelect
      Case $15: Language$="Polish" 
      Case $16: Language$="Portuguese"
         If Language_Sub=$02: SubLanguage$="Brazilian" :EndIf
      Case $18: Language$="Romanian" 
      Case $19: Language$="Russian" 
      Case $1a: Language$="Croatian" 
      Case $1a: Language$="Serbian"
         Select Language_Sub
            Case $02: SubLanguage$="Latin"
            Case $03: SubLanguage$="Cyrillic"
         EndSelect
      Case $1b: Language$="Slovak" 
      Case $1c: Language$="Albanian" 
      Case $1d: Language$="Swedish"
         If Language_Sub=$02: SubLanguage$="Finland" :EndIf  
      Case $1e: Language$="Thai" 
      Case $1f: Language$="Turkish"  
      Case $20: Language$="Urdu"
         Select Language_Sub
            Case $01: SubLanguage$="Pakistan"
            Case $02: SubLanguage$="India"
         EndSelect
      Case $21: Language$="Indonesian" 
      Case $22: Language$="Ukrainian" 
      Case $23: Language$="Belarusian" 
      Case $24: Language$="Slovenian" 
      Case $25: Language$="Estonian" 
      Case $26: Language$="Latvian" 
      Case $27: Language$="Lithuanian"
         If Language_Sub: SubLanguage$="Classic" :EndIf
      Case $29: Language$="Farsi" 
      Case $2a: Language$="Vietnamese" 
      Case $2b: Language$="Armenian" 
      Case $2c: Language$="Azeri"
         Select Language_Sub
            Case $01: SubLanguage$="Latin"
            Case $02: SubLanguage$="Cyrillic"
         EndSelect
      Case $2d: Language$="Basque" 
      Case $2f: Language$="Macedonian" 
      Case $36: Language$="Afrikaans" 
      Case $37: Language$="Georgian" 
      Case $38: Language$="Faeroese" 
      Case $39: Language$="Hindi" 
      Case $3e: Language$="Malay"
         Select Language_Sub
            Case $01: SubLanguage$="Malaysia"
            Case $02: SubLanguage$="Brunei Darassalam"
         EndSelect
      Case $3f: Language$="Kazak" 
      Case $41: Language$="Swahili" 
      Case $43: Language$="Uzbek"
         Select Language_Sub
            Case $01: SubLanguage$="Latin"
            Case $02: SubLanguage$="Cyrillic"
         EndSelect 
      Case $44: Language$="Tatar" 
      Case $45: Language$="Bengali" 
      Case $46: Language$="Punjabi" 
      Case $47: Language$="Gujarati" 
      Case $48: Language$="Oriya" 
      Case $49: Language$="Tamil" 
      Case $4a: Language$="Telugu" 
      Case $4b: Language$="Kannada" 
      Case $4c: Language$="Malayalam" 
      Case $4d: Language$="Assamese" 
      Case $4e: Language$="Marathi" 
      Case $4f: Language$="Sanskrit" 
      Case $57: Language$="Konkani" 
      Case $58: Language$="Manipuri" 
      Case $59: Language$="Sindhi" 
      Case $60: Language$="Kashmiri"
         If Language_Sub=$02 : SubLanguage$="India" : EndIf
      Case $61: Language$="Nepali"
         If Language_Sub=$02 : SubLanguage$="India" : EndIf
   EndSelect
   If SubLanguage$
      ProcedureReturn Language$+" "+SubLanguage$
   Else
      ProcedureReturn Language$
   EndIf 
EndProcedure

Debug GetSystemLanguage()



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 199
; FirstLine = 162
; Folding = -
; EnableXP
; EnableOnError