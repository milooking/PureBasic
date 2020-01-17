;***********************************
;迷路仟 最后修改:2018.08.29
;V001:基础版功能:采用空格最少的单元进行枚举(网上大部分这么干),速度要几十秒到几百秒
;V002:优化速度,采用可能性最小的单元进行枚举,将时间降到毫秒级
;V003:优化速度,对判断函数进行算法优化,使用速度从140ms降到30ms
;***********************************

;-[Constant]
Enumeration
   #winScreen
EndEnumeration

;-[Structure]
;用到输入/输出结果的结构
Structure __ResultInfo
   FindValue.l
   MaxCount.l
   MinRow.l
   MinCol.l
EndStructure

;-[Global]
Global Dim _DimResult.b(8,8)  ;用到存放单元枚举结果
Global _IsStopSudoku          ;中断线程

;-[Function]
;判断某个空格的[待填数],返回[待填数]数量
Procedure Sudoku_Judgment(Array DimOracle.b(2), *pResult.__ResultInfo)
   With *pResult
      \FindValue = 0  : r = \MinRow/3*3 : c = \MinCol/3*3     
      For k = 0 To 8       
         \FindValue | (1<<DimOracle(\MinRow,k))       ;将横行的出现过的[待填数]去除掉
         \FindValue | (1<<DimOracle(k,\MinCol))       ;将纵列的出现过的[待填数]去除掉
         \FindValue | (1<<DimOracle(r+k/3,c+k%3))     ;将3x3区域中出现过的[待填数]去除掉
      Next 
      ;$3FE=(1<<1)|(1<<2)|(1<<3)|...|(1<<9),用位来记录,
      For k = 1 To 9       ;有占位情况的,就可以我们要求的[待填数]
         If (\FindValue >> k) & 1 = 0 : Count+1 : EndIf 
      Next 
   EndWith
   ProcedureReturn Count
EndProcedure

;找到最有价值的单元[待填数]最小的空格获胜.
Procedure Sudoku_FindCell(Array DimOracle.b(2), *pResult.__ResultInfo)
   MaxCount = 9 : Result.__ResultInfo
   For r = 0 To 8   
      For c = 0 To 8  
         If DimOracle(r, c) : Continue : EndIf 
         If _IsStopSudoku = #True : ProcedureReturn : EndIf 
         Result\MinRow = R
         Result\MinCol = C
         Count = Sudoku_Judgment(DimOracle(), Result) ;获取[待填数]数量
         Complete+Count                               ;累计[待填数]数量,如果为0,说明已经完成
         If Count < MaxCount                         ;[待填数]数量最小的获胜
            MaxCount = Count
            CopyMemory_(*pResult, Result, SizeOf(__ResultInfo))
            If Count = 1 : ProcedureReturn Complete : EndIf 
         EndIf 
      Next 
   Next 
   ProcedureReturn Complete
EndProcedure

;递归函数,用于进行递层枚举,
Procedure Sudoku_Simulation(Array DimArrary.b(2))
   Dim DimOracle.b(8,8)
   Result.__ResultInfo
   CopyMemory_(DimOracle(), DimArrary(), 81)   
   If Sudoku_FindCell(DimOracle(), Result) = 0    ;如果已经完成,保存各个单元的记录,用于输出到界面
      CopyMemory_(_DimResult(), DimArrary(), 81) 
      ProcedureReturn #True 
   EndIf 
   Bit = 1
   While Bit < 10                          ;将[待填数],进行逐一枚举
      If Result\FindValue >> Bit & 1 = 0   ;有占位情况的,才是[待填数]
         DimOracle(Result\MinRow, Result\MinCol) = Bit
         If _IsStopSudoku = #True : ProcedureReturn #False : EndIf
         If Sudoku_Simulation(DimOracle()) = #True: ProcedureReturn #True : EndIf   
      EndIf 
      Bit+1
   Wend 
   ProcedureReturn #False
EndProcedure

