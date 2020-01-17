;***********************************
;迷路仟整理 2019.01.23
;Digest_SHA摘要
;***********************************
;注意:
;1.SHA属于摘要校验,从属于密码学,但不属加密或解密范畴,网上很多人写文章时,将SHA说成是加密函数
;2.摘要是指从一堆数据中通过算法,计算出固定长度的结果,这个结果在一定的数量级下,具有唯一性.
;  摘要最明显的特征是长度一致,无法还原数据,具有一定范围内的唯一性
;3.摘要用于校验数据的完整性,网易游戏,暴雪游戏,就是利用CRC32的校验值为替代资源中的虚拟文件名,
;  起来资源文件数据的作用,更高效的加载和查找速度.
;4.目前比较主流的有: CRC, MD5, SHA 三大类型

;安卓和苹果的应用程序安装包里面的检验值,就采用SHA1+MD5

FileName$ = "Digest_SHA摘要.pb"
String$ = "欢迎使用 [迷路PureBasic实例库工具]! "
UseSHA1Fingerprint()
Result$ = StringFingerprint(String$, #PB_Cipher_SHA1)
Debug "SHA1摘要: "+Result$

Result$ = FileFingerprint(FileName$, #PB_Cipher_SHA1)
Debug "SHA1摘要: "+Result$
Debug "===================="

UseSHA2Fingerprint()
Result$ = StringFingerprint(String$, #PB_Cipher_SHA2)
Debug "SHA2摘要: "+Result$

Result$ = FileFingerprint(FileName$, #PB_Cipher_SHA2)
Debug "SHA2摘要: "+Result$
Debug "===================="

UseSHA3Fingerprint()
Result$ = StringFingerprint(String$, #PB_Cipher_SHA3)
Debug "SHA3摘要: "+Result$

Result$ = FileFingerprint(FileName$, #PB_Cipher_SHA3)
Debug "SHA3摘要: "+Result$
Debug "===================="














; IDE Options = PureBasic 5.62 (Windows - x86)
; CursorPosition = 40
; FirstLine = 15
; EnableXP