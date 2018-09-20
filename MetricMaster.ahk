;COMPILE COMMAND
;.\Ahk2Exe112400\Ahk2Exe.exe /in MetricMaster\MetricMaster_v0.9\MetricMaster.ahk /out MetricMaster\MetricMaster_v0.9\MetricMaster.exe /icon MetricMaster\MetricMaster_v0.9\Lib\MM.ico

if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

#SingleInstance, force
#Include Lib\UIA_Interface.ahk
#Include Lib\Class_CtlColors.ahk
#Persistent

SetTitleMatchMode, RegEx
;SetTimer, Refreshers, 5000

Menu, Tray, Icon, Lib\Pics\MM.ico
Menu, Tray, NoStandard
Menu, Tray, NoStandard
Menu, Tray, Add, Destroy, MMDestroy
Menu, Tray, Add
Menu, Tray, Add, Window Manager, MMWM
Menu, Tray, Add 
Menu, Tray, Add, Unhide, skip_init

global TIME_STAMP
global TICKET_NUMBER
global CUSTOMER_NAME
global ACCOUNT_NUMBER
global CONTACT_NUMBER
global CHRONIC_ACCOUNT
global ATTEMPT_NUMBER
global AFFECTED_DEVICE
global REPORTED_ISSUE
global RESOLUTION_ACTION
global NEXT_ACTION
global WIRELESS_GATEWAY
global IP_ADDRESS
global MAC_ADDRESS
global ALT_EMAIL
global AUTO_PAY
global IPv4
global IPv6


;;; SET DEFAULT VARIABLES
SSID := "default-2.4"
SSID5 := "default-5.0"
ESSID := SSID . " & " . SSID5
BootFiles := "_blastpro_"
			. "|_chnbronze_"
			. "|_chnstarter_"
			. "|_chnultra_"
			. "|_chnsilver_"
			. "|_chnspeedtierextreme2_"
			. "|_chnwidebandblast_"
			. "|_chnwidebandshowcaseblast_"
			. "|_economyplus_"
			. "|_extreme_"
			. "|_extreme250_"
			. "|_extreme300_"
			. "|_gigabit_"
			. "|_gigabitpro_"
			. "|_internetessentials_"
			. "|_internet5_"
			. "|_performance2_"
			. "|_performancepro_"
			. "|_performancestarter_"
			. "|_silver_"
			. "|_silverboost_"
			. "|_speedtier_"
			. "|_speedtierextreme2_"
			. "|_tppremier_"
			. "|_widebandblast_"
			. "|_widebandshowcaseblast_"

WirelessGateways := "Arris SB8200"
			. "|C3000100NAS"
			. "|C3700100NAS"
			. "|C6300"
			. "|Cable Modem only"
			. "|CM500100NAS"
			. "|Customer Owned Equipment"
			. "|DPC3939"
			. "|DPC3939B"
			. "|DPC3941T"
			. "|Netgear CM1000"
			. "|Netgear R8000"
			. "|SBG6782AC"
			. "|SMCD3GNV"
			. "|TC4400-CMT"
			. "|TC8305C"
			. "|TC8717C"
			. "|TG1682G"
			. "|TG852G"
			. "|TG862G"
			. "|Other"

MarketRegions := "BELTWAY MARKET"
				. "|BIG SOUTH REGION"
				. "|CALIFORNIA MARKET"
				. "|FLORIDA REGION"
				. "|FREEDOM MARKET"
				. "|GREATER BOSTON MARKET"
				. "|GREATER CHICAGO MARKET"
				. "|HEARTLAND REGION"
				. "|HOUSTON MARKET"
				. "|KEYSTONE MARKET"
				. "|MILE HIGH REGION"
				. "|MOUNTAIN WEST REGION"
				. "|NATIONAL"
				. "|PORTLAND/SALEM MARKET"
				. "|SALT LAKE CITY MARKET"
				. "|SEATTLE MARKET"
				. "|TWIN CITIES MARKET"
				. "|WESTERN NEW ENGLAND MARKET"


;;; INITIALIZE VARIOUS COM'S VARIABLES TO BE SCRAPED
ReconnectComs:
global es360 := setWbCom("Einstein 360° - Internet Explorer", "https://einstein360.cable.comcast.com/einstein360")
global Remedy := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/")
global GP := setWbCom("Support.com Cloud","https://care.nexus.support.com/nexus/#/navigator")
global Scout := setWbCom("Scout Monitor", "http://scoutmonitoring.g.comcast.net/network_monitoring/servlet/network_monitoring")
global ZipLookup := setWbCom("Home - Comcast XHome", "http://intranet.support.com/SDCWorkcenter/SEPortal/XHome/default.aspx")
global RemedyCreate := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/RX-Customer+Care/Create+Customer+Ticket/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/RX-Customer+Care/Create+Customer+Ticket/")
global RemedyCreateOK := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/SHR%3AMessage/Message-OK-3x45/","http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/SHR%3AMessage/Message-OK-3x45/")
global RemedyResolve := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3AResolve+CR/Resolve/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3AResolve+CR/Resolve/?cacheid=822738ed&format=html")
global RemedyBypass := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/")
global DP360 := setWbCom("TruckRoll Schedule","https://einstein360.cable.comcast.com/Einstein360/GenericPopup/*")
global esUP := setWbCom("Users & Preferences", "https://einstein360.cable.comcast.com/Einstein360/Toolkit/Default")
if (reconnect = 1)
{
	MessageStatus("info","COM's have been reconnected")
	reconnect = 0
	Return
}


IniRead, MMX, .\Lib\MM.ini, MMWinPos, XPos, 0
IniRead, MMY, .\Lib\MM.ini, MMWinPos, YPos, 0
MMX += 28
MMY += 36
SplashImage, Lib\Pics\MetricMaster.png, x%MMX% y%MMY% B,Loading...
Gui,MM:Show,,Metric Master

IniRead, es, .\Lib\MM.ini, Einstein, Ein, 360
IniRead, REPORTED_ISSUE, .\Lib\MM.ini, Einstein, ReportedIssue
IniRead, RESOLUTION_ACTION, .\Lib\MM.ini, Einstein, ResolutionAction

IniRead, AButt, .\Lib\MM.ini, AvayaSettings, AvayaButtons, A
IniRead, AutoInX, .\Lib\MM.ini, AvayaSettings, AutoInX_%AButt%, 189
IniRead, AfterCallX, .\Lib\MM.ini, AvayaSettings, AfterCallX_%AButt%, 332
IniRead, ButtonBar, .\Lib\MM.ini, AvayaSettings, ButtonBar, 51

;;; GET FORMATTED DATE
FormatTime, TIME_STAMP, , MMM-dd-yyyy

IfWinNotExist, Einstein 360
{
	skipInit = 1
	goto skip_init
}


;;; GET CUSTOMER NAME FROM EINSTEIN
if (es = "360")
{
	;;; EINSTEIN 360 INITIALIZATION ROUTINE

	IfWinExist, Einstein 360
		WinActivate, Einstein 360

	SplashTextOn,300,,Getting Customer Name
	try {
		CUSTOMER_NAME := es360.document.getElementById("customer-name").getElementsByTagName("SPAN")[0].innerText
		ACCOUNT_NUMBER := es360.document.getElementById("newHeaderSection").getElementsByTagName("DIV")[3].innerText
		PHONE_NUMBER := es360.document.all.callbackNo.innerText
			TELEPHONE := StrReplace(PHONE_NUMBER, "(")
			CONTACT_NUMBER := StrReplace(TELEPHONE,") ","-")
		MARKET := es360.document.all.market.innerText
		StringTrimRight, MARKET, MARKET, 1
		ZIP_CODE := es360.document.getElementById("header-customer-address").getElementsByTagName("SPAN")[3].innerText
		ALT_EMAIL := es360.document.getElementById("expanded-email").InnerText
	} catch e {
		skipInit = 1
		Goto, skip_init
	}
	
	SplashTextOn,300,,Opening Devices Menu
	try {
		es360.document.getElementById("lhs-button-devices").click()

		sleep, 2000

		SplashTextOn,300,,Opening Internet Menu
		Loop {
		} Until es360.document.getElementById("liEquipment_Internet").getElementsByClassName("summary")[0].innerText = "Internet"
		es360.document.getElementById("liEquipment_Internet").getElementsByClassName("summary")[0].click()

		sleep, 2000

		SplashTextOn,300,,Opening Gateway Card
		Loop {
		} Until es360.document.getElementById("liEquipment_Internet").getElementsByTagName("SPAN")[4].innerText = "Device Type: "
		es360.document.getElementById("liEquipment_Internet").getElementsByTagName("SPAN")[4].click()

		sleep, 4000

	} catch e {
		DevCard := "ERROR: device card not loaded."
	}
	
	SplashTextOn,300,,Getting Gateway Model
	try {
		GATEWAY_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
		Loop %GATEWAY_LENGTH% {
			INDEXER := A_Index
		} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "Device Make/Model"
		WIRELESS_GATEWAY := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
		RegExMatch(WIRELESS_GATEWAY, ".*\s$", EndSpace)
		if (EndSpace)
			RegExMatch(WIRELESS_GATEWAY, "^.*\s(\w*)\s$", WGOut)
		else
			RegExMatch(WIRELESS_GATEWAY, "^.*\s(\w*)$", WGOut)
		WIRELESS_GATEWAY := WGOut1
	} catch e {
		GateError := "Gateway not found"
	}
	
	SplashTextOn,300,,Getting IP Address
	try {
		IP_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
		Loop %IP_LENGTH% {
			INDEXER := A_Index
		} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "IP Address of Modem"
		IP_ADDRESS := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
		IP_ADDRESS := MatchIP(IP_ADDRESS)
		} catch e {
		IPError := "IP Address not found"
	}
	
	SplashTextOn,300,,Getting Boot File
	try {
		BOOT_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
		Loop %BOOT_LENGTH% {
			INDEXER := A_Index
		} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "Modem Boot File"
		BOOT_FILE := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
	} catch e {
		BootError := "Boot File not found"
	}
	
	SplashTextOn,300,,Getting MAC Address
	try {
		MAC_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
		Loop %MAC_LENGTH% {
			INDEXER := A_Index
		} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "MAC Address"
		MAC_ADDRESS := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
	} catch e {
		MACError := "MAC Address not found"
	}

	SplashTextOn,300,,Getting Autopay Info
	try
	{
		es360.document.all.LaunchBillingSummary.click()
		Loop {
			Sleep, 7000
		} Until es360.document.all.billSummaryPaymentDue.getElementsByTagName("SPAN")[0].InnerText := "Payment Due:"
		BALANCE := es360.document.all.billSummaryPaymentDue.getElementsByTagName("SPAN")[1].InnerText
		DUE_DATE := es360.document.all.billStatementSummary.getElementsByTagName("DIV")[0].InnerText
		StringTrimRight, DUE_DATE, DUE_DATE, 5
		enrolled := es360.document.getElementByID("ebillAutoPay").InnerText
		RegExMatch(enrolled, "Enrolled in Autopay", AUTO_PAY)
		if (AUTO_PAY = "Enrolled in Autopay")
			AUTO_PAY := "YES"
		else
			AUTO_PAY := "NO"
	}
		
} else {
	skipInit = 1
	IniWrite, 360, .\Lib\MM.ini, Einstein, Ein
}


SplashTextOff

skip_init:
Gui,MM:Destroy
Gui,MM:-AlwaysOntop

IniRead, MMX, .\Lib\MM.ini, MMWinPos, XPos, 0
IniRead, MMY, .\Lib\MM.ini, MMWinPos, YPos, 0
IniRead, MMOnTop, .\Lib\MM.ini, MMAlwaysOnTop, AlwaysOnTop , 0

IniRead, MMTheme, .\Lib\MM.ini, MMTheme, Theme , 0
if MMTheme
{
	IniRead, MMBackgroundColor, .\Lib\MM.ini, MMTheme, BackgroundColor, F0F0F0
	IniRead, MMControlColor, .\Lib\MM.ini, MMTheme, ControlColor, FFFFFF
	IniRead, MMTextColor, .\Lib\MM.ini, MMTheme, TextColor, 000000
} else {
	IniRead, MMBackgroundColor, .\Lib\MM.ini, MMTheme, DefaultBackgroundColor, F0F0F0
	IniRead, MMControlColor, .\Lib\MM.ini, MMTheme, DefaultControlColor, FFFFFF
	IniRead, MMTextColor, .\Lib\MM.ini, MMTheme, DefaultTextColor, 000000
}

SplashTextOff

Gui,MM:Default
Gui,MM:+Resize

Gui,MM:Add,Text,x30 y10 w276 h51 Border gMMStatus vMMStatus,%MMSTATUS%
Gui,MM:Add,Picture,x30 y10 w276 h51 vErrorBG,Lib\Pics\error.png
Gui,MM:Add,Picture,x30 y10 w276 h51 vWarnBG,Lib\Pics\warn.png
Gui,MM:Add,Picture,x30 y10 w276 h51 vInfoBG,Lib\Pics\info.png
Gui,MM:Add,Text,x30 y10 w276 h51 Border BackgroundTrans vMessageStatus

GuiControl,MM:Hide,MMStatus
GuiControl,MM:Hide,MessageStatus
GuiControl,MM:Hide,ErrorBG
GuiControl,MM:Hide,WarnBG
GuiControl,MM:Hide,InfoBG
Gui,MM:Color,%MMBackgroundColor%,%MMControlColor%
Gui,MM:Font,c%MMTextColor%

Gui,MM:Add,Picture,x30 y10 w275 h51 gMMBanner vMMBanner,Lib\Pics\MetricMaster.png
Gui,MM:Add,Button,x310 y10 w30 h20 gMMHelp vMMHelp,Help
Gui,MM:Add,Button,x310 y30 w30 h20 gMMSettings vMMSettings,Sets
Gui,MM:Add,Text,x260 y50 w50 h13 vMMVersion,v1.0.0
Gui,MM:Add,GroupBox,x10 y70 w330 h330,Documentation/Notes
Gui,MM:Add,Text,x20 y90 w100 h20 Right,Today's Date:
Gui,MM:Add,Edit,x130 y90 w200 h21 vTIME_STAMP ReadOnly,%TIME_STAMP%
Gui,MM:Add,Text,x20 y110 w100 h20 gMMTicketNumber vMMTicketNumber Right Border,Ticket Number:
Gui,MM:Add,Edit,x130 y110 w120 h21 gTICKET_NUMBER vTICKET_NUMBER HwndTICKETNUMBER,%TICKET_NUMBER%
Gui,MM:Add,Button,x250 y110 w40 h20 gMMTT2Cursor vMMTT2Cursor,Send
Gui,MM:Add,Button,x290 y110 w40 h20 gMMTTCopy vMMTTCopy,Copy
Gui,MM:Add,Text,x20 y130 w100 h20 Right,Customer Name:
Gui,MM:Add,Edit,x130 y130 w200 h21 vCUSTOMER_NAME HwndCUSTOMERNAME ReadOnly,%CUSTOMER_NAME%
Gui,MM:Add,Text,x20 y150 w100 h20 gMMAccountNumber vMMAccountNumber Right Border,Account Number:
Gui,MM:Add,Edit,x130 y150 w120 h21 gACCOUNT_NUMBER vACCOUNT_NUMBER HwndACCOUNTNUMBER,%ACCOUNT_NUMBER%
Gui,MM:Add,Button,x250 y150 w30 h20 gMMAcct2Rem vMMAcct2Rem,Re
Gui,MM:Add,Button,x280 y150 w30 h20 gMMAcct2Scout vMMAcct2Scout,Sc
Gui,MM:Add,Button,x310 y150 w20 h20 gMMAcctCopy vMMAcctCopy,C
Gui,MM:Add,Text,x20 y170 w100 h20 gMMPhoneNumber vMMPhoneNumber Right Border,Phone Number:
Gui,MM:Add,Button,x130 y170 w15 h20 gMMPhone vMMPhone,C
Gui,MM:Add,Edit,x145 y170 w75 h21 gCONTACT_NUMBER vCONTACT_NUMBER HwndCONTACTNUMBER ReadOnly,%CONTACT_NUMBER%
Gui,MM:Add,Edit,x220 y170 w75 h21 gBEST_NUMBER vBEST_NUMBER,%BEST_NUMBER%
Gui,MM:Add,Button,x295 y170 w20 h20 gMMBestSend vMMBestSend,S
Gui,MM:Add,Button,x315 y170 w15 h20 gMMBestNumber vMMBestNumber,C
Gui,MM:Add,Text,x20 y190 w100 h20 Right,Chronic Account:
Gui,MM:Add,DropDownList,x130 y190 w70 vCHRONIC_ACCOUNT,No||Yes
Gui,MM:Add,Text,x210 y193 w120 h15,Documentation Buttons:
Gui,MM:Add,Text,x20 y210 w100 h20 Right,Attempt Number:
Gui,MM:Add,DropDownList,x130 y210 w70 vATTEMPT_NUMBER,1||2|3|4|5 or more
Gui,MM:Add,Button,x210 y210 w30 h20 gMMCopyNotes vMMCopyNotes,Cop
Gui,MM:Add,Button,x240 y210 w30 h20 gMMNotesSend vMMNotesSend,Sen
Gui,MM:Add,Button,x270 y210 w60 h20 gMMRemNotes vMMRemNotes,RemQN
Gui,MM:Add,Text,x20 y230 w100 h20 Right,Affected Devices:
Gui,MM:Add,ComboBox,x130 y230 w200 vAFFECTED_DEVICE,Blu-ray / DVD Player|Laptop|PC|Phone|Printer|Streaming Device|Tablet|TV|Video Games|Wireless Gateway / Router Only||Other|
Gui,MM:Add,Edit,x130 y250 w200 h40 HwndDefaultBox vREPORTED_ISSUE,%REPORTED_ISSUE%
Gui,MM:Add,Text,x20 y260 w100 h20 gMMReportedIssue vMMReportedIssue Right Border,Reported Issue:
Gui,MM:Add,Edit,x130 y290 w200 h80 vRESOLUTION_ACTION,%RESOLUTION_ACTION%
Gui,MM:Add,Text,x20 y300 w100 h20 gMMResolutionAction vMMResolutionAction Right Border,ResolutionAction:
Gui,MM:Add,Button,x30 y330 w85 h20 gMMDispatch vMMDispatch,Dispatch Notes
Gui,MM:Add,Text,x20 y370 w100 h20 Right,Next Action:
Gui,MM:Add,ComboBox,x130 y370 w200 vNEXT_ACTION,None||Truck Roll|Replace Equipment| Visit Comcast Store|Transfer|Awaiting Customer Response
Gui,MM:Add,GroupBox,x10 y410 w330 h230,Modem Information
Gui,MM:Add,Button,x230 y420 w100 h20 gMMSubmitChanges vMMSubmitChanges,Sumbit Changes
Gui,MM:Add,Text,x20 y430 w100 h20 Right,Txfr w/o TT#:
Gui,MM:Add,DropDownList,x130 y430 w50 vMMTTTxfr,No||Yes
Gui,MM:Add,Text,x20 y450 w100 h20 gMMGateway_Get vMMGateway_Get Right Border,Wrls Gateway:
Gui,MM:Add,ComboBox,x130 y450 w130 gMMGateway vWIRELESS_GATEWAY HwndWIRELESSGATEWAY,%WIRELESS_GATEWAY%||%WirelessGateways%
Gui,MM:Add,Edit,x260 y450 w70 h21 gMMGateway_Other vWG_OTHER,Unknown
Gui,MM:Add,Text,x20 y470 w40 h20 vMMBootSpeed Center,?/?
Gui,MM:Add,Text,x60 y470 w60 h20 gMMBoot vMMBoot Right Border,BootFile:
Gui,MM:Add,ComboBox,x130 y470 w200 gMMBootSpeed vBOOT_FILE HwndBOOTFILE,%BOOT_FILE%||%Bootfiles%
Gui,MM:Add,Text,x20 y490 w100 h20 gMMGetIP vMMGetIP Right Border,IP Address:
Gui,MM:Add,Edit,x130 y490 w120 h21 gMMIPAddress vIP_ADDRESS HwndIPADDRESS,%IP_ADDRESS%
Gui,MM:Add,Button,x250 y490 w40 h20 gMMIP2RDS vMMIP2RDS,RDS
Gui,MM:Add,Button,x290 y490 w40 h20 gMMIPCopy vMMIPCopy,Copy
Gui,MM:Add,Text,x20 y510 w100 h20 gMMMACAddress vMMMACAddress Right Border,MAC Address:
Gui,MM:Add,Edit,x130 y510 w100 h21 gMMMAC vMAC_ADDRESS HwndMACADDRESS,%MAC_ADDRESS%
Gui,MM:Add,Button,x230 y510 w40 h20 gMMMACNoColon vMMMACNoColon,NoCol
Gui,MM:Add,Button,x270 y510 w40 h20 gMMMACSend vMMMACSend,Send
Gui,MM:Add,Button,x310 y510 w20 h20 gMMMACCopy vMMMACCopy,C
Gui,MM:Add,Text,x20 y530 w100 h20 gMMSSID vMMSSID Right Border,SSID 2.4:
Gui,MM:Add,Button,x130 y530 w15 h20 gMMSSIDCopy vMMSSIDCopy,C
Gui,MM:Add,Edit,x145 y530 w85 h21 gSSID vSSID,%SSID%
Gui,MM:Add,Text,x230 y530 w15 h20 gMMSSIDPass vMMSSIDPass Center Border,P
Gui,MM:Add,Edit,x245 y530 w70 h21 gSSID_PASS vSSID_PASS,%SSID_PASS%
Gui,MM:Add,Button,x315 y530 w15 h20 gMMSSIDPassCopy vMMSSIDPassCopy,C
Gui,MM:Add,Text,x20 y550 w100 h20 gMMSSID5 vMMSSID5 Right Border,SSID 5.0:
Gui,MM:Add,Button,x130 y550 w15 h20 gMMSSID5Copy vMMSSID5Copy,C
Gui,MM:Add,Edit,x145 y550 w85 h21 gSSID5 vSSID5,%SSID5%
Gui,MM:Add,Text,x230 y550 w15 h20 gMMSSID5Pass vMMSSID5Pass Center Border,P
Gui,MM:Add,Edit,x245 y550 w70 h21 gSSID5_PASS vSSID5_PASS,%SSID5_PASS%
Gui,MM:Add,Button,x315 y550 w15 h20 gMMSSID5PassCopy vMMSSID5PassCopy,C
Gui,MM:Add,Text,x20 y570 w100 h20 Right,Location Comarision:
Gui,MM:Add,DropDownList,x130 y570 w100 vMMLocComp,0-10 feet|10-30 feet||30-50 feet|50+ feet
Gui,MM:Add,Button,x240 y575 w45 h30 gMMSkipES vMMSkipES,SkipES
Gui,MM:Add,Button,x285 y575 w45 h30 gMMEndES vMMEndES,EndES
Gui,MM:Add,Text,x20 y590 w100 h20 Right,How Many Devices:
Gui,MM:Add,DropDownList,x130 y590 w100 vMMManyDevices,1||2|3 or more
Gui,MM:Add,Text,x20 y610 w100 h20 Right,Enviro Details:
Gui,MM:Add,ComboBox,x130 y610 w200 gENVIRO_DETAILS vENVIRO_DETAILS,%ENVIRO_DETAILS%|Modem in the living room||Modem Upstairs|Modem Downstairs|Modem in Attick|Modem in Basement|Modem at far end of house
Gui,MM:Add,GroupBox,x10 y650 w330 h130,Misc Info
Gui,MM:Add,Text,x20 y670 w100 h20 Right,Market Region:
Gui,MM:Add,ComboBox,x130 y670 w200 gMMMarketRegion vMARKET_REGION HwndMARKETREGION,%MARKET_REGION%||%MarketRegions%
Gui,MM:Add,Text,x20 y690 w100 h20 Right,Zip Code:
Gui,MM:Add,Edit,x130 y690 w120 h21 gMMZipCode vZIP_CODE HwndZIPCODE,%ZIP_CODE%
Gui,MM:Add,Button,x250 y690 w40 h20 gMMZipLook vMMZipLook,Look
Gui,MM:Add,Button,x290 y690 w40 h20 gMMZipCopy vMMZipCopy,Copy
Gui,MM:Add,Text,x20 y710 w100 h20 gMMAltEmail vMMAltEmail Right Border,Alt Email:
Gui,MM:Add,Edit,x130 y710 w170 h21 gMMALT_EMAIL vALT_EMAIL HwndALTEMAIL,%ALT_EMAIL%
Gui,MM:Add,Button,x300 y710 w15 h20 gMMAESend vMMAESend,S
Gui,MM:Add,Button,x315 y710 w15 h20 gMMAECopy vMMAECopy,C
Gui,MM:Add,Text,x20 y730 w100 h20 Right,Balance Due:
Gui,MM:Add,Edit,x130 y730 w70 h21 vBALANCE HwndBAL ReadOnly,%BALANCE%
Gui,MM:Add,Edit,x200 y730 w80 h21 vDUE_DATE ReadOnly,%DUE_DATE%
Gui,MM:Add,Button,x290 y740 w40 h30 gMMGuidedPaths vMMGuidedPaths,GP
Gui,MM:Add,Text,x20 y750 w100 h20 Right,Auto Pay:
Gui,MM:Add,Edit,x130 y750 w50 h21 vAUTO_PAY HwndAUTOPAY ReadOnly,%AUTO_PAY%
Gui,MM:Add,GroupBox,x140 y790 w100 h110,Remedy
Gui,MM:Add,Button,x150 y810 w80 h25 gMMCreateTicket vMMCreateTicket,Create TIcket
Gui,MM:Add,Button,x150 y840 w80 h25 gMMResolveTicket vMMResolveTicket,Resolve Ticket
Gui,MM:Add,Button,x150 y870 w80 h25 gMMBypassTicket vMMBypassTicket,Bypass/Other
Gui,MM:Add,GroupBox,x250 y790 w90 h110,Other Tools
Gui,MM:Add,Button,x260 y810 w70 h20 gMMS4Checklist vMMS4Checklist,S4 Checklist
Gui,MM:Add,Button,x260 y830 w70 h20 gMMRDSPass vMMRDSPass,RDS Pass
Gui,MM:Add,Button,x260 y850 w35 h20 gMMWM vMMWM,WM
Gui,MM:Add,Button,x20 y800 w80 h30 gMMNewCustomer vMMNewCustomer,New Customer
Gui,MM:Add,Button,x100 y800 w20 h30 gMMRestart vMMRestart,R
Gui,MM:Add,Button,x20 y830 w80 h30 gMMEndCall vMMEndCall,End Call
Gui,MM:Add,Button,x100 y830 w20 h30 gMMResetOptions vMMResetOptions,?
Gui,MM:Add,Button,x20 y860 w100 h30 gMMDestroy vMMDestroy,Destroy

