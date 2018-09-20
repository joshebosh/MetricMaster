#SingleInstance, Force
;SetTitleMatchMode, Regex
SetTitleMatchMode, 2

Menu,Tray,Icon,Lib\dg.ico
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
}