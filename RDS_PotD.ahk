if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

GroupAdd, PassWins, ahk_exe sdcwbProxyBrowser.exe
GroupAdd, PassWins, Password Keeper

#SingleInstance, Force
#Include Lib\UIA_Interface.ahk
#IfWinActive, ahk_group PassWins

SetTitleMatchMode, 2

IniRead, PMX, .\Lib\PM.ini, PMWinPos, XPos, 0
IniRead, PMY, .\Lib\PM.ini, PMWinPos, YPos, 0
IniRead, PMOnTop, .\Lib\PM.ini, PMAlwaysOnTop, AlwaysOnTop, 0

Menu, Tray, Icon, Lib\Pics\PM.ico
Menu, Tray, NoStandard
Menu, Tray, Add, Destroy, PotDDestroy
Menu, Tray, Add, Reset, PotDReset
Menu, Tray, Add
Menu, Tray, Add, About, PotDAbout
Menu, Tray, Add, Help, PotDHelp
Menu, Tray, Add 
Menu, Tray, Add, Unhide, PotDUnhide

global PotDTitle := "RDS Password Manager"


GW_1 := "Technicolor Yesterday"
GW_2 := "Technicolor Today"
GW_3 := "Technicolor Tomorrow"
GW_4 := "Arris WG Yesterday"
GW_5 := "Arris WG Today"
GW_6 := "Arris WG Tomorrow"
GW_7 := "Arris XB6 Yesterday"
GW_8 := "Arris XB6 Today"
GW_9 := "Arris XB6 Tomorrow"
GW_F1 := "Cisco BWG Alt Yesterday" 
GW_F2 := "Cisco BWG Alt Today"
GW_F3 := "Cisco BWG Alt Tomorrow"
GW_F4 := "Cisco XB3/BWG Yesterday"
GW_F5 := "Cisco XB3/BWG Today"
GW_F6 := "Cisco XB3/BWG Tomorrow"
GW_F7 := "Moto Yesterday"
GW_F8 := "Moto Today"
GW_F9 := "Moto Tomorrow"
GW_F10 := "Netgear Yesterday"
GW_F11 := "Netgear Today"
GW_F12 := "Netgear Tomorrow"
GW_11 := "SMC WG(Dory) Yesterday"
GW_22 := "SMC WG(Dory) Today"
GW_33 := "SMC WG(Dory) Tomorrow"
GW_44 := "SMCD3-CCR Yesterday"
GW_55 := "SMCD3-CCR Today"
GW_66 := "SMCD3-CCR Tomorrow"
GW_77 := "Thomson Yesterday"
GW_88 := "Thomson Today"
GW_99 := "Thomson Tomorrow"
GW_FF1 := "UBEE-CCR Yesterday" 
GW_FF2 := "UBEE-CCR Today"
GW_FF3 := "UBEE-CCR Tomorrow"
GW_FF4 := "Ubee eMTA Yesterday"
GW_FF5 := "Ubee eMTA Today"
GW_FF6 := "Ubee eMTA Tomorrow"
GW_FF7 := ""
GW_FF8 := ""
GW_FF9 := ""
GW_FF10 := "        edit your choice"
GW_FF11 := "        of gateways then"
GW_FF12 := "           hit  [Submit]"


PotdUnhide:
;^0::
Gui,PotD:Destroy
Gui,PotD:Add,Picture,x30 y10 w355 h52 gPotDBanner,.\Lib\Pics\RDSPotD.png
Gui,PotD:Add,Text,x470 y10 w100 h13,Keyboard Shortcuts
Gui,PotD:Add,Text,x450 y30 w25 h13,RDS
Gui,PotD:Add,Text,x550 y30 w25 h13,RDS
Gui,PotD:Add,Text,x440 y45 w55 h13,Username
Gui,PotD:Add,Text,x540 y45 w55 h13,Mouseover
Gui,PotD:Add,Text,x360 y50 w30 h13,v1.0

Gui,PotD:Add,Tab3, x5 y65 h540 w630 -Theme Bottom,Main|More

Gui,PotD:Add,GroupBox,x10 y70 w170 h510,-----------    Gateways    --------------
Gui,PotD:Add,Edit,x20 y90 w150 h21 vGW_1,%GW_1%
Gui,PotD:Add,Edit,x20 y110 w150 h21 vGW_2,%GW_2%
Gui,PotD:Add,Edit,x20 y130 w150 h21 vGW_3,%GW_3%
Gui,PotD:Add,Edit,x20 y160 w150 h21 vGW_4,%GW_4%
Gui,PotD:Add,Edit,x20 y180 w150 h21 vGW_5,%GW_5%
Gui,PotD:Add,Edit,x20 y200 w150 h21 vGW_6,%GW_6%
Gui,PotD:Add,Edit,x20 y230 w150 h21 vGW_7,%GW_7%
Gui,PotD:Add,Edit,x20 y250 w150 h21 vGW_8,%GW_8%
Gui,PotD:Add,Edit,x20 y270 w150 h21 vGW_9,%GW_9%
Gui,PotD:Add,Edit,x20 y300 w150 h21 vGW_F1,%GW_F1%
Gui,PotD:Add,Edit,x20 y320 w150 h21 vGW_F2,%GW_F2%
Gui,PotD:Add,Edit,x20 y340 w150 h21 vGW_F3,%GW_F3%
Gui,PotD:Add,Edit,x20 y370 w150 h21 vGW_F4,%GW_F4%
Gui,PotD:Add,Edit,x20 y390 w150 h21 vGW_F5,%GW_F5%
Gui,PotD:Add,Edit,x20 y410 w150 h21 vGW_F6,%GW_F6%
Gui,PotD:Add,Edit,x20 y440 w150 h21 vGW_F7,%GW_F7%
Gui,PotD:Add,Edit,x20 y460 w150 h21 vGW_F8,%GW_F8%
Gui,PotD:Add,Edit,x20 y480 w150 h21 vGW_F9,%GW_F9%
Gui,PotD:Add,Edit,x20 y510 w150 h21 vGW_F10,%GW_F10%
Gui,PotD:Add,Edit,x20 y530 w150 h21 vGW_F11,%GW_F11%
Gui,PotD:Add,Edit,x20 y550 w150 h21 vGW_F12,%GW_F12%
Gui,PotD:Add,GroupBox,x180 y70 w230 h510,----------------------    Passwords    ----------------------
Gui,PotD:Add,Button,x190 y90 w60 h20 gPotDCopy1,Copy 1
Gui,PotD:Add,Edit,x250 y90 w150 h21 vPassword1,%Password1%
Gui,PotD:Add,Button,x190 y110 w60 h20 gPotDCopy2,Copy 2
Gui,PotD:Add,Edit,x250 y110 w150 h21 vPassword2,%Password2%
Gui,PotD:Add,Button,x190 y130 w60 h20 gPotDCopy3,Copy 3
Gui,PotD:Add,Edit,x250 y130 w150 h21 vPassword3,%Password3%
Gui,PotD:Add,Button,x190 y160 w60 h20 gPotDCopy4,Copy 4
Gui,PotD:Add,Edit,x250 y160 w150 h21 vPassword4,%Password4%
Gui,PotD:Add,Button,x190 y180 w60 h20 gPotDCopy5,Copy 5
Gui,PotD:Add,Edit,x250 y180 w150 h21 vPassword5,%Password5%
Gui,PotD:Add,Button,x190 y200 w60 h20 gPotDCopy6,Copy 6
Gui,PotD:Add,Edit,x250 y200 w150 h21 vPassword6,%Password6%
Gui,PotD:Add,Button,x190 y230 w60 h20 gPotDCopy7,Copy 7
Gui,PotD:Add,Edit,x250 y230 w150 h21 vPassword7,%Password7%
Gui,PotD:Add,Button,x190 y250 w60 h20 gPotDCopy8,Copy 8
Gui,PotD:Add,Edit,x250 y250 w150 h21 vPassword8,%Password8%
Gui,PotD:Add,Button,x190 y270 w60 h20 gPotDCopy9,Copy 9
Gui,PotD:Add,Edit,x250 y270 w150 h21 vPassword9,%Password9%
Gui,PotD:Add,Button,x190 y300 w60 h20 gPotDCopyF1,Copy F1
Gui,PotD:Add,Edit,x250 y300 w150 h21 vPasswordF1,%PasswordF1%
Gui,PotD:Add,Button,x190 y320 w60 h20 gPotDCopyF2,Copy F2
Gui,PotD:Add,Edit,x250 y320 w150 h21 vPasswordF2,%PasswordF2%
Gui,PotD:Add,Button,x190 y340 w60 h20 gPotDCopyF3,Copy F3
Gui,PotD:Add,Edit,x250 y340 w150 h21 vPasswordF3,%PasswordF3%
Gui,PotD:Add,Button,x190 y370 w60 h20 gPotDCopyF4,Copy F4
Gui,PotD:Add,Edit,x250 y370 w150 h21 vPasswordF4,%PasswordF4%
Gui,PotD:Add,Button,x190 y390 w60 h20 gPotDCopyF5,Copy F5
Gui,PotD:Add,Edit,x250 y390 w150 h21 vPasswordF5,%PasswordF5%
Gui,PotD:Add,Button,x190 y410 w60 h20 gPotDCopyF6,Copy F6
Gui,PotD:Add,Edit,x250 y410 w150 h21 vPasswordF6,%PasswordF6%
Gui,PotD:Add,Button,x190 y440 w60 h20 gPotDCopyF7,Copy F7
Gui,PotD:Add,Edit,x250 y440 w150 h21 vPasswordF7,%PasswordF7%
Gui,PotD:Add,Button,x190 y460 w60 h20 gPotDCopyF8,Copy F8
Gui,PotD:Add,Edit,x250 y460 w150 h21 vPasswordF8,%PasswordF8%
Gui,PotD:Add,Button,x190 y480 w60 h20 gPotDCopyF9,Copy F9
Gui,PotD:Add,Edit,x250 y480 w150 h21 vPasswordF9,%PasswordF9%
Gui,PotD:Add,Button,x190 y510 w60 h20 gPotDCopyF10,Copy F10
Gui,PotD:Add,Edit,x250 y510 w150 h21 vPasswordF10,%PasswordF10%
Gui,PotD:Add,Button,x190 y530 w60 h20 gPotDCopyF11,Copy F11
Gui,PotD:Add,Edit,x250 y530 w150 h21 vPasswordF11,%PasswordF11%
Gui,PotD:Add,Button,x190 y550 w60 h20 gPotDCopyF12,Copy F12
Gui,PotD:Add,Edit,x250 y550 w150 h21 vPasswordF12,%PasswordF12%
Gui,PotD:Add,GroupBox,x410 y70 w100 h510,---------   Set  ---------
Gui,PotD:Add,Text,x440 y90 w50 h13,Ctrl + 1
Gui,PotD:Add,Text,x440 y110 w50 h13,Ctrl + 2
Gui,PotD:Add,Text,x440 y130 w50 h13,Ctrl + 3
Gui,PotD:Add,Text,x440 y160 w50 h13,Ctrl + 4
Gui,PotD:Add,Text,x440 y180 w50 h13,Ctrl + 5
Gui,PotD:Add,Text,x440 y200 w50 h13,Ctrl + 6
Gui,PotD:Add,Text,x440 y230 w50 h13,Ctrl + 7
Gui,PotD:Add,Text,x440 y250 w50 h13,Ctrl + 8
Gui,PotD:Add,Text,x440 y270 w50 h13,Ctrl + 9
Gui,PotD:Add,Text,x440 y300 w50 h13,Ctrl + F1
Gui,PotD:Add,Text,x440 y320 w50 h13,Ctrl + F2
Gui,PotD:Add,Text,x440 y340 w50 h13,Ctrl + F3
Gui,PotD:Add,Text,x440 y370 w50 h13,Ctrl + F4
Gui,PotD:Add,Text,x440 y390 w50 h13,Ctrl + F5
Gui,PotD:Add,Text,x440 y410 w50 h13,Ctrl + F6
Gui,PotD:Add,Text,x440 y440 w50 h13,Ctrl + F7
Gui,PotD:Add,Text,x440 y460 w50 h13,Ctrl + F8
Gui,PotD:Add,Text,x440 y480 w50 h13,Ctrl + F9
Gui,PotD:Add,Text,x440 y510 w50 h13,Ctrl + F10
Gui,PotD:Add,Text,x440 y530 w50 h13,Ctrl + F11
Gui,PotD:Add,Text,x440 y550 w50 h13,Ctrl + F12
Gui,PotD:Add,GroupBox,x510 y70 w100 h510,--------   Get   --------
Gui,PotD:Add,Text,x540 y90 w50 h13,Alt + 1
Gui,PotD:Add,Text,x540 y110 w50 h13,Alt + 2
Gui,PotD:Add,Text,x540 y130 w50 h13,Alt + 3
Gui,PotD:Add,Text,x540 y160 w50 h13,Alt + 4
Gui,PotD:Add,Text,x540 y180 w50 h13,Alt + 5
Gui,PotD:Add,Text,x540 y200 w50 h13,Alt + 6
Gui,PotD:Add,Text,x540 y230 w50 h13,Alt + 7
Gui,PotD:Add,Text,x540 y250 w50 h13,Alt + 8
Gui,PotD:Add,Text,x540 y270 w50 h13,Alt + 9
Gui,PotD:Add,Text,x540 y300 w50 h13,Alt + F1
Gui,PotD:Add,Text,x540 y320 w50 h13,Alt + F2
Gui,PotD:Add,Text,x540 y340 w50 h13,Alt + F3
Gui,PotD:Add,Text,x540 y370 w50 h13,Alt + F4
Gui,PotD:Add,Text,x540 y390 w50 h13,Alt + F5
Gui,PotD:Add,Text,x540 y410 w50 h13,Alt + F6
Gui,PotD:Add,Text,x540 y440 w50 h13,Alt + F7
Gui,PotD:Add,Text,x540 y460 w50 h13,Alt + F8
Gui,PotD:Add,Text,x540 y480 w50 h13,Alt + F9
Gui,PotD:Add,Text,x540 y510 w50 h13,Alt + F10
Gui,PotD:Add,Text,x540 y530 w50 h13,Alt + F11
Gui,PotD:Add,Text,x540 y550 w50 h13,Alt + F12
Gui,PotD:Tab,2
Gui,PotD:Add,GroupBox,x10 y70 w170 h510,-----------    Gateways    --------------
Gui,PotD:Add,Edit,x20 y90 w150 h21 vGW_11,%GW_11%
Gui,PotD:Add,Edit,x20 y110 w150 h21 vGW_22,%GW_22%
Gui,PotD:Add,Edit,x20 y130 w150 h21 vGW_33,%GW_33%
Gui,PotD:Add,Edit,x20 y160 w150 h21 vGW_44,%GW_44%
Gui,PotD:Add,Edit,x20 y180 w150 h21 vGW_55,%GW_55%
Gui,PotD:Add,Edit,x20 y200 w150 h21 vGW_66,%GW_66%
Gui,PotD:Add,Edit,x20 y230 w150 h21 vGW_77,%GW_77%
Gui,PotD:Add,Edit,x20 y250 w150 h21 vGW_88,%GW_88%
Gui,PotD:Add,Edit,x20 y270 w150 h21 vGW_99,%GW_99%
Gui,PotD:Add,Edit,x20 y300 w150 h21 vGW_FF1,%GW_FF1%
Gui,PotD:Add,Edit,x20 y320 w150 h21 vGW_FF2,%GW_FF2%
Gui,PotD:Add,Edit,x20 y340 w150 h21 vGW_FF3,%GW_FF3%
Gui,PotD:Add,Edit,x20 y370 w150 h21 vGW_FF4,%GW_FF4%
Gui,PotD:Add,Edit,x20 y390 w150 h21 vGW_FF5,%GW_FF5%
Gui,PotD:Add,Edit,x20 y410 w150 h21 vGW_FF6,%GW_FF6%
Gui,PotD:Add,Edit,x20 y440 w150 h21 vGW_FF7,%GW_FF7%
Gui,PotD:Add,Edit,x20 y460 w150 h21 vGW_FF8,%GW_FF8%
Gui,PotD:Add,Edit,x20 y480 w150 h21 vGW_FF9,%GW_FF9%
Gui,PotD:Add,Edit,x20 y510 w150 h21 vGW_FF10,%GW_FF10%
Gui,PotD:Add,Edit,x20 y530 w150 h21 vGW_FF11,%GW_FF11%
Gui,PotD:Add,Edit,x20 y550 w150 h21 vGW_FF12,%GW_FF12%
Gui,PotD:Add,GroupBox,x180 y70 w230 h510,----------------------    Passwords    ----------------------
Gui,PotD:Add,Button,x190 y90 w60 h20 gPotDCopy11,Copy 11
Gui,PotD:Add,Edit,x250 y90 w150 h21 vPassword11,%Password11%
Gui,PotD:Add,Button,x190 y110 w60 h20 gPotDCopy22,Copy 22
Gui,PotD:Add,Edit,x250 y110 w150 h21 vPassword22,%Password22%
Gui,PotD:Add,Button,x190 y130 w60 h20 gPotDCopy33,Copy 33
Gui,PotD:Add,Edit,x250 y130 w150 h21 vPassword33,%Password33%
Gui,PotD:Add,Button,x190 y160 w60 h20 gPotDCopy44,Copy 44
Gui,PotD:Add,Edit,x250 y160 w150 h21 vPassword44,%Password44%
Gui,PotD:Add,Button,x190 y180 w60 h20 gPotDCopy55,Copy 55
Gui,PotD:Add,Edit,x250 y180 w150 h21 vPassword55,%Password55%
Gui,PotD:Add,Button,x190 y200 w60 h20 gPotDCopy66,Copy 66
Gui,PotD:Add,Edit,x250 y200 w150 h21 vPassword66,%Password66%
Gui,PotD:Add,Button,x190 y230 w60 h20 gPotDCopy77,Copy 77
Gui,PotD:Add,Edit,x250 y230 w150 h21 vPassword77,%Password77%
Gui,PotD:Add,Button,x190 y250 w60 h20 gPotDCopy88,Copy 88
Gui,PotD:Add,Edit,x250 y250 w150 h21 vPassword88,%Password88%
Gui,PotD:Add,Button,x190 y270 w60 h20 gPotDCopy99,Copy 99
Gui,PotD:Add,Edit,x250 y270 w150 h21 vPassword99,%Password99%
Gui,PotD:Add,Button,x190 y300 w60 h20 gPotDCopyFF1,Copy FF1
Gui,PotD:Add,Edit,x250 y300 w150 h21 vPasswordFF1,%PasswordFF1%
Gui,PotD:Add,Button,x190 y320 w60 h20 gPotDCopyFF2,Copy FF2
Gui,PotD:Add,Edit,x250 y320 w150 h21 vPasswordFF2,%PasswordFF2%
Gui,PotD:Add,Button,x190 y340 w60 h20 gPotDCopyFF3,Copy FF3
Gui,PotD:Add,Edit,x250 y340 w150 h21 vPasswordFF3,%PasswordFF3%
Gui,PotD:Add,Button,x190 y370 w60 h20 gPotDCopyFF4,Copy FF4
Gui,PotD:Add,Edit,x250 y370 w150 h21 vPasswordFF4,%PasswordFF4%
Gui,PotD:Add,Button,x190 y390 w60 h20 gPotDCopyFF5,Copy FF5
Gui,PotD:Add,Edit,x250 y390 w150 h21 vPasswordFF5,%PasswordFF5%
Gui,PotD:Add,Button,x190 y410 w60 h20 gPotDCopyFF6,Copy FF6
Gui,PotD:Add,Edit,x250 y410 w150 h21 vPasswordFF6,%PasswordFF6%
Gui,PotD:Add,Button,x190 y440 w60 h20 gPotDCopyFF7,Copy FF7
Gui,PotD:Add,Edit,x250 y440 w150 h21 vPasswordFF7,%PasswordFF7%
Gui,PotD:Add,Button,x190 y460 w60 h20 gPotDCopyFF8,Copy FF8
Gui,PotD:Add,Edit,x250 y460 w150 h21 vPasswordFF8,%PasswordFF8%
Gui,PotD:Add,Button,x190 y480 w60 h20 gPotDCopyFF9,Copy FF9
Gui,PotD:Add,Edit,x250 y480 w150 h21 vPasswordFF9,%PasswordFF9%
Gui,PotD:Add,Button,x190 y510 w60 h20 gPotDCopyFF10,Copy FF10
Gui,PotD:Add,Edit,x250 y510 w150 h21 vPasswordFF10,%PasswordFF10%
Gui,PotD:Add,Button,x190 y530 w60 h20 gPotDCopyFF11,Copy FF11
Gui,PotD:Add,Edit,x250 y530 w150 h21 vPasswordFF11,%PasswordFF11%
Gui,PotD:Add,Button,x190 y550 w60 h20 gPotDCopyFF12,Copy FF12
Gui,PotD:Add,Edit,x250 y550 w150 h21 vPasswordFF12,%PasswordFF12%
Gui,PotD:Add,GroupBox,x410 y70 w100 h510,---------   Set  ---------
Gui,PotD:Add,Text,x420 y90 w70 h13,Ctrl + Win + 1
Gui,PotD:Add,Text,x420 y110 w70 h13,Ctrl + Win + 2
Gui,PotD:Add,Text,x420 y130 w70 h13,Ctrl + Win + 3
Gui,PotD:Add,Text,x420 y160 w70 h13,Ctrl + Win + 4
Gui,PotD:Add,Text,x420 y180 w70 h13,Ctrl + Win + 5
Gui,PotD:Add,Text,x420 y200 w70 h13,Ctrl + Win + 6
Gui,PotD:Add,Text,x420 y230 w70 h13,Ctrl + Win + 7
Gui,PotD:Add,Text,x420 y250 w70 h13,Ctrl + Win + 8
Gui,PotD:Add,Text,x420 y270 w70 h13,Ctrl + Win + 9
Gui,PotD:Add,Text,x420 y300 w75 h13,Ctrl + Win + F1
Gui,PotD:Add,Text,x420 y320 w75 h13,Ctrl + Win + F2
Gui,PotD:Add,Text,x420 y340 w75 h13,Ctrl + Win + F3
Gui,PotD:Add,Text,x420 y370 w75 h13,Ctrl + Win + F4
Gui,PotD:Add,Text,x420 y390 w75 h13,Ctrl + Win + F5
Gui,PotD:Add,Text,x420 y410 w75 h13,Ctrl + Win + F6
Gui,PotD:Add,Text,x420 y440 w75 h13,Ctrl + Win + F7
Gui,PotD:Add,Text,x420 y460 w75 h13,Ctrl + Win + F8
Gui,PotD:Add,Text,x420 y480 w75 h13,Ctrl + Win + F9
Gui,PotD:Add,Text,x420 y510 w80 h13,Ctrl + Win + F10
Gui,PotD:Add,Text,x420 y530 w80 h13,Ctrl + Win + F11
Gui,PotD:Add,Text,x420 y550 w80 h13,Ctrl + Win + F12
Gui,PotD:Add,GroupBox,x510 y70 w100 h510,--------   Get   --------
Gui,PotD:Add,Text,x520 y90 w70 h13,Alt + Win + 1
Gui,PotD:Add,Text,x520 y110 w70 h13,Alt + Win + 2
Gui,PotD:Add,Text,x520 y130 w70 h13,Alt + Win + 3
Gui,PotD:Add,Text,x520 y160 w70 h13,Alt + Win + 4
Gui,PotD:Add,Text,x520 y180 w70 h13,Alt + Win + 5
Gui,PotD:Add,Text,x520 y200 w70 h13,Alt + Win + 6
Gui,PotD:Add,Text,x520 y230 w70 h13,Alt + Win + 7
Gui,PotD:Add,Text,x520 y250 w70 h13,Alt + Win + 8
Gui,PotD:Add,Text,x520 y270 w70 h13,Alt + Win + 9
Gui,PotD:Add,Text,x520 y300 w70 h13,Alt + Win + F1
Gui,PotD:Add,Text,x520 y320 w70 h13,Alt + Win + F2
Gui,PotD:Add,Text,x520 y340 w70 h13,Alt + Win + F3
Gui,PotD:Add,Text,x520 y370 w70 h13,Alt + Win + F4
Gui,PotD:Add,Text,x520 y390 w70 h13,Alt + Win + F5
Gui,PotD:Add,Text,x520 y410 w70 h13,Alt + Win + F6
Gui,PotD:Add,Text,x520 y440 w70 h13,Alt + Win + F7
Gui,PotD:Add,Text,x520 y460 w70 h13,Alt + Win + F8
Gui,PotD:Add,Text,x520 y480 w70 h13,Alt + Win + F9
Gui,PotD:Add,Text,x520 y510 w75 h13,Alt + Win + F10
Gui,PotD:Add,Text,x520 y530 w75 h13,Alt + Win + F11
Gui,PotD:Add,Text,x520 y550 w75 h13,Alt + Win + F12
Gui,PotD:Tab
Gui,PotD:Add,Button,x110 y590 w100 h23 gPotDUpdate,Submit Changes
Gui,PotD:Add,Button,x220 y590 w43 h23 gPotDReset,Reset
Gui,PotD:Add,Button,x270 y590 w43 h23 gPotDHide,Hide
Gui,PotD:Add,Button,x320 y590 w43 h23 gPotDHelp,Help
Gui,PotD:Add,Button,x370 y590 w70 h23 gPMDefaults,Default X/Y
Gui,PotD:Add,Button,x440 y590 w50 h23 gPMSetXY,Set X/Y
Gui,PotD:Add,Button,x560 y590 w50 h23 gPotDDestroy,Destroy
Gui,PotD:Add,Checkbox,x500 y600 w55 h13 gPMOnTop vPMOnTop,On Top

Gui,PotD:Show, x%PMX% y%PMY%,%PotDTitle%

if PMOnTop
	Gui, PotD:+AlwaysOnTop
else
	Gui, PotD:-AlwaysOnTop

GuiControl, PotD:, PMOnTop, %PMOnTop%
return

PMSetXY:
WinGetPos, PMX, PMY, , , RDS Password Manager
IniWrite, %PMX%, .\Lib\PM.ini, PMWinPos, XPos
IniWrite, %PMY%, .\Lib\PM.ini, PMWinPos, YPos
Return


PMOnTop:
Gui,PotD:Submit,Nohide
If PMOnTop = 1
{
	Gui, +AlwaysOnTop
	IniWrite, 1, .\Lib\PM.ini, PMAlwaysOnTop, AlwaysOnTop
}
else
{
	Gui, -AlwaysOnTop
	IniWrite, 0, .\Lib\PM.ini, PMAlwaysOnTop, AlwaysOnTop
}
Return

PMDefaults:
IniWrite, 0, .\Lib\PM.ini, PMWinPos, XPos
IniWrite, 0, .\Lib\PM.ini, PMWinPos, YPos
IniWrite, 0, .\Lib\PM.ini, PMAlwaysOnTop, PMAlwaysOnTop
Reload
Return


PotDBanner:
PotDAbout:
AboutPotD := "
(
Created by:

	joshebosh

--------------------------

joyoung@support.com

	or
	
support@joshebosh.com

)"
MsgBox,,%PotDTitle%,%AboutPotD%, 5
Return


Exit:
ExitApp
Return


Reload:
Reload
Return


PotDUpdate:
Gui, PotD:Submit
Send, ^0
Return


PotDGuiEscape:
PotDGuiClose:
PotDDestroy:
MsgBox,4100,Confirm Destruction,Are you sure you want to destroy the passwords?`n`n Aborting request in 5 seconds,5
IfMsgBox Yes
	ExitApp
IfMsgBox Timeout
	Return
IfMsgBox No
	Return


PotDHide:
Gui,PotD:Destroy
MsgBox,4100,Minimized to System Tray,Right click unhide in Tray, 3
Return

PotDHelp:
HelpPotD := "
(
A)   So there are basically two ways to do this.

	1.  Your way,  the slow way,  the mouse way.
	2.  My Way,  the fast way,  the keyboard way.
	

B)   Your Way:

	1.  INITIALIZE: Open RDS Password of the Day, highlight first password, copy and paste into Manager, hit Submit to keep it in memory.
	2.  Repeat the process for up to 21 passwords, applying your own Gateway labels if need be.
	3.  For logging into the modem, find, copy, and paste IP address from Einstein into RDS.
	4.  Choose the respective password and hit the corresponding [Copy] button.
	5.  Type the proper username into RDS.
	6.  Paste the password into RDS.
	7.  Click Login.


C)   My Way:

	1.  INITIALIZE:  Hover mouse over first RDS Password of the Day and hit  [Alt + number].  Auto assign up to 21 combos:  [Alt + 1] thru [9]  and  [Alt + F1] thru [F12]
	2.  Place cursor in modem Username box and Hit the respective  [Ctrl + number]  to auto login into modem.


D)	 CAVEATS:

	1.  If the modem is OFFLINE the IP Address will NOT auto copy from Einstein and paste into RDS. Wait till modem is online.
	2.  You may change any of the Gateway labels and hit Submit. They dont actually do anything but sit there.
	3.  You can also manually update indvidual passwords and hit Submit. But why not just use the  [Alt + number]  to update a password?
	4.  I recommend you practice the  [Ctrl + number] functions on your notepad after you've initialized passwords with  [Alt + number]
	5.  You have tinker with Manger to understand it... If it doesn't work, either you did something wrong, or I didnt program something right.
	6.  This is alpha/beta software. There is NO WARRANTY, neither express nor implied. You absolve me of any responsibilty by its use.
	7.  If passwords contain special characters like plus(+), slashs(\)(/), backets()[]{}, and others, you may need to copy manually.
	----------------------------------------------------------------------------------------------------------------------------------------------------------------
	8.  THIS PROGRAM IS CORPORATE SECURITY POLICY COMPLIANT.
	     YOU MUST RE-INITIALIZE PASSWORDS UPON EVERY RESTART OF THE PROGRAM.
	     THIS PORGRAM WILL NOT SAVE PASSWORDS! CLICK DESTROY AT END OF SHIFT!
	----------------------------------------------------------------------------------------------------------------------------------------------------------------

		
)"
Gui, PotDHelp:Add,Text,w900 h520,%HelpPotD%
Gui, PotDHelp:Add,Button,w50 x450 y500 gHelpOK,OK
Gui, PotDHelp:Show
Return

HelpOK:
Gui, PotDHelp:Destroy
Return

PotDReset:
^!+#p::
Reload
Return

PotDDetach:
MsgBox,4100,Coming Soon, Feature Coming Soon,2
Return


!1::
Password1 := GetPassword()
GuiControl,PotD:,Password1,%Password1%
return


!2::
Password2 := GetPassword()
GuiControl,PotD:,Password2,%Password2%
return


!3::
Password3 := GetPassword()
GuiControl,PotD:,Password3,%Password3%
return


!4::
Password4 := GetPassword()
GuiControl,PotD:,Password4,%Password4%
return


!5::
Password5 := GetPassword()
GuiControl,PotD:,Password5,%Password5%
return


!6::
Password6 := GetPassword()
GuiControl,PotD:,Password6,%Password6%
return


!7::
Password7 := GetPassword()
GuiControl,PotD:,Password7,%Password7%
return


!8::
Password8 := GetPassword()
GuiControl,PotD:,Password8,%Password8%
return


!9::
Password9 := GetPassword()
GuiControl,PotD:,Password9,%Password9%
return


!F1::
PasswordF1 := GetPassword()
GuiControl,PotD:,PasswordF1,%PasswordF1%
return


!F2::
PasswordF2 := GetPassword()
GuiControl,PotD:,PasswordF2,%PasswordF2%
return