Gui,MM:Show,w350 h910 x%MMX% y%MMY%,Metric Master

Gosub, ControlColors
SplashImage,Off

if MMOnTop
	Gui,MM:+AlwaysOnTop 
else 
	Gui,MM:-AlwaysOnTop 

GuiControl,MM:Disable,WG_OTHER
GuiControl,MM:Focus, REPORTED_ISSUE

Gui,MM:Font, cGreen Bold
GuiControl,MM:Font,MMTicketNumber
GuiControl,MM:Font,MMGateway_Get
GuiControl,MM:Font,MMBoot
GuiControl,MM:Font,MMGetIP
GuiControl,MM:Font,MMMACAddress

Gui,MM:Font, cMaroon
GuiControl,MM:Font,MMReportedIssue
GuiControl,MM:Font,MMResolutionAction

Gui,MM:Font, cRed
GuiControl,MM:Font,MMSSIDPass
GuiControl,MM:Font,MMSSID5Pass

Gui,MM:Font, cBlue
GuiControl,MM:Font,MMAccountNumber
GuiControl,MM:Font,MMPhoneNumber
GuiControl,MM:Font,MMSSID
GuiControl,MM:Font,MMSSID5
GuiControl,MM:Font,MMAltEmail 

Gui,MM:Submit,NoHide

if (skipInit != 1)
	Gosub, MMBootSpeed

if (es = "360")
{
	Gui,MM:Submit,Nohide

	length := GetDDLLength("ComboBox8")
	Loop, %length% {
		GuiControl, MM:Choose, MARKET_REGION, %A_Index%
		GuiControlGet,REGION,MM:,MARKET_REGION
		RegExMatch(REGION, MARKET, MROUT)
		INDEXER := %A_Index%
		}  Until (MROUT = MARKET)
	GuiControl, MM:Choose, MARKET_REGION, %INDEXER%
	

	Gui,MM:Submit,Nohide
}

GetDDLLength(item) {
	ControlGet, DDLLength, List, , %item%, Metric Master
	loop, parse, DDLLength,`n,`r
		b_index := A_Index
	Return b_index
}

OnMessage(0x200,"WM_MOUSEMOVE_FUNC")

ACCOUNT_NUMBER_TT := "Place holder for the Account Number"
AFFECTED_DEVICE_TT := "What devices are affected by the problem?"
ALT_EMAIL_TT := "Place holder for Atl Email."
ATTEMPT_NUMBER_TT := "How many attempts have been made to resolve the issue?"
BEST_NUMBER_TT := "What the best contact number for the customer? (Temporary place holder for now. Automation has not been programed)"
BOOT_FILE_TT := "Select a Boot File manually if one was not selected automatically, or use  [Alt + B]  to mouse hover capture bootfile from ES or Scout."
CHRONIC_ACCOUNT_TT := "Is this a chronic caller?"
CONTACT_NUMBER_TT := "Place holder the Phone Number"
CUSTOMER_NAME_TT := "Place holder for the Customer Name"
ENVIRO_DETAILS_TT := "What are some details of the environment around the modem?"
IP_ADDRESS_TT := "[Alt + I]  to mouse hover capture IP. Or paste in IP Address manually if one was not selected automatically."
MAC_ADDRESS_TT := "[Alt + M] to mouse hover capture MAC from ES or Scout. Or paste in MAC Address manually if one was not selected automatically."
MARKET_REGION_TT := "Select Market Region if one was not selected automatically."
MMAccountNumber_TT := "[Ctrl + Alt + Win + A]  or click to send account number to cursor."
MMAcct2Rem_TT := "[Ctrl + Alt + Win + R]  or click to send Account Number into Remedy customer search box."
MMAcct2Scout_TT := "[Ctrl + Alt + Win + S]  or click to send Account Number into Scout Monitor customer search box."
MMAcctCopy_TT := "Copy Account number to clipboard."
MMAECopy_TT := "Click to copy Alt Email to clipboard."
MMAESend_TT := "Click to send Alt Email to cursor."
MMAltEmail_TT := "[Ctrl + Alt + Win + L]  or click to paste Alt Email into ES360."
MMBanner_BT := "[Win + M]  to activate Metric Master window`nor  [Double Right Click]  anywhere, anytime.`n Useful when hidden behind other windows`n`n Click this banner for contact info`n  and various control status updates."
MMBestNumber_TT := "Copy Best Number to clipboard."
MMBestSend_TT := "Click to send Best Number to cursor."
MMBoot_TT := "Click to retrieve bootfile (if available), or use [Alt + B] to mouse hover capture the boot file name."
MMBypassTicket_TT := "[Ctrl + Alt + Win + B]  to bypass auto open of first ticket in the list, and resovle different ticket you manually opened."
MMColors_TT := "Click to change the color theme for Metric Master."
MMCopyNotes_TT := "Copy notes to clipboard."
MMCreateTicket_TT := "[Ctrl + Alt + Win + C]  or click to create a ticket."
MMDestroy_TT := "Click to Destroy sensitive info and close program."
MMDispatch_TT := "[Ctrl + Alt + Win + D]  or click to quickly fillout dispatch notes for truck rolls. Place cursor where you wants the notes to appear first before hitting this button."
MMEndCall_TT := "[Ctrl + Alt + Win + E]  to end the call and autofill all documentation."
MMEndES_TT := "[Ctrl + Alt + Shift + E]  or click to End Conversation in ES360, saving notes automatically."
MMGateway_Get_TT := "Click to retrieve Gateway Model (if available)`nor use  [Alt + G]  to mouse hover capture the gateway from ES or Scout."
MMGetIP_TT := "Click to get IP when gateway is offline (if possible). Or use  [Alt + I]  to mouse hover capture IP from ES, or Scout."
MMGuidedPaths_TT := "[Ctrl + Alt + Win + G]  to fill out and close Guided Path session."
MMHelp_TT := "[Ctrl + Alt + Win + H]  or click to see helpful information."
MMIP2RDS_TT := "[Ctrl + Alt + Win + I]  to send IP Address to RDS address bar."
MMIPCopy_TT := "Copy IP Address to Clipboard."
MMLocComp_TT := "What is the Location of device in proximity to modem?"
MMMACAddress_TT := "Click to get MAC Address (if possible), or use  [Alt + M]  to mouse hover capture MAC from ES or Scout."
MMMACCopy_TT := "Copy MAC Address to Clipboard"
MMMACNoColon_TT := "Copy MAC Address to Clipboard without colons."
MMMACSend_TT := "[Ctrl + Alt + Win + M]  or click to send MAC Address to cursor."
MMManyDevices_TT := "How many devices did you work with?"
MMNewCustomer_TT := "[Ctrl + Alt + Win + N]  or click to refresh new customer variables."
MMNotesSend_TT := "[Ctrl + Alt + Win + P]  or click to send Notes to current cursor position."
MMOnTop_TT := "Check this box to always keep Metric Master on top of other windows."
MMPhone_TT := "Copy Phone number to clipboard."
MMPhoneNumber_TT := "[Ctrl + Alt + Win + O]  or click to send Phone Number at cursor."
MMRDSPass_TT := "Show RDS Password Manager Tool."
MMRemNotes_TT := "[Ctrl + Alt + Win + Q]  to add a Quick Note to account in Remedy."
MMReportedIssue_TT := "Click to get a quick fill menu for sentence structuring array."
MMResetOptions_TT := "[Ctrl + Alt + Win + ?]  to choose specific End Call functions."
MMResolutionAction_TT := "Click to get a quick fill menu for sentence structuring array."
MMResolveTicket_TT := "[Ctrl + Alt + Win + V]  or click to resolve a ticket. Will only work on first assigned ticket in list."
MMRestart_TT := "[Ctrl + Alt + Shift + R]  or click to restart, but keep notes.   [Ctrl + Alt + Shift + Win + R]  or  [Esc] to restart and bypass initializations to get unstuck if modem missing."
MMS4Checklist_TT := "Show S4 Checklist."
MMSettings_TT := "Click to change various settings."
MMSkipES_TT := "[Alt + Shift + Win + E]  to skip End Conversation in ES360 (No Changes made to account)."
MMSSID_TT := "use [Alt + Shift + S] with cursor on SSID 2.4 box. RDS does not support the click method."
MMSSID5_TT := "use [Alt + Shift + X] with cursor on SSID 5.0 box. RDS does not support the click method."
MMSSID5Copy_TT := "Click to copy 5ghz SSID to clipboard."
MMSSID5Pass_TT := "use [Alt + Shift + C] with cursor on 5.0 password box. RDS does not support the click method."
MMSSID5PassCopy_TT := "Click to copy 5ghz Password to clipboard"
MMSSIDCopy_TT := "Click to copy 2.4 SSID to clipboard"
MMSSIDPass_TT := "use [Alt + Shift + D] with cursor hovered on 2.4 password box. RDS does not support the click method."
MMSSIDPassCopy_TT := "Click to copy 2.4 Password to clipboard"
MMStatus_TT := "Created by:  joshebosh`nemail:  joyoung@support.com`nalt email:  sdc@joshebosh.com"
MMSubmitChanges_TT := "Click to save manually changed variables."
MMTheme_TT := "Click to enable the color theme for Metric Master."
MMTicketNumber_TT := "[Ctrl + Alt + Win + T]  or click to get the TT# from Remedy (if available), or  [Alt + T] to mouse hover capture from Remedy."
MMTT2Cursor_TT := "[Ctrl + Alt + Shift + T]  or click to send the TT# to cursor position."
MMTTCopy_TT := "Copy TT# to clipboard."
MMTTTxfr_TT := "Was ticket already created before transfer?"
MMWM_TT := "Click to view help info on the Window Manager(WM)."
MMZipCopy_TT := "Copy Zipcode to clipboard."
MMZipLook_TT := "Send Zip Code to Lookup Tool."
NEXT_ACTION_TT := "What needs to happend next?"
REPORTED_ISSUE_TT := "What is the issues the Customer is reporting?"
RESOLUTION_ACTION_TT := "What actions did you take to resolve the issue?"
SSID_PASS_TT := "[Alt + D]  while hovering mouse over 2.4 password to capture."
SSID_TT := "[Alt + S]  while hovering mouse over SSID to capture 2.4 SSID"
SSID5_PASS_TT := "[Alt + C]  while hovering mouse over 5ghz password to capture."
SSID5_TT := "[Alt + X]  whie hovering mouse over SSID to capture 5ghz SSID."
TICKET_NUMBER_TT := "Place holder for the Ticket Number"
TIME_STAMP_TT := "Place holder for the Date"
WIRELESS_GATEWAY_TT := "Select a Wireless Gateway manually if one was not selected automatically, or use  [Alt + G]  to mouse hover capture from ES or Scout."
ZIP_CODE_TT := "Place holder for the Zip Code"

Gui,MM:Submit,Nohide

SplashTextOff

if (Themed = 1)
{
	Themed := 0
	return
}

