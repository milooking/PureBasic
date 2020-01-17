;***********************************
;迷路仟整理 2019.03.13
;Date_日期时间
;***********************************


DateTime = Date()
Debug "年份:" + Str(Year(DateTime))  
Debug "月份:" + Str(Month(DateTime))  
Debug "日期:" + Str(Day(DateTime))  

Debug "小时:" + Str(Hour(DateTime))  
Debug "分钟:" + Str(Minute(DateTime))  
Debug "秒数:" + Str(Second(DateTime)) 
Debug "星期:" + Str(DayOfWeek(DateTime)) 



Debug ""
;无视大小写,注意,分钟用I
Debug FormatDate("%YYYY-%MM-%DD %HH:%II:%SS", DateTime)  
Debug FormatDate("%yyyy-%mm-%dd %hh:%ii:%ss", DateTime)
Debug FormatDate("%YYYY-%MM-%DD", DateTime)  
Debug FormatDate("%HH:%II:%SS", DateTime)  


;支持中文
Debug FormatDate("%YYYY年%MM月%DD日 %HH:%II:%SS", DateTime) 

;支持其它内容
Week$ = Mid("日一二三四五六", DayOfWeek(DateTime)+1, 1)
Debug FormatDate("%YYYY年%MM月%DD日 %HH:%II:%SS 星期", DateTime)+Week$


Debug ""
;时间戳
Debug "时间戳: " + FormatDate("%YYYY-%MM-%DD %HH:%II:%SS", 0)  

;解析时间
Debug ParseDate("%YYYY-%MM-%DD %HH:%II:%SS", "2019-03-12 23:56:45") 
Debug Date(2019, 03, 12, 23, 56, 45)












; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 26
; EnableXP