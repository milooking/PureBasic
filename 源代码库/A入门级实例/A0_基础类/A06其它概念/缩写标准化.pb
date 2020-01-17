;***********************************
;迷路仟整理 2015.06.21
;各种控件,函数的命令的缩写标准
;***********************************

;标准控件
   btn = ButtonGadget() 
   btm = ButtonImageGadget()  
   chk = CheckBoxGadget()   
   cmb = ComboBoxGadget()  
   ctg = CalendarGadget()  
   dtg = DateGadget() 
   hlk = HyperLinkGadget()   
   lbl = TextGadget()  
   lfm = Frame3DGadget() 
   lst = ListIconGadget()  
   lvw = ListViewGadget()  
   pic = ImageGadget()  
   prg = ProgressBarGadget()  
   ptn = OptionGadget()  
   rtx = EditorGadget()   
   scb = ScrollBarGadget()  
   txt = StringGadget()   
   tvw = TreeGadget()   
   wbs = WebGadget()  
     
 
;窗体/菜单/工具栏类
   win = OpenWindow() 
   frm = ContainerGadget()  
   wtb = CreateToolBar() 
   wsb = CreateStatusBar() 
   wmn = CreateImageMenu() 
   wmb = CreateMenu() 
   wmp = CreatePopupImageMenu() 
   wmp = CreatePopupMenu() 
   mnt = MenuItem() 

; 对话框类
   rqc = ColorRequester() 
   rqf = FontRequester() 
   rqi = InputRequester() 
   rqm = MessageRequester() 
   rqo = OpenFileRequester() 
   rqp = PathRequester() 
   rqs = SaveFileRequester() 


; 驱动器类
   fcx = ExplorerComboGadget()  
   flv = ExplorerListGadget()   
   ftv = ExplorerTreeGadget()   
           
; 容器控件
   spl = SplitterGadget()   
   pnl = PanelGadget()  
   mdi = MDIGadget() 
   scr = ScrollAreaGadget()   


; 杂项类
   ipx = IPAddressGadget()   
   spn = SpinGadget()  
   tkb = TrackBarGadget()   
   fnt = LoadFont() 
   img = CatchImage() 
   img = CreateImage() 
   img = LoadImage() 
   fid = CreateFile() 
   fid = OpenFile() 
   fid = ReadFile() 
   Mem = AllocateMemory() 
   lib = OpenLibrary() 
   avi = LoadMovie() 
   wav = CatchSound() 
   wav = LoadSound() 
   dir = CreateDirectory() 

 
; 其它:
; 前辍为: "#" :表示常量,可以 Long/Quad 
; 前辍为: "@":表示取址
; 前辍为: "$":表示数值采用16进制表示
; 前辍为: "_" :表示全局变量
; 前辍为: "*" :表示内存指针或全局指针
; 前辍为: "*p" :指向指针的指针，或指向地址的指针
; 前辍为: "__":表示结构
; 
; 后辍为: "$":表示参数为字符串类型
; ID类常量格式: "#"+缩写+主文

 
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 38
; FirstLine = 21
; EnableXP