NewCustSend:
if skipInit = 1
{
	Gui, MM:Submit,NoHide
	MessageStatus("Error","Account not opened in ES360.")
	skipInit = 0
	es = 360
	Return
} else {

	if ((DevCard) or (GateError) or (IPError) or (BootError) or (MACError))
	{
		MessageStatus("Error", DevCard "..." GateError "... " IPError "... " BootError "... " MACError)
	}
	Gui,SendAccount:Add,Text,xp yp+20,Automate the following?
	Gui,SendAccount:Add,CheckBox,xp yp+40 vSendAvaya Checked,AfterCall
	Gui,SendAccount:Add,CheckBox,xp yp+20 vSendRemedy Checked,Remedy
	Gui,SendAccount:Add,CheckBox,xp yp+20 vSendRDS Checked,RDS
	Gui,SendAccount:Add,CheckBox,xp yp+20 vSendScout Checked,Scout
	Gui,SendAccount:Add,CheckBox,xp yp+20 vSendGP Checked,Guided Paths
	SAOKW := 50
	SAOKH := 50
	Gui,SendAccount:Add,Button,xp yp+40 w%SAOKW% h%SAOKH% gSendOK vSendOK Default,OK
	Gui,SendAccount:Show
	Gui,SendAccount:+AlwaysOnTop
	SetTimer, OKTimeout, 5000
	Return
	
	SendAccountGuiSize:
	SAOKX := (A_GuiWidth - SAOKW) // 2
	GuiControl, Move, SendOK, x%SAOKX%
	Return
	
	SendAccountGuiClose:
	SendAccountGuiEscape:
	Gui,SendAccount:Destroy
	SetTimer, OKTimeout, off
	Return

	SendOK:
	SetTimer, OKTimeout, off
	Gui,SendAccount:Submit
	if SendAvaya
	{
		Gosub, AfterCall
	}
	if SendRemedy
	{
		Gosub, MMAcct2Rem
	}
	if SendRDS
	{
		if IP_ADDRESS != ""
		{
			Gosub, MMIP2RDS
		}
	}
	if SendScout
	{
		Gosub, MMAcct2Scout
	}
	if SendGP
	{
		if (ACCOUNT_NUMBER and TICKET_NUMBER and MARKET and BOOT_FILE and WIRELESS_GATEWAY)
			Gosub, MMGuidedPaths
		else
			MessageStatus("Error","GP not ready. Populate red fields manually. Click GP Button")
	}
	Gui,MM:Submit,NoHide
	
	MessageStatus("Info","Loading complete...")
	Gosub, ControlColors
	Return
	
	OKTimeout:
	Send, {Enter}
	Return
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; END OF INITIALIZATIONS ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MMGuiSize:
	If (A_EventInfo != 1) {
		Gui, %A_Gui%:+LastFound
		WinSet, ReDraw
	}
Return


#m::
IfWinExist, Metric Master
	WinActivate, Metric Master
Return

MMBanner:
GuiControl,MM:Hide,MMBanner
GuiControl,MM:Hide,MMVersion
GuiControl,MM:Show,MMStatus
GuiControl,MM:,MMStatus,%Banner%
return

MMStatus:
GuiControl,MM:Hide,MMStatus
GuiControl,MM:Show,MMBanner
GuiControl,MM:Show,MMVersion
Return

MMTicketNumber:
^!#t::
;;; GET TROUBLE TICKET NUMBER
IfWinExist, Home (Search)
	WinActivate, Home (Search)
try {
	if ((Remedy.document.all.T680001300.getElementsByTagName("SPAN")[3].InnerText = "Assigned") or (Remedy.document.all.T680001300.getElementsByTagName("SPAN")[3].InnerText = "Working") or (Remedy.document.all.T680001300.getElementsByTagName("SPAN")[3].InnerText = "Linked") or (Remedy.document.all.T680001300.getElementsByTagName("SPAN")[3].InnerText = "New")) {
		TICKET_NUMBER := Remedy.document.all.T680001300.getElementsByTagName("SPAN")[0].InnerText
		GuiControl,MM:,TICKET_NUMBER,%TICKET_NUMBER%
		GuiControl,MM:Choose,MMTTTxfr,2
	} else {
		MsgBox,4100,No Ticket Found,Create Ticket Now?,5
			IfMsgBox Yes
				Gosub, MMCreateTicket
			IfMsgBox Timeout
				Return
			IfMsgBox No
				Return
	}
	Gui, MM:Submit,Nohide
} catch {
	MessageStatus("Error","Remedy Get Ticket Error")
}
Gosub, ControlColors
return


TICKET_NUMBER:
Gui, MM:Submit,Nohide
Gosub, ControlColors
Return


!t::
TICKET_NUMBER := GetUnderMouse()
ToolTip, "copied:  " %TICKET_NUMBER%
SetTimer, MMToolTip, -2000
GuiControl,MM:,TICKET_NUMBER,%TICKET_NUMBER%
Gui, MM:Submit,Nohide
Gosub, ControlColors
Return

MMTT2Cursor:
Send, !{Esc}
^!+t::
Gui, MM:Submit,Nohide
Clipboard := TICKET_NUMBER
Send, ^v
return


MMTTCopy:
Gui,MM:Submit,NoHide
Tooltip, "copied:  " %TICKET_NUMBER%, 100, 100
Settimer,MMToolTip, -5000 
Clipboard := TICKET_NUMBER
return

MMAccountNumber:
Send, !{Esc}
^!#a::
Clipboard := ACCOUNT_NUMBER
Send, ^v
Return

ACCOUNT_NUMBER:
Gui,MM:Submit,NoHide
Gosub,ControlColors
Return

MMAcct2Rem:
^!#r::
Gui,MM:Submit,NoHide
try
{
	SetTitleMatchMode, 2
	IfWinExist, Home (Search)
		WinActivate, Home (Search)
	IfWinActive, Home (Search)
	{
		Sleep, 200
		Sleep, 200
		Remedy.document.all.arid_WIN_0_682000116.focus()
		Sleep, 200
		Remedy.document.all.arid_WIN_0_682000116.click()
		Sleep, 200
		Send, ^a
		Sleep, 200
		Send, {Del}
		Sleep, 200
		Clipboard := ACCOUNT_NUMBER
		Send, ^v
		Sleep, 500
		Send, {Down}
		Sleep, 200
		Remedy.document.getElementById("WIN_0_536870828").getElementsByClassName("f9")[0].click()
		Sleep, 4000
	}
}
catch
{
	MessageStatus("Error","Did not get account into Remedy.")
}
Gosub, MMTicketNumber
Gosub, ControlColors
SetTitleMatchMode, Regex
return


MMAcct2Scout:
Gui,MM:Submit,NoHide
^!#s::
;;; OPEN SCOUT AND SET TO CUSTOMER PAGE AND PASTE ACCOUNT NUMBER AND HIT ENTER
try
{
SetTitleMatchMode, 2
IfWinExist, Scout Monitor - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
{
	WinActivate, Scout Monitor - Internet Explorer ahk_class IEFrame ahk_exe iexplore.exe
	Scout.Navigate("http://scoutmonitoring.g.comcast.net/network_monitoring/servlet/network_monitoring?reqType=getPage&pageName=customerLookup~customerLookup")
	while Scout.busy or Scout.ReadyState != 4
	Sleep, 1000
	while (Scout.document.all.searchValue.Value != ACCOUNT_NUMBER)
		Scout.document.all.searchValue.Value := ACCOUNT_NUMBER
	Scout.document.all.btnSubmit.click()

}
else IfWinExist, Scout Monitor - Google Chrome ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe
{
	WinActivate, Scout Monitor - Google Chrome ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe
	Gosub, MMResetScout
	Sleep, 500
	Click, 570, 348
	Sleep, 500
	Send, %ACCOUNT_NUMBER%
	Sleep, 1000
	Click, , 456, 422
}
else IfWinExist, Scout Monitor - Mozilla Firefox ahk_class MozillaWindowClass ahk_exe firefox.exe
{
	WinActivate, Scout Monitor - Mozilla Firefox ahk_class MozillaWindowClass ahk_exe firefox.exe
	Gosub, MMResetScout
	Sleep, 500
	Click, 570, 365
	Send, %ACCOUNT_NUMBER%
	Sleep, 500
	Click, 452, 451
} else {
	IfWinExist, Scout Monitor ahk_class MozillaWindowClass ahk_exe sdcwbProxyBrowser.exe
	{
		WinActivate, Scout Monitor ahk_class MozillaWindowClass ahk_exe sdcwbProxyBrowser.exe
		Gosub, MMResetScout
		Sleep, 2000
		Click, , 582, 288
		Sleep, 500
		Send, %ACCOUNT_NUMBER%
		Sleep, 1000
		Click, , 456, 371
	}
}
}
catch
{
	MessageStatus("Error","Did not get account into Scout")
}
SetTitleMatchMode, RegEx
return


MMAcctCopy:
Gui,MM:Submit,NoHide
Tooltip % "copied:  " ACCOUNT_NUMBER
Settimer,MMToolTip, -5000 
Clipboard := ACCOUNT_NUMBER
return


MMPhoneNumber:
Send, !{Esc}
Sleep, 500
^!#o::
PHONE := StrReplace(CONTACT_NUMBER,"-","")
Send, %PHONE%
Return


MMPhone:
Gui,MM:Submit,NoHide
PHONE := StrReplace(CONTACT_NUMBER,"-","")
Tooltip % "copied:  " PHONE
Settimer,MMToolTip, -5000 
Clipboard := PHONE
Return

CONTACT_NUMBER:
Gui,MM:Submit,NoHide
Return

MMBestNumber:
Gui,MM:Submit,NoHide
;BEST_NUMBER := StrReplace(BEST_NUMBER,"-","")
Tooltip % "copied:  " BEST_NUMBER
Settimer,MMToolTip, -5000 
Clipboard := BEST_NUMBER
return

BEST_NUMBER:
Gui,MM:Submit,NoHide
return

MMBestSend:
Send, !{Esc}
^!+o::
BEST_NUMBER := StrReplace(BEST_NUMBER,"-","")
Send, %BEST_NUMBER%
Return


;;; PASTE DOCUMENTTION NOTES AT CURRENT CURSOR POSITION
MMNotesSend:
Send, !{Esc}
^!#p::
Gui,MM:Submit,NoHide
NOTES := GetNotes()
Clipboard := NOTES
Send, ^v
Return


MMSkipES:
!#+E::
IfWinExist, Einstein
{
	Loop {
		INDEX := A_Index-1
	} Until es360.document.getElementById("RecentlyViewedAccounts").getElementsByTagName("A")[A_Index-1].InnerText = "New Customer"
	es360.document.getElementById("RecentlyViewedAccounts").getElementsByTagName("A")[INDEX].click()
	;sleep, 1000
	Loop {
	} Until es360.document.getElementById("skipConversation").InnerText = "Skip"
	es360.document.getElementById("skipConversation").click()
	;Sleep, 1000
	Loop {
	} Until es360.document.getElementById("skipConversationSummaryDialog").getElementsByTagName("LABEL")[0].InnerText = "No changes have been made to this account"
	es360.document.getElementById("skipConversationSummaryDialog").getElementsByTagName("LABEL")[0].click()
	;Sleep, 1000
	es360.document.getElementById("nextCustomer").click()
}
Return


MMEndES:
^!+e::
SetTitleMatchMode,2
IfWinExist, Einstein 360
	WinActivate, Einstein 360

try {
	es360.document.getElementByID("end-call-link").click()
	Sleep, 3500
	es360.document.getElementByID("note-subject").focus()
	Sleep, 1000
	es360.document.getElementByID("note-subject").Value := TICKET_NUMBER
	Sleep, 1000
	es360.document.getElementByID("note-content").focus()
	Sleep, 1000
	NOTES := GetNotes()
	es360.document.getElementByID("note-content").Value := NOTES
	Send, {End}
	Sleep, 1000
	es360.document.getElementByID("note-content").fireEvent("onchange")
	Sleep, 1000
	es360.document.all.nextStep.focus()
	es360.document.all.nextStep.click()
	sleep, 1000
	es360.document.all.nextStep2.focus()
	es360.document.all.nextStep2.click()
	Sleep, 2000
	Length := es360.document.getElementsByClassName("next-step").length
	Loop, %Length%
	{
		Indexer := A_Index-1
	} Until es360.document.getElementsByClassName("next-step")[A_Index-1].InnerText = "New Customer"
	es360.document.getElementsByClassName("next-step")[Indexer].focus()
	Send, {End}
	Sleep, 1000
	es360.document.getElementsByClassName("next-step")[Indexer].click()
	Sleep, 2000
}
catch
{
	MessageStatus("Error","MMEndES function could not end conversation in ES360.")
}
SetTitleMatchMode,RegEx
Return



MMCopyNotes:
;;; PASTE DOCUMENTTION NOTES AT CURRENT CURSOR POSITION
Gui,MM:Submit,NoHide
NOTES := GetNotes()
Tooltip % NOTES
Settimer,MMToolTip, -5000 
Clipboard := NOTES
return


;;; REMEDY QUICK NOTES
MMRemNotes:
^!#q::
Gui,MM:Submit,NoHide
SplashTextOn,300,,Entering Remedy Quick Note
SetTitleMatchMode,2
IfWinExist, Home (Search)
	WinActivate, Home (Search)
Sleep, 1500
NOTES := GetNotes()
try
{
	Remedy.document.all.arid_WIN_0_651000336.focus()
	Remedy.document.all.arid_WIN_0_651000336.click()
	Remedy.document.all.arid_WIN_0_651000336.Value := Notes
	Remedy.document.all.arid_WIN_0_651000336.fireEvent("onchange")
	Sleep, 500
	Send, ^{End}
	Sleep, 100
	Send, {Enter}
	Remedy.document.getElementById("WIN_0_536870785").getElementsByClassName("f7")[0].click()
	SplashTextOn,300,,Done entering Quick Note
}
catch
{
	MessageStatus("Error","MMRemNotes function cant enter Quick Note into Remedy.")
}
Sleep, 2000
SplashTextOff
SetTitleMatchMode,RegEx
return


MMGateway_Get:
try {
	GATEWAY_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
	Loop %GATEWAY_LENGTH% {
		INDEXER := A_Index
	} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "Device Make/Model"
	WIRELESS_GATEWAY := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
	RegExMatch(WIRELESS_GATEWAY, ".*\s$", EndSpace)
	if (EndSpace)
		RegExMatch(WIRELESS_GATEWAY, "^.*\s(\w*)\s$", WGOut)
	else
		RegExMatch(WIRELESS_GATEWAY, "^.*\s(\w*)$", WGOut)
	WIRELESS_GATEWAY := WGOut1
} catch e {
	MessageStatus("Error","Gateway not found.")
}
GuiControl, MM:, WIRELESS_GATEWAY, |%WIRELESS_GATEWAY%||%WirelessGateways%
Gosub, ControlColors
Return

!g::
WIRELESS_GATEWAY := GetUnderMouse()
RegExMatch(WIRELESS_GATEWAY, "(MODEL:)?(.*)?\s(.*)?\s(.*)", WRLS_GW)
WIRELESS_GATEWAY := WRLS_GW4
StringUpper, WIRELESS_GATEWAY, WIRELESS_GATEWAY
ToolTip % "copied:  " WIRELESS_GATEWAY
SetTimer, MMToolTip, -2000
GuiControl, MM:, WIRELESS_GATEWAY, |%WIRELESS_GATEWAY%||%WirelessGateways%
Gui,MM:Submit,NoHide
Gosub, ControlColors
Return

MMGateway:
Gui,MM:Submit,NoHide
if (WIRELESS_GATEWAY = "Other")
	GuiControl,MM:Enable,WG_OTHER
else
	GuiControl,MM:Disable,WG_OTHER
GuiControl, MM:, WIRELESS_GATEWAY, |%WIRELESS_GATEWAY%||%WirelessGateways%
Gosub, ControlColors
Return


MMGateway_Other:
Gui,MM:Submit,NoHide
Return


MMBoot:
try {
	BOOT_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
	Loop %BOOT_LENGTH% {
		INDEXER := A_Index
	} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "Modem Boot File"
	BOOT_FILE := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
} catch e {
	MessageStatus("Error","Boot File not found.")
}
GuiControl, MM:,BOOT_FILE,|%BOOT_FILE%||%BootFiles%
Gosub, MMBootSpeed
Return



MMBootSpeed:
Gui,MM:Submit,NoHide
BootSpeeds := {"abusesuspend":"0.0"
				, "abuseterminate":"0/0"
				, "abusedead":"0/0"
				, "abuse25":"0/0"
				, "atlt2.ga.comcast.net":"0/0"
				, "blastpro":"200/100"
				, "cdvonly":"0/0"
				, "cdvvaction":"0/0"
				, "chnbronze":"3/768k"
				, "chnstarter":"6/1"
				, "chnultra":"22/5"
				, "chnsilver":"25/5"
				, "chnspeedtierextreme2":"50/10"
				, "chnwidebandblast":"105/10"
				, "chnwidebandshowcaseblast":"105/10"
				, "economyplus":"3/768k"
				, "extreme":"150/20"
				, "extreme250":"250/25"
				, "extreme300":"300/25"
				, "gigabit":"1G/35"
				, "gigabitpro":"2G/2G"
				, "internetessentials":"10/1"
				, "internet5":"5/1"
				, "nonpay":"0/0"
				, "performance2":"25/5"
				, "performancepro":"100/5"
				, "performancestarter":"10/2"
				, "silver":"25/5"
				, "silverboost":"75/5"
				, "speedtier":"75/10"
				, "speedtierextreme2":"75/10"
				, "tosdefault":"0/0"
				, "tppremier":"75/5"
				, "vacation":"0/0"
				, "walledgarden":"0/0"
				, "widebandblast":"150/20"
				, "widebandshowcaseblast":"150/20"}
RegExMatch(BOOT_FILE, ".*(_.*_)(.*\.cm)?", BOOT_FOUND)
StringTrimLeft, BOOT_FOUND1, BOOT_FOUND1, 1
StringTrimRight, BOOT_FOUND1, BOOT_FOUND1, 1
for key,val in BootSpeeds
{
	if (BOOT_FOUND1 = key)
	{
		;BOOT_FILE := BOOT_FOUND1
		BootSpeed := val
		Break
	} else {
		;BOOT_FILE := "unknown"
		BootSpeed := "?/?"
	}
}
GuiControl, MM:, MMBootSpeed, %BootSpeed%
GuiControl, MM:,BOOT_FILE,|%BOOT_FILE%||%Bootfiles%
Gosub, ControlColors
Return

!b::
BOOT_FILE := GetUnderMouse()
ToolTip % "copied:  " BOOT_FILE
SetTimer, MMToolTip, -2000
GuiControl, MM:,BOOT_FILE,|%BOOT_FILE%||%Bootfiles%
Gui,MM:Submit,NoHide
Gosub, MMBootSpeed
Gosub, ControlColors
Return

MMMarketRegion:
Gui,MM:Submit,NoHide
Gosub, ControlColors
Return

SSID:
Gui,MM:Submit,NoHide
Return


!s::
SSID := GetUnderMouse()
Tooltip % "copied:  " SSID
SetTimer, MMToolTip, -2000
GuiControl, MM:, SSID, %SSID%
Gui,MM:Submit,Nohide
Return


MMSSID:
MessageStatus("Error","Use Keyboard Shortcut`nPut cursor on SSID 2.4 box and hit [Alt + Shift + s]")
Return
MMPasteSSID:
!+s::
Send, %SSID%
Tooltip % "pasted:  " SSID
SetTimer, MMToolTip, -2000
Return


MMSSIDCopy:
Gui,MM:Submit,Nohide
Clipboard := SSID
Tooltip % "copied:  " SSID
SetTimer, MMToolTip, -2000
Return


SSID_PASS:
Gui,MM:Submit,Nohide
Return

!d::
SSID_PASS := GetUnderMouse()
Tooltip % "copied:  " SSID_PASS
SetTimer, MMToolTip, -2000
GuiControl,MM:,SSID_PASS,%SSID_PASS%
Gui,MM:Submit,Nohide
return


MMSSIDPass:
MessageStatus("Error","Use Keyboard Shortcut`nPut cursor on password 2.4 box and hit [Alt + Shift + d]")
Return
MMPastePass:
!+d::
Send, %SSID_PASS%
Tooltip % "pasted:  " SSID_PASS
SetTimer, MMToolTip, -2000
Return


MMSSIDPassCopy:
Gui,MM:Submit,Nohide
Clipboard := SSID_PASS
Tooltip % "copied:  " SSID_PASS
SetTimer, MMToolTip, -2000
return


SSID5:
Gui,MM:Submit,NoHide
Return

!x::
SSID5 := GetUnderMouse()
Tooltip % "copied:  " SSID5
SetTimer, MMToolTip, -2000
GuiControl, MM:, SSID5, %SSID5%
Gui,MM:Submit,Nohide
Return

MMSSID5:
MessageStatus("Error","Use Keyboard Shortcut`nPut cursor on SSID 5.0 box and hit [Alt + Shift + x]")
Return
MMPasteSSID5:
!+x::
Send, %SSID5%
Tooltip % "pasted:  " SSID5
SetTimer, MMToolTip, -2000
Return


MMSSID5Copy:
Gui,MM:Submit,Nohide
Clipboard := SSID5
Tooltip % "copied:  " SSID5
SetTimer, MMToolTip, -2000
return


SSID5_PASS:
Gui,MM:Submit,Nohide
Return

!c::
SSID5_PASS := GetUnderMouse()
Tooltip % "copied:  " SSID5_PASS
SetTimer, MMToolTip, -2000
GuiControl,MM:,SSID5_PASS,%SSID5_PASS%
Gui,MM:Submit,Nohide
return


MMSSID5Pass:
MessageStatus("Error","Use Keyboard Shortcut`nPut cursor on password 5.0 box and hit [Alt + Shift + c]")
Return
MMPastePass5:
!+c::
Send, %SSID5_PASS%
Tooltip % "pasted:  " SSID5_PASS
SetTimer, MMToolTip, -2000
Return


MMSSID5PassCopy:
Gui,MM:Submit,Nohide
Clipboard := SSID5_PASS
Tooltip % "copied:  " SSID5_PASS
SetTimer, MMToolTip, -2000
return


^!#z::
IfWinExist, Untitled - Notepad
{
	WinActivate, Untitled - Notepad
	Send, ^a
	Sleep, 100
	Send, {Del}
	Sleep, 100
	Gosub, MMPasteSSID
	Send, {Enter}
	Sleep, 100
	Gosub, MMPastePass
	Send, {Enter}
	Sleep, 100
	Gosub, MMPasteSSID5
	Send, {Enter}
	Sleep, 100
	Gosub, MMPastePass5
	Send, {Enter}
	Return
} else {
	MessageStatus("Error","Notepad not opened.")
	Return
}


ENVIRO_DETAILS:
Gui,MM:Submit,Nohide
Return


MMGuidedPaths:
^!#g::
Gui,MM:Submit,Nohide
Gosub, MMAccountMatch
if (acctchk = 0)
{
	MessageStatus("Error","Accounts not matching in ES and GP")
	Return
}

SetTitleMatchMode,2
IfWinExist, https://care.nexus.support.com/nexus/#/navigator - Internet Explorer
	WinActivate, https://care.nexus.support.com/nexus/#/navigator - Internet Explorer
else IfWinExist, Support.com Cloud
	WinActivate, Support.com Cloud
else
{
	MessageStatus("Error","Guided Paths not opened.")
	Return
}

;GP.Navigate("https://care.nexus.support.com/nexus/#/navigator")
;Sleep,3000

SetTitleMatchMode,RegEx

;;; GUIDED PATHS STEP 1
try
{
	GP.document.GetElementsByName("createNewCustomer")[0].click()
	Sleep, 100
	GP.document.GetElementsByName("customfield_10001")[0].focus()
	Sleep, 100
	SendInput, %ACCOUNT_NUMBER%
	Sleep,100
	GP.document.GetElementsByName("customfield_10000")[0].focus()
	Sleep,100
	SendInput, %TICKET_NUMBER%
	Sleep,100
	if (TICKET_NUMBER != "")
	{
		GP.document.GetElementsByName("customfield_10035")[0].focus()
		SendInput, {Space}
		Sleep,500
	}
}
catch
{
	MessageStatus("Error","MMGuidedPaths Step 1 problem.")
}


;;; GUIDED PATHS MARKET REGION
try
{
	GP.document.getElementsByName("customfield_10042")[0].focus()
	While MARKET_REGION != MR_GP
	{
		MR_GP := GP.document.GetElementsByName("customfield_10042")[0].getElementsByTagName("OPTION")[A_Index-1].innerText
		MR_INDEX := A_Index-1
	}
	GP.document.GetElementsByName("customfield_10042")[0].selectedIndex := MR_INDEX
	Sleep, 100
	SendInput, {Up}
	Sleep, 100
	SendInput, {Down}
	Sleep, 100
}
catch
{
	MessageStatus("Error","Select Market Region manually.")
}

try
{
GP.document.GetElementsByName("customfield_10036")[0].focus()
Sleep, 100
SendInput, %ESSID%
Sleep, 100
}
catch
{
	MessageStatus("Error","inputing SSID into Guided Paths.")
}

;;; GUIDED PATHS BOOT FILE
try
{
	RegExMatch(BOOT_FILE, ".*_.*_(.*)\.cm?", BOOT_FOUND)
	if (BOOT_FOUND1 = "nonpay" or BOOT_FOUND1 = "walledgarden" or BOOT_FOUND1 = "cdvonly")
	{
		if (BOOT_FOUND1 = "nonpay")
			BOOT_FOUND1 := "non_pay"
		if (BOOT_FOUND1 = "walledgargen")
			BOOT_FOUND1 := "walled_garden"
		if (BOOT_FOUND1 = "cdvonly")
			BOOT_FOUND1 := "cdv_only"
	} else {
	RegExMatch(BOOT_FILE, ".*(_.*_)(.*\.cm)?", BOOT_FOUND)
	StringTrimLeft, BOOT_FOUND1, BOOT_FOUND1, 1
	StringTrimRight, BOOT_FOUND1, BOOT_FOUND1, 1
	if (BOOT_FOUND1 = "internetessentials")
		BOOT_FOUND1 := "internet_essentials"
	if (BOOT_FOUND1 = "economyplus")
		BOOT_FOUND1 := "economy_plus"
	}
	GP.document.getElementsByName("customfield_10037")[0].focus()
	Sleep, 100
	While BOOT_FOUND1 != BOOT_GP
	{
		BOOT_GP := GP.document.getElementsByName("customfield_10037")[0].getElementsByTagName("OPTION")[A_Index-1].InnerText
		BOOT_INDEX := A_Index-1
	}
	GP.document.getElementsByName("customfield_10037")[0].selectedIndex := BOOT_INDEX
	Sleep, 100
	SendInput, {Up}
	Sleep, 100
	SendInput, {Down}
	Sleep, 100
}
catch
{
	MessageStatus("Error","Select Boot File manually.")
}

	
;;; GUIDED PATHS GATEWAY MODEL
try
{
	GP.document.getElementsByName("customfield_10039")[0].focus()
	Sleep, 100
	While WIRELESS_GATEWAY != WG_GP
	{
		WG_GP := GP.document.getElementsByName("customfield_10039")[0].getElementsByTagName("OPTION")[A_Index-1].InnerText
		WG_INDEX := A_Index-1
	}
	GP.document.getElementsByName("customfield_10039")[0].selectedIndex := WG_INDEX
	Sleep, 100
	SendInput, {Up}
	Sleep, 100
	SendInput, {Down}
	Sleep, 100
}
catch
{
	MessageStatus("Error","Select gateway manually.")
}


try
{
	GP.document.GetElementsByName("customfield_10038")[0].focus()
	Sleep, 100
	while MMLocComp != MMLocComp_GP
	{
		MMLocComp_GP := GP.document.GetElementsByName("customfield_10038")[0].getElementsByTagName("OPTION")[A_Index-1].innerText
		MMLocComp_Index := A_Index-1
	}
	GP.document.GetElementsByName("customfield_10038")[0].selectedIndex := MMLocComp_Index
	Sleep, 100
	SendInput, {Up}
	Sleep, 100
	SendInput, {Down}
	Sleep, 100
}
catch
{
	MessageStatus("Error","Select Location Comparison manually.")
}

try
{
GP.document.GetElementsByName("customfield_10040")[0].focus()
Sleep, 100
SendInput, %MMManyDevices%
Sleep, 100

GP.document.GetElementsByName("customfield_10041")[0].focus()
Sleep, 100
SendInput, %AFFECTED_DEVICE%
Sleep, 100
}
catch
{
	MessageStatus("Error","Select number of devices manually.")
}

;;;;;;;;;;;;;;;;;;;;;;;;;;
Return
;;;;;;;;;;;;;;;;;;;;;;;;;;

try
{
	GP.document.all.createNewConsumer.click()
}
catch
{
	MessageStatus("Error","Cant click GP Create button")
}


Sleep, 3000


try
{
	GP.document.all.dropdownMenu1.click()
}
catch
{
	Sleep, 2000
	try
	{
		GP.document.all.dropdownMenu1.click()
	}
	catch
	{
		Sleep, 2000
		try
		{
			GP.document.all.dropdownMenu1.click()
		}
		catch
		{
			Sleep, 2000
			try
			{
				GP.document.all.dropdownMenu1.click()
			}
			catch
			{
				MsgBox,4096,Paused, Fill Out Properly: Then hit OK
				Sleep, 1000
				try
				{
					GP.document.all.createNewConsumer.click()
					GP.document.all.createNewConsumer.fireEvent("onfocus")
					GP.document.all.createNewConsumer.fireEvent("onchange")
					Sleep, 3000
					GP.document.all.dropdownMenu1.click()
				}
				catch
				{
					MessageStatus("Error","close GP session manually")
					Return
				}
			}
		}
	}
}

	
try
	GP.document.all.closesessionwithresolved.click()
catch
	MessageStatus("Error","Cant resolve GP, please do it manully.")


;WinWait, Security Alert ahk_class #32770 ahk_exe IEXPLORE.EXE,,2
;{
;	WinActivate, Security Alert ahk_class #32770 ahk_exe IEXPLORE.EXE
;	Sleep, 200
;	Send, !y
;	Sleep, 1000
;}

Return


MMGetIP:
try {
	IP_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
	Loop %IP_LENGTH% {
		INDEXER := A_Index
	} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "IP Address of Modem"
	IP_ADDRESS := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
	IP_ADDRESS := MatchIP(IP_ADDRESS)
} catch e {
	MessageStatus("Error","IP Address not found.")
}
GuiControl, MM:, IP_ADDRESS, %IP_ADDRESS%
if !(IP_ADDRESS = "0.0.0.0")
	Gosub, MMIP2RDS
Gosub, ControlColors
Return

MMIPAddress:
Gui,MM:Submit,NoHide
IP_ADDRESS := MatchIP(IP_ADDRESS)
Gosub, ControlColors
Return


MatchIP(IP_ADDRESS) {
	RegExMatch(IP_ADDRESS, "(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))", IPv6)
	RegExMatch(IP_ADDRESS, "((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])", IPv4)
	if IPv6
		IP_ADDRESS := IPv6
	else if IPv4
		IP_ADDRESS := IPv4
	else
		IP_ADDRESS := "error"
	Return IP_ADDRESS
}


!i::
IP_ADDRESS := GetUnderMouse()
IP_ADDRESS := MatchIP(IP_ADDRESS)
GuiControl,MM:,IP_ADDRESS,%IP_ADDRESS%
ToolTip % "copied:  " IP_ADDRESS
SetTimer, MMToolTip, -1000
Gui,MM:Submit,Nohide
Sleep, 100


MMIP2RDS:
^!#i::
Gui, MM:Submit,Nohide
;;; COPY IP ADDRESS FROM EINSTEIN AND PASTE INTO RDS
try
{
	if IP_ADDRESS
	{
		if (IP_ADDRESS != "0.0.0.0")
		{
			if IPv4
			{
				IfWinExist, Comcast - Proxy Browser*
				{
					WinActivate, Comcast - Proxy Browser*
					WinGetClass, Win_Class, A
					RegExMatch(Win_Class, "(.*)\.(.*)\.(.*)\.(.*)\.(.*)\.(.*)", WINCLASS)
					PROXY := WINCLASS1 ".EDIT." WINCLASS4 "." WINCLASS5 "." WINCLASS6 "1"
					ControlClick, %PROXY%
					Send, ^a
					Send, {Del}
					Send, http://%IP_ADDRESS%{Enter}
					GuiControl,MM:,MMGetIP,IP(v4) Address
				}
				else
				{
					MessageStatus("Error","RDS not opened! Can't paste IPv4 address.")
				}
			}
			else if IPv6
			{
				IfWinExist, Comcast - Proxy Browser*
				{
					WinActivate, Comcast - Proxy Browser*
					WinGetClass, Win_Class, A
					RegExMatch(Win_Class, "(.*)\.(.*)\.(.*)\.(.*)\.(.*)\.(.*)", WINCLASS)
					PROXY := WINCLASS1 ".EDIT." WINCLASS4 "." WINCLASS5 "." WINCLASS6 "1"
					ControlClick, %PROXY%
					Send, ^a
					Send, {Del}
					Send, http://[%IP_ADDRESS%]{Enter}
					GuiControl,MM:,MMGetIP,IP(v6) Address
				}
				else
				{
					MessageStatus("Error","RDS not opened! Can't paste IPv6 address.")
				}
			}
			else
			{
				MessageStatus("Error","unknown error with IP address")
			}
		}
		else
		{
			MessageStatus("Error","error IP address is invalid  =  0.0.0.0")
		}
	}
	else
	{
		MessageStatus("Error","No IP available. Try to capture first.")
	}
}
catch
{
	MessageStatus("Error","MMIP2RDS did not work. Try pasting IP into RDS manually.")
}
Gosub, ControlColors
return


MMIPCopy:
Clipboard := "http://[" . IP_ADDRESS . "]"
Tooltip % "copied:  " Clipboard
Settimer, MMToolTip, 1000
return


MMMACAddress:
try {
	MAC_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
	Loop %MAC_LENGTH% {
		INDEXER := A_Index
	} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "MAC Address"
	MAC_ADDRESS := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
} catch e {
	MessageStatus("Error","MAC Address Not Found.")
}
GuiControl, MM:, MAC_ADDRESS, %MAC_ADDRESS%
SplashTextOff
Gosub, ControlColors
Return


MMMACSend:
Send, !{Esc}
Sleep, 300
^!#m::
Clipboard := MAC_ADDRESS
Send, ^v
Return


MMMAC:
Gui,MM:Submit,Nohide
Gosub, ControlColors
Return

^!+m::
MACNoColon := StrReplace(MAC_ADDRESS,":", "")
Clipboard := MACNoColon
Send, ^v
Return


MMMACNoColon:
MACNoColon := StrReplace(MAC_ADDRESS,":", "")
Clipboard := MACNoColon
Tooltip % "copied:  " Clipboard
Settimer, MMToolTip, 1000
Return


MMMACCopy:
Clipboard := MAC_ADDRESS
Tooltip % "copied:  " Clipboard
Settimer, MMToolTip, 1000
Return


!m::
MAC_ADDRESS := GetUnderMouse()
RegExMatch(MAC_ADDRESS, "\w\w\:\w\w\:\w\w\:\w\w\:\w\w\:\w\w", MAC_ADDRESS)
GuiControl, MM:, MAC_ADDRESS, %MAC_ADDRESS%
Gui,MM:Submit,Nohide
Return


MMZipCode:
Gui,MM:Submit,Nohide
Gosub, ControlColors
Return

MMZipLook:
Run, http://intranet.support.com/SDCWorkcenter/SEPortal/XHome/default.aspx
	Sleep, 2000
try
{
	while ZipLookup.busy or ZipLookup.ReadyState != 4
		Sleep, 2000
	ZipLookup.document.all.ctl00_m_g_d7008d6c_0f3b_4b2d_8e65_50e870a7b769_SPTextSlicerValueTextControl.Value := ZIP_CODE
	sleep, 500
	ZipLookup.document.all.ctl00_m_g_d7008d6c_0f3b_4b2d_8e65_50e870a7b769_SPTextSlicerValueTextControl.focus()
	sleep, 1500
	Send, {Enter}
}
catch
{
	MessageStatus("Error","Cant look up Zip Code.")
}
return


MMZipCopy:
Clipboard := ZIP_CODE
ToolTip % "copied:  " ZIP_CODE
SetTimer, MMToolTip, -1500
return


MMSubmitChanges:
Gui,MM:Submit,NoHide
reconnect = 1
Gosub, ReconnectComs
Gosub, ControlColors
return

MMNewCustomer:
^!#n::
REPORTED_ISSUE =
RESOLUTION_ACTION =
IniWrite, %REPORTED_ISSUE%, .\Lib\MM.ini, Einstein, ReportedIssue
IniWrite, %RESOLUTION_ACTION%, .\Lib\MM.ini, Einstein, ResolutionAction
Reload
Return

^!#+n::
breaker = 0
TICKET_NUMBER =
CUSTOMER_NAME =
ACCOUNT_NUMBER =
CONTACT_NUMBER =
REPORTED_ISSUE =
RESOLUTION_ACTION =
WIRELESS_GATEWAY =
BOOT_FILE =
MARKET_REGION =
IP_ADDRESS =
MAC_ADDRESS =
ZIP_CODE =
SSID = default-2.4
SSIDPass =
SSID5 = default-5
SSID5Pass =

Gui,MM:Submit,NoHide

GuiControl,MM:,TICKET_NUMBER,%TICKET_NUMBER%
GuiControl,MM:,CUSTOMER_NAME,%CUSTOMER_NAME%
GuiControl,MM:,ACCOUNT_NUMBER,%ACCOUNT_NUMBER%
GuiControl,MM:,CONTACT_NUMBER,%CONTACT_NUMBER%
GuiControl,MM:,REPORTED_ISSUE,%REPORTED_ISSUE%
GuiControl,MM:,RESOLUTION_ACTION,%RESOLUTION_ACTION%
GuiControl,MM:,WIRELESS_GATEWAY,|%WIRELESS_GATEWAY%||%WirelessGateways%
GuiControl,MM:,BOOT_FILE,|%BOOT_FILE%||%BootFiles%
GuiControl,MM:,MARKET_REGION,|%MARKET_REGION%||%MarketRegions%
GuiControl,MM:,IP_ADDRESS,%IP_ADDRESS%
GuiControl,MM:,MAC_ADDRESS,%MAC_ADDRESS%
GuiControl,MM:,ZIP_CODE,%ZIP_CODE%
GuiControl,MM:,SSID,%SSID%
GuiControl,MM:,SSIDPass,%SSIDPass%
GuiControl,MM:,SSID5,%SSID5%
GuiControl,MM:,SSID5Pass,%SSID5Pass%

Gui,MM:Submit,NoHide

IniRead, es, .\Lib\MM.ini, Einstein, Ein, 360

;;; GET FORMATTED DATE
FormatTime, TIME_STAMP, , MMM-dd-yyyy
GuiControl,MM:,TIME_STAMP,%TIME_STAMP%

;;; GET CUSTOMER NAME FROM EINSTEIN
if (es = "360")
{
	;;; EINSTEIN 360 INITIALIZATION ROUTINE

	IfWinExist, Einstein 360
	{
		SetTitleMatchMode,2
		WinActivate, Einstein 360
		SetTitleMatchMode,RegEx
	}

	SplashTextOn,300,,Getting Customer Name
	try {
		CUSTOMER_NAME := es360.document.getElementById("customer-name").getElementsByTagName("SPAN")[0].innerText
		GuiControl,MM:,CUSTOMER_NAME,%CUSTOMER_NAME%
		ACCOUNT_NUMBER := es360.document.getElementById("newHeaderSection").getElementsByTagName("DIV")[3].innerText
		GuiControl,MM:,ACCOUNT_NUMBER,%ACCOUNT_NUMBER%
		PHONE_NUMBER := es360.document.all.callbackNo.innerText
			TELEPHONE := StrReplace(PHONE_NUMBER, "(")
			CONTACT_NUMBER := StrReplace(TELEPHONE,") ","-")
		GuiControl,MM:,CONTACT_NUMBER,%CONTACT_NUMBER%
		MARKET_REGION := es360.document.all.market.innerText
		GuiControl,MM:,MARKET_REGION,|%MARKET_REGION%||%MarketRegions%
		ZIP_CODE := es360.document.getElementById("header-customer-address").getElementsByTagName("SPAN")[3].innerText
		GuiControl,MM:,ZIP_CODE,%ZIP_CODE%
	} catch e {
		MessageStatus("Error","Account Not Opened in ES360")
		Goto, skipper
		Return
	}
	
	SplashTextOn,300,,Getting Modem Model
	try {
		es360.document.getElementById("lhs-button-devices").click()

		sleep, 2000

		Loop {
		} Until es360.document.getElementById("liEquipment_Internet").getElementsByClassName("summary")[0].innerText = "Internet"
		es360.document.getElementById("liEquipment_Internet").getElementsByClassName("summary")[0].click()

		sleep, 2000

		Loop {
		} Until es360.document.getElementById("liEquipment_Internet").getElementsByTagName("SPAN")[4].innerText = "Device Type: "
		es360.document.getElementById("liEquipment_Internet").getElementsByTagName("SPAN")[4].click()

		sleep, 4000

		SplashTextOn,300,,Getting Wireless Gateway
		try {
			GATEWAY_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
			Loop %GATEWAY_LENGTH% {
				INDEXER := A_Index
			} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "Device Make/Model"
			WIRELESS_GATEWAY := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
			RegExMatch(WIRELESS_GATEWAY, ".*\s$", EndSpace)
			if (EndSpace)
				RegExMatch(WIRELESS_GATEWAY, "^.*\s(\w*)\s$", WGOut)
			else
				RegExMatch(WIRELESS_GATEWAY, "^.*\s(\w*)$", WGOut)
			WIRELESS_GATEWAY := WGOut1
			GuiControl,MM:,WIRELESS_GATEWAY,%WIRELESS_GATEWAY%||%WirelessGateways%
		} catch e {
			GateError := "Gateway not found"
		}
		
		SplashTextOn,300,,Getting IP Address
		try {
			IP_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
			Loop %IP_LENGTH% {
				INDEXER := A_Index
			} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "IP Address of Modem"
			IP_ADDRESS := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
			IP_ADDRESS := MatchIP(IP_ADDRESS)
			GuiControl,MM:,IP_ADDRESS,%IP_ADDRESS%
		} catch e {
			IPError := "IP Address not found"
		}
		
		SplashTextOn,300,,Getting Boot File
		try {
			BOOT_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
			Loop %BOOT_LENGTH% {
				INDEXER := A_Index
			} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "Modem Boot File"
			BOOT_FILE := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
			GuiControl,MM:,BOOT_FILE,|%BOOT_FILE%||%BootFiles%
		} catch e {
			BootError := "Boot File not found"
		}
		
		SplashTextOn,300,,Getting MAC Address
		try {
			MAC_LENGTH := es360.document.all.liEquipment_Internet.getElementsByTagName("TD").Length
			Loop %MAC_LENGTH% {
				INDEXER := A_Index
			} Until es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[A_Index-1].innerText = "MAC Address"
			MAC_ADDRESS := es360.document.all.liEquipment_Internet.getElementsByTagName("TD")[INDEXER].innerText
			GuiControl,MM:,MAC_ADDRESS,%MAC_ADDRESS%
		} catch e {
			MACError := "MAC Address not found"
		}
		if ((GateError) or (IPError) or (BootError) or (MACError))
		{
			MessageStatus("Error",GateError "... " IPError "... " BootError "... " MACError)
		}
	}
	catch
	{
		MessageStatus("Error","Device Card not loaded")
	}

	try
	{
		Length := es360.document.getElementById("ein-nav-menu").getElementsByTagName("A").Length
		Loop, %Length% {
			Indexer := A_Index-1
		} Until es360.document.getElementById("ein-nav-menu").getElementsByTagName("A")[A_Index-1].InnerText = Activity
		es360.document.getElementById("ein-nav-menu").getElementsByTagName("A")[Indexer-1].click()
		sleep,1500
		TICKET_NUMBER := es360.document.getElementById("ein-nav-menu").getElementsByClassName("ticket-banner")[0].InnerText
		StringTrimLeft,TICKET_NUMBER,TICKET_NUMBER,10
		GuiControl,MM:,TICKET_NUMBER,%TICKET_NUMBER%
	}
	catch
		MessageStatus("Error","No Ticket Found")

}


try {
	;;; GET ZIPCODE FROM EINSTEIN
	SplashTextOn,300,,Getting Zip Code
	ZIP_CODE := einstein.document.all.liCityStateZip.InnerText
	RegExMatch(ZIP_CODE, "\d\d\d\d\d", ZIP_CODE)
	GuiControl,MM:,ZIP_CODE,%ZIP_CODE%
} catch {
	MessageStatus("Error","cant get Zip Code")
}

Gui,MM:Submit,NoHide
SplashTextOff
Gosub, NewCustSend

skipper:
Gui,MM:Submit,NoHide
SplashTextOff
Gosub, ControlColors
Return


MMAltEmail:
^!#l::
es360.document.all.LaunchUserPreferences.click()
WinWait, Users & Preference
esUP := setWbCom("Users & Preferences", "https://einstein360.cable.comcast.com/Einstein360/Toolkit/Default")
while esUP.Busy or esUP.ReadyState != 4
{
	Sleep, 200
	SplashTextOn,300,,esUP busy %A_Index%
}

SplashTextOff
WinActivate, Users & Preferences

try
{
	esUP.document.all.usernameTab.click()
	Sleep, 2000
	esUP.document.all.addAltEmailLink0.click()
	Sleep, 3000
	;esUP.document.all.txtAltEmailEdit0.InnerText := ALTE
	esUP.document.all.txtAltEmailEdit0.focus()
	Sleep, 500
	Clipboard := ALT_EMAIL
	Send, ^v
	Sleep, 1000
	esUP.document.all.btnAltEmailSave.click()
	Sleep, 5000
} catch {
	MessageStatus("Error","Could not set Alt Email in ES360")
}
;WinClose, Users & Preferences
SplashTextOff
Return


MMALT_EMAIL:
Gui,MM:Submit,NoHide
Gosub, ControlColors
Return


MMAESend:
Send, !{Esc}
Clipboard := ALTE
Send, ^v
Return


MMAECopy:
Clipboard := ALTE
ToolTip % "copied:  " ALTE
SetTimer, MMToolTip, -1500
Return


MMRestart:
^!+r::
Gui,MM:Submit,NoHide
IniWrite, %REPORTED_ISSUE%, .\Lib\MM.ini, Einstein, ReportedIssue
IniWrite, %RESOLUTION_ACTION%, .\Lib\MM.ini, Einstein, ResolutionAction
CtlColors.Free()
Reload
Return

^!+#r::
Gui,MM:Submit,NoHide
IniWrite, bypass, .\Lib\MM.ini, Einstein, Ein
REPORTED_ISSUE =
RESOLUTION_ACTION =
IniWrite, %REPORTED_ISSUE%, .\Lib\MM.ini, Einstein, ReportedIssue
IniWrite, %RESOLUTION_ACTION%, .\Lib\MM.ini, Einstein, ResolutionAction
CtlColors.Free()
Reload
Return


MMCreateTicket:
^!#c::
SplashTextOn,300,,Create Ticket Function
SetTitleMatchMode,2
IfWinExist, Home (Search)
	WinActivate, Home (Search)
SetTitleMatchMode,RegEx

SplashTextOn,300,,Verifying Account Match
GoSub, MMAccountMatch
if (acctchk = 1)
	Goto, CreateTicket
else
	Return

CreateTicket:
SplashTextOn,300,,Creating New Ticket
try
{
	Remedy := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/")
	Remedy.document.getElementById("WIN_0_682000515").getElementsByClassName("f9")[0].click()
	WinWait, Create a new Customer Ticket
	Sleep, 2000
	RemedyCreate := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/RX-Customer+Care/Create+Customer+Ticket/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/RX-Customer+Care/Create+Customer+Ticket/")
	SplashTextOn,300,,Doing Skip LOQ
	if (RemedyCreate.document.getElementById("WIN_0_536870822").getElementsByClassName("f9")[0].innerText = "Skip LOQ")
	{
	Loop {
		Sleep,2000
	} Until RemedyCreate.document.getElementById("WIN_0_536870822").getElementsByClassName("f9")[0].innerText = "Skip LOQ"
	}
	Sleep, 2000
	RemedyCreate.document.getElementById("arid_WIN_0_651000150").Click()
	Sleep, 2000
}
catch
{
	MessageStatus("Error","MMCreateTicket Remedy step 1")
}

try {
	if (RemedyCreate.document.getElementsByClassName("MenuEntryName")[0].InnerText = "HSD") {
		Send, {Down}
		Sleep, 200
		Send, {Enter}
		Sleep, 1000
	}
	else if (RemedyCreate.document.getElementsByClassName("MenuEntryName")[1].InnerText = "HSD") {
		Send, {Down}
		Sleep, 200
		Send, {Down}
		Sleep, 200
		Send, {Enter}
		Sleep, 1000
	}
	else if (RemedyCreate.document.getElementsByClassName("MenuEntryName")[2].InnerText = "HSD") {
		Send, {Down}
		Sleep, 200
		Send, {Down}
		Sleep, 200
		Send, {Down}
		Sleep, 200
		Send, {Enter}
		Sleep, 1000
	}
	else
		MessageStatus("Error","Manually select HDS from dropdown list.")
} catch {
	if (RemedyCreate.document.getElementsByClassName("MenuEntryNameHover")[0].InnerText = "HSD") {
		Send, {Down}
		Sleep, 200
		Send, {Enter}
		Sleep, 1000
	}
	else if (RemedyCreate.document.getElementsByClassName("MenuEntryNameHover")[1].InnerText = "HSD") {
		Send, {Down}
		Sleep, 200
		Send, {Down}
		Sleep, 200
		Send, {Enter}
		Sleep, 1000
	}
	else if (RemedyCreate.document.getElementsByClassName("MenuEntryNameHover")[2].InnerText = "HSD") {
		Send, {Down}
		Sleep, 200
		Send, {Down}
		Sleep, 200
		Send, {Down}
		Sleep, 200
		Send, {Enter}
		Sleep, 1000
	}
	else
		MessageStatus("Error","in HDS hover selector function.")
}
;;; CLICK OK ON TICKET CREATED WINDOW
SplashTextOn,300,,Doing 15003 value
Sleep, 2000

try
{
	RemedyCreate.document.getElementById("WIN_0_536870822").getElementsByClassName("f9")[0].click()
	Sleep, 2000
	RemedyCreate.document.getElementById("arid_WIN_0_651002701").focus()
	Sleep, 500
	RemedyCreate.document.getElementById("arid_WIN_0_651002701").Value := "15003"
	Sleep, 500
	Send, {Down}
	Sleep, 500
	Send, {Enter}
	SplashTextOn,300,,Clicking Save
	Sleep, 2000
	RemedyCreate.document.getElementById("WIN_0_536870800").getElementsByClassName("f9")[0].click()
	WinWait, http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/SHR`%3AMessage/Message-OK-3x45/
	SplashTextOn,300,,Clicking OK
	Sleep, 2000
	SplashTextOn,300,,Waiting for Ticket#
	RemedyCreateOK := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/SHR%3AMessage/Message-OK-3x45/","http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/SHR%3AMessage/Message-OK-3x45/")
	RemedyCreateOK.document.getElementsByClassName("f6")[0].click()
}
catch
	MessageStatus("Error","in create ticket end function.")

SplashTextOn,300,,Updating MM Ticket# box
Sleep, 4000
SplashTextOff
Gosub, MMTicketNumber
return

MMResolveTicket:
^!#v::
Sleep, 2000
SplashTextOn,300,,Resolve Ticket Function
;;; AUTO OPEN AND FILL REMEDY RESOLVE TICKET WINDOW (DELETE THE LAST ";" COMMENT SEMICOLN TO ENABLE AUTO SUBMIT BUTTON)
Gui,MM:Submit,NoHide

SplashTextOn,300,,Checking Account Match
GoSub, MMAccountMatch
if (acctchk = 1)
	Goto, ResolveTicket
else
	Return

ResolveTicket:
SplashTextOn,300,,Begin Resolution
SetTitleMatchMode,2

IfWinExist, Home (Search)
	WinActivate, Home (Search)

Sleep, 200

;;; OPEN A TICKET THAT IS ASSIGNED OR WORKING STATUS
SplashTextOn,300,,Opening First Assigned Ticket
Remedy := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/")
try
{
	if ((Remedy.document.all.T680001300.getElementsByTagName("SPAN")[3].InnerText = "Assigned") or (Remedy.document.all.T680001300.getElementsByTagName("SPAN")[3].InnerText = "Working") or (Remedy.document.all.T680001300.getElementsByTagName("SPAN")[3].InnerText = "Linked") or (Remedy.document.all.T680001300.getElementsByTagName("SPAN")[3].InnerText = "New"))
	{
		pWin := Remedy.document.parentWindow
		pbrt := Remedy.document.all.T680001300.getElementsByTagName("SPAN")[0].getBoundingClientRect()
		CRXL := pbrt.left ;+ pWin.Left
		CRYT := pbrt.top ;+ pWin.screenTop
		CRXR := pbrt.right ;+ pWin.screenLeft
		CRYB := pbrt.bottom ;+ pWin.screenTop
		CRX := (CRXL + CRXR) / 2
		CRY := (CRYT + CRYB) / 2 + 108
		MouseMove,CRX,CRY,1
		Sleep, 200
		Click 2
		Sleep, 200
		Click 2
		SplashTextOn,300,,Waiting for ticket to open
		WinWait, Customer Ticket (Search) - Internet Explorer
		Sleep, 2000
	}
	else
	{
		MessageStatus("Error","No ticket found with Assigned or Working or Linked or New")
	}
}
catch
{
	MessageStatus("Error","in Resolve Ticket function.")
}
SetTitleMatchMode,Regex

^!#b::
SplashTextOn,300,,Checking Account Match
MMBypassTicket:
GoSub, MMAccountMatch
if (acctchk = 1)
	Goto, BypassTicket
else
	Return

BypassTicket:
SplashTextOn,300,,Begin Bypass Function
RemedyBypass := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/")

try
{
	FrameName := RemedyBypass.document.parentWindow.frames[1].name
	STATUS := RemedyBypass.document.parentWindow.frames(FrameName).document.all.Status.InnerText
	if ((STATUS = "Assigned") or (STATUS = "Linked") or (STATUS = "Working") or (STATUS = "New"))
	{
		SplashTextOn,300,,Clicking Edit Button
		FrameName := RemedyBypass.document.parentWindow.frames[2].name
		RemedyBypass.document.parentWindow.frames(FrameName).document.all.btn_EditTicket.click()
		
		try
		{
			SplashTextOn,300,,Waiting for Working Status
			RemedyBypass := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/")
			FrameName := RemedyBypass.document.parentWindow.frames[1].name
			Loop
			{
				Sleep, 3000
			} Until  ((RemedyBypass.document.parentWindow.frames(FrameName).document.all.Status.InnerText = "Working") or (RemedyBypass.document.parentWindow.frames(FrameName).document.all.Status.InnerText = "Linked"))
		}
		catch
		{
			try
			{
				SplashTextOn,300,,Waiting for Working Status
				RemedyBypass := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/")
				while RemedyBypass.busy or RemedyBypass.ReadyState != 4
					Sleep, 100
				FrameName := RemedyBypass.document.parentWindow.frames[1].name
				Loop
				{
				} Until  ((RemedyBypass.document.parentWindow.frames(FrameName).document.all.Status.InnerText = "Working") or (RemedyBypass.document.parentWindow.frames(FrameName).document.all.Status.InnerText = "Linked"))
			}
			catch
			{
				MessageStatus("Error","Something may not have gone right. I dont know what went wrong.")
			}
		}
		SplashTextOn,300,,Clicking on Resolution Actions
		Sleep 2000
		FrameName := RemedyBypass.document.parentWindow.frames[2].name
		RemedyBypass.document.parentWindow.frames(FrameName).document.all.btn_ResolutionActions.click()
		Sleep, 500
		RemedyBypass.document.all.WIN_0_651200006.click()
	}
	else if ((STATUS = "Working") or (STATUS = "New"))
	{
		SplashTextOn,300,,Clicking on Resolution Actions
		FrameName := RemedyBypass.document.parentWindow.frames[2].name
		RemedyBypass.document.parentWindow.frames(FrameName).document.all.btn_ResolutionActions.click()
		Sleep, 500
		RemedyBypass.document.all.WIN_0_651200006.click()
	}
	else
		MessageStatus("Error","Ticket Status not Assigned or Working... try to resolve manually...")
}
catch
	MessageStatus("Error","MMBypassTicket function.")

SplashTextOn,300,,Waiting for Resolve Ticket window

WinWaitActive, Resolve Ticket - Internet Explorer

SplashTextOn,300,,Doing 165 code
Sleep, 2000

try
{
	RemedyResolve := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3AResolve+CR/Resolve/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3AResolve+CR/Resolve/")
	RemedyResolve.document.all.arid_WIN_0_536870916.click()
	RemedyResolve.document.all.arid_WIN_0_536870916.Value := 165
	RemedyResolve.document.all.arid_WIN_0_536870916.focus()
	Sleep, 200
	Send, {Down}
	RemedyResolve.document.all.arid_WIN_0_536870916.fireEvent("onchange")
	RemedyResolve.document.getElementById("WIN_0_536870972").getElementsByClassName("f7")[0].click()

	Sleep, 2000
	;Send, {Enter}
	RemedyResolve.document.parentWindow.frames[2].document.getElementsByTagName("A")[0].click()
	Sleep, 2000
	
	SplashTextOn,300,,Doing 2804 code
	RemedyResolve.document.all.arid_WIN_0_536870917.click()
	RemedyResolve.document.all.arid_WIN_0_536870917.Value := 2804
	RemedyResolve.document.all.arid_WIN_0_536870917.focus()
	Sleep, 200
	Send, {Down}
	RemedyResolve.document.all.arid_WIN_0_536870917.fireEvent("onchange")
	RemedyResolve.document.getElementById("WIN_0_536870931").getElementsByClassName("f7")[0].click()
	
	SplashTextOn,300,,Doing Notes
	sleep, 500
	NOTES := GetNotes()
	RemedyResolve.document.all.arid_WIN_0_651000702.Value := NOTES
	sleep, 1000
	
	RemedyResolve.document.getElementById("WIN_0_651000902").getElementsByClassName("f9")[0].click()
}
catch
	MessageStatus("Error","in ResolveTicketWindow function.")

SplashTextOn,300,,Waiting for Resolve Ticket window to close
WinWaitClose, Resolve Ticket - Internet Explorer

try {
	RemedyBypass := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/")
	FrameName := RemedyBypass.document.parentWindow.frames[1].name
	Loop {
	} Until (RemedyBypass.document.parentWindow.frames(FrameName).document.all.Status.InnerText != "Working")
}
catch
{
	try
	{
		while RemedyBypass.busy or RemedyBypass.ReadyState != 4
			Sleep, 2000
		RemedyBypass := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/ESM%3ACustomer+Ticket/Default+Administrator+View/")
		FrameName := RemedyBypass.document.parentWindow.frames[1].name
		Loop {
			Sleep, 2000
		} Until (RemedyBypass.document.parentWindow.frames(FrameName).document.all.Status.InnerText = "Resolved")
	}
	catch
	{
		MessageStatus("Error","Please close Ticket window manually... did not work automatically...")
	}
}

try
{
	if (RemedyBypass.document.parentWindow.frames(FrameName).document.all.Status.InnerText = "Resolved")
	{
		Sleep, 2000
		SetTitleMatchMode,2
		SplashTextOn,300,,Waiting for Customer Ticket window to close.
		WinClose, Customer Ticket (Search) - Internet Explorer
		WinWaitClose, Customer Ticket (Search) - Internet Explorer,,4
		if ErrorLevel
			MessageStatus("Error","Customer Ticket Window did not close.")
		SetTitleMatchMode,RegEx
	} else {
		SplashTextOn,300,,Waiting for Customer Ticket window to close.
		WinClose, Customer Ticket
		WinWaitClose, Customer Ticket,,4
		if ErrorLevel
			MessageStatus("Error","Customer Ticket Window did not close.")
	}
}
catch
	MessageStatus("Error","in closing Resolved Ticket window")
SplashTextOff
return


MMS4Checklist:
IfWinExist, S4 Checklist
	WinActivate, S4 Checklist
else
	Run, S4CheckList.ahk
return


MMRDSPass:
IfWinExist, RDS Password Manager
	WinActivate, RDS Password Manager
else
	Run, RDS_PotD.ahk
return


MMHelp:
^!#h::
helpinfo = 
(
email me at support@joshebosh.com for support



For colored text boxes:

    Green = get info
    Blue = send info to
    Brown = note info down
)

Gui,MMHelp:Destroy
Gui,MMHelp:Add,Tab3,-Theme,General|Avaya|Remedy|Perfect Call
Gui,MMHelp:Add,Text,x50 y70 vMMHelp,%helpinfo%
Gui,MMHelp:Add,Button,x50 y300 gREADME vREADME,README File
Gui,MMHelp:Tab,Avaya
Gui,MMHelp:Add,Picture,,.\Lib\Pics\AvayaButtons.png
Gui,MMHelp:Tab,Remedy
Gui,MMHelp:Add,Picture,,.\Lib\Pics\Remedy_IE_Bars.png
Gui,MMHelp:Tab,Perfect Call
Gui,MMHelp:Add,Picture,w-1 h700,Lib\Pics\PerfectCall.png
Gui,MMHelp:Tab
Gui,MMhelp:Add,Button,gMMHelpOK Default,OK
Gui,MMHelp:Show
Gui,MMHelp:+AlwaysOnTOp
Return

README:
Run, .\Lib\README.txt
Return

MMHelpGuiClose:
MMHelpGuiEscape:
MMHelpOK:
Gui,MMHelp:Destroy
Return


MMSettings:
Gui,MMSettings:Destroy

IniRead, MMOnTop, .\Lib\MM.ini, MMAlwaysOnTop, AlwaysOnTop , 0
IniRead, MMTheme, .\Lib\MM.ini, MMTheme, Theme , 0
IniRead, AButt, .\Lib\MM.ini, AvayaSettings, AvayaButtons

Gui,MMSettings:Add,Tab3,-Theme,Avaya|Theme|Other
Gui,MMSettings:Add,Radio,x20 y50 hwndAvButtA gAvayaButt vAvayaButtA,A
Gui,MMSettings:Add,Radio,x20 y90 hwndAvButtB gAvayaButt vAvayaButtB,B
ABut := % AvButt%AButt%
Control,Check,,,ahk_id %ABut%
Gui,MMSettings:Add,Picture,x60 y40,.\Lib\Pics\AvayaButtonsA.png
Gui,MMSettings:Add,Picture,x60 y80,.\Lib\Pics\AvayaButtonsB.png

Gui,MMSettings:Tab,Theme
Gui,MMSettings:Add,Checkbox,xp+10 ym+30 HwndMMTh gMMTheme vMMTheme,Activate Theme
if MMTheme
	Control,Check,,,ahk_id %MMTh%
Gui,MMSettings:Add,GroupBox,x20 y60 w200 h110,Set Theme Colors
Gui,MMSettings:Add,Text,xp+10 yp+30 w60 h13,Backgound
Gui,MMSettings:Add,ComboBox,xp+60 yp-5 w120 gMMThemeColors vMMBackgroundColor,%MMBackgroundColor%||Aqua|Black|Blue|Fuchsia|Gray|Green|Lime|Maroon|Navy|Olive|Purple|Red|Silver|Teal|White|Yellow
Gui,MMSettings:Add,Text,xp-60 yp+30 w60 h13,Edit Boxes
Gui,MMSettings:Add,ComboBox,xp+60 yp-5 w120 gMMThemeColors vMMControlColor,%MMControlColor%||Aqua|Black|Blue|Fuchsia|Gray|Green|Lime|Maroon|Navy|Olive|Purple|Red|Silver|Teal|White|Yellow
Gui,MMSettings:Add,Text,xp-60 yp+30 w60 h13,Text
Gui,MMSettings:Add,ComboBox,xp+60 yp-5 w120 gMMThemeColors vMMTextColor,%MMTextColor%||Aqua|Black|Blue|Fuchsia|Gray|Green|Lime|Maroon|Navy|Olive|Purple|Red|Silver|Teal|White|Yellow
Gui,MMSettings:Add,Picture,xp+140 y30,.\Lib\Pics\ColorChart.png

Gui,MMSettings:Tab,Other
Gui,MMSettings:Add,Checkbox,x50 y50 HwndMMAOT gMMOnTop vMMOnTop,Always on Top
if MMOnTop
	Control,Check,,,ahk_id %MMAOT%

Gui,MMSettings:Tab
Gui,MMSettings:Add,Button,vMMSettingsOK gMMSettingsOK Default,OK
Gui,MMSettings:Show
Gui,MMSettings:+AlwaysOnTop
Return


AvayaButt:
Gui,MMSettings:Submit,NoHide
if AvayaButtA or AvPicA
{
	IniWrite, A,.\Lib\MM.ini, AvayaSettings, AvayaButtons
	AvayaButtA = 0
}
if AvayaButtB or AvPicB
{
	IniWrite, B,.\Lib\MM.ini, AvayaSettings, AvayaButtons
	AvayaButtB = 0
}
Return


MMOnTop:
Gui,MMSettings:Submit,Nohide
If MMOnTop = 1
{
	Gui,MM:+AlwaysOnTop
	IniWrite, 1, .\Lib\MM.ini, MMAlwaysOnTop, AlwaysOnTop
}
else
{
	Gui,MM:-AlwaysOnTop
	IniWrite, 0, .\Lib\MM.ini, MMAlwaysOnTop, AlwaysOnTop
}
Return


MMTheme:
Gui, MMSettings:Submit,NoHide
if MMTheme
{
	Themed = 1
	IniWrite, 1, .\Lib\MM.ini, MMTheme, Theme
} else {
	Themed = 1
	IniWrite, 0, .\Lib\MM.ini, MMTheme, Theme
}

Return


MMThemeColors:
Gui, MMSettings:Submit,NoHide
IniWrite, 1, .\Lib\MM.ini, MMTheme, Theme
IniWrite, %MMBackgroundColor%, .\Lib\MM.ini, MMTheme, BackgroundColor
IniWrite, %MMControlColor%, .\Lib\MM.ini, MMTheme, ControlColor
IniWrite, %MMTextColor%, .\Lib\MM.ini, MMTheme, TextColor
Themed := 1
Gosub,skip_init
Return


MMSettingsOK:
Gui,MMSettings:Submit
IniRead, AButt, .\Lib\MM.ini, AvayaSettings, AvayaButtons, A
IniRead, AutoInX, .\Lib\MM.ini, AvayaSettings, AutoInX_%AButt%, 189
IniRead, AfterCallX, .\Lib\MM.ini, AvayaSettings, AfterCallX_%AButt%, 332
IniRead, ButtonBar, .\Lib\MM.ini, AvayaSettings, ButtonBar, 51
if Themed
{
	Themed := 1
	Gosub, skip_init
}
Return

MMSettingsGuiClose:
MMSettingsGuiEscape:
Gui,MMSettings:Destroy
Return


MMWM:
WMHelp =
(

NOT FOR NEWBIES!!!
Must have AutoHotKey Installed to use the Window Manager.


Windows Manager(WM)
	where you can set window to always appear in certain place.


There is no visible interface... it happens in the background.
The config file "WindowManager.ahk" is where you'll.

[Ctrl + Alt + Win + w]
to activate the manager

[Ctrl + Alt + Win + Shift + w]
to deactivate the manager

Remember a window placement:
   (activate WM first, you'll see the "W" icon in system tray)
	1. Place the window just where you want it.
    2. Hold down [Ctrl + Alt + Win] and left click anywhere at the top of the window.

Manually remove any placements not wanted:
    1. open the WindowManager.ahk in notepad (or whatever)
    2. read the ;############### lines very carefully and proceed.
    3. either find the one you want to delete, or if too difficult, delete them all and start over...
)
Gui, MMWM:Add, Text,,%WMHelp%
Gui, MMWM:Add,Button,gMMWMOK Default,OK
Gui, MMWM:Show
Gui, MMWM:+AlwaysOnTop
Return

MMWMGuiClose:
MMWMGuiEscape:
MMWMOK:
Gui,MMWM:Destroy
Return


^!#w::
Run, WindowManager.ahk
return


;;; RETURN NOTES
GetNotes()
{
NOTES =
(
Date: %TIME_STAMP%
Ticket #: %TICKET_NUMBER%
Customer Name: %CUSTOMER_NAME%
Account Number: %ACCOUNT_NUMBER%
Contact Number: %CONTACT_NUMBER%
Chronic Account: %CHRONIC_ACCOUNT%
Attempt Number: %ATTEMPT_NUMBER%
Affected Device: %AFFECTED_DEVICE%
Reported Issue: %REPORTED_ISSUE%
Resolution Action: %RESOLUTION_ACTION%
Next Action: %NEXT_ACTION%
)
Return NOTES
}


WM_MOUSEMOVE_FUNC()
{
	static CurrControl, PrevControl, _TT, _BT
	CurrControl := A_GuiControl
	If (CurrControl <> PrevControl){
			SetTimer, DisplayToolTip, -1 	; shorter wait, shows the tooltip quicker
			PrevControl := CurrControl
	}
	return
	
	DisplayToolTip:
	ToolTip, % %CurrControl%_BT
	GuiControl,MM:,MMStatus,% %CurrControl%_TT
	SetTimer, RemoveToolTip, -10000
	return
	
	RemoveToolTip:
		ToolTip
		GuiControl,MM:,MMStatus,% %MMStatus%_TT
	return
}


;;; IE11 GET FUNCTION	
setWbCom(name=false, url=false) {
    if (!name AND !url) {
        return false
    }
    wb:=false
    For wb in ComObjCreate( "Shell.Application" ).Windows {
        Try {
            If ((InStr(wb.locationName, name) AND name) OR (InStr(wb.locationURL, url) AND url)) && InStr(wb.FullName, "iexplore.exe") {
                return wb
            }
        } Catch, e {
            if (e AND this.debug) {
                FileAppend, % "`r`nCOM Error: " . e, % this.debug_file
            }
        }
    }
    if (debug) {
        this.errorWindow("Failed to find web browser.`r`nName:`t" . name . "`r`nURL:`t" . url)
    }
    return false
}



GetUnderMouse()
{
	uia := UIA_Interface()
	Element := uia.ElementFromPoint()
	for each, value in [30093,30092,30045] ; lvalue,lname,value
		UnderMouse := Element.GetCurrentPropertyValue(value)
	until r != ""
	if (UnderMouse = "")
		UnderMouse := Element.CurrentName
	Tooltip % UnderMouse = ""? "<No Text Found>" : clipboard := UnderMouse
	SetTimer, MMToolTip, -1000
	Return UnderMouse
}


MMToolTip:
Tooltip
Return

!#+r::
Refreshers:
;ANIT-SCREENSAVER
MouseGetPos, MX, MY
MX += 1
MY += 1
MouseMove, MX, MY
MouseMove, MX-1, MY-1
;SendInput, {ScrollLock}
;sleep,50
;SendInput, {ScrollLock}

;REFRESH COM GLOBALS
reconnect = 1
Gosub, ReconnectComs

;REFRESH CONTROL COLORS
Gosub, ControlColors
Return


MMAccountMatch:
try
{
	Remedy := setWbCom("http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/", "http://sams-midtier.cable.comcast.com:9000/arsys/forms/sams/")
	RemAcct := Remedy.document.all.T651001000.getElementsByTagName("SPAN")[4].innerText
	ES360Acct := es360.document.getElementById("newHeaderSection").getElementsByTagName("DIV")[3].innerText
	if (RemAcct = ES360Acct)
	{
		acctchk := 1
		Return
	}
	else
	{
		MsgBox,4100,Accounts Mismatch,Continue Anyway?,5
		IfMsgBox Timeout
		{
			acctchk := 0
			SplashTextOff
			Return
		}
		IfMsgBox No
		{
			acctchk := 0
			SplashTextOff
			Return
		}
		IfMsgBox Yes
		{
			acctchk := 1
			Return
		}
	}
}
catch
	MessageStatus("Error","Account Checker function")
SplashTextOff
Return


MMEndCall:
^!#e::
MsgBox,4099,Resolve Ticket,Need to Resolve Ticket?,5
IfMsgBox Timeout
{
	Gosub, MMRemNotes
	Sleep, 1000
	Goto, EndContinue
}
IfMsgBox No
{
	Gosub, MMRemNotes
	Sleep, 1000
	Goto, EndContinue
}
IfMsgBox Yes
{
	Gosub, MMRemNotes
	Sleep, 1000
	Gosub, MMResolveTicket
	Sleep, 1000
	Goto, EndContinue
}
IfMsgBox Cancel
	Return
EndContinue:
Gosub, MMResetES360
Sleep,1000
Gosub, MMResetProxy
Sleep,1000
Gosub, MMResetS4
Sleep,1000
Gosub, MMResetScout
Sleep,1000
Gosub, MMResetAvaya
Return


MMResetOptions:
^!#/::
Gui,MMReset:Destroy
Gui,MMReset:Add,CheckBox, gResetAll vResetAll,Check All
Gui,MMReset:Add,CheckBox,vResetRemNotes,Paste Remedy Notes
Gui,MMReset:Add,CheckBox,gResetRem vResetRem,Remedy
Gui,MMReset:Add,Radio,x30 Checked vResetResolve,Resolve Ticket
Gui,MMReset:Add,Radio,x30 vResetByPass,Bypass Ticket
Gui,MMReset:Add,CheckBox,x10 vResetScout,Reset Scout
Gui,MMReset:Add,CheckBox,vResetProxy,Reset RDS
Gui,MMReset:Add,CheckBox,vResetES360,End Call Enstein 360
Gui,MMReset:Add,CheckBox,vResetS4,Reset S4 Checklist
;Gui,MMReset:Add,CheckBox,vResetGuidedPaths,Guided Paths
Gui,MMReset:Add,CheckBox,vResetAvaya,AutoIn Avaya
Gui,MMReset:ADD,Button,Default gMMResetOK,OK
GuiControl,MMReset:Disable,ResetResolve
GuiControl,MMReset:Disable,ResetBypass
Gui,MMReset:+AlwaysOnTop
Gui,MMReset:Show
Return

ResetAll:
Gui,MMReset:Submit,NoHide
if (ResetAll = 1)
{
	GuiControl,MMReset:,Button2,1
	GuiControl,MMReset:,Button3,1
	GuiControl,MMReset:Enable,ResetResolve
	GuiControl,MMReset:Enable,ResetBypass
	GuiControl,MMReset:,Button6,1
	GuiControl,MMReset:,Button7,1
	GuiControl,MMReset:,Button8,1
	GuiControl,MMReset:,Button9,1
	GuiControl,MMReset:,Button10,1
	;GuiControl,MMReset:,Button11,1
} else {
	GuiControl,MMReset:,Button2,0
	GuiControl,MMReset:,Button3,0
	GuiControl,MMReset:Disable,ResetResolve
	GuiControl,MMReset:Disable,ResetBypass
	GuiControl,MMReset:,Button6,0
	GuiControl,MMReset:,Button7,0
	GuiControl,MMReset:,Button8,0
	GuiControl,MMReset:,Button9,0
	GuiControl,MMReset:,Button10,0
	;GuiControl,MMReset:,Button11,0
}
Return

ResetRem:
Gui,MMReset:Submit,NoHide
if ResetRem
{
	GuiControl,MMReset:Enable,ResetResolve
	GuiControl,MMReset:Enable,ResetBypass
} else {
	GuiControl,MMReset:Disable,ResetResolve
	GuiControl,MMReset:Disable,ResetBypass
}
Return
MMResetOK:
Gui,MMReset:Submit
if ResetRemNotes
	Gosub, MMRemNotes
if ResetRem
{
	if ResetResolve
		Gosub, MMResolveTicket
	if ResetBypass
		Gosub, MMBypassTicket
}
if ResetGuidedPaths
	Sleep, 100 ;Gosub, MMGuidedPaths
if ResetES360
	Gosub, MMResetES360
if ResetProxy
	Gosub, MMResetProxy
if ResetS4
	Gosub, MMResetS4
if ResetScout
	Gosub, MMResetScout
if ResetAvaya
	Gosub, MMResetAvaya
Gui,MMReset:Destroy
Return
MMResetEscape:
MMResetGuiClose:
Gui,MMReset:Destroy
Return

MMResetProxy:
SetTitleMatchMode,2
Sleep,200
IfWinExist, Comcast - Proxy Browser
{
	WinActivate, Comcast - Proxy Browser
	Sleep, 300
	MouseMove, 815,75
	Sleep, 100
	MouseClick, Left, 815, 75
	Sleep, 100
}
SetTitleMatchMode,RegEx
Return


MMResetS4:
SetTitleMatchMode,2
Sleep,200
IfWinExist, S4 Checklist
{
	WinActivate, S4 Checklist
	Sleep, 300
	MouseClick, Left, 303, 58
}
SetTitleMatchMode,RegEx
Return


MMResetScout:
SetTitleMatchMode,2
Sleep,200
IfWinExist, Scout Monitor - Internet Explorer 
{
	WinActivate, Scout Monitor - Internet Explorer
	Sleep, 300
	try {
		Scout.Navigate("http://scoutmonitoring.g.comcast.net/network_monitoring/servlet/network_monitoring?reqType=getPage&pageName=customerLookup~customerLookup")
	} catch {
		MessageStatus("Error","Scout Not Opened or Offline")
	}
}
else IfWinExist, Scout Monitor - Google Chrome ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe
{
	WinActivate, Scout Monitor - Google Chrome ahk_class Chrome_WidgetWin_1 ahk_exe chrome.exe
	Sleep, 500
	Click, , 170, 180
	Sleep, 500
	Click, 170, 206
}
else IfWinExist, Scout Monitor - Mozilla Firefox ahk_class MozillaWindowClass ahk_exe firefox.exe
{
	WinActivate, Scout Monitor - Mozilla Firefox ahk_class MozillaWindowClass ahk_exe firefox.exe
	Sleep, 500
	Click, 163, 182
	Sleep, 500
	Click, 175, 208
} else {
	IfWinExist, Scout Monitor ahk_class MozillaWindowClass ahk_exe sdcwbProxyBrowser.exe
	{
		WinActivate, Scout Monitor ahk_class MozillaWindowClass ahk_exe sdcwbProxyBrowser.exe
		Sleep, 500
		Send, {Home}
		MouseClick, , 165, 100
		Sleep, 500
		MouseClick, , 188, 129
	}
}
SetTitleMatchMode,RegEx
Return


MMResetES360:
SetTitleMatchMode,2
Sleep,200
IfWinExist, Einstein 360
{
	WinActivate, Einstein 360
	Gosub, MMEndES
}
SetTitleMatchMode,RegEx
Return

MMResetAvaya:
MsgBox,4100,,Avaya AutoIn?,5
	IfMsgBox Yes
		Goto, AutoIn
	IfMsgBox Timeout
		Goto, AutoIn
	IfMsgBox No
		Return

AutoIn:
SetTitleMatchMode,2
Sleep,200
IfWinExist, Avaya one-X Agent ahk_exe OneXAgentUI.exe
{
	WinActivate, Avaya one-X Agent ahk_exe OneXAgentUI.exe
	MouseMove, %AutoInX%, %ButtonBar%
	Sleep, 500
	MouseClick, Left, %AutoInX%, %ButtonBar%
	Sleep, 500
}
SetTitleMatchMode,RegEx
Return


AfterCall:
IfWinExist, Avaya one-X Agent ahk_exe OneXAgentUI.exe
{
	WinActivate, Avaya one-X Agent ahk_exe OneXAgentUI.exe
	MouseMove, %AfterCallX%, %ButtonBar%
	Sleep, 500
	MouseClick, Left, %AfterCallX%, %ButtonBar%
	Sleep, 500
}
Return


MMGuiClose:
MMDestroy:
MsgBox,4100,Confirm Destruction,Are you sure you want to destroy the session?`n`n Aborting request in 5 seconds,5
IfMsgBox No
	return
IfMsgBox Yes
	Gosub, MMGuiSet
	ExitApp
IfMsgBox Timeout
	ExitApp
Return


~RButton::
If (A_TimeSincePriorHotkey<500) and (A_TimeSincePriorHotkey<>-1)
IfWinExist, Metric Master
	WinActivate, Metric Master
Return

^!#+m::
InputBox, asdf, kind, Info/Warn/Error
MessageStatus(asdf,"test message status " asdf)
Return

MessageStatus(kind,mstat) {
	SetTimer, cont, off
	GuiControl,MM:Hide,ErrorBG
	GuiControl,MM:Hide,WarnBG
	GuiControl,MM:Hide,InfoBG
	GuiControl,MM:Hide,MMVersion
	GuiControl,MM:Hide,MMBanner
	GuiControl,MM:Show,% kind . "BG"
	GuiControl,MM:Show,MessageStatus
	GuiControl,MM:,MessageStatus,%mstat%
	SetTimer, cont,10000
	Return
	cont:
	GuiControl,MM:Hide,MessageStatus
	GuiControl,MM:Hide,ErrorBG
	GuiControl,MM:Hide,WarnBG
	GuiControl,MM:Hide,InfoBG
	GuiControl,MM:Show,MMBanner
	GuiControl,MM:Show,MMVersion
	Return 
}


ControlColors:
if !TICKET_NUMBER
	CtlColors.Change(TICKETNUMBER, "Red", "Black")
else
	CtlColors.Change(TICKETNUMBER, "Lime", "Black")

if !CUSTOMER_NAME
	CtlColors.Change(CUSTOMERNAME, "Red", "Black")
else
	CtlColors.Change(CUSTOMERNAME, "Lime", "Black")

if !ACCOUNT_NUMBER
	CtlColors.Change(ACCOUNTNUMBER, "Red", "Black")
else
	CtlColors.Change(ACCOUNTNUMBER, "Lime", "Black")

if !CONTACT_NUMBER
	CtlColors.Change(CONTACTNUMBER, "Red", "Black")
else
	CtlColors.Change(CONTACTNUMBER, "Lime", "Black")

if !WIRELESS_GATEWAY
	CtlColors.Change(WIRELESSGATEWAY, "Red", "Black")
else
	CtlColors.Change(WIRELESSGATEWAY, "Lime", "Black")

if !BOOT_FILE
	CtlColors.Change(BOOTFILE, "Red", "Black")
else if ((RegExMatch(BOOT_FILE, "cdvonly"))
		or (RegExMatch(BOOT_FILE, "cdvvaction"))
		or (RegExMatch(BOOT_FILE, "nonpay"))
		or (RegExMatch(BOOT_FILE, "walledgarden"))
		or (RegExMatch(BOOT_FILE, "timeout"))
		or (RegExMatch(BOOT_FILE, "unknown")))
	CtlColors.Change(BOOTFILE, "Yellow", "Black")
else if ((RegExMatch(BOOT_FILE, "blastpro"))
		or (RegExMatch(BOOT_FILE, "atlt2.ga.comcast.net"))
		or (RegExMatch(BOOT_FILE, "chnbronze"))
		or (RegExMatch(BOOT_FILE, "chnstarter"))
		or (RegExMatch(BOOT_FILE, "chnultra"))
		or (RegExMatch(BOOT_FILE, "chnsilver"))
		or (RegExMatch(BOOT_FILE, "chnspeedtierextreme2"))
		or (RegExMatch(BOOT_FILE, "chnwidbandblast"))
		or (RegExMatch(BOOT_FILE, "chnwidbandshowcaseblast"))
		or (RegExMatch(BOOT_FILE, "economyplus"))
		or (RegExMatch(BOOT_FILE, "extreme250"))
		or (RegExMatch(BOOT_FILE, "extreme300"))
		or (RegExMatch(BOOT_FILE, "extreme"))
		or (RegExMatch(BOOT_FILE, "gigabitpro"))
		or (RegExMatch(BOOT_FILE, "gigabit"))
		or (RegExMatch(BOOT_FILE, "internet5"))
		or (RegExMatch(BOOT_FILE, "internetessentials"))
		or (RegExMatch(BOOT_FILE, "performance2"))
		or (RegExMatch(BOOT_FILE, "performancepro"))
		or (RegExMatch(BOOT_FILE, "performancestarter"))
		or (RegExMatch(BOOT_FILE, "pro"))
		or (RegExMatch(BOOT_FILE, "silverpboost"))
		or (RegExMatch(BOOT_FILE, "silver"))
		or (RegExMatch(BOOT_FILE, "speedtierextreme2"))
		or (RegExMatch(BOOT_FILE, "speedtier"))
		or (RegExMatch(BOOT_FILE, "tppremier"))
		or (RegExMatch(BOOT_FILE, "widebandblast"))
		or (RegExMatch(BOOT_FILE, "widebandshowcaseblast")))
	CtlColors.Change(BOOTFILE, "Lime", "Black")
else if ((RegExMatch(BOOT_FILE, "abusesuspend"))
		or (RegExMatch(BOOT_FILE, "abuseterminate"))
		or (RegExMatch(BOOT_FILE, "tosdefault"))
		or (RegExMatch(BOOT_FILE, "abusetb25"))
		or (RegExMatch(BOOT_FILE, "abusedead")))
	CtlColors.Change(BOOTFILE, "black", "yellow")
else
	CtlColors.Change(BOOTFILE, "grey", "red")

if !(MARKET or MARKET_REGION)
	CtlColors.Change(MARKETREGION, "Red", "Black")
else
	CtlColors.Change(MARKETREGION, "Lime", "Black")

if IPv6
	CtlColors.Change(IPADDRESS, "Lime", "Black")
else if (IP_ADDRESS = "0.0.0.0")
	CtlColors.Change(IPADDRESS, "Yellow", "Red")
else if IPv4
	CtlColors.Change(IPADDRESS, "Aqua", "Black")
else
	CtlColors.Change(IPADDRESS, "Red", "Black")

if !MAC_ADDRESS
	CtlColors.Change(MACADDRESS, "Red", "Black")
else
	CtlColors.Change(MACADDRESS, "Lime", "Black")

if !ZIP_CODE
	CtlColors.Change(ZIPCODE, "Red", "Black")
else
	CtlColors.Change(ZIPCODE, "Lime", "Black")

if !ALT_EMAIL
	CtlColors.Change(ALTEMAIL, "Red", "Black")
else if (RegExMatch(ALT_EMAIL, "^.*@.*[.]\w\w\w(.*)?"))
	CtlColors.Change(ALTEMAIL, "Lime", "Black")
else
	CtlColors.Change(ALTEMAIL, "Yellow", "Black")

if !BALANCE
	CtlColors.Change(BAL, "Red", "Black")
else if (BALANCE = "$0.00") or (RegExMatch(BALANCE, "[-](\$)(\d{1,4})(\.)(\d\d)"))
	CtlColors.Change(BAL, "Lime", "Black")
else
	CtlColors.Change(BAL, "Yellow", "Black")

if (AUTO_PAY = "NO")
	CtlColors.Change(AUTOPAY, "Yellow", "Black")
else if (AUTO_PAY = "YES")
	CtlColors.Change(AUTOPAY, "Lime", "Black")
else
	CtlColors.Change(AUTOPAY, "Red", "Black")

Return


MMGuiSet:
IfWinExist, Metric Master
	WinGetPos, MMX, MMY, , , Metric Master
IniWrite, %MMX%, .\Lib\MM.ini, MMWinPos, XPos
IniWrite, %MMY%, .\Lib\MM.ini, MMWinPos, YPos
Return

MMGuiEscape:
Esc::
IfWinActive, Einstein 360
	Send, ^!+#r
else IfWinActive, Metric Master
	Send, ^!+#r
Return

^!+g::
InputBox, subroutine, Choose, Sub Routine
Gosub, %subroutine%
Return


MMReportedIssue:
Gui,RepIss:Destroy
Gui,MM:Submit,NoHide

RIA := [RI1,RI2,RI3,RI4,RI5,RI6,RI7,RI8,RI9,RI10,RI11,RI12
		,RI13,RI14,RI15,RI16,RI17,RI18,RI19,RI20,RI21,RI22,RI23,RI24
		,RI25,RI26,RI27,RI28,RI29,RI30,RI31,RI32,RI33,RI34,RI35,RI36
		,RI37,RI38,RI39,RI40,RI41,RI42,RI43,RI44,RI45,RI46,RI47,RI48]
for key in RIA
	IniRead, RI%A_Index%, .\Lib\MM.ini, ReportedIssue,RI%A_Index%

global RINoteArray := Object()
ERepIss =

Gui,RepIss:Add,Text,x10 y10 w40 h20 gTRepIss1 Border,RI1
Gui,RepIss:Add,Checkbox,x50 y10 w300 h20 gRepIss1 vRepIss1 Border,%RI1%
Gui,RepIss:Add,Text,x370 y10 w40 h20 gTRepIss25 Border,RI25
Gui,RepIss:Add,Checkbox,x410 y10 w300 h20 gRepIss25 vRepIss25 Border,%RI25%
Gui,RepIss:Add,Text,x10 y30 w40 h20 gTRepIss2 Border,RI2
Gui,RepIss:Add,Checkbox,x50 y30 w300 h20 gRepIss2 vRepIss2 Border,%RI2%
Gui,RepIss:Add,Text,x370 y30 w40 h20 gTRepIss26 Border,RI26
Gui,RepIss:Add,Checkbox,x410 y30 w300 h20 gRepIss26 vRepIss26 Border,%RI26%
Gui,RepIss:Add,Text,x10 y50 w40 h20 gTRepIss3 Border,RI3
Gui,RepIss:Add,Checkbox,x50 y50 w300 h20 gRepIss3 vRepIss3 Border,%RI3%
Gui,RepIss:Add,Text,x370 y50 w40 h20 gTRepIss27 Border,RI27
Gui,RepIss:Add,Checkbox,x410 y50 w300 h20 gRepIss27 vRepIss27 Border,%RI27%
Gui,RepIss:Add,Text,x10 y70 w40 h20 gTRepIss4 Border,RI4
Gui,RepIss:Add,Checkbox,x50 y70 w300 h20 gRepIss4 vRepIss4 Border,%RI4%
Gui,RepIss:Add,Text,x370 y70 w40 h20 gTRepIss28 Border,RI28
Gui,RepIss:Add,Checkbox,x410 y70 w300 h20 gRepIss28 vRepIss28 Border,%RI28%
Gui,RepIss:Add,Text,x10 y90 w40 h20 gTRepIss5 Border,RI5
Gui,RepIss:Add,Checkbox,x50 y90 w300 h20 gRepIss5 vRepIss5 Border,%RI5%
Gui,RepIss:Add,Text,x370 y90 w40 h20 gTRepIss29 Border,RI29
Gui,RepIss:Add,Checkbox,x410 y90 w300 h20 gRepIss29 vRepIss29 Border,%RI29%
Gui,RepIss:Add,Text,x10 y110 w40 h20 gTRepIss6 Border,RI6
Gui,RepIss:Add,Checkbox,x50 y110 w300 h20 gRepIss6 vRepIss6 Border,%RI6%
Gui,RepIss:Add,Text,x370 y110 w40 h20 gTRepIss30 Border,RI30
Gui,RepIss:Add,Checkbox,x410 y110 w300 h20 gRepIss30 vRepIss30 Border,%RI30%
Gui,RepIss:Add,Text,x10 y130 w40 h20 gTRepIss7 Border,RI7
Gui,RepIss:Add,Checkbox,x50 y130 w300 h20 gRepIss7 vRepIss7 Border,%RI7%
Gui,RepIss:Add,Text,x370 y130 w40 h20 gTRepIss31 Border,RI31
Gui,RepIss:Add,Checkbox,x410 y130 w300 h20 gRepIss31 vRepIss31 Border,%RI31%
Gui,RepIss:Add,Text,x10 y150 w40 h20 gTRepIss8 Border,RI8
Gui,RepIss:Add,Checkbox,x50 y150 w300 h20 gRepIss8 vRepIss8 Border,%RI8%
Gui,RepIss:Add,Text,x370 y150 w40 h20 gTRepIss32 Border,RI32
Gui,RepIss:Add,Checkbox,x410 y150 w300 h20 gRepIss32 vRepIss32 Border,%RI32%
Gui,RepIss:Add,Text,x10 y170 w40 h20 gTRepIss9 Border,RI9
Gui,RepIss:Add,Checkbox,x50 y170 w300 h20 gRepIss9 vRepIss9 Border,%RI9%
Gui,RepIss:Add,Text,x370 y170 w40 h20 gTRepIss33 Border,RI33
Gui,RepIss:Add,Checkbox,x410 y170 w300 h20 gRepIss33 vRepIss33 Border,%RI33%
Gui,RepIss:Add,Text,x10 y190 w40 h20 gTRepIss10 Border,RI10
Gui,RepIss:Add,Checkbox,x50 y190 w300 h20 gRepIss10 vRepIss10 Border,%RI10%
Gui,RepIss:Add,Text,x370 y190 w40 h20 gTRepIss34 Border,RI34
Gui,RepIss:Add,Checkbox,x410 y190 w300 h20 gRepIss34 vRepIss34 Border,%RI34%
Gui,RepIss:Add,Text,x10 y210 w40 h20 gTRepIss11 Border,RI11
Gui,RepIss:Add,Checkbox,x50 y210 w300 h20 gRepIss11 vRepIss11 Border,%RI11%
Gui,RepIss:Add,Text,x370 y210 w40 h20 gTRepIss35 Border,RI35
Gui,RepIss:Add,Checkbox,x410 y210 w300 h20 gRepIss35 vRepIss35 Border,%RI35%
Gui,RepIss:Add,Text,x10 y230 w40 h20 gTRepIss12 Border,RI12
Gui,RepIss:Add,Checkbox,x50 y230 w300 h20 gRepIss12 vRepIss12 Border,%RI12%
Gui,RepIss:Add,Text,x370 y230 w40 h20 gTRepIss36 Border,RI36
Gui,RepIss:Add,Checkbox,x410 y230 w300 h20 gRepIss36 vRepIss36 Border,%RI36%
Gui,RepIss:Add,Text,x10 y250 w40 h20 gTRepIss13 Border,RI13
Gui,RepIss:Add,Checkbox,x50 y250 w300 h20 gRepIss13 vRepIss13 Border,%RI13%
Gui,RepIss:Add,Text,x370 y250 w40 h20 gTRepIss37 Border,RI37
Gui,RepIss:Add,Checkbox,x410 y250 w300 h20 gRepIss37 vRepIss37 Border,%RI37%
Gui,RepIss:Add,Text,x10 y270 w40 h20 gTRepIss14 Border,RI14
Gui,RepIss:Add,Checkbox,x50 y270 w300 h20 gRepIss14 vRepIss14 Border,%RI14%
Gui,RepIss:Add,Text,x370 y270 w40 h20 gTRepIss38 Border,RI38
Gui,RepIss:Add,Checkbox,x410 y270 w300 h20 gRepIss38 vRepIss38 Border,%RI38%
Gui,RepIss:Add,Text,x10 y290 w40 h20 gTRepIss15 Border,RI15
Gui,RepIss:Add,Checkbox,x50 y290 w300 h20 gRepIss15 vRepIss15 Border,%RI15%
Gui,RepIss:Add,Text,x370 y290 w40 h20 gTRepIss39 Border,RI39
Gui,RepIss:Add,Checkbox,x410 y290 w300 h20 gRepIss39 vRepIss39 Border,%RI39%
Gui,RepIss:Add,Text,x10 y310 w40 h20 gTRepIss16 Border,RI16
Gui,RepIss:Add,Checkbox,x50 y310 w300 h20 gRepIss16 vRepIss16 Border,%RI16%
Gui,RepIss:Add,Text,x370 y310 w40 h20 gTRepIss40 Border,RI40
Gui,RepIss:Add,Checkbox,x410 y310 w300 h20 gRepIss40 vRepIss40 Border,%RI40%
Gui,RepIss:Add,Text,x10 y330 w40 h20 gTRepIss17 Border,RI17
Gui,RepIss:Add,Checkbox,x50 y330 w300 h20 gRepIss17 vRepIss17 Border,%RI17%
Gui,RepIss:Add,Text,x370 y330 w40 h20 gTRepIss41 Border,RI41
Gui,RepIss:Add,Checkbox,x410 y330 w300 h20 gRepIss41 vRepIss41 Border,%RI41%
Gui,RepIss:Add,Text,x10 y350 w40 h20 gTRepIss18 Border,RI18
Gui,RepIss:Add,Checkbox,x50 y350 w300 h20 gRepIss18 vRepIss18 Border,%RI18%
Gui,RepIss:Add,Text,x370 y350 w40 h20 gTRepIss42 Border,RI42
Gui,RepIss:Add,Checkbox,x410 y350 w300 h20 gRepIss42 vRepIss42 Border,%RI42%
Gui,RepIss:Add,Text,x10 y370 w40 h20 gTRepIss19 Border,RI19
Gui,RepIss:Add,Checkbox,x50 y370 w300 h20 gRepIss19 vRepIss19 Border,%RI19%
Gui,RepIss:Add,Text,x370 y370 w40 h20 gTRepIss43 Border,RI43
Gui,RepIss:Add,Checkbox,x410 y370 w300 h20 gRepIss43 vRepIss43 Border,%RI43%
Gui,RepIss:Add,Text,x10 y390 w40 h20 gTRepIss20 Border,RI20
Gui,RepIss:Add,Checkbox,x50 y390 w300 h20 gRepIss20 vRepIss20 Border,%RI20%
Gui,RepIss:Add,Text,x370 y390 w40 h20 gTRepIss44 Border,RI44
Gui,RepIss:Add,Checkbox,x410 y390 w300 h20 gRepIss44 vRepIss44 Border,%RI44%
Gui,RepIss:Add,Text,x10 y410 w40 h20 gTRepIss21 Border,RI21
Gui,RepIss:Add,Checkbox,x50 y410 w300 h20 gRepIss21 vRepIss21 Border,%RI21%
Gui,RepIss:Add,Text,x370 y410 w40 h20 gTRepIss45 Border,RI45
Gui,RepIss:Add,Checkbox,x410 y410 w300 h20 gRepIss45 vRepIss45 Border,%RI45%
Gui,RepIss:Add,Text,x10 y430 w40 h20 gTRepIss22 Border,RI22
Gui,RepIss:Add,Checkbox,x50 y430 w300 h20 gRepIss22 vRepIss22 Border,%RI22%
Gui,RepIss:Add,Text,x370 y430 w40 h20 gTRepIss46 Border,RI46
Gui,RepIss:Add,Checkbox,x410 y430 w300 h20 gRepIss46 vRepIss46 Border,%RI46%
Gui,RepIss:Add,Text,x10 y450 w40 h20 gTRepIss23 Border,RI23
Gui,RepIss:Add,Checkbox,x50 y450 w300 h20 gRepIss23 vRepIss23 Border,%RI23%
Gui,RepIss:Add,Text,x370 y450 w40 h20 gTRepIss47 Border,RI47
Gui,RepIss:Add,Checkbox,x410 y450 w300 h20 gRepIss47 vRepIss47 Border,%RI47%
Gui,RepIss:Add,Text,x10 y470 w40 h20 gTRepIss24 Border,RI24
Gui,RepIss:Add,Checkbox,x50 y470 w300 h20 gRepIss24 vRepIss24 Border,%RI24%
Gui,RepIss:Add,Text,x370 y470 w40 h20 gTRepIss48 Border,RI48
Gui,RepIss:Add,Checkbox,x410 y470 w300 h20 gRepIss48 vRepIss48 Border,%RI48%
Gui,RepIss:Add,Edit,x10 y500 w240 h60 gERepIss vERepIss,%ERepIss%
Gui,RepIss:Add,Text,x450 y500 w200 h13 Center,Click the "RI" boxes to edit values
Gui,RepIss:Add,Button,x330 y510 w50 h50 gRepIssOK Default,OK
Gui,RepIss:Add,Button,x660 y500 w43 h23 gRISort,Sort
Gui,RepIss:Show
Gui,RepIss:+AlwaysOnTop +OwnDialogs

Return
RepIssGuiEscape:
RepIssGuiClose:
Gui,RepIss:Destroy
Return


TRepIss1:
TRIFunc(1)
Return
RepIss1:
RIFunc(1)
Return
TRepIss2:
TRIFunc(2)
Return
RepIss2:
RIFunc(2)
Return
TRepIss3:
TRIFunc(3)
Return
RepIss3:
RIFunc(3)
Return
TRepIss4:
TRIFunc(4)
Return
RepIss4:
RIFunc(4)
Return
TRepIss5:
TRIFunc(5)
Return
RepIss5:
RIFunc(5)
Return
TRepIss6:
TRIFunc(6)
Return
RepIss6:
RIFunc(6)
Return
TRepIss7:
TRIFunc(7)
Return
RepIss7:
RIFunc(7)
Return
TRepIss8:
TRIFunc(8)
Return
RepIss8:
RIFunc(8)
Return
TRepIss9:
TRIFunc(9)
Return
RepIss9:
RIFunc(9)
Return
TRepIss10:
TRIFunc(10)
Return
RepIss10:
RIFunc(10)
Return
TRepIss11:
TRIFunc(11)
Return
RepIss11:
RIFunc(11)
Return
TRepIss12:
TRIFunc(12)
Return
RepIss12:
RIFunc(12)
Return
TRepIss13:
TRIFunc(13)
Return
RepIss13:
RIFunc(13)
Return
TRepIss14:
TRIFunc(14)
Return
RepIss14:
RIFunc(14)
Return
TRepIss15:
TRIFunc(15)
Return
RepIss15:
RIFunc(15)
Return
TRepIss16:
TRIFunc(16)
Return
RepIss16:
RIFunc(16)
Return
TRepIss17:
TRIFunc(17)
Return
RepIss17:
RIFunc(17)
Return
TRepIss18:
TRIFunc(18)
Return
RepIss18:
RIFunc(18)
Return
TRepIss19:
TRIFunc(19)
Return
RepIss19:
RIFunc(19)
Return
TRepIss20:
TRIFunc(20)
Return
RepIss20:
RIFunc(20)
Return
TRepIss21:
TRIFunc(21)
Return
RepIss21:
RIFunc(21)
Return
TRepIss22:
TRIFunc(22)
Return
RepIss22:
RIFunc(22)
Return
TRepIss23:
TRIFunc(23)
Return
RepIss23:
RIFunc(23)
Return
TRepIss24:
TRIFunc(24)
Return
RepIss24:
RIFunc(24)
Return
TRepIss25:
TRIFunc(25)
Return
RepIss25:
RIFunc(25)
Return
TRepIss26:
TRIFunc(26)
Return
RepIss26:
RIFunc(26)
Return
TRepIss27:
TRIFunc(27)
Return
RepIss27:
RIFunc(27)
Return
TRepIss28:
TRIFunc(28)
Return
RepIss28:
RIFunc(28)
Return
TRepIss29:
TRIFunc(29)
Return
RepIss29:
RIFunc(29)
Return
TRepIss30:
TRIFunc(30)
Return
RepIss30:
RIFunc(30)
Return
TRepIss31:
TRIFunc(31)
Return
RepIss31:
RIFunc(31)
Return
TRepIss32:
TRIFunc(32)
Return
RepIss32:
RIFunc(32)
Return
TRepIss33:
TRIFunc(33)
Return
RepIss33:
RIFunc(33)
Return
TRepIss34:
TRIFunc(34)
Return
RepIss34:
RIFunc(34)
Return
TRepIss35:
TRIFunc(35)
Return
RepIss35:
RIFunc(35)
Return
TRepIss36:
TRIFunc(36)
Return
RepIss36:
RIFunc(36)
Return
TRepIss37:
TRIFunc(37)
Return
RepIss37:
RIFunc(37)
Return
TRepIss38:
TRIFunc(38)
Return
RepIss38:
RIFunc(38)
Return
TRepIss39:
TRIFunc(39)
Return
RepIss39:
RIFunc(39)
Return
TRepIss40:
TRIFunc(40)
Return
RepIss40:
RIFunc(40)
Return
TRepIss41:
TRIFunc(41)
Return
RepIss41:
RIFunc(41)
Return
TRepIss42:
TRIFunc(42)
Return
RepIss42:
RIFunc(42)
Return
TRepIss43:
TRIFunc(43)
Return
RepIss43:
RIFunc(43)
Return
TRepIss44:
TRIFunc(44)
Return
RepIss44:
RIFunc(44)
Return
TRepIss45:
TRIFunc(45)
Return
RepIss45:
RIFunc(45)
Return
TRepIss46:
TRIFunc(46)
Return
RepIss46:
RIFunc(46)
Return
TRepIss47:
TRIFunc(47)
Return
RepIss47:
RIFunc(47)
Return
TRepIss48:
TRIFunc(48)
Return
RepIss48:
RIFunc(48)
Return

RIFunc(num) {
 Gui,RepIss:Submit,NoHide
	if RepIss%num% = 1
	{
		RINoteArray.Push(RI%num%)
		for i, val in RINoteArray
			ERepIss .= RINoteArray[A_Index] ", "
	} else {
		for index, value in RINoteArray
			if (value = RI%num%)
			{
				RINoteArray.RemoveAt(index)
				for i, val in RINoteArray
					ERepIss .= RINoteArray[A_Index] ", "
			}
	}
	GuiControl,RepIss:,ERepIss,%ERepIss%
}

TRIFunc(num) {
	RINoteArray := Object()
	Gui +LastFound +OwnDialogs +AlwaysOnTop
	InputBox, RepIss%num%,RI%num% Value, Please input RI%num% keywords,,,,,,,,% RI%num%
	IniWrite, % RepIss%num%, .\Lib\MM.ini,ReportedIssue,RI%num%
	IniRead, RI%num%, .\Lib\MM.ini, ReportedIssue,RI%num%
	GuiControl,RepIss:,RepIss%num%,% RepIss%num%
}

RISort:
var =
RIS := []
for key in RIA
	if (RI%A_Index% != "")
		var .= RI%A_Index% "`n"
Sort, var
Loop, parse, var,`n,`n
	RIS.Push(A_LoopField)
for key in RIA
	RI%A_Index% =
for key in RIS
	RI%A_Index% := RIS[A_Index]
for key in RIA
{
	IniWrite, % RI%A_Index%, .\Lib\MM.ini,ReportedIssue,RI%A_Index%
	IniRead, RI%A_Index%, .\Lib\MM.ini, ReportedIssue,RI%A_Index%
	GuiControl,RepIss:,RepIss%A_Index%,% RI%A_Index%
}
Return

ERepIss:
Gui,RepIss:Submit,NoHide
return


RepIssOK:
Gui,RepIss:Submit
StringTrimRight,ERepIss,ERepIss,2
if (REPORTED_ISSUE)
{
	REPORTED_ISSUE := REPORTED_ISSUE ", " ERepIss
	StringReplace, REPORTED_ISSUE, REPORTED_ISSUE, `,`,,`,
	GuiControl,MM:,REPORTED_ISSUE,%REPORTED_ISSUE%
	Gui,MM:Submit,NoHide
}
else
{
	GuiControl,MM:,REPORTED_ISSUE,%ERepIss%
	Gui,MM:Submit,NoHide
}
Return


MMResolutionAction:
Gui,ResAct:Destroy
Gui,MM:Submit,NoHide

RAA := [RA1,RA2,RA3,RA4,RA5,RA6,RA7,RA8,RA9,RA10,RA11,RA12
		,RA13,RA14,RA15,RA16,RA17,RA18,RA19,RA20,RA21,RA22,RA23,RA24
		,RA25,RA26,RA27,RA28,RA29,RA30,RA31,RA32,RA33,RA34,RA35,RA36
		,RA37,RA38,RA39,RA40,RA41,RA42,RA43,RA44,RA45,RA46,RA47,RA48]
for key in RAA
	IniRead, RA%A_Index%, .\Lib\MM.ini, ResolutionAction,RA%A_Index%

global RANoteArray := Object()
EResAct =

Gui,ResAct:Add,Text,x10 y10 w40 h20 gTResAct1 Border,RA1
Gui,ResAct:Add,Checkbox,x50 y10 w300 h20 gResAct1 vResAct1 Border,%RA1%
Gui,ResAct:Add,Text,x370 y10 w40 h20 gTResAct25 Border,RA25
Gui,ResAct:Add,Checkbox,x410 y10 w300 h20 gResAct25 vResAct25 Border,%RA25%
Gui,ResAct:Add,Text,x10 y30 w40 h20 gTResAct2 Border,RA2
Gui,ResAct:Add,Checkbox,x50 y30 w300 h20 gResAct2 vResAct2 Border,%RA2%
Gui,ResAct:Add,Text,x370 y30 w40 h20 gTResAct26 Border,RA26
Gui,ResAct:Add,Checkbox,x410 y30 w300 h20 gResAct26 vResAct26 Border,%RA26%
Gui,ResAct:Add,Text,x10 y50 w40 h20 gTResAct3 Border,RA3
Gui,ResAct:Add,Checkbox,x50 y50 w300 h20 gResAct3 vResAct3 Border,%RA3%
Gui,ResAct:Add,Text,x370 y50 w40 h20 gTResAct27 Border,RA27
Gui,ResAct:Add,Checkbox,x410 y50 w300 h20 gResAct27 vResAct27 Border,%RA27%
Gui,ResAct:Add,Text,x10 y70 w40 h20 gTResAct4 Border,RA4
Gui,ResAct:Add,Checkbox,x50 y70 w300 h20 gResAct4 vResAct4 Border,%RA4%
Gui,ResAct:Add,Text,x370 y70 w40 h20 gTResAct28 Border,RA28
Gui,ResAct:Add,Checkbox,x410 y70 w300 h20 gResAct28 vResAct28 Border,%RA28%
Gui,ResAct:Add,Text,x10 y90 w40 h20 gTResAct5 Border,RA5
Gui,ResAct:Add,Checkbox,x50 y90 w300 h20 gResAct5 vResAct5 Border,%RA5%
Gui,ResAct:Add,Text,x370 y90 w40 h20 gTResAct29 Border,RA29
Gui,ResAct:Add,Checkbox,x410 y90 w300 h20 gResAct29 vResAct29 Border,%RA29%
Gui,ResAct:Add,Text,x10 y110 w40 h20 gTResAct6 Border,RA6
Gui,ResAct:Add,Checkbox,x50 y110 w300 h20 gResAct6 vResAct6 Border,%RA6%
Gui,ResAct:Add,Text,x370 y110 w40 h20 gTResAct30 Border,RA30
Gui,ResAct:Add,Checkbox,x410 y110 w300 h20 gResAct30 vResAct30 Border,%RA30%
Gui,ResAct:Add,Text,x10 y130 w40 h20 gTResAct7 Border,RA7
Gui,ResAct:Add,Checkbox,x50 y130 w300 h20 gResAct7 vResAct7 Border,%RA7%
Gui,ResAct:Add,Text,x370 y130 w40 h20 gTResAct31 Border,RA31
Gui,ResAct:Add,Checkbox,x410 y130 w300 h20 gResAct31 vResAct31 Border,%RA31%
Gui,ResAct:Add,Text,x10 y150 w40 h20 gTResAct8 Border,RA8
Gui,ResAct:Add,Checkbox,x50 y150 w300 h20 gResAct8 vResAct8 Border,%RA8%
Gui,ResAct:Add,Text,x370 y150 w40 h20 gTResAct32 Border,RA32
Gui,ResAct:Add,Checkbox,x410 y150 w300 h20 gResAct32 vResAct32 Border,%RA32%
Gui,ResAct:Add,Text,x10 y170 w40 h20 gTResAct9 Border,RA9
Gui,ResAct:Add,Checkbox,x50 y170 w300 h20 gResAct9 vResAct9 Border,%RA9%
Gui,ResAct:Add,Text,x370 y170 w40 h20 gTResAct33 Border,RA33
Gui,ResAct:Add,Checkbox,x410 y170 w300 h20 gResAct33 vResAct33 Border,%RA33%
Gui,ResAct:Add,Text,x10 y190 w40 h20 gTResAct10 Border,RA10
Gui,ResAct:Add,Checkbox,x50 y190 w300 h20 gResAct10 vResAct10 Border,%RA10%
Gui,ResAct:Add,Text,x370 y190 w40 h20 gTResAct34 Border,RA34
Gui,ResAct:Add,Checkbox,x410 y190 w300 h20 gResAct34 vResAct34 Border,%RA34%
Gui,ResAct:Add,Text,x10 y210 w40 h20 gTResAct11 Border,RA11
Gui,ResAct:Add,Checkbox,x50 y210 w300 h20 gResAct11 vResAct11 Border,%RA11%
Gui,ResAct:Add,Text,x370 y210 w40 h20 gTResAct35 Border,RA35
Gui,ResAct:Add,Checkbox,x410 y210 w300 h20 gResAct35 vResAct35 Border,%RA35%
Gui,ResAct:Add,Text,x10 y230 w40 h20 gTResAct12 Border,RA12
Gui,ResAct:Add,Checkbox,x50 y230 w300 h20 gResAct12 vResAct12 Border,%RA12%
Gui,ResAct:Add,Text,x370 y230 w40 h20 gTResAct36 Border,RA36
Gui,ResAct:Add,Checkbox,x410 y230 w300 h20 gResAct36 vResAct36 Border,%RA36%
Gui,ResAct:Add,Text,x10 y250 w40 h20 gTResAct13 Border,RA13
Gui,ResAct:Add,Checkbox,x50 y250 w300 h20 gResAct13 vResAct13 Border,%RA13%
Gui,ResAct:Add,Text,x370 y250 w40 h20 gTResAct37 Border,RA37
Gui,ResAct:Add,Checkbox,x410 y250 w300 h20 gResAct37 vResAct37 Border,%RA37%
Gui,ResAct:Add,Text,x10 y270 w40 h20 gTResAct14 Border,RA14
Gui,ResAct:Add,Checkbox,x50 y270 w300 h20 gResAct14 vResAct14 Border,%RA14%
Gui,ResAct:Add,Text,x370 y270 w40 h20 gTResAct38 Border,RA38
Gui,ResAct:Add,Checkbox,x410 y270 w300 h20 gResAct38 vResAct38 Border,%RA38%
Gui,ResAct:Add,Text,x10 y290 w40 h20 gTResAct15 Border,RA15
Gui,ResAct:Add,Checkbox,x50 y290 w300 h20 gResAct15 vResAct15 Border,%RA15%
Gui,ResAct:Add,Text,x370 y290 w40 h20 gTResAct39 Border,RA39
Gui,ResAct:Add,Checkbox,x410 y290 w300 h20 gResAct39 vResAct39 Border,%RA39%
Gui,ResAct:Add,Text,x10 y310 w40 h20 gTResAct16 Border,RA16
Gui,ResAct:Add,Checkbox,x50 y310 w300 h20 gResAct16 vResAct16 Border,%RA16%
Gui,ResAct:Add,Text,x370 y310 w40 h20 gTResAct40 Border,RA40
Gui,ResAct:Add,Checkbox,x410 y310 w300 h20 gResAct40 vResAct40 Border,%RA40%
Gui,ResAct:Add,Text,x10 y330 w40 h20 gTResAct17 Border,RA17
Gui,ResAct:Add,Checkbox,x50 y330 w300 h20 gResAct17 vResAct17 Border,%RA17%
Gui,ResAct:Add,Text,x370 y330 w40 h20 gTResAct41 Border,RA41
Gui,ResAct:Add,Checkbox,x410 y330 w300 h20 gResAct41 vResAct41 Border,%RA41%
Gui,ResAct:Add,Text,x10 y350 w40 h20 gTResAct18 Border,RA18
Gui,ResAct:Add,Checkbox,x50 y350 w300 h20 gResAct18 vResAct18 Border,%RA18%
Gui,ResAct:Add,Text,x370 y350 w40 h20 gTResAct42 Border,RA42
Gui,ResAct:Add,Checkbox,x410 y350 w300 h20 gResAct42 vResAct42 Border,%RA42%
Gui,ResAct:Add,Text,x10 y370 w40 h20 gTResAct19 Border,RA19
Gui,ResAct:Add,Checkbox,x50 y370 w300 h20 gResAct19 vResAct19 Border,%RA19%
Gui,ResAct:Add,Text,x370 y370 w40 h20 gTResAct43 Border,RA43
Gui,ResAct:Add,Checkbox,x410 y370 w300 h20 gResAct43 vResAct43 Border,%RA43%
Gui,ResAct:Add,Text,x10 y390 w40 h20 gTResAct20 Border,RA20
Gui,ResAct:Add,Checkbox,x50 y390 w300 h20 gResAct20 vResAct20 Border,%RA20%
Gui,ResAct:Add,Text,x370 y390 w40 h20 gTResAct44 Border,RA44
Gui,ResAct:Add,Checkbox,x410 y390 w300 h20 gResAct44 vResAct44 Border,%RA44%
Gui,ResAct:Add,Text,x10 y410 w40 h20 gTResAct21 Border,RA21
Gui,ResAct:Add,Checkbox,x50 y410 w300 h20 gResAct21 vResAct21 Border,%RA21%
Gui,ResAct:Add,Text,x370 y410 w40 h20 gTResAct45 Border,RA45
Gui,ResAct:Add,Checkbox,x410 y410 w300 h20 gResAct45 vResAct45 Border,%RA45%
Gui,ResAct:Add,Text,x10 y430 w40 h20 gTResAct22 Border,RA22
Gui,ResAct:Add,Checkbox,x50 y430 w300 h20 gResAct22 vResAct22 Border,%RA22%
Gui,ResAct:Add,Text,x370 y430 w40 h20 gTResAct46 Border,RA46
Gui,ResAct:Add,Checkbox,x410 y430 w300 h20 gResAct46 vResAct46 Border,%RA46%
Gui,ResAct:Add,Text,x10 y450 w40 h20 gTResAct23 Border,RA23
Gui,ResAct:Add,Checkbox,x50 y450 w300 h20 gResAct23 vResAct23 Border,%RA23%
Gui,ResAct:Add,Text,x370 y450 w40 h20 gTResAct47 Border,RA47
Gui,ResAct:Add,Checkbox,x410 y450 w300 h20 gResAct47 vResAct47 Border,%RA47%
Gui,ResAct:Add,Text,x10 y470 w40 h20 gTResAct24 Border,RA24
Gui,ResAct:Add,Checkbox,x50 y470 w300 h20 gResAct24 vResAct24 Border,%RA24%
Gui,ResAct:Add,Text,x370 y470 w40 h20 gTResAct48 Border,RA48
Gui,ResAct:Add,Checkbox,x410 y470 w300 h20 gResAct48 vResAct48 Border,%RA48%
Gui,ResAct:Add,Edit,x10 y500 w300 h100 gEResAct vEResAct,%EResAct%
Gui,ResAct:Add,Button,x350 y520 w50 h50 gResActOK,OK
Gui,ResAct:Add,Text,x440 y500 w200 h13 Center,Click on "RA" boxes to edit keywords
Gui,ResAct:Add,Button,x650 y500 w43 h23 gRASort,Sort
Gui,ResAct:Show
Gui,ResAct:+AlwaysOnTop
Return
ResActGuiEscape:
ResActGuiClose:
Gui,ResAct:Destroy
Return


TResAct1:
TRAFunc(1)
Return
ResAct1:
RAFunc(1)
Return
TResAct2:
TRAFunc(2)
Return
ResAct2:
RAFunc(2)
Return
TResAct3:
TRAFunc(3)
Return
ResAct3:
RAFunc(3)
Return
TResAct4:
TRAFunc(4)
Return
ResAct4:
RAFunc(4)
Return
TResAct5:
TRAFunc(5)
Return
ResAct5:
RAFunc(5)
Return
TResAct6:
TRAFunc(6)
Return
ResAct6:
RAFunc(6)
Return
TResAct7:
TRAFunc(7)
Return
ResAct7:
RAFunc(7)
Return
TResAct8:
TRAFunc(8)
Return
ResAct8:
RAFunc(8)
Return
TResAct9:
TRAFunc(9)
Return
ResAct9:
RAFunc(9)
Return
TResAct10:
TRAFunc(10)
Return
ResAct10:
RAFunc(10)
Return
TResAct11:
TRAFunc(11)
Return
ResAct11:
RAFunc(11)
Return
TResAct12:
TRAFunc(12)
Return
ResAct12:
RAFunc(12)
Return
TResAct13:
TRAFunc(13)
Return
ResAct13:
RAFunc(13)
Return
TResAct14:
TRAFunc(14)
Return
ResAct14:
RAFunc(14)
Return
TResAct15:
TRAFunc(15)
Return
ResAct15:
RAFunc(15)
Return
TResAct16:
TRAFunc(16)
Return
ResAct16:
RAFunc(16)
Return
TResAct17:
TRAFunc(17)
Return
ResAct17:
RAFunc(17)
Return
TResAct18:
TRAFunc(18)
Return
ResAct18:
RAFunc(18)
Return
TResAct19:
TRAFunc(19)
Return
ResAct19:
RAFunc(19)
Return
TResAct20:
TRAFunc(20)
Return
ResAct20:
RAFunc(20)
Return
TResAct21:
TRAFunc(21)
Return
ResAct21:
RAFunc(21)
Return
TResAct22:
TRAFunc(22)
Return
ResAct22:
RAFunc(22)
Return
TResAct23:
TRAFunc(23)
Return
ResAct23:
RAFunc(23)
Return
TResAct24:
TRAFunc(24)
Return
ResAct24:
RAFunc(24)
Return
TResAct25:
TRAFunc(25)
Return
ResAct25:
RAFunc(25)
Return
TResAct26:
TRAFunc(26)
Return
ResAct26:
RAFunc(26)
Return
TResAct27:
TRAFunc(27)
Return
ResAct27:
RAFunc(27)
Return
TResAct28:
TRAFunc(28)
Return
ResAct28:
RAFunc(28)
Return
TResAct29:
TRAFunc(29)
Return
ResAct29:
RAFunc(29)
Return
TResAct30:
TRAFunc(30)
Return
ResAct30:
RAFunc(30)
Return
TResAct31:
TRAFunc(31)
Return
ResAct31:
RAFunc(31)
Return
TResAct32:
TRAFunc(32)
Return
ResAct32:
RAFunc(32)
Return
TResAct33:
TRAFunc(33)
Return
ResAct33:
RAFunc(33)
Return
TResAct34:
TRAFunc(34)
Return
ResAct34:
RAFunc(34)
Return
TResAct35:
TRAFunc(35)
Return
ResAct35:
RAFunc(35)
Return
TResAct36:
TRAFunc(36)
Return
ResAct36:
RAFunc(36)
Return
TResAct37:
TRAFunc(37)
Return
ResAct37:
RAFunc(37)
Return
TResAct38:
TRAFunc(38)
Return
ResAct38:
RAFunc(38)
Return
TResAct39:
TRAFunc(39)
Return
ResAct39:
RAFunc(39)
Return
TResAct40:
TRAFunc(40)
Return
ResAct40:
RAFunc(40)
Return
TResAct41:
TRAFunc(41)
Return
ResAct41:
RAFunc(41)
Return
TResAct42:
TRAFunc(42)
Return
ResAct42:
RAFunc(42)
Return
TResAct43:
TRAFunc(43)
Return
ResAct43:
RAFunc(43)
Return
TResAct44:
TRAFunc(44)
Return
ResAct44:
RAFunc(44)
Return
TResAct45:
TRAFunc(45)
Return
ResAct45:
RAFunc(45)
Return
TResAct46:
TRAFunc(46)
Return
ResAct46:
RAFunc(46)
Return
TResAct47:
TRAFunc(47)
Return
ResAct47:
RAFunc(47)
Return
TResAct48:
TRAFunc(48)
Return
ResAct48:
RAFunc(48)
Return

RAFunc(num) {
Gui,ResAct:Submit,NoHide
	if ResAct%num% = 1
	{
		RANoteArray.Push(RA%num%)
		for i, val in RANoteArray
			EResAct .= RANoteArray[A_Index] ", "
	} else {
		for index, value in RANoteArray
			if (value = RA%num%)
			{
				RANoteArray.RemoveAt(index)
				for i, val in RANoteArray
					EResAct .= RANoteArray[A_Index] ", "
			}
	}
	GuiControl,ResAct:,EResAct,%EResAct%
}

TRAFunc(num) {
	RANoteArray := Object()
	Gui +LastFound +OwnDialogs +AlwaysOnTop
	InputBox, ResAct%num%,RA%num% Value, Please input RA%num% keywords,,,,,,,,% RA%num%
	IniWrite, % ResAct%num%, .\Lib\MM.ini,ResolutionAction,RA%num%
	IniRead, RA%num%, .\Lib\MM.ini, ResolutionAction,RA%num%
	GuiControl,ResAct:,ResAct%num%,% ResAct%num%
}

RASort:
var = 
RAS := []
for key in RAA
	if (RA%A_Index% != "")
		var .= RA%A_Index% "`n"
Sort, var
Loop, parse, var,`n,`n
	RAS.Push(A_LoopField)
for key in RAA
	RA%A_Index% =
for key in RAS
	RA%A_Index% := RAS[A_Index]
for key in RAA
{
	IniWrite, % RA%A_Index%, .\Lib\MM.ini,ResolutionAction,RA%A_Index%
	IniRead, RA%A_Index%, .\Lib\MM.ini, ResolutionAction,RA%A_Index%
	GuiControl,ResAct:,ResAct%A_Index%,% RA%A_Index%
}
Return

EResAct:
Gui,ResAct:Submit,NoHide
return

ResActOK:
Gui,ResAct:Submit
StringTrimRight,EResAct,EResAct,2
if (RESOLUTION_ACTION)
{
	RESOLUTION_ACTION := RESOLUTION_ACTION ", " EResAct
	StringReplace, RESOLUTION_ACTION, RESOLUTION_ACTION, `,`,,`,
	GuiControl,MM:,RESOLUTION_ACTION,%RESOLUTION_ACTION%
	Gui,MM:Submit,NoHide
}
else
{
	GuiControl,MM:,RESOLUTION_ACTION,%EResAct%
	Gui,MM:Submit,NoHide
}
return


MMDispatch:
^!#d::
Gui,Dispatch:Destroy
Gui,MM:Submit,NoHide

DPA := [DP1,DP2,DP3,DP4,DP5,DP6,DP7,DP8,DP9,DP10,DP11,DP12
		,DP13,DP14,DP15,DP16,DP17,DP18,DP19,DP20,DP21,DP22,DP23,DP24
		,DP25,DP26,DP27,DP28,DP29,DP30,DP31,DP32,DP33,DP34,DP35,DP36]
for key in DPA
	IniRead, DP%A_Index%, .\Lib\MM.ini, Dispatch,DP%A_Index%

global DPNoteArray := Object()
EDispatch = 

Gui,Dispatch:Add,GroupBox,x10 y10 w210 h270,Redlines/Yellows
Gui,Dispatch:Add,Checkbox,x20 y30 w190 h20 gDispatch25 vDispatch25 Border,Redlines
Gui,Dispatch:Add,Checkbox,x20 y50 w190 h20 gDispatch26 vDispatch26 Border,Down RX Power
Gui,Dispatch:Add,Checkbox,x20 y70 w190 h20 gDispatch27 vDispatch27 Border,Downstream SNR
Gui,Dispatch:Add,Checkbox,x20 y90 w190 h20 gDispatch28 vDispatch28 Border,Upstream TX Power
Gui,Dispatch:Add,Checkbox,x20 y110 w190 h20 gDispatch29 vDispatch29 Border,Upstream SNR CM
Gui,Dispatch:Add,Checkbox,x20 y130 w190 h20 gDispatch30 vDispatch30 Border,Upstream RX Power
Gui,Dispatch:Add,Checkbox,x20 y150 w190 h20 gDispatch31 vDispatch31 Border,Upstream SNR Ch
Gui,Dispatch:Add,Checkbox,x20 y170 w190 h20 gDispatch32 vDispatch32 Border,Upstream Ranging
Gui,Dispatch:Add,Checkbox,x20 y190 w190 h20 gDispatch33 vDispatch33 Border,Upstream ICFR
Gui,Dispatch:Add,Checkbox,x20 y210 w190 h20 gDispatch34 vDispatch34 Border,Upstream Ripples
Gui,Dispatch:Add,Checkbox,x20 y230 w190 h20 gDispatch35 vDispatch35 Border,Upstream Distortion
Gui,Dispatch:Add,Checkbox,x20 y250 w190 h20 gDispatch36 vDispatch36 Border,Test coax for issues
Gui,Dispatch:Add,GroupBox,x230 y10 w360 h510,Custom
Gui,Dispatch:Add,Text,x240 y30 w40 h20 gTDispatch1 Border,DP1
Gui,Dispatch:Add,Checkbox,x280 y30 w300 h20 gDispatch1 vDispatch1 Border,%DP1%
Gui,Dispatch:Add,Text,x240 y50 w40 h20 gTDispatch2 Border,DP2
Gui,Dispatch:Add,Checkbox,x280 y50 w300 h20 gDispatch2 vDispatch2 Border,%DP2%
Gui,Dispatch:Add,Text,x240 y70 w40 h20 gTDispatch3 Border,DP3
Gui,Dispatch:Add,Checkbox,x280 y70 w300 h20 gDispatch3 vDispatch3 Border,%DP3%
Gui,Dispatch:Add,Text,x240 y90 w40 h20 gTDispatch4 Border,DP4
Gui,Dispatch:Add,Checkbox,x280 y90 w300 h20 gDispatch4 vDispatch4 Border,%DP4%
Gui,Dispatch:Add,Text,x240 y110 w40 h20 gTDispatch5 Border,DP5
Gui,Dispatch:Add,Checkbox,x280 y110 w300 h20 gDispatch5 vDispatch5 Border,%DP5%
Gui,Dispatch:Add,Text,x240 y130 w40 h20 gTDispatch6 Border,DP6
Gui,Dispatch:Add,Checkbox,x280 y130 w300 h20 gDispatch6 vDispatch6 Border,%DP6%
Gui,Dispatch:Add,Text,x240 y150 w40 h20 gTDispatch7 Border,DP7
Gui,Dispatch:Add,Checkbox,x280 y150 w300 h20 gDispatch7 vDispatch7 Border,%DP7%
Gui,Dispatch:Add,Text,x240 y170 w40 h20 gTDispatch8 Border,DP8
Gui,Dispatch:Add,Checkbox,x280 y170 w300 h20 gDispatch8 vDispatch8 Border,%DP8%
Gui,Dispatch:Add,Text,x240 y190 w40 h20 gTDispatch9 Border,DP9
Gui,Dispatch:Add,Checkbox,x280 y190 w300 h20 gDispatch9 vDispatch9 Border,%DP9%
Gui,Dispatch:Add,Text,x240 y210 w40 h20 gTDispatch10 Border,DP10
Gui,Dispatch:Add,Checkbox,x280 y210 w300 h20 gDispatch10 vDispatch10 Border,%DP10%
Gui,Dispatch:Add,Text,x240 y230 w40 h20 gTDispatch11 Border,DP11
Gui,Dispatch:Add,Checkbox,x280 y230 w300 h20 gDispatch11 vDispatch11 Border,%DP11%
Gui,Dispatch:Add,Text,x240 y250 w40 h20 gTDispatch12 Border,DP12
Gui,Dispatch:Add,Checkbox,x280 y250 w300 h20 gDispatch12 vDispatch12 Border,%DP12%
Gui,Dispatch:Add,Text,x240 y270 w40 h20 gTDispatch13 Border,DP13
Gui,Dispatch:Add,Checkbox,x280 y270 w300 h20 gDispatch13 vDispatch13 Border,%DP13%
Gui,Dispatch:Add,Text,x240 y290 w40 h20 gTDispatch14 Border,DP14
Gui,Dispatch:Add,Checkbox,x280 y290 w300 h20 gDispatch14 vDispatch14 Border,%DP14%
Gui,Dispatch:Add,Text,x240 y310 w40 h20 gTDispatch15 Border,DP15
Gui,Dispatch:Add,Checkbox,x280 y310 w300 h20 gDispatch15 vDispatch15 Border,%DP15%
Gui,Dispatch:Add,Text,x240 y330 w40 h20 gTDispatch16 Border,DP16
Gui,Dispatch:Add,Checkbox,x280 y330 w300 h20 gDispatch16 vDispatch16 Border,%DP16%
Gui,Dispatch:Add,Text,x240 y350 w40 h20 gTDispatch17 Border,DP17
Gui,Dispatch:Add,Checkbox,x280 y350 w300 h20 gDispatch17 vDispatch17 Border,%DP17%
Gui,Dispatch:Add,Text,x240 y370 w40 h20 gTDispatch18 Border,DP18
Gui,Dispatch:Add,Checkbox,x280 y370 w300 h20 gDispatch18 vDispatch18 Border,%DP18%
Gui,Dispatch:Add,Text,x240 y390 w40 h20 gTDispatch19 Border,DP19
Gui,Dispatch:Add,Checkbox,x280 y390 w300 h20 gDispatch19 vDispatch19 Border,%DP19%
Gui,Dispatch:Add,Text,x240 y410 w40 h20 gTDispatch20 Border,DP20
Gui,Dispatch:Add,Checkbox,x280 y410 w300 h20 gDispatch20 vDispatch20 Border,%DP20%
Gui,Dispatch:Add,Text,x240 y430 w40 h20 gTDispatch21 Border,DP21
Gui,Dispatch:Add,Checkbox,x280 y430 w300 h20 gDispatch21 vDispatch21 Border,%DP21%
Gui,Dispatch:Add,Text,x240 y450 w40 h20 gTDispatch22 Border,DP22
Gui,Dispatch:Add,Checkbox,x280 y450 w300 h20 gDispatch22 vDispatch22 Border,%DP22%
Gui,Dispatch:Add,Text,x240 y470 w40 h20 gTDispatch23 Border,DP23
Gui,Dispatch:Add,Checkbox,x280 y470 w300 h20 gDispatch23 vDispatch23 Border,%DP23%
Gui,Dispatch:Add,Text,x240 y490 w40 h20 gTDispatch24 Border,DP24
Gui,Dispatch:Add,Checkbox,x280 y490 w300 h20 gDispatch24 vDispatch24 Border,%DP24%
Gui,Dispatch:Add,Edit,x10 y290 w210 h100 gEDispatch vEDispatch,%Edispatch%
Gui,Dispatch:Add,Text,x10 y390 w210 h13 vmax91,(%max91%) of max 91    [ yellow if over ]
Gui,Dispatch:Add,Text,x10 y405 w210 h13 vmax190,(%max190%) of max 190    [ red if over ]
Gui,Dispatch:Add,Button,x70 y420 w80 h40 gDOK Default,OK
Gui,Dispatch:Add,Text,x10 y470 w200 h13 Center,Click on "DP" boxes to edit values
Gui,Dispatch:Add,Button,x90 y490 w43 h23 gDPSort,Sort

Gui,Dispatch:Show
Gui,Dispatch:+AlwaysOnTop
StringLen, max91, EDispatch
StringLen, max190, EDispatch
GuiControl,Dispatch:,max91,(%max91%) of max 91    [ yellow if over ]
GuiControl,Dispatch:,max190,(%max190%) of max 190    [ red if over ]
Return
DispatchGuiEscape:
DispatchGuiClose:
Gui,Dispatch:Destroy
Return

TDispatch1:
TDispatchFunc(1)
Return
Dispatch1:
Dispatch(1)
Return
TDispatch2:
TDispatchFunc(2)
Return
Dispatch2:
Dispatch(2)
Return
TDispatch3:
TDispatchFunc(3)
Return
Dispatch3:
Dispatch(3)
Return
TDispatch4:
TDispatchFunc(4)
Return
Dispatch4:
Dispatch(4)
Return
TDispatch5:
TDispatchFunc(5)
Return
Dispatch5:
Dispatch(5)
Return
TDispatch6:
TDispatchFunc(6)
Return
Dispatch6:
Dispatch(6)
Return
TDispatch7:
TDispatchFunc(7)
Return
Dispatch7:
Dispatch(7)
Return
TDispatch8:
TDispatchFunc(8)
Return
Dispatch8:
Dispatch(8)
Return
TDispatch9:
TDispatchFunc(9)
Return
Dispatch9:
Dispatch(9)
Return
TDispatch10:
TDispatchFunc(10)
Return
Dispatch10:
Dispatch(10)
Return
TDispatch11:
TDispatchFunc(11)
Return
Dispatch11:
Dispatch(11)
Return
TDispatch12:
TDispatchFunc(12)
Return
Dispatch12:
Dispatch(12)
Return
TDispatch13:
TDispatchFunc(13)
Return
Dispatch13:
Dispatch(13)
Return
TDispatch14:
TDispatchFunc(14)
Return
Dispatch14:
Dispatch(14)
Return
TDispatch15:
TDispatchFunc(15)
Return
Dispatch15:
Dispatch(15)
Return
TDispatch16:
TDispatchFunc(16)
Return
Dispatch16:
Dispatch(16)
Return
TDispatch17:
TDispatchFunc(17)
Return
Dispatch17:
Dispatch(17)
Return
TDispatch18:
TDispatchFunc(18)
Return
Dispatch18:
Dispatch(18)
Return
TDispatch19:
TDispatchFunc(19)
Return
Dispatch19:
Dispatch(19)
Return
TDispatch20:
TDispatchFunc(20)
Return
Dispatch20:
Dispatch(20)
Return
TDispatch21:
TDispatchFunc(21)
Return
Dispatch21:
Dispatch(21)
Return
TDispatch22:
TDispatchFunc(22)
Return
Dispatch22:
Dispatch(22)
Return
TDispatch23:
TDispatchFunc(23)
Return
Dispatch23:
Dispatch(23)
Return
TDispatch24:
TDispatchFunc(24)
Return
Dispatch24:
Dispatch(24)
Return


Dispatch25:
Dispatch(25)
Return
Dispatch26:
Dispatch(26)
Return
Dispatch27:
Dispatch(27)
Return
Dispatch28:
Dispatch(28)
Return
Dispatch29:
Dispatch(29)
Return
Dispatch30:
Dispatch(30)
Return
Dispatch31:
Dispatch(31)
Return
Dispatch32:
Dispatch(32)
Return
Dispatch33:
Dispatch(33)
Return
Dispatch34:
Dispatch(34)
Return
Dispatch35:
Dispatch(35)
Return
Dispatch36:
Dispatch(36)
Return

Dispatch(num) {
Gui,Dispatch:Submit,NoHide
	if Dispatch%num% = 1
	{
		DPNoteArray.Push(DP%num%)
		for i, val in DPNoteArray
			EDispatch .= DPNoteArray[A_Index] ", "
	} else {
		for index, value in DPNoteArray
			if (value = DP%num%)
			{
				DPNoteArray.RemoveAt(index)
				for i, val in DPNoteArray
					EDispatch .= DPNoteArray[A_Index] ", "
			}
	}
	GuiControl,Dispatch:,EDispatch,%EDispatch%
	StringLen, max91, EDispatch
	StringLen, max190, EDispatch
	GuiControl,Dispatch:,max91,(%max91%) of max 91    [ yellow if over ]
	GuiControl,Dispatch:,max190,(%max190%) of max 190    [ red if over ]
	if (max91 > 91)
		Gui,Color,,FFFF00
	else
		Gui,Color,,FFFFFF
	if (max190 > 190)
		Gui,Color,,FF0000
}

TDispatchFunc(num) {
	DPNoteArray := Object()
	Gui +LastFound +OwnDialogs +AlwaysOnTop
	InputBox, Dispatch%num%,DP%num% Value, Please input DP%num% keywords,,,,,,,,% DP%num%
	IniWrite, % Dispatch%num%, .\Lib\MM.ini,Dispatch,DP%num%
	IniRead, DP%num%, .\Lib\MM.ini, Dispatch,DP%num%
	GuiControl,Dispatch:,Dispatch%num%,% Dispatch%num%
}

DPSort:
var =
;ONLY NEED TO SORT FIRST 24 DP's IN DPA
DPA := [DP1,DP2,DP3,DP4,DP5,DP6,DP7,DP8,DP9,DP10,DP11,DP12
		,DP13,DP14,DP15,DP16,DP17,DP18,DP19,DP20,DP21,DP22,DP23,DP24]
DPS := []
for key in DPA
	if (DP%A_Index% != "")
		var .= DP%A_Index% "`n"
Sort, var
Loop, parse, var,`n,`n
	DPS.Push(A_LoopField)
for key in DPA
	DP%A_Index% =
for key in DPS
	DP%A_Index% := DPS[A_Index]
for key in DPA
{
	IniWrite, % DP%A_Index%, .\Lib\MM.ini,Dispatch,DP%A_Index%
	IniRead, DP%A_Index%, .\Lib\MM.ini,Dispatch,DP%A_Index%
	GuiControl,Dispatch:,Dispatch%A_Index%,% DP%A_Index%
}
;NEED TO RESTORE ALL 36 DP's IN DPA
DPA := [DP1,DP2,DP3,DP4,DP5,DP6,DP7,DP8,DP9,DP10,DP11,DP12
		,DP13,DP14,DP15,DP16,DP17,DP18,DP19,DP20,DP21,DP22,DP23,DP24
		,DP25,DP26,DP27,DP28,DP29,DP30,DP31,DP32,DP33,DP34,DP35,DP36]
Return


EDispatch:
Gui,Dispatch:Submit,NoHide
StringLen, max91, EDispatch
StringLen, max190, EDispatch
GuiControl,Dispatch:,max91,(%max91%) of max 91    [ yellow if over ]
GuiControl,Dispatch:,max190,(%max190%) of max 190    [ red if over ]
if (max91 > 91)
	Gui,Color,,FFFF00
else
	Gui,Color,,FFFFFF
if (max190 > 190)
	Gui,Color,,FF0000
Return


DOK:
Gui,Dispatch:Submit
IfWinExist, TruckRoll Schedule
{
	WinActivate, TruckRoll Schedule
	Clipboard := EDispatch
	Send, ^a
	Send, ^v
}
else IfWinExist, TruckRoll Reschedule
{
	WinActivate, TruckRoll Reschedule
	Clipboard := EDispatch
	Send, ^a
	Send, ^v
}

if (RESOLUTION_ACTION)
{
	RESOLUTION_ACTION := RESOLUTION_ACTION ", " EDispatch
	StringReplace, RESOLUTION_ACTION, RESOLUTION_ACTION, `,`,,`,
	GuiControl,MM:,RESOLUTION_ACTION,%RESOLUTION_ACTION%
	GuiControl,MM:Choose,NEXT_ACTION,2
	Gui,MM:Submit,NoHide
}
else
{
	GuiControl,MM:,RESOLUTION_ACTION,%EDispatch%
	GuiControl,MM:Choose,NEXT_ACTION,2
	Gui,MM:Submit,NoHide
}
Return