;线程函数,用来暴力穷举
Procedure Thread_Simulation(Index)
   Dim DimArrary.b(8,8)
   For y = 0 To 8
      For x = 0 To 8
         DimArrary(y,x) = Val(GetGadgetText(y*10+x))
         If DimArrary(y,x)
            SetGadgetColor(y*10+x, #PB_Gadget_FrontColor, $FF)
         Else 
            SetGadgetColor(y*10+x, #PB_Gadget_FrontColor, $00)
         EndIf 
      Next 
   Next 
   CopyMemory_(_DimResult(), DimArrary(), 81) 
   Time = GetTickCount_() 
   Result = Sudoku_Simulation(DimArrary())
   Time = GetTickCount_()-Time
   If Result
      For y = 0 To 8
         For x = 0 To 8
            SetGadgetText(y*10+x, Str(_DimResult(y,x)))
         Next 
      Next 
      MessageRequester("迷路提示", "AI已完成数独!!"+#LF$+"用时: "+Str(Time)+"毫秒")
   ElseIf _IsStopSudoku = #True
      MessageRequester("迷路提示", "中断推算!!"+#LF$+"用时: "+Str(Time)+" 毫秒")
   Else  
      MessageRequester("迷路提示", "数独无解!!"+#LF$+"用时: "+Str(Time)+" 毫秒")
   EndIf 
   SetGadgetText(0100, "开始")
   _IsStopSudoku = #True
   DisableGadget(0101, #False)
EndProcedure

;运行事件
Procedure Event_Simulation()
   If _IsStopSudoku = #True
      SetGadgetText(0100, "停止")
      DisableGadget(0101, #True)
      _IsStopSudoku = #False
      CreateThread(@Thread_Simulation(), Index)
   Else 
      SetGadgetText(0100, "开始")
      _IsStopSudoku = #True
      DisableGadget(0101, #False)
   EndIf 
EndProcedure

;清空事件
Procedure Event_ClearGadget()
   For y = 0 To 8
      For x = 0 To 8
         If GetGadgetColor(y*10+x, #PB_Gadget_FrontColor) = 0
            SetGadgetText(y*10+x, "")
         EndIf 
         SetGadgetColor(y*10+x, #PB_Gadget_FrontColor, 0)
      Next 
   Next 
EndProcedure

;- ##########################
;- [Main]
Dim DimArrary.b(8,8)
CopyMemory_(DimArrary(), ?__BIN_Test, 81)
LoadFont(16, "宋体", 16, #PB_Font_Bold)
SetGadgetFont(#PB_Default, FontID(16))
WindowFlags  = #PB_Window_SystemMenu |#PB_Window_MinimizeGadget |#PB_Window_ScreenCentered
hWindow = OpenWindow(#winScreen, 0, 0, 400,300, "[迷路]9x9数独-AI", WindowFlags) 

For y = 0 To 8
   For x = 0 To 8
      If DimArrary(y,x) = 0 
         Color = 0 : Text$ = "" 
      Else 
         Color = $0000FF : Text$ = Str(DimArrary(y,x) )
      EndIf 
      StringGadget(y*10+x, 10+x*30+x/3*5, 10+y*30+y/3*5, 30, 30, Text$, #PB_String_Numeric|#ES_CENTER)
      SetGadgetColor(y*10+x, #PB_Gadget_FrontColor, Color)
   Next 
Next 
ButtonGadget(0101, 310, 010, 080, 030, "清空")
ButtonGadget(0100, 310, 050, 080, 030, "开始")
_IsStopSudoku = #True

Repeat
   Select WindowEvent()
      Case #PB_Event_CloseWindow : IsExitWindow = #True : _IsStopTraining = #True
      Case #PB_Event_Gadget
         Select EventGadget() 
            Case 0100 : Event_Simulation()
            Case 0101 : Event_ClearGadget()
         EndSelect 
      Default 
   EndSelect
   Delay(1)
Until IsExitWindow = #True 

;- [Data] 实例
DataSection
   __BIN_Test:
;    Data.b 0,9,0,4,0,0,0,0,3
;    Data.b 0,0,0,0,0,9,0,6,0
;    Data.b 4,0,0,3,0,0,0,0,1
;    Data.b 8,0,0,6,7,3,4,1,0
;    Data.b 1,0,0,9,0,0,6,0,0
;    Data.b 9,0,0,0,5,1,7,0,8
;    Data.b 0,1,0,0,4,0,3,8,0
;    Data.b 0,0,8,0,0,0,0,9,0
;    Data.b 0,5,0,0,9,0,0,0,0

   Data.b 8,0,0,0,0,0,0,0,0
   Data.b 0,0,3,6,0,0,0,0,0
   Data.b 0,7,0,0,9,0,2,0,0
   Data.b 0,5,0,0,0,7,0,0,0
   Data.b 0,0,0,0,4,5,7,0,0
   Data.b 0,0,0,1,0,0,0,3,0
   Data.b 0,0,1,0,0,0,0,6,8
   Data.b 0,0,8,5,0,0,0,1,0
   Data.b 0,9,0,0,0,0,4,0,0
EndDataSection




; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 8
; Folding = c9
; EnableXP
; Executable = 迷路9x9数独AI.exe
; EnableUnicode