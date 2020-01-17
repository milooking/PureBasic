;***********************************
;迷路仟整理 2019.03.15
;获取硬盘信息
;***********************************


Structure IDEREGS 
    bFeaturesReg.b 
    bSectorCountReg.b 
    bSectorNumberReg.b 
    bCylLowReg.b 
    bCylHighReg.b 
    bDriveHeadReg.b 
    bCommandReg.b 
    bReserved.b 
EndStructure 

Structure SENDCMDINPARAMS 
    cBufferSize.l 
    irDriveRegs.IDEREGS 
    bDriveNumber.b 
    bReserved.b[3] 
    dwReserved.l[4]
EndStructure 

Structure  DRIVERSTATUS 
    bDriveError.b 
    bIDEStatus.b 
    bReserved.b[2]
    dwReserved.l[2]
EndStructure 

Structure  SENDCMDOUTPARAMS 
    cBufferSize.l 
    DStatus.DRIVERSTATUS      
    bBuffer.b[512]
EndStructure 

#DFP_RECEIVE_DRIVE_DATA = $7C088 

Procedure$ ChangeHighLowByte(Instring$) 
   Sdummy$ = "" 
   Lenght = Len(Instring$) 
   For i=1 To Lenght Step 2 
      If (i+1)<=Lenght 
         Sdummy$ = Sdummy$ + Mid(Instring$,i+1,1)+Mid(Instring$,i,1)  
      EndIf 
   Next 
   ProcedureReturn Sdummy$
EndProcedure 

Procedure GetHardDiskInfo(CurrentDriveNum) 
   hHardDisk = CreateFile_("\\.\PhysicalDrive" + Str(CurrentDriveNum),#GENERIC_READ|#GENERIC_WRITE, #FILE_SHARE_READ|#FILE_SHARE_WRITE,0, #OPEN_EXISTING, 0, 0) 
   If hHardDisk  
      bin.SENDCMDINPARAMS 
      bin\bDriveNumber = CurrentDriveNum 
      bin\cBufferSize = 512 
      If (CurrentDriveNum & 1) 
         bin\irDriveRegs\bDriveHeadReg = $B0 
      Else 
         bin\irDriveRegs\bDriveHeadReg = $A0 
      EndIf 
      bin\irDriveRegs\bCommandReg      = $EC 
      bin\irDriveRegs\bSectorCountReg  = 1 
      bin\irDriveRegs\bSectorNumberReg = 1 

      Result = DeviceIoControl_(hHardDisk, #DFP_RECEIVE_DRIVE_DATA, bin, SizeOf(SENDCMDINPARAMS), bout.SENDCMDOUTPARAMS , SizeOf(SENDCMDOUTPARAMS), @ByteResult, 0) 
      If ByteResult > 0 
         Offset = 55 
         Lenght = 40
         Model$ = PeekS(@bout\bBuffer[0]+Offset-1 ,Lenght, #PB_Ascii)
         Model$ = ChangeHighLowByte(Model$) 
         
         Offset  = 21
         Lenght  = 20 
         Serial$ = PeekS(@bout\bBuffer[0]+Offset-1 ,Lenght, #PB_Ascii)
         Serial$ = Trim(ChangeHighLowByte(Serial$)) 
         Offset    = 47
         Lenght    = 08          
         Firmware$ = PeekS(@bout\bBuffer[0]+Offset-1 ,Lenght, #PB_Ascii)
         Firmware$ = ChangeHighLowByte(Firmware$) 
         Debug "硬盘信息"
         Debug "供 应 商: "+Model$
         Debug "硬盘串号: "+Serial$
         Debug "固件版本: "+Firmware$
         Debug ""
      EndIf 
   Else 
      Beep_(100,100) 
   EndIf 
EndProcedure

GetHardDiskInfo(0) 
GetHardDiskInfo(1) 
GetHardDiskInfo(2) 








; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 2
; Folding = Q-
; EnableXP
; EnableOnError