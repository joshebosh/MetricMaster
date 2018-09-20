if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

#SingleInstance, Force
#Include .\Lib\UIA_Interface.ahk
Menu, Tray, Icon, Lib\Pics\lg.ico

/*
global ArrayA := Object()
global ArrayB := Object()
global ArrayA := ["Password1","Password2","Password3","Password4","Password5","Password6","Password7","Password8","Password9","PasswordF1","PasswordF2","PasswordF3","PasswordF4","PasswordF5","PasswordF6","PasswordF7","PasswordF8","PasswordF9","PasswordF10","PasswordF11","PasswordF12","PPassword1","PPassword2","PPassword3","PPassword4","PPassword5","PPassword6","PPassword7","PPassword8","PPassword9","PPasswordF1","PPasswordF2","PPasswordF3","PPasswordF4","PPasswordF5","PPasswordF6","PPasswordF8","PPasswordF9","PPasswordF10","PPasswordF11","PPasswordF12"]
global ArrayB := [Password1,Password2,Password3,Password4,Password5,Password6,Password7,Password8,Password9,PasswordF1,PasswordF2,PasswordF3,PasswordF4,PasswordF5,PasswordF6,PasswordF7,PasswordF8,PasswordF9,PasswordF10,PasswordF11,PasswordF12,PPassword1,PPassword2,PPassword3,PPassword4,PPassword5,PPassword6,PPassword7,PPassword8,PPassword9,PPasswordF1,PPasswordF2,PPasswordF3,PPasswordF4,PPasswordF5,PPasswordF6,PPasswordF8,PPasswordF9,PPasswordF10,PPasswordF11,PPasswordF12]


Loop, 42
{
	raya := ArrayA[A_Index]
	rayb := ArrayB[A_Index]
	IniRead, raya, .\Lib\Pk.ini, Keepers, %raya%
	GuiControl,RDSPotDk:,%raya%,%rayb%
}
*/
Goto, Start

Return

