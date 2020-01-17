;***********************************
;迷路仟整理 2019.03.13
;Date_日期计算
;***********************************



DateTime = Date()
Debug "今天日期: "+FormatDate("%YYYY-%MM-%DD", DateTime) 

Debug "三 天 后: "+FormatDate("%YYYY-%MM-%DD", AddDate(DateTime, #PB_Date_Day, 3))
Debug "三个月后: "+FormatDate("%YYYY-%MM-%DD", AddDate(DateTime, #PB_Date_Month, 3))
Debug "三 年 后: "+FormatDate("%YYYY-%MM-%DD", AddDate(DateTime, #PB_Date_Year, 3))









; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 15
; EnableXP