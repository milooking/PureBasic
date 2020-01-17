;***********************************
;迷路仟整理 2019.02.16
;自绘控件_视图列表控件
;***********************************

Enumeration
   #winScreen
   #cvsScreen
   #scrScreen
   #imgScreen
   #fntScreen12
   #fntScreen09
EndEnumeration

#ScreenW = 400
#ScreenH = 350
#TitleH = 030

;列表内容结构
Structure __MessageInfo
   Name$
   AvatarID.l
   Notice$
   DataTime$
EndStructure

;主体结构
Structure __MainScreen
   ScrollIndex.l
   SelectIndex.l
   MoveOnIndex.l
EndStructure


Global NewList _ListMessage.__MessageInfo()
Global _Main.__MainScreen

;绘制列表控制
Procedure EventGadget_ShowList()
   If StartDrawing(CanvasOutput(#cvsScreen))
      W = GadgetWidth(#cvsScreen)
      H = GadgetHeight(#cvsScreen)
      ;绘制背景
      Box(0, 0, W, H, $FFF8F8F8)
      
      ;绘制表头
      DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)      
      FrontColor($FFE0E0E0)
      BackColor ($10F0F0F0)
      LinearGradient(000, 0, 000, #TitleH)    
      Box(0, 0, W, #TitleH)
      DrawingMode(#PB_2DDrawing_Transparent)  
      DrawingFont(FontID(#fntScreen12))
      DrawText(050, 008, "聊天群",   $FF5CD3)
      DrawText(280, 008, "聊天内容", $FF5CD3)


      ;绘制列表项内容
      Y = #TitleH
      ScrollIndex = _Main\ScrollIndex
      *pMessage.__MessageInfo = SelectElement(_ListMessage(), ScrollIndex) ;从当前滚动页面开始
      While *pMessage
         DrawingMode(#PB_2DDrawing_Gradient|#PB_2DDrawing_AlphaBlend)   
         If _Main\SelectIndex = ScrollIndex        ;当前选中项背景色
            FrontColor($FFBBECFF)
            BackColor ($10BBECFF)
         ElseIf _Main\MoveOnIndex = ScrollIndex    ;当前鼠标在上背景色
            FrontColor($FFFFBBE7)
            BackColor ($10FFBBE7)
         Else                                      ;正常子项背景色
            FrontColor($FFE0E0E0)
            BackColor ($10F0F0F0)
         EndIf 
         LinearGradient(000, Y, 000, Y+40)         ;绘制渐变背景
         Box(0, Y, W, 40)
         
         ;绘制文本
         DrawingMode(#PB_2DDrawing_Transparent)          
         DrawingFont(FontID(#fntScreen12))
         DrawText(050, Y+012, *pMessage\Name$, $FF6060)
         DrawingFont(FontID(#fntScreen09))
         DrawText(W-TextWidth(*pMessage\DataTime$)-030, Y+005, *pMessage\DataTime$, $606060)
         DrawText(W-TextWidth(*pMessage\Notice$  )-030, Y+022, *pMessage\Notice$,   $606060)
         
         ;绘制头像
         DrawAlphaImage(ImageID(*pMessage\AvatarID), 010, Y+004)
         Y+40
         If Y > H : Break : EndIf                                       ;超出显示范围
         *pMessage.__MessageInfo = NextElement(_ListMessage())
         ScrollIndex+1
      Wend
      StopDrawing()
   EndIf
EndProcedure

;滚动条事件
Procedure EventGadget_scrScreen()
   ScrollIndex = GetGadgetState(#scrScreen)
   If _Main\ScrollIndex <> ScrollIndex
      _Main\ScrollIndex = ScrollIndex
      EventGadget_ShowList()
   EndIf 
EndProcedure

;画布事件
Procedure EventGadget_cvsScreen()
   Select EventType()
      Case #PB_EventType_MouseWheel
         Scroll = GetGadgetAttribute(#cvsScreen, #PB_Canvas_WheelDelta )
         Select Scroll
            Case -1 : SetGadgetState(#scrScreen, _Main\ScrollIndex+1)
            Case 01 : SetGadgetState(#scrScreen, _Main\ScrollIndex-1)
            Default : ProcedureReturn
         EndSelect 
         ScrollIndex = GetGadgetState(#scrScreen)
         If _Main\ScrollIndex <> ScrollIndex
            _Main\ScrollIndex = ScrollIndex
            EventGadget_ShowList()
         EndIf 
   
      Case #PB_EventType_LeftClick
         X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
         Index = (Y-#TitleH)/40
         If Index < 0 : ProcedureReturn : EndIf 
         If _Main\SelectIndex <> _Main\ScrollIndex + Index
            _Main\SelectIndex = _Main\ScrollIndex + Index
            EventGadget_ShowList()
         EndIf 
         
      Case #PB_EventType_MouseMove
         X = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseX)
         Y = GetGadgetAttribute(#cvsScreen, #PB_Canvas_MouseY)
         Index = (Y-#TitleH) / 40
         If Index < 0 : ProcedureReturn : EndIf 
         If _Main\MoveOnIndex <> _Main\ScrollIndex + Index
            _Main\MoveOnIndex = _Main\ScrollIndex + Index
            EventGadget_ShowList()
         EndIf 
   EndSelect
EndProcedure

;- 模拟显示内容
UsePNGImageDecoder()
LoadImage(#imgScreen, "Avatar.png")
#AvatarName$ = "奇逸,Jozhesheng,烨磊Di酸奶,贝琪De恐龙,Ignativs、热忱,高粱,奢靡ヽ宠物鲱,小意境,才艺的香蕉,彭魄ヽ宁静,可人ヽ达尼尔,"+
               "你还记得名靓的女孩,褒贬Di痛心,孤注一掷DI芝璐,ING丨无忧无虑De鸿熙,所罗门,bingshouの炒米粉,壮实、菩提,霸爷の宁静,懊悔ヽ忻愉,"+
               "Hardy,机灵的甜瓜,暄嫣,Vipのnuanchi2015,萨琳娜の海螺,浓郁芬芳的紫菜汤,白头鹰de娇嫩,干瘦,诗柳,颖然DE火锅,yanchen丨石貂,"+
               "知足常乐ヽ达莲娜,唯唯诺诺、吊灯,谨小慎微的白蚁,奇怪,曼语ヽ知更鸟,忻然、自卑,直率、yaowen,海洛伊丝,莴苣菜Di憔悴,伤天害理DI白鹇,"+
               "拾荒者De傍徨,话里有刺ヽ甘泽,诗怀丨2010,xueliu,wanxiu|咖喱饭,始终如一ヽ四叶草,用阴影描绘色彩ヾ谨慎,坚定不移ヽ思愆,沃若,"+
               "Vipヽ曼文,kaijiの深海鱼,面包Di善意,铁骨铮铮De毛豆,你若不惜我亦不爱,曜栋,琼音ヽ阳台,Ai|keyi|青柠檬,怏然自足ヽyian,移樽就教ヽ咸鸭蛋,"+
               "小兔ヽ殷勤,悲痛,阳煦的对虾,帝辉di忧惧,得过且过のRonald,Bernie2012,床单,子虚乌有ヽ秋沙鸭,摯愛ヾ温存,自谦、峻熙,彦昌,Una,qingchuan、"+
               "会议桌,雪貂ヽ囍槑,伤肝不伤感の沮丧,假惺惺的干巴,鸿畴2013,Vip|阳曦,yingyuan|蜘蛛,langning|坦然,诚实真诚ヽ甜玉米,宝宝脾气不坏,"+
               "昕月ヽ2009,博学的头饰,Ai丨huarong、巴豆,悠闲のchengye,乐极生悲、蚝油,蒲公英,爱的发声练习,莹琇de鼹鼠,芳霜DI心烦,惨绝人寰|hairuo,"+
               "huaxin,我行我素ヾ葡萄酒,香菇、单恋,耽恋の朴素,贪吃的心诺,昕靓,suxiao,蓓姬の白糖,跳蚤,安逸de甘蔗,"

CurrTime = Date() : StartTime = CurrTime - 86400*30
For k = 0 To 100-1
   Pos = k % 125 : X = Pos % 25 : Y = Pos / 25
   *pMessage.__MessageInfo = AddElement(_ListMessage())
   *pMessage\Name$     = StringField(#AvatarName$,   k % 100+1, ",")
   *pMessage\AvatarID  = GrabImage(#imgScreen, #PB_Any, X*30, Y*30, 30, 30)
   *pMessage\Notice$   = "["+StringField(#AvatarName$, Random(100)+1, ",")+"]"+ "发来信息"
   *pMessage\DataTime$ = FormatDate("%YYYY-%MM-%DD %hh:%ii:%ss", Random(CurrTime, StartTime))
Next

;-=======================


LoadFont(#fntScreen12, "", 12)
LoadFont(#fntScreen09, "", 09)

WindowFlags = #PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget
hWindow = OpenWindow(#winScreen, 0, 0, #ScreenW, #ScreenH, "自绘控件_视图列表控件", WindowFlags)
CanvasGadget(#cvsScreen, 000, 000, #ScreenW, #ScreenH, #PB_Canvas_Container|#PB_Canvas_Keyboard)
   ScrollBarGadget(#scrScreen, #ScreenW-20, 000, 020, #ScreenH, 0, 100-1, 1, #PB_ScrollBar_Vertical)
CloseGadgetList()
SetActiveGadget(#cvsScreen)
BindGadgetEvent(#scrScreen, @EventGadget_scrScreen())
BindGadgetEvent(#cvsScreen, @EventGadget_cvsScreen())
EventGadget_ShowList()

Repeat
   EventNum  = WindowEvent()
   GadgetID  = EventGadget()
   EventType = EventType()
   Select EventNum
      Case #PB_Event_CloseWindow : IsExitWindow = #True 
      Case #PB_Event_SizeWindow 
      Case #PB_Event_Gadget 
   EndSelect
   Delay(1)   
Until IsExitWindow = #True 
End



; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 71
; Folding = d-
; EnableXP
; EnableUnicode