#0::
Start:
Gui,RDSPotDk:Destroy
Gui,RDSPotDk:Add,Edit,x10 y10 w150 h21 vPassword1,%Password1%
Gui,RDSPotDk:Add,Edit,x170 y10 w150 h21 vPPassword1,%PPassword1%
Gui,RDSPotDk:Add,Edit,x10 y30 w150 h21 vPassword2,%Password2%
Gui,RDSPotDk:Add,Edit,x170 y30 w150 h21 vPPassword2,%PPassword2%
Gui,RDSPotDk:Add,Edit,x10 y50 w150 h21 vPassword3,%Password3%
Gui,RDSPotDk:Add,Edit,x170 y50 w150 h21 vPPassword3,%PPassword3%
Gui,RDSPotDk:Add,Edit,x10 y80 w150 h21 vPassword4,%Password4%
Gui,RDSPotDk:Add,Edit,x170 y80 w150 h21 vPPassword4,%PPassword4%
Gui,RDSPotDk:Add,Edit,x10 y100 w150 h21 vPassword5,%Password5%
Gui,RDSPotDk:Add,Edit,x170 y100 w150 h21 vPPassword5,%PPassword5%
Gui,RDSPotDk:Add,Edit,x10 y120 w150 h21 vPassword6,%Password6%
Gui,RDSPotDk:Add,Edit,x170 y120 w150 h21 vPPassword6,%PPassword6%
Gui,RDSPotDk:Add,Edit,x10 y150 w150 h21 vPassword7,%Password7%
Gui,RDSPotDk:Add,Edit,x170 y150 w150 h21 vPPassword7,%PPassword7%
Gui,RDSPotDk:Add,Edit,x10 y170 w150 h21 vPassword8,%Password8%
Gui,RDSPotDk:Add,Edit,x170 y170 w150 h21 vPPassword8,%PPassword8%
Gui,RDSPotDk:Add,Edit,x10 y190 w150 h21 vPassword9,%Password9%
Gui,RDSPotDk:Add,Edit,x170 y190 w150 h21 vPPassword9,%PPassword9%
Gui,RDSPotDk:Add,Edit,x10 y220 w150 h21 vPasswordF1,%PasswordF1%
Gui,RDSPotDk:Add,Edit,x170 y220 w150 h21 vPPasswordF1,%PPasswordF1%
Gui,RDSPotDk:Add,Edit,x10 y240 w150 h21 vPasswordF2,%PasswordF2%
Gui,RDSPotDk:Add,Edit,x170 y240 w150 h21 vPPasswordF2,%PPasswordF2%
Gui,RDSPotDk:Add,Edit,x10 y260 w150 h21 vPasswordF3,%PasswordF3%
Gui,RDSPotDk:Add,Edit,x170 y260 w150 h21 vPPasswordF3,%PPasswordF3%
Gui,RDSPotDk:Add,Edit,x10 y290 w150 h21 vPasswordF4,%PasswordF4%
Gui,RDSPotDk:Add,Edit,x170 y290 w150 h21 vPPasswordF4,%PPasswordF4%
Gui,RDSPotDk:Add,Edit,x10 y310 w150 h21 vPasswordF5,%PasswordF5%
Gui,RDSPotDk:Add,Edit,x170 y310 w150 h21 vPPasswordF5,%PPasswordF5%
Gui,RDSPotDk:Add,Edit,x10 y330 w150 h21 vPasswordF6,%PasswordF6%
Gui,RDSPotDk:Add,Edit,x170 y330 w150 h21 vPPasswordF6,%PPasswordF6%
Gui,RDSPotDk:Add,Edit,x10 y360 w150 h21 vPasswordF7,%PasswordF7%
Gui,RDSPotDk:Add,Edit,x170 y360 w150 h21 vPPasswordF7,%PPasswordF7%
Gui,RDSPotDk:Add,Edit,x10 y380 w150 h21 vPasswordF8,%PasswordF8%
Gui,RDSPotDk:Add,Edit,x170 y380 w150 h21 vPPasswordF8,%PPasswordF8%
Gui,RDSPotDk:Add,Edit,x10 y400 w150 h21 vPasswordF9,%PasswordF9%
Gui,RDSPotDk:Add,Edit,x170 y400 w150 h21 vPPasswordF9,%PPasswordF9%
Gui,RDSPotDk:Add,Edit,x10 y430 w150 h21 vPasswordF10,%PasswordF10%
Gui,RDSPotDk:Add,Edit,x170 y430 w150 h21 vPPasswordF10,%PPasswordF10%
Gui,RDSPotDk:Add,Edit,x10 y450 w150 h21 vPasswordF11,%PasswordF11%
Gui,RDSPotDk:Add,Edit,x170 y450 w150 h21 vPPasswordF11,%PPasswordF11%
Gui,RDSPotDk:Add,Edit,x10 y470 w150 h21 vPasswordF12,%PasswordF12%
Gui,RDSPotDk:Add,Edit,x170 y470 w150 h21 vPPasswordF12,%PPasswordF12%
Gui,RDSPotDk:Show,w330,Password Keeper
Return


^!#+k::
Reload
Return


^!#k::
Gui,RDSPotDk:Submit,NoHide
Loop, 42
{
	raya := ArrayA[A_Index]
	rayb := ArrayB[A_Index]
	IniWrite, %raya%, .\Lib\Pk.ini, Keepers, %rayb%
}
Return


!k::
Gui,RDSPotDk:Submit,NoHide
raya := ArrayA[1]
rayb := ArrayB[1]
Msgbox % raya and rayb
GuiControl,RDSPotDk:,Password1,%Password1%
Return


^!k::
Gui,RDSPotDk:Submit,NoHide
Msgbox % ArrayA[1]
Return


#1::
Password1 := GetPassword()
GuiControl,RDSPotDk:,Password1,%Password1%
return

#2::
Password2 := GetPassword()
GuiControl,RDSPotDk:,Password2,%Password2%
return

#3::
Password3 := GetPassword()
GuiControl,RDSPotDk:,Password3,%Password3%
return

#4::
Password4 := GetPassword()
GuiControl,RDSPotDk:,Password4,%Password4%
return

#5::
Password5 := GetPassword()
GuiControl,RDSPotDk:,Password5,%Password5%
return

#6::
Password6 := GetPassword()
GuiControl,RDSPotDk:,Password6,%Password6%
return

#7::
Password7 := GetPassword()
GuiControl,RDSPotDk:,Password7,%Password7%
return

#8::
Password8 := GetPassword()
GuiControl,RDSPotDk:,Password8,%Password8%
return

#9::
Password9 := GetPassword()
GuiControl,RDSPotDk:,Password9,%Password9%
return

