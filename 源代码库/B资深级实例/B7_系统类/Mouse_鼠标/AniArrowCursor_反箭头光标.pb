;***********************************
;迷路仟整理 2015.11.09
;AniArrowCursor_反箭头光标_反箭头光标
;***********************************

#winScreen = 0
#wmbScreen = 1
#btnScreen = 2

WindowFlags = #PB_Window_ScreenCentered| #PB_Window_SystemMenu| #PB_Window_MinimizeGadget|
              #PB_Window_MaximizeGadget| #PB_Window_SizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, 400, 250, "反箭头光标", WindowFlags)

hInstance = GetModuleHandle_(0)
hCursor = CreateCursor_(hInstance, 32, 0, 32, 32, ?_Bin_ANDPlane, ?_Bin_XORPlane)
SetClassLong_(hWindow, #GCL_HCURSOR, hCursor) 
DestroyCursor_(hCursor)
Repeat
   WinEvent  = WindowEvent()
   Select WinEvent
      Case #PB_Event_CloseWindow : IsExitWindow = #True
      Case #PB_Event_Menu 
         Debug EventMenu() 
   EndSelect
   Delay(1)
Until IsExitWindow = #True
End

;- ##########################
;- [Data]
DataSection
   _Bin_ANDPlane:   ; [行符区]反箭头光标1
      Data.l  $FFFFFFFF, $FFFFFFFF, $FDFFFFFF, $F9FFFFFF, $F1FFFFFF, $E1FFFFFF, $C1FFFFFF, $81FFFFFF
      Data.l  $01FFFFFF, $01FEFFFF, $01FCFFFF, $01F8FFFF, $81FFFFFF, $91FFFFFF, $39FFFFFF, $3DFFFFFF
      Data.l  $7FFEFFFF, $7FFEFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF
      Data.l  $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF, $FFFFFFFF
   _Bin_XORPlane:   ; [行符区]反箭头光标2
      Data.l  $01000000, $03000000, $07000000, $0F000000, $1F000000, $3F000000, $7F000000, $FF000000
      Data.l  $FF010000, $FF030000, $FF070000, $FF0F0000, $FF0F0000, $FF000000, $EF010000, $E7010000
      Data.l  $C3030000, $C0030000, $80010000, $00000000, $00000000, $00000000, $00000000, $00000000
      Data.l  $00000000, $00000000, $00000000, $00000000, $00000000, $00000000, $00000000, $00000000
EndDataSection 












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP