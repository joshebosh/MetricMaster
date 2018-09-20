#SingleInstance, Force
;SetTitleMatchMode, Regex
SetTitleMatchMode, 2

Menu,Tray,Icon,Lib\Pics\dg.ico
Menu,Tray,NoStandard
Menu,Tray,Add,Exit,WM_Exit
Menu,Tray,Add,Help,WM_Help

Goto, WP_Loop
Return


WM_Help:
WM_Help := "
(
Click the window to make sure it's focused and fronted

Hit [Ctrl + Alt + Win + LeftClick] anywhere on window (preferably up top)

Auto Arrange Setup Complete. Repeat for each Window.

Hit [Ctrl + Alt + Win + w] to activate auto arrange loop (shortcut built into Master Metric)

Hit [Ctrl + Alt + Win + Shift + w] to deactivate auto arrange loop if things get to annoying
)"
Gui, WM:Add, Text,,%WM_Help%
Gui, WM:Add,Button,gWM_OK,OK
Gui, WM:Show
Return

WM_OK:
Gui, WM:Destroy
Return

WM_Exit:
^!+#w::
ExitApp
Return

^!#LButton::
Loop, Read, WindowManager.ahk
{
	LastLine = %A_Index%
	LastLine--
}
Loop, Read, WindowManager.ahk, temp.ahk
{
	FileAppend, %A_LoopReadLine%`n
	If A_Index = %LastLine%
	{
		break
	}
}

WinGetTitle, Win_Title, A
WinGetClass, Win_Class, A
WinGet, Win_Proc_Name, ProcessName, A
WinGetPos, WinX, WinY, WinW, WinH, A

Appendage = `n`nIfWinExist, %Win_Title% ahk_class %Win_Class% ahk_exe %Win_Proc_Name%`n{`n    WinMove, %Win_Title% ahk_class %Win_Class% ahk_exe %Win_Proc_Name%, , %WinX%, %WinY%, %WinW%, %WinH%`n}`n}
FileAppend, %Appendage%, temp.ahk
FileRead, Clipboard, temp.ahk
FileDelete, WindowManager.ahk
FileAppend, %Clipboard%, WindowManager.ahk
FileDelete, temp.ahk
Tooltip % WinX " and " WinY
SetTimer, MMToolTip, -1500
Reload
return

MMToolTip:
	ToolTip
Return


WP_Loop:
Loop
{
Sleep 2000
;#######################################
; To clear out and start over
; delete everythign but the 
; last line.
;
; There should be an end curly "}" only,
; all by it's self on the last line.
;#######################################


IfWinExist, Active Window Info ahk_class AutoHotkeyGUI ahk_exe AU3_Spy.exe
{
    WinMove, Active Window Info ahk_class AutoHotkeyGUI ahk_exe AU3_Spy.exe, , 610, -588, 356, 561
}


IfWinExist, AutoHotkey Help ahk_class HH Parent ahk_exe hh.exe
{
    WinMove, AutoHotkey Help ahk_class HH Parent ahk_exe hh.exe, , 953, -1080, 974, 1057
}

IfWinExist, iWB2 Learner ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
{
    WinMove, iWB2 Learner ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe, , 3, -355, 328, 319
}

IfWinExist, Parent Structure ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
{
    WinMove, Parent Structure ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe, , 336, -355, 276, 327
}


IfWinExist, Team Labbe ahk_class SunAwtFrame ahk_exe Spark.exe
{
    WinMove, Team Labbe ahk_class SunAwtFrame ahk_exe Spark.exe, , -1441, -877, 722, 837
}


IfWinExist, CD_Comcast ahk_class SunAwtFrame ahk_exe Spark.exe
{
    WinMove, CD_Comcast ahk_class SunAwtFrame ahk_exe Spark.exe, , -1441, -877, 722, 837
}


IfWinExist, Spark ahk_class SunAwtFrame ahk_exe Spark.exe
{
    WinMove, Spark ahk_class SunAwtFrame ahk_exe Spark.exe, , -1440, -904
}


IfWinExist, OneNote ahk_class ApplicationFrameWindow ahk_exe ApplicationFrameHost.exe
{
    WinMove, OneNote ahk_class ApplicationFrameWindow ahk_exe ApplicationFrameHost.exe, , -727, -904, 734, 877
}


IfWinExist, Google Keep ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe
{
    WinMove, Google Keep ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe, , -727, -904, 734, 877
}


IfWinExist, Resolve Ticket - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, Resolve Ticket - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , -1500, 338, 667, 397
}


IfWinExist, Home (Search) - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, Home (Search) - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , -1922, 0, 1200, 945
}


IfWinExist, BMC Remedy Mid Tier 9.1 - Login - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, BMC Remedy Mid Tier 9.1 - Login - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , -1922, 0, 1200, 945
}


IfWinExist, S4 Checklist ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
{
    WinMove, S4 Checklist ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe, , -705, 0, 706, 789
}


IfWinExist, Sound ahk_class #32770 ahk_exe rundll32.exe
{
    WinMove, Sound ahk_class #32770 ahk_exe rundll32.exe, , -413, 790, 414, 462
}


IfWinExist, Comcast - Proxy Browser ahk_class WindowsForms10.Window.8.app.0.141b42a_r34_ad1 ahk_exe sdcwbProxyBrowser.exe
{
    WinMove, Comcast - Proxy Browser ahk_class WindowsForms10.Window.8.app.0.141b42a_r34_ad1 ahk_exe sdcwbProxyBrowser.exe, , -1300, 0,1228, 1057
}


IfWinExist, Support.com Cloud - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
    ;WinMove, Support.com Cloud - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, ,-1836 ,103, 1720, 955
    WinMove, Support.com Cloud - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , 347, 0, 1440, 1025
}


IfWinExist, Security Alert ahk_class #32770 ahk_exe IEXPLORE.EXE
{
	WinActivate, Security Alert ahk_class #32770 ahk_exe IEXPLORE.EXE
	Sleep, 200
	Send, !y
}


IfWinExist,  (RDSBROKER2.CABLE.COMCAST.COM) ahk_class RAIL_WINDOW ahk_exe mstsc.exe
{
;    WinMove,  (RDSBROKER2.CABLE.COMCAST.COM) ahk_class RAIL_WINDOW ahk_exe mstsc.exe, , 355, 2, 1084, 703
}


IfWinExist, Einstein 360° - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
    ;WinMove, Einstein 360° - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , 347, 0, 1098, 1027
    WinMove, Einstein 360° - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , 829, 0, 1098, 1027
}


IfWinExist, Notepad++ ahk_class Notepad++ ahk_exe notepad++.exe
{
    WinMove, Notepad++ ahk_class Notepad++ ahk_exe notepad++.exe, , 123, 107, 1579, 890
}


IfWinExist, Reminder - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, Reminder - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , -5, 757, 445, 268
	SoundBeep, 300, 300
}


IfWinExist, PopupNotifierForm ahk_class WindowsForms10.Window.8.app.0.310f4af_r34_ad1 ahk_exe ONECTI.exe
{
    WinMove, PopupNotifierForm ahk_class WindowsForms10.Window.8.app.0.310f4af_r34_ad1 ahk_exe ONECTI.exe, , 786, 1, 420, 125
}


IfWinExist, Schedule Change - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, Schedule Change - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , -3, 798, 280, 228
}


IfWinExist, PopupNotifierForm ahk_class WindowsForms10.Window.8.app.0.59efbf_r34_ad1 ahk_exe onecti.exe
{
    WinMove, PopupNotifierForm ahk_class WindowsForms10.Window.8.app.0.59efbf_r34_ad1 ahk_exe onecti.exe, , 889, 7, 420, 125
}


IfWinExist, Metric Master ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
{
    WinMove, Metric Master ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe, , 0, 0
}


IfWinExist, This page can’t be displayed - Internet Explorer - [InPrivate] ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, This page can’t be displayed - Internet Explorer - [InPrivate] ahk_class IEFrame ahk_exe iexplore.exe, , 1920, 0, 974, 865
}


IfWinExist, Joshua Young - Outlook Web App - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, Joshua Young - Outlook Web App - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , 2873, 0, 974, 1057
}


IfWinExist, Outlook Web App - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, Outlook Web App - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , 2873, 0, 974, 1057
}


IfWinExist, Scout Monitor - Mozilla Firefox (Private Browsing) ahk_class MozillaWindowClass ahk_exe firefox.exe
{
    WinMove, Scout Monitor - Mozilla Firefox (Private Browsing) ahk_class MozillaWindowClass ahk_exe firefox.exe, , 1920, 0, 968, 861
}


IfWinExist, Scout Monitor - Google Chrome ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe
{
    WinMove, Scout Monitor - Google Chrome ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe, , 1920, 0, 971, 864
}


IfWinExist, Scout Monitor ahk_class MozillaWindowClass ahk_exe sdcwbProxyBrowser.exe
{
    WinMove, Scout Monitor ahk_class MozillaWindowClass ahk_exe sdcwbProxyBrowser.exe, , 1920, 0, 974, 865
}


IfWinExist, InPrivate - Internet Explorer - [InPrivate] ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, InPrivate - Internet Explorer - [InPrivate] ahk_class IEFrame ahk_exe iexplore.exe, , 1920, 0, 974, 865
}


IfWinExist, Scout Monitor - Internet Explorer - [InPrivate] ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, Scout Monitor - Internet Explorer - [InPrivate] ahk_class IEFrame ahk_exe iexplore.exe, , 1920, 0, 974, 865
}


IfWinExist, RDS Password Manager ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
{
    WinMove, RDS Password Manager ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe, , 3846, -768, 651, 648
}


IfWinExist, Password Keeper ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
{
    WinMove, Password Keeper ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe, , 4494, -768, 336, 526
}


IfWinExist, keepass.kdbx - KeePass ahk_class WindowsForms10.Window.8.app.0.141b42a_r6_ad1 ahk_exe KeePass.exe
{
    WinMove, keepass.kdbx - KeePass ahk_class WindowsForms10.Window.8.app.0.141b42a_r6_ad1 ahk_exe KeePass.exe, , 4459, -363, 414, 334
}


IfWinExist, C:\Users\joshebosh\Desktop\awake.exe ahk_class ConsoleWindowClass ahk_exe awake.exe
{
    WinMove, C:\Users\joshebosh\Desktop\awake.exe ahk_class ConsoleWindowClass ahk_exe awake.exe, , 3846, -111, 234, 74
}


IfWinExist, Untitled - Notepad ahk_class Notepad ahk_exe notepad.exe
{
    WinMove, Untitled - Notepad ahk_class Notepad ahk_exe notepad.exe, , 4076, -230, 338, 197
}


IfWinExist, Activation - Welcome - Opera ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe
{
    WinMove, Activation - Welcome - Opera ahk_class Chrome_WidgetWin_1 ahk_exe opera.exe, , 2876, -606, 974, 569
}


IfWinExist, AWD/Contact Signon - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, AWD/Contact Signon - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , 2813, -1091, 1035, 793
}


IfWinExist, Alarm Clock ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
{
    WinMove, Alarm Clock ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe, , 2497, 861, 410, 204
}


IfWinExist, SDC Alert ahk_class WindowsForms10.Window.8.app.0.143a722_r9_ad1 ahk_exe SDCWB_V3.exe
{
    WinMove, SDC Alert ahk_class WindowsForms10.Window.8.app.0.143a722_r9_ad1 ahk_exe SDCWB_V3.exe, , 2437, -584, 879, 538
}


IfWinExist, Alerts ahk_class WindowsForms10.Window.8.app.0.143a722_r9_ad1 ahk_exe SDCWB_V3.exe
{
    WinMove, Alerts ahk_class WindowsForms10.Window.8.app.0.143a722_r9_ad1 ahk_exe SDCWB_V3.exe, , 2438, -1089, 835, 503
}

IfWinExist,  ahk_class WindowsForms10.Window.8.app.0.143a722_r9_ad1 ahk_exe SDCWB_V3.exe
{
    WinMove,  ahk_class WindowsForms10.Window.8.app.0.143a722_r9_ad1 ahk_exe SDCWB_V3.exe, , 1924, -121, 372, 79
}


IfWinExist, C:\Users\joshebosh\Dropbox\autohotkey\MetricMaster\MetricMaster ahk_class CabinetWClass ahk_exe explorer.exe
{
    WinMove, C:\Users\joshebosh\Dropbox\autohotkey\MetricMaster\MetricMaster ahk_class CabinetWClass ahk_exe explorer.exe, , 1921, -1088, 526, 970
}


IfWinExist, Avaya one-X Agent ahk_exe OneXAgentUI.exe
{
    WinMove, Avaya one-X Agent ahk_exe OneXAgentUI.exe, , 1931, 860, 570, 186
	CoordMode, Pixel, Screen
	PX := 2100
	PY := 910
	PixelGetColor, PC, PX, PY, RGB
	if !(PC = "0x63B463" or PC = "0x4A874A")
	{
		PX += 70
		PixelGetColor, PC, PX, PY, RGB
		;if (PC = "0x767676" or PC = "0x9E9E9E")
		if !(PC = "0x63B463" or PC = "0x4A874A")
		{
			SoundPlay, .\Lib\NotReadyState.wav
			Sleep, 120000
		}
	}
}


IfWinExist, ahk_class SunAwtFrame ahk_exe Spark.exe
{
	CoordMode, Pixel, Screen
	;PX := -1130
	PX := -990
	PY := -840
	SparkChat:
	Loop, 100
	{
		PixelGetColor, PXC, PX, PY, RGB
		if (PXC != "0xFFFFFF")
		{
			SoundPlay, %A_WinDir%\Media\Ring07.wav
			Sleep, 120000
			break SparkChat
		}
		PX += 1
	}
}


IfWinExist, Colors ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
{
    WinMove, Colors ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe, , 13, -679, 326, 309
}


IfWinExist, AWD/Contact - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
    WinMove, AWD/Contact - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe, , 2813, -1091, 1035, 793
}


IfWinExist, Scourby ahk_class Chrome_WidgetWin_1 ahk_exe Scourby.exe
{
    WinMove, Scourby ahk_class Chrome_WidgetWin_1 ahk_exe Scourby.exe, , -1, -1080, 1050, 700
}
}