#F1::
PasswordF1 := GetPassword()
GuiControl,RDSPotDk:,PasswordF1,%PasswordF1%
return

#F2::
PasswordF2 := GetPassword()
GuiControl,RDSPotDk:,PasswordF2,%PasswordF2%
return

#F3::
PasswordF3 := GetPassword()
GuiControl,RDSPotDk:,PasswordF3,%PasswordF3%
return

#F4::
PasswordF4 := GetPassword()
GuiControl,RDSPotDk:,PasswordF4,%PasswordF4%
return

#F5::
PasswordF5 := GetPassword()
GuiControl,RDSPotDk:,PasswordF5,%PasswordF5%
return

#F6::
PasswordF6 := GetPassword()
GuiControl,RDSPotDk:,PasswordF6,%PasswordF6%
return

#F7::
PasswordF7 := GetPassword()
GuiControl,RDSPotDk:,PasswordF7,%PasswordF7%
return

#F8::
PasswordF8 := GetPassword()
GuiControl,RDSPotDk:,PasswordF8,%PasswordF8%
return

#F9::
PasswordF9 := GetPassword()
GuiControl,RDSPotDk:,PasswordF9,%PasswordF9%
return

#F10::
PasswordF10 := GetPassword()
GuiControl,RDSPotDk:,PasswordF10,%PasswordF10%
return

#F11::
PasswordF11 := GetPassword()
GuiControl,RDSPotDk:,PasswordF11,%PasswordF11%
return

#F12::
PasswordF12 := GetPassword()
GuiControl,RDSPotDk:,PasswordF12,%PasswordF12%
return

#+1::
PPassword1 := GetPassword()
GuiControl,RDSPotDk:,PPassword1,%PPassword1%
Return


#+2::
PPassword2 := GetPassword()
GuiControl,RDSPotDk:,PPassword2,%PPassword2%
Return


#+3::
PPassword3 := GetPassword()
GuiControl,RDSPotDk:,PPassword3,%PPassword3%
Return


#+4::
PPassword4 := GetPassword()
GuiControl,RDSPotDk:,PPassword4,%PPassword4%
Return


#+5::
PPassword5 := GetPassword()
GuiControl,RDSPotDk:,PPassword5,%PPassword5%
Return


#+6::
PPassword6 := GetPassword()
GuiControl,RDSPotDk:,PPassword6,%PPassword6%
Return


#+7::
PPassword7 := GetPassword()
GuiControl,RDSPotDk:,PPassword7,%PPassword7%
Return


#+8::
PPassword8 := GetPassword()
GuiControl,RDSPotDk:,PPassword8,%PPassword8%
Return


#+9::
PPassword9 := GetPassword()
GuiControl,RDSPotDk:,PPassword9,%PPassword9%
Return


#+F1::
PPasswordF1 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF1,%PPasswordF1%
Return


#+F2::
PPasswordF2 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF2,%PPasswordF2%
Return


#+F3::
PPasswordF3 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF3,%PPasswordF3%
Return


#+F4::
PPasswordF4 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF4,%PPasswordF4%
Return


#+F5::
PPasswordF5 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF5,%PPasswordF5%
Return


#+F6::
PPasswordF6 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF6,%PPasswordF6%
Return


#+F7::
PPasswordF7 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF7,%PPasswordF7%
Return


#+F8::
PPasswordF8 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF8,%PPasswordF8%
Return


#+F9::
PPasswordF9 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF9,%PPasswordF9%
Return


#+F10::
PPasswordF10 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF10,%PPasswordF10%
Return


#+F11::
PPasswordF11 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF11,%PPasswordF11%
Return


#+F12::
PPasswordF12 := GetPassword()
GuiControl,RDSPotDk:,PPasswordF12,%PPasswordF12%
Return

^!#+s::
;RegWrite
Return

GetPassword()
{
uia := UIA_Interface()
Element := uia.ElementFromPoint()
for each, value in [30093,30092,30045] ; lvalue,lname,value
	potd := Element.GetCurrentPropertyValue(value)
until r != ""
if (potd = "")
	potd := Element.CurrentName
Tooltip % potd=""? "<No Text Found>" : clipboard:= potd
SetTimer, ToolTipPotd, -1000
Return potd
}


ToolTipPotd:
	Tooltip
Return

#k::
Reload
Return

