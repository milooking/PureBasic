;***********************************
;迷路仟整理 2019.01.30
;DateTime_日期与时间
;***********************************
; PureBasic 使用的是Unix时间系统,时间戳为: 1970-01-01, 00:00:00
; 最小值:0表示1970-01-01, 00:00:00, 最大值为2038-01-19, 03:14:07



;【获取时间值】
Debug Date()  
Debug Date(1999, 12, 31, 23, 59, 59)
Debug Day(Date(2002, 10, 3, 0, 0, 0))
Debug Month(Date(2002, 10, 3, 0, 0, 0))
Debug Hour(Date(1970, 1, 1, 11, 3, 45))
Debug Minute(Date(1970, 1, 1, 11, 3, 45))
Debug Second(Date(1970, 1, 1, 11, 3, 45))

;【获取时间格式文本】
Debug FormatDate("%yyyy-%mm-%dd %hh:%ii:%ss", Date()) 
Debug FormatDate("%yyyy年%mm月%dd日 %hh时%ii分%ss秒", Date()) 

;【获取格式文本中的时间值】
Debug ParseDate("%yyyy-%mm-%dd", "2010-10-11")    
Debug ParseDate("%yy-%mm-%dd",   "09-10-11")  

;【添加时间】
Debug FormatDate("%yyyy-%mm-%dd", AddDate(Date(), #PB_Date_Year, 2))
Debug FormatDate("%yyyy-%mm-%dd", AddDate(Date(), #PB_Date_Month, -2))
; #PB_Date_Year   
; #PB_Date_Month  
; #PB_Date_Week   
; #PB_Date_Day    
; #PB_Date_Hour   
; #PB_Date_Minute 
; #PB_Date_Second 


;【获取星期】
Debug DayOfWeek(Date(2006, 10, 30, 0, 0, 0)) 
;   0 : Sunday
;   1 : Monday
;   2 : Tuesday
;   3 : Wednesday
;   4 : Thursday
;   5 : Friday
;   6 : Saturday


;【获取天数】
Debug DayOfYear(Date(2002, 2, 1, 0, 0, 0)) 










; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 37
; FirstLine = 15
; EnableThread
; EnableXP