!F3::
PasswordF3 := GetPassword()
GuiControl,PotD:,PasswordF3,%PasswordF3%
return


!F4::
PasswordF4 := GetPassword()
GuiControl,PotD:,PasswordF4,%PasswordF4%
return


!F5::
PasswordF5 := GetPassword()
GuiControl,PotD:,PasswordF5,%PasswordF5%
return


!F6::
PasswordF6 := GetPassword()
GuiControl,PotD:,PasswordF6,%PasswordF6%
return


!F7::
PasswordF7 := GetPassword()
GuiControl,PotD:,PasswordF7,%PasswordF7%
return


!F8::
PasswordF8 := GetPassword()
GuiControl,PotD:,PasswordF8,%PasswordF8%
return


!F9::
PasswordF9 := GetPassword()
GuiControl,PotD:,PasswordF9,%PasswordF9%
return


!F10::
PasswordF10 := GetPassword()
GuiControl,PotD:,PasswordF10,%PasswordF10%
return


!F11::
PasswordF11 := GetPassword()
GuiControl,PotD:,PasswordF11,%PasswordF11%
return


!F12::
PasswordF12 := GetPassword()
GuiControl,PotD:,PasswordF12,%PasswordF12%
return


!#1::
Password11 := GetPassword()
GuiControl,PotD:,Password11,%Password11%
return


!#2::
Password22 := GetPassword()
GuiControl,PotD:,Password22,%Password22%
return


!#3::
Password33 := GetPassword()
GuiControl,PotD:,Password33,%Password33%
return


!#4::
Password44 := GetPassword()
GuiControl,PotD:,Password44,%Password44%
return


!#5::
Password55 := GetPassword()
GuiControl,PotD:,Password55,%Password55%
return


!#6::
Password66 := GetPassword()
GuiControl,PotD:,Password66,%Password66%
return


!#7::
Password77 := GetPassword()
GuiControl,PotD:,Password77,%Password77%
return


!#8::
Password88 := GetPassword()
GuiControl,PotD:,Password88,%Password88%
return


!#9::
Password99 := GetPassword()
GuiControl,PotD:,Password99,%Password99%
return


!#F1::
PasswordFF1 := GetPassword()
GuiControl,PotD:,PasswordFF1,%PasswordFF1%
return


!#F2::
PasswordFF2 := GetPassword()
GuiControl,PotD:,PasswordFF2,%PasswordFF2%
return


!#F3::
PasswordFF3 := GetPassword()
GuiControl,PotD:,PasswordFF3,%PasswordFF3%
return


!#F4::
PasswordFF4 := GetPassword()
GuiControl,PotD:,PasswordFF4,%PasswordFF4%
return


!#F5::
PasswordFF5 := GetPassword()
GuiControl,PotD:,PasswordFF5,%PasswordFF5%
return


!#F6::
PasswordFF6 := GetPassword()
GuiControl,PotD:,PasswordFF6,%PasswordFF6%
return


!#F7::
PasswordFF7 := GetPassword()
GuiControl,PotD:,PasswordFF7,%PasswordFF7%
return


!#F8::
PasswordFF8 := GetPassword()
GuiControl,PotD:,PasswordFF8,%PasswordFF8%
return


!#F9::
PasswordFF9 := GetPassword()
GuiControl,PotD:,PasswordFF9,%PasswordFF9%
return


!#F10::
PasswordFF10 := GetPassword()
GuiControl,PotD:,PasswordFF10,%PasswordFF10%
return


!#F11::
PasswordFF11 := GetPassword()
GuiControl,PotD:,PasswordFF11,%PasswordFF11%
return


!#F12::
PasswordFF12 := GetPassword()
GuiControl,PotD:,PasswordFF12,%PasswordFF12%
return


^1::
PastePass(Password1)
Return


^2::
PastePass(Password2)
Return


^3::
PastePass(Password3)
Return


^4::
PastePass(Password4)
Return


^5::
PastePass(Password5)
Return


^6::
PastePass(Password6)
Return


^7::
PastePass(Password7)
Return


^8::
PastePass(Password8)
Return


^9::
PastePass(Password9)
Return


^F1::
PastePass(PasswordF1)
Return


^F2::
PastePass(PasswordF2)
Return


^F3::
PastePass(PasswordF3)
Return


^F4::
PastePass(PasswordF4)
Return


^F5::
PastePass(PasswordF5)
Return


^F6::
PastePass(PasswordF6)
Return


^F7::
PastePass(PasswordF7)
Return


^F8::
PastePass(PasswordF8)
Return


^F9::
PastePass(PasswordF9)
Return


^F10::
PastePass(PasswordF10)
Return


^F11::
PastePass(PasswordF11)
Return


^F12::
PastePass(PasswordF12)
Return


^#1::
PastePass(Password11)
Return


^#2::
PastePass(Password22)
Return


^#3::
PastePass(Password33)
Return


^#4::
PastePass(Password44)
Return


^#5::
PastePass(Password55)
Return


^#6::
PastePass(Password66)
Return


^#7::
PastePass(Password77)
Return


^#8::
PastePass(Password88)
Return


^#9::
PastePass(Password99)
Return


^#F1::
PastePass(PasswordFF1)
Return


^#F2::
PastePass(PasswordFF2)
Return


^#F3::
PastePass(PasswordFF3)
Return


^#F4::
PastePass(PasswordFF4)
Return


^#F5::
PastePass(PasswordFF5)
Return


^#F6::
PastePass(PasswordFF6)
Return


^#F7::
PastePass(PasswordFF7)
Return


^#F8::
PastePass(PasswordFF8)
Return


^#F9::
PastePass(PasswordFF9)
Return


^#F10::
PastePass(PasswordFF10)
Return


^#F11::
PastePass(PasswordFF11)
Return


^#F12::
PastePass(PasswordFF12)
Return


PotDCopy1:
CopyPass(Password1)
return


PotDCopy2:
CopyPass(Password2)
return


PotDCopy3:
CopyPass(Password3)
return


PotDCopy4:
CopyPass(Password4)
return


PotDCopy5:
CopyPass(Password5)
return


PotDCopy6:
CopyPass(Password6)
return


PotDCopy7:
CopyPass(Password7)
return


PotDCopy8:
CopyPass(Password8)
return


PotDCopy9:
CopyPass(Password9)
return


PotDCopyF1:
CopyPass(PasswordF1)
return


PotDCopyF2:
CopyPass(PasswordF2)
return


PotDCopyF3:
CopyPass(PasswordF3)
return


PotDCopyF4:
CopyPass(PasswordF4)
return


PotDCopyF5:
CopyPass(PasswordF5)
return


PotDCopyF6:
CopyPass(PasswordF6)
return


PotDCopyF7:
CopyPass(PasswordF7)
return

PotDCopyF8:
CopyPass(PasswordF8)
return


PotDCopyF9:
CopyPass(PasswordF9)
return


PotDCopyF10:
CopyPass(PasswordF10)
return


PotDCopyF11:
CopyPass(PasswordF11)
return


PotDCopyF12:
CopyPass(PasswordF12)
return


PotDCopy11:
CopyPass(Password11)
Return


PotDCopy22:
CopyPass(Password22)
Return


PotDCopy33:
CopyPass(Password33)
Return


PotDCopy44:
CopyPass(Password44)
Return


PotDCopy55:
CopyPass(Password55)
Return


PotDCopy66:
CopyPass(Password66)
Return


PotDCopy77:
CopyPass(Password77)
Return


PotDCopy88:
CopyPass(Password88)
Return


PotDCopy99:
CopyPass(Password99)
Return


PotDCopyFF1:
CopyPass(PasswordFF1)
Return


PotDCopyFF2:
CopyPass(PasswordFF2)
Return


PotDCopyFF3:
CopyPass(PasswordFF3)
Return


PotDCopyFF4:
CopyPass(PasswordFF4)
Return


PotDCopyFF5:
CopyPass(PasswordFF5)
Return


PotDCopyFF6:
CopyPass(PasswordFF6)
Return


PotDCopyFF7:
CopyPass(PasswordFF7)
Return


PotDCopyFF8:
CopyPass(PasswordFF8)
Return


PotDCopyFF9:
CopyPass(PasswordFF9)
Return


PotDCopyFF10:
CopyPass(PasswordFF10)
Return


PotDCopyFF11:
CopyPass(PasswordFF11)
Return


PotDCopyFF12:
CopyPass(PasswordFF12)
Return


GetPassword()
{
uia := UIA_Interface()
Element := uia.ElementFromPoint()
for each, value in [30093,30092,30045] ; lvalue,lname,value
PotD := Element.GetCurrentPropertyValue(value)
until r != ""
if (PotD = "")
PotD := Element.CurrentName
Tooltip % PotD = ""? "<No Text Found>" : clipboard:= "copied:  " PotD
SetTimer, ToolTipPotD, -1000
Return PotD
}


ToolTipPotD:
	Tooltip
Return


PastePass(ppotd)
{
Send, mso
Sleep, 100
Send, {Tab}
Sleep, 100
SendRaw, %ppotd%
Send, {Enter}
}


CopyPass(cp)
{
Clipboard := cp
ToolTip % "copied: " cp
SetTimer, ToolTipPotD, -1000
}