;***********************************
;迷路仟整理 2015.10.24
;WM常量
;***********************************

$0000 = #WM_NULL              ; 空消息,可检测程序是否有响应等  
$0001 = #WM_CREATE            ; 新建一个窗口  
$0002 = #WM_DESTROY           ; 销毁一个窗口  
IDSTR($0004) 
$0003 = #WM_MOVE              ; 移动一个窗口  
$0005 = #WM_SIZE              ; 改变一个窗口的大小  
$0006 = #WM_ACTIVATE          ; 一个窗口被激活或失去激活状态  
$0007 = #WM_SETFOCUS          ; 将焦点转向一个窗口  
$0008 = #WM_KILLFOCUS         ; 使一个窗口失去焦点  
IDSTR($0009) 
$000A = #WM_ENABLE            ; 使一个窗口处于可用状态  
$000B = #WM_SETREDRAW         ; 设置窗口是否能重绘  
$000C = #WM_SETTEXT           ; 设置一个窗口的文本  
$000D = #WM_GETTEXT           ; 复制窗口的文本到缓冲区  
$000E = #WM_GETTEXTLENGTH                ; 得到窗口的文本长度(不含结束符)  
$000F = #WM_PAINT             ; 窗口重绘  
$0010 = #WM_CLOSE             ; 用户关闭窗口时会发送本消息,紧接着会发送WM_DESTROY消息  
$0011 = #WM_QUERYENDSESSION   ; 关机或注销时系统会按优先级给各进程发送WM_QUERYENDSESSION,告诉应用程序要关机或注销了  
$0012 = #WM_QUIT              ; 关闭消息循环结束程序的运行  
$0013 = #WM_QUERYOPEN         ; 最小化的窗口即将被恢复以前的大小位置  
$0014 = #WM_ERASEBKGND        ; 当一个窗口的背景必须被擦除时本消息会被触发(如:窗口大小改变时)  
$0015 = #WM_SYSCOLORCHANGE    ; 当系统颜色改变时,发送本消息给所有顶级窗口  
$0016 = #WM_ENDSESSION        ; 关机或注销时系统会发出WM_QUERYENDSESSION消息,然后将本消息发送给应用程序,通知程序会话结束  
IDSTR($0017) 
$0018 = #WM_SHOWWINDOW        ; 发送本消息给一个窗口,以便隐藏或显示该窗口  
IDSTR($0019) 
$001A = #WM_WININICHANGE      ; 读写\"win.ini\"时会发送本消息给所有顶层窗口,通知其它进程该文件已被更改  
$001B = #WM_DEVMODECHANGE     ; 改变设备模式设置(\"win.ini\")时,处理本消息的应用程序可重新初始化它们的设备模式设置  
$001C = #WM_ACTIVATEAPP       ; 窗口进程激活状态改动,正被激活的窗口属于不同的应用程序 //??  
$001D = #WM_FONTCHANGE        ; 当系统的字体资源库变化时发送本消息给所有顶级窗口  
$001E = #WM_TIMECHANGE        ; 当系统的时间变化时发送本消息给所有顶级窗口  
$001F = #WM_CANCELMODE        ; 发送本消息来取消某种正在进行的模态(操作)(如鼠示捕获),例如:启动一个模态窗口时,父窗会收到本消息;该消息无参数  
$0020 = #WM_SETCURSOR         ; 若鼠标光标在某窗口内移动且鼠标没被捕获时,就会发送本消息给某个窗口  
$0021 = #WM_MOUSEACTIVATE     ; 当鼠标光标在某个未激活窗口内,而用户正按着鼠标的某个键时,会发送本消息给当前窗口  
$0022 = #WM_CHILDACTIVATE     ; 点击窗口标题栏或当窗口被激活、移动、大小改变时,会发送本消息给MDI子窗口  
$0023 = #WM_QUEUESYNC         ; 本消息由基于计算机的训练程序发送,通过WH_JOURNALPALYBACK的HOOK程序分离出用户输入消息  
$0024 = #WM_GETMINMAXINFO     ; 当窗口将要改变大小或位置时,由系统发送本消息给窗口,用户拖动一个可重置大小的窗口时便会发出本消息  
IDSTR($0025) 
$0026 = #WM_PAINTICON         ; 当一个最小化的窗口图标将被重绘时发送本消息  
$0027 = #WM_ICONERASEBKGND    ; 本消息发送给某个最小化的窗口,仅当它在画图标前它的背景必须被重画  
$0028 = #WM_NEXTDLGCTL        ; 发送本消息给一个对话框程序窗口过程,以便在各控件间设置键盘焦点位置  
IDSTR($0029) 
$002A = #WM_SPOOLERSTATUS     ; 每当打印管理列队增加或减少一条作业时就会发出本消息  
$002B = #WM_DRAWITEM          ; 按钮、组合框、列表框、菜单的外观改变时会发送本消息给这些控件的所有者  
$002C = #WM_MEASUREITEM       ; 按钮、组合框、列表框、列表控件、菜单项被创建时会发送本消息给这些控件的所有者  
$002D = #WM_DELETEITEM        ; 当列表框或组合框被销毁或通过LB_DELETESTRING、LB_RESETCONTENT、CB_DELETESTRING或CB_RESETCONTENT消息删除某些项时,会发送本消息给这些控件的所有者  
$002E = #WM_VKEYTOITEM        ; LBS_WANTKEYBOARDINPUT风格的列表框会发出本消息给其所有者,以便响应WM_KEYDOWN消息  
$002F = #WM_CHARTOITEM        ; LBS_WANTKEYBOARDINPUT风格的列表框会发送本消息给其所有者,以便响应WM_CHAR消息  
$0030 = #WM_SETFONT           ; 指定控件所用字体  
$0031 = #WM_GETFONT           ; 得到当前控件绘制其文本所用的字体  
$0032 = #WM_SETHOTKEY         ; 为某窗口关联一个热键  
$0033 = #WM_GETHOTKEY         ; 确定某热键与某窗口是否相关联  
IDSTR($0034) 
IDSTR($0035) 
IDSTR($0036) 
$0037 = #WM_QUERYDRAGICON     ; 本消息发送给最小化的窗口(iconic),当该窗口将被拖放而其窗口类中没有定义图标,应用程序能返回一个图标或光标的句柄。当用户拖放图标时系统会显示这个图标或光标  
IDSTR($0038) 
$0039 = #WM_COMPAREITEM       ; 可发送本消息来确定组合框(CBS_SORT)或列表框(LBS_SORT)中新增项的相对位置  
IDSTR($003A) 
IDSTR($003B) 
IDSTR($003C) 
$003D = #WM_GETOBJECT         ; \"oleacc.dll\"(COM组件)(Microsoft Active Accessibility:方便残疾人使用电脑的一种技术)发送本消息激活服务程序以便获取它所包含的关联对象的信息  
IDSTR($003E) 
IDSTR($003F) 
IDSTR($0040) 
$0041 = #WM_COMPACTING        ; 显示内存已经很少了  
IDSTR($0042) 
IDSTR($0043) 
$0044 = #WM_COMMNOTIFY        ; Win3.1中,当串口事件产生时,通讯设备驱动程序发送消息本消息给系统,指示输入输出队列的状态  
IDSTR($0045) 
$0046 = #WM_WINDOWPOSCHANGING ; 本消息会发送给那些大小和位置(Z_Order)将被改变的窗口,以调用SetWindowPos函数或其它窗口管理函数  
$0047 = #WM_WINDOWPOSCHANGED  ; 本消息会发送给那些大小和位置(Z_Order)已被改变的窗口,以调用SetWindowPos函数或其它窗口管理函数  
$0048 = #WM_POWER             ; 当系统将要进入暂停状态时发送本消息(适用于16位的windows)  
IDSTR($0049) 
$004A = #WM_COPYDATA          ; 当一个应用程序传递数据给另一个应用程序时发送本消息  
$004B = #WM_CANCELJOURNAL     ; 当用户取消程序日志激活状态时,发送本消息给那个应用程序。该消息使用空窗口句柄发送  
IDSTR($004C) 
IDSTR($004D) 
$004E = #WM_NOTIFY            ; 当某控件的某事件已发生或该控件需得到一些信息时,发送本消息给其父窗  
IDSTR($004F) 
$0050 = #WM_INPUTLANGCHANGEREQUEST  ; 当用户通过过单击任务栏上的语言指示符或某快捷键组合选择改变输入法时系统会向焦点窗口发送本消息  
$0051 = #WM_INPUTLANGCHANGE   ; 切换输入法后,系统会发送本消息给受影响的顶层窗口  
$0052 = #WM_TCARD             ; 程序已初始化windows帮助例程时会发送本消息给应用程序  
$0053 = #WM_HELP              ; 按下<F1>后,若某菜单是激活的,就发送本消息给此窗口关联的菜单;否则就发送给有焦点的窗口;若当前都没有焦点,就把本消息发送给当前激活的窗口  
$0054 = #WM_USERCHANGED       ; 当用户已登入或退出后发送本消息给所有窗口;当用户登入或退出时系统更新用户的具体设置信息,在用户更新设置时系统马上发送本消息  
$0055 = #WM_NOTIFYFORMAT      ; 公用控件、自定义控件和其父窗通过本消息判断控件在WM_NOTIFY通知消息中是使用ANSI还是UNICODE,使用本消息能使某个控件与它的父控件间进行相互通信  
$007B = #WM_CONTEXTMENU       ; 当用户在某窗口中点击右键就发送本消息给该窗口,设置右键菜单  
$007C = #WM_STYLECHANGING     ; 当调用SetWindowLong函数将要改变一个或多个窗口的风格时,发送本消息给那个窗口  
$007D = #WM_STYLECHANGED      ; 当调用SetWindowLong函数改变一个或多个窗口的风格后,发送本消息给那个窗口  
$007E = #WM_DISPLAYCHANGE     ; 当显示器的分辨率改变后,发送本消息给所有窗口  
$007F = #WM_GETICON           ; 本消息发送给某个窗口,用于返回与某窗口有关联的大图标或小图标的句柄  
$0080 = #WM_SETICON           ; 应用程序发送本消息让一个新的大图标或小图标与某窗口相关联  
$0081 = #WM_NCCREATE          ; 当某窗口首次被创建时,本消息在WM_CREATE消息发送前发送  
$0082 = #WM_NCDESTROY         ; 本消息通知某窗口,非客户区正在销毁  
$0083 = #WM_NCCALCSIZE        ; 当某窗口的客户区的大小和位置须被计算时发送本消息  
$0084 = #WM_NCHITTEST         ; 当用户在在非客户区移动鼠标、按住或释放鼠标时发送本消息(击中测试);若鼠标没有被捕获,则本消息在窗口得到光标之后发出,否则消息发送到捕获到鼠标的窗口  
$0085 = #WM_NCPAINT           ; 当窗口框架(非客户区)必须被被重绘时,应用程序发送本消息给该窗口  
$0086 = #WM_NCACTIVATE        ; 本消息发送给某窗口,在窗口的非客户区被激活时重绘窗口  
$0087 = #WM_GETDLGCODE        ; 发送本消息给某个与对话框程序关联的控件,系统控制方位键和TAB键使输入进入该控件,通过响应本消息应用程序可把它当成一个特殊的输入控件并能处理它  
$0088 = #WM_SYNCPAINT         ; 当避免联系独立的GUI线程时,本消息用于同步刷新,本消息由系统确定是否发送  
$00A0 = #WM_NCMOUSEMOVE       ; 当光标在某窗口的非客户区内移动时,发送本消息给该窗口  
$00A1 = #WM_NCLBUTTONDOWN     ; 当光标在某窗口的非客户区内的同时按下鼠标左键,会发送本消息  
$00A2 = #WM_NCLBUTTONUP       ; 当用户释放鼠标左键的同时光标在某窗口的非客户区内时,会发送本消息  
$00A3 = #WM_NCLBUTTONDBLCLK   ; 当用户双击鼠标左键的同时光标在某窗口的非客户区内时,会发送本消息  
$00A4 = #WM_NCRBUTTONDOWN     ; 当用户按下鼠标右键的同时光标在某窗口的非客户区内时,会发送本消息  
$00A5 = #WM_NCRBUTTONUP       ; 当用户释放鼠标右键的同时光标在某窗口的非客户区内时,会发送本消息  
$00A6 = #WM_NCRBUTTONDBLCLK   ; 当用户双击鼠标右键的同时光标在某窗口的非客户区内时,会发送本消息  
$00A7 = #WM_NCMBUTTONDOWN     ; 当用户按下鼠标中键的同时光标在某窗口的非客户区内时,会发送本消息  
$00A8 = #WM_NCMBUTTONUP       ; 当用户释放鼠标中键的同时光标在某窗口的非客户区内时,会发送本消息  
$00A9 = #WM_NCMBUTTONDBLCLK   ; 当用户双击鼠标中键的同时光标在某窗口的非客户区内时,会发送本消息  

    
    
    
    
; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 4
; EnableXP