#SingleInstance, Force

Menu,Tray,Icon, Lib\Pics\S4.ico
Menu,Tray,NoStandard
Menu,Tray,Add,Unhide,S4Unhide
Menu,Tray,Add,Close,S4Close
Menu,Tray,Add,Reset,S4Reset

global POINTS := 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DEFAULT SENTENCES ASSIGNED TO VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Greeting := "Thank you for choosing Telecom, My name is ________. How may I help you today?"
Reflect := "I understand you're calling about ________."
Relate := "I can understand your frustration with ________."
Own := "You have reached the right person in the right department."
Auth := "May I ask you a few questions to authenticate your account?"
Phone := "In case we get disconnect, if (phone#) the best way to call you back?"
Obtain := "Lets take a closer look at what is going on."
Resolve := "Can you confirm that everything is now working as expected?"
Build := "We also have self help options available at xfinity.com/help"
Transition := "Now that we have resolved all of your issues, What are you doing for ________ services?"
Present := "Based on what you shared with me about ________, we offer ________."
Overcome := "I want to recommend the best product based on what you shared with me."
Ask := "We stand by our products and services with our Telecom Customer Guarantee."
Verification := "We should make sure we have the best contact information on record."
Bill := "Would you like to enroll in auto pay at this time?"
Today := "You can always manage you billing options with MyAccount app, or pay your bill online."
Expectation := "Is there anything else I can help you with? Thank you for being the best part of Telecom."
Documentation := "I documented this interaction with reference number CR________ (give details)."
Tone := "Use professional, pleasant, upbeat, and energetic tone, using appropriate pleasantries."
Listen := "Provide frequent indication of active listening, do not interrupt or talk over customer."
ContactM := "Minimize pauses and dead air to 20 seconds or less, with pauses being brief and explained."
Acknowledge := "Take ownership of the customers concern and use positive word choices."
Rapport := "Maintaine a genuine concern for customer, acknowledge customers feelings as appropriate."

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; USE ARRAYS TO HELP READ INI FILE CONTENTS INTO VARIABLES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ACTUAL VARIABLE NAMES TO USE THROUGHOUT THE SCRIPT
global ArrayA := ["Greeting", "Reflect", "Relate", "Own", "Auth", "Phone", "Obtain", "Present", "Overcome", "Resolve", "Ask", "Email", "Build", "Transition", "Verification", "Bill", "Today", "Expectation", "Documentation", "Tone", "Listen", "ContactM", "Acknowledge", "Rapport"]

; DEFAULT SENTENCES TO USE AS DEFINED ABOVE
global ArrayB := [Greeting, Reflect, Relate, Own, Auth, Phone, Obtain, Present, Overcome, Resolve, Ask, Email, Build, Transition, Verification, Bill, Today, Expectation, Documentation, Tone, Listen, ContactM, Acknowledge, Rapport]

; CUSTOM SENTENCES TO USE FROM INI FILE
global ArrayC := ["EGreeting", "EReflect", "ERelate", "EOwn", "EAuth", "EPhone", "EObtain", "EPresent", "EOvercome", "EResolve", "EAsk", "EEmail", "EBuild", "ETransition", "EVerification", "EBill", "EToday", "EExpectation", "EDocumentation", "ETone", "EListen", "EContactM", "EAcknowledge", "ERapport"]

; PROGRESSBAR NOT RETAINING PROGRESS
; SCRIPT WILL PICKUP AND START HERE WHEN YOU UNHIDE
S4Unhide:

For key in ArrayA
{
	raya := ArrayA[A_Index]
	rayb := ArrayB[A_Index]
	rayc := ArrayC[A_Index]
	IniRead, %raya%, .\Lib\S4.ini, Custom, %rayc%, %rayb%
}

IniRead, S4X, .\Lib\S4.ini, S4WinPos, XPos, 0
IniRead, S4Y, .\Lib\S4.ini, S4WinPos, YPos, 0
IniRead, S4OnTop, .\Lib\S4.ini, S4AlwaysOnTop, AlwaysOnTop , 0
IniRead, S4Theme, .\Lib\S4.ini, S4Theme, Theme , 0
if S4Theme
{
	IniRead, S4BackgroundColor, .\Lib\S4.ini, S4Theme, BackgroundColor, F0F0F0
	IniRead, S4ControlColor, .\Lib\S4.ini, S4Theme, ControlColor, FFFFFF
	IniRead, S4TextColor, .\Lib\S4.ini, S4Theme, TextColor, 000000
} else {
	IniRead, S4BackgroundColor, .\Lib\S4.ini, S4Theme, DefaultBackgroundColor, F0F0F0
	IniRead, S4ControlColor, .\Lib\S4.ini, S4Theme, DefaultControlColor, FFFFFF
	IniRead, S4TextColor, .\Lib\S4.ini, S4Theme, DefaultTextColor, 000000
}

Gui,S4Checklist:Destroy
Gui,S4Checklist:Color,%S4BackgroundColor%,%S4ControlColor%
Gui,S4Checklist:Font,c%S4TextColor%

Gui,S4Checklist:Add,Picture,x10 y10 w227 h42,Lib\Pics\S4Checklist.png
Gui,S4Checklist:Add,Button,x280 y20 w50 h23 gS4Reset vS4Reset,Reset
Gui,S4Checklist:Add,Button,x350 y20 w43 h23 gS4Hide vS4Hide,Hide
Gui,S4Checklist:Add,Button,x410 y20 w50 h23 gS4Defaults vS4Defaults,Defaults
Gui,S4Checklist:Add,Button,x480 y20 w43 h23 gS4Close vS4Close,Close
Gui,S4Checklist:Add,Button,x540 y20 w60 h20 gS4SetXY vS4SetXY,Set X/Y
Gui,S4Checklist:Add,Button,x630 y20 w60 h20 gS4Colors vS4Colors,Set Colors
Gui,S4Checklist:Add,Text,x540 y40 w60 h13 vS4XText,X =  %S4X%
Gui,S4Checklist:Add,Text,x210 y50 w30 h13,v1.0
Gui,S4Checklist:Add,Checkbox,x350 y50 w60 h13 gS4OnTop vS4OnTop,On Top
Gui,S4Checklist:Add,Checkbox,x630 y50 w55 h13 gS4Theme vS4Theme,Theme
Gui,S4Checklist:Add,Text,x540 y55 w60 h13 vS4YText,Y =  %S4Y%
Gui,S4Checklist:Add,Text,x40 y60 w60 h13 Border,S1 - START
Gui,S4Checklist:Add,Edit,x240 y75 w450 h21 gEGreeting vEGreeting,%Greeting%
Gui,S4Checklist:Add,Text,x10 y80 w20 h13 Center,(3)
Gui,S4Checklist:Add,Checkbox,x40 y80 w65 h13 gGreeting vGreeting,Greeting
Gui,S4Checklist:Add,Edit,x240 y95 w450 h21 gEReflect vEReflect,%Reflect%
Gui,S4Checklist:Add,Text,x10 y100 w20 h13 Center,(5)
Gui,S4Checklist:Add,Checkbox,x40 y100 w150 h13 gReflect vReflect,Reflect Reason for Contact
Gui,S4Checklist:Add,Edit,x240 y115 w450 h21 gERelate vERelate,%Relate%
Gui,S4Checklist:Add,Text,x10 y120 w20 h13 Center,(5)
Gui,S4Checklist:Add,Checkbox,x40 y120 w120 h13 gRelate vRelate,Relate / Empathize
Gui,S4Checklist:Add,Edit,x240 y135 w450 h21 gEOwn vEOwn,%Own%
Gui,S4Checklist:Add,Text,x10 y140 w20 h13 Center,(5)
Gui,S4Checklist:Add,Checkbox,x40 y140 w200 h13 gOwn vOwn,Take Ownership / Assure Assistance
Gui,S4Checklist:Add,Edit,x240 y155 w450 h21 gEAuth vEAuth,%Auth%
Gui,S4Checklist:Add,Text,x10 y160 w20 h13 Center,(4)
Gui,S4Checklist:Add,Checkbox,x40 y160 w150 h13 gAuth vAuth,Authentication/Set Agenda
Gui,S4Checklist:Add,Checkbox,x60 y190 w120 h13 vTN,Telephone Number
Gui,S4Checklist:Add,Checkbox,x210 y190 w100 h13 vCN,Customer Name
Gui,S4Checklist:Add,Checkbox,x330 y190 w70 h13 vAddress,Address
Gui,S4Checklist:Add,Checkbox,x420 y190 w150 h13 vSSN,SSN / Acct # / PIN / Pay
Gui,S4Checklist:Add,Checkbox,x590 y190 w80 h13 vCCDV,Called CDV
Gui,S4Checklist:Add,Edit,x240 y220 w450 h21 gEPhone vEPhone,%Phone%
Gui,S4Checklist:Add,Checkbox,x60 y225 w140 h13 gPhone vPhone,Best Phone for Call back
Gui,S4Checklist:Add,Text,x40 y260 w60 h13 Border,S2 - SOLVE
Gui,S4Checklist:Add,Edit,x240 y270 w450 h21 gEObtain vEObtain,%Obtain%
Gui,S4Checklist:Add,Text,x10 y280 w20 h13 Center,(7)
Gui,S4Checklist:Add,Checkbox,x40 y280 w170 h13 gObtain vObtain,Obtain Info/Probe Problem
Gui,S4Checklist:Add,Edit,x240 y290 w450 h21 gEResolve vEResolve,%Resolve%
Gui,S4Checklist:Add,Text,x10 y300 w20 h13 Center,(14)
Gui,S4Checklist:Add,Checkbox,x40 y300 w150 h13 gResolve vResolve,Resolve/Address Issue
Gui,S4Checklist:Add,Edit,x240 y310 w450 h21 gEBuild vEBuild,%Build%
Gui,S4Checklist:Add,Text,x10 y320 w20 h13 Center,(6)
Gui,S4Checklist:Add,Checkbox,x40 y320 w170 h13 gBuild vBuild,Build Value / Enhance
Gui,S4Checklist:Add,Text,x40 y350 w160 h13 Border,S3 - SELL / APPS / SELF HELP
Gui,S4Checklist:Add,Edit,x240 y360 w450 h21 gETransition vETransition,%Transition%
Gui,S4Checklist:Add,Text,x10 y370 w20 h13 Center,(6)
Gui,S4Checklist:Add,Checkbox,x40 y370 w170 h13 gTransition vTransition,Transition to Relevant Offer
Gui,S4Checklist:Add,Edit,x240 y380 w450 h21 gEPresent vEPresent,%Present%
Gui,S4Checklist:Add,Text,x10 y390 w21 h13 Center,(6)
Gui,S4Checklist:Add,Checkbox,x40 y390 w100 h13 gPresent vPresent,Present Offer
Gui,S4Checklist:Add,Edit,x240 y400 w450 h21 gEOvercome vEOvercome,%Overcome%
Gui,S4Checklist:Add,Text,x10 y410 w21 h13 Center,(4)
Gui,S4Checklist:Add,Checkbox,x40 y410 w130 h13 gOvercome vOvercome,Overcome Objections
Gui,S4Checklist:Add,Edit,x240 y420 w450 h21 gEAsk vEAsk,%Ask%
Gui,S4Checklist:Add,Text,x10 y430 w21 h13 Center,(4)
Gui,S4Checklist:Add,Checkbox,x40 y430 w110 h13 gAsk vAsk,Ask for the Sale
Gui,S4Checklist:Add,Text,x40 y460 w120 h13 Border,S4 - G'BYE Elements
Gui,S4Checklist:Add,Edit,x240 y470 w450 h21 gEVerification vEVerification,%Verification%
Gui,S4Checklist:Add,Text,x10 y480 w20 h13 Center,(3)
Gui,S4Checklist:Add,Checkbox,x40 y480 w115 h13 gVerification vVerification,Get Verification
Gui,S4Checklist:Add,Edit,x240 y490 w450 h21 gEBill vEBill,%Bill%
Gui,S4Checklist:Add,Text,x10 y500 w20 h13 Center,(4)
Gui,S4Checklist:Add,Checkbox,x40 y500 w70 h13 gBill vBill,Bill Recap
Gui,S4Checklist:Add,Edit,x240 y510 w450 h21 gEToday vEToday,%Today%
Gui,S4Checklist:Add,Text,x10 y520 w20 h13 Center,(1)
Gui,S4Checklist:Add,Checkbox,x40 y520 w120 h13 gToday vToday,You Can Start Today
Gui,S4Checklist:Add,Edit,x240 y530 w450 h21 gEExpectation vEExpectation,%Expectation%
Gui,S4Checklist:Add,Text,x10 y540 w21 h13 Center,(3)
Gui,S4Checklist:Add,Checkbox,x40 y540 w190 h13 gExpectation vExpectation,Expectation/End on Positive Note
Gui,S4Checklist:Add,Edit,x240 y550 w450 h21 gEDocumentation vEDocumentation,%Documentation%
Gui,S4Checklist:Add,Text,x10 y560 w21 h13 Center,(3)
Gui,S4Checklist:Add,Checkbox,x40 y560 w100 h13 gDocumentation vDocumentation,Documentation
Gui,S4Checklist:Add,Text,x40 y590 w70 h13 Border,BEHAVIORS
Gui,S4Checklist:Add,Edit,x240 y600 w450 h21 gETone vETone ReadOnly,%Tone%
Gui,S4Checklist:Add,Text,x10 y610 w20 h13 Center,(3)
Gui,S4Checklist:Add,Checkbox,x40 y610 w150 h13 gTone vTone,Tone, Confidence, Clarity
Gui,S4Checklist:Add,Edit,x240 y620 w450 h21 gEListen vEListen ReadOnly,%Listen%
Gui,S4Checklist:Add,Text,x10 y630 w20 h13 Center,(3)
Gui,S4Checklist:Add,Checkbox,x40 y630 w100 h13 gListen vListen,Active Listening
Gui,S4Checklist:Add,Edit,x240 y640 w450 h21 gEContactM vEContactM ReadOnly,%ContactM%
Gui,S4Checklist:Add,Text,x10 y650 w20 h13 Center,(3)
Gui,S4Checklist:Add,Checkbox,x40 y650 w130 h13 gContactM vContactM,Contact Management
Gui,S4Checklist:Add,Edit,x240 y660 w450 h21 gEAcknowledge vEAcknowledge ReadOnly,%Acknowledge%
Gui,S4Checklist:Add,Text,x10 y670 w20 h13 Center,(4)
Gui,S4Checklist:Add,Checkbox,x40 y670 w190 h13 gAcknowledge vAcknowledge,Acknowledge/Take Responsibility
Gui,S4Checklist:Add,Edit,x240 y680 w450 h21 gERapport vERapport ReadOnly,%Rapport%
Gui,S4Checklist:Add,Text,x10 y690 w20 h13 Center,(4)
Gui,S4Checklist:Add,Checkbox,x40 y690 w200 h13 gRapport vRapport,Build Rapport/Demonstrate Concern
Gui,S4Checklist:Add,Text,x10 y720 w130 h13 vTPOINTS,Total Points  = (%Points%) of 100
Gui,S4Checklist:Add,Progress,x150 y720 w490 h20 vProgress Border Range-0-104,0

Gui,S4Checklist:Show, x%S4X% y%S4Y% w700 h760,S4 Checklist

if S4OnTop
	Gui,S4Checklist:+AlwaysOnTop 
else 
	Gui,S4Checklist:-AlwaysOnTop 

if S4Theme
{
	GuiControl,S4Checklist:,Button8,1
	GuiControl,S4Checklist:Enable,S4Colors
}
else
{
	GuiControl,S4Checklist:,Button8,0
	GuiControl,S4Checklist:Disable,S4Colors
}
	
GuiControl, S4Checklist:, S4OnTop, %S4OnTop%
GuiControl, S4Checklist:, S4Theme, %S4Theme%

OnMessage(0x200,"WM_MOUSEMOVE_FUNC")
S4Reset_TT := "Will reset all the checkbox's, make ready for new customer."
S4Hide_TT := "Will Hide the Checklist. Right click tray icon to unhide."
S4Defaults_TT := "Will set the Colors, X/Y coordinates, and custom sentences back to defaults."
S4Close_TT := "Will exit the S4 Checklist."
S4SetXY_TT := "Will set the X/Y coordinates to always open checklist in a certain spot on your monitor."
S4Colors_TT := "Will set the Background, Edit boxes, and font color of the checklist."

Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; END INITIALIZATION 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



S4Theme:
Gui, S4Checklist:Submit,NoHide
if S4Theme
{
	IniRead, S4BackgroundColor, .\Lib\S4.ini, S4Theme, BackgroundColor, F0F0F0
	IniRead, S4ControlColor, .\Lib\S4.ini, S4Theme, ControlColor, White
	IniRead, S4TextColor, .\Lib\S4.ini, S4Theme, TextColor, Black
	IniWrite, 1, .\Lib\S4.ini, S4Theme, Theme
	Gosub, S4Unhide
} else {
	IniWrite, 0, .\Lib\S4.ini, S4Theme, Theme
	IniRead, S4BackgroundColor, .\Lib\S4.ini, S4Theme, DefaultBackgroundColor, F0F0F0
	IniRead, S4ControlColor, .\Lib\S4.ini, S4Theme, DefaultControlColor, White
	IniRead, S4TextColor, .\Lib\S4.ini, S4Theme, DefaultTextColor, Black
	Gosub, S4Unhide
}
Return


S4Colors:
Gui,S4Colors:Add,GroupBox,x10 y10 w200 h190,Set Theme Colors
Gui,S4Colors:Add,Text,x30 y30 w150 h40,Select colors from down down or specify your own HTML RRGGBB color notation.
Gui,S4Colors:Add,Text,x20 y80 w60 h13,Backgound
Gui,S4Colors:Add,ComboBox,x80 y80 w120 gS4ColorSubmit vS4BackgroundColor,%S4BackgroundColor%||Aqua|Black|Blue|Fuchsia|Gray|Green|Lime|Maroon|Navy|Olive|Purple|Red|Silver|Teal|White|Yellow
Gui,S4Colors:Add,Text,x20 y110 w60 h13,Edit Boxes
Gui,S4Colors:Add,ComboBox,x80 y110 w120 gS4ColorSubmit vS4ControlColor,%S4ControlColor%||Aqua|Black|Blue|Fuchsia|Gray|Green|Lime|Maroon|Navy|Olive|Purple|Red|Silver|Teal|White|Yellow
Gui,S4Colors:Add,Text,x20 y140 w60 h13,Text
Gui,S4Colors:Add,ComboBox,x80 y140 w120 gS4ColorSubmit vS4TextColor,%S4TextColor%||Aqua|Black|Blue|Fuchsia|Gray|Green|Lime|Maroon|Navy|Olive|Purple|Red|Silver|Teal|White|Yellow
Gui,S4Colors:Add,Button,x100 y170 w100 h23 gS4ColorsOK vS4ColorsOK Default,OK
Gui,S4Colors:Add,Picture,x10 y210,.\Lib\ColorChart.png
Gui,S4Colors:Show
Gui,S4Colors:+AlwaysOnTop
Return
S4ColorsGuiEscape:
S4ColorsGuiClose:
Gui,S4Colors:Destroy
Return
S4ColorSubmit:
Gui,S4Colors:Submit,Nohide
Return
S4ColorsOK:
Gui,S4Colors:Submit
Gui,S4Colors:Destroy
IniWrite, 1, .\Lib\S4.ini, S4Theme, Theme
IniWrite, %S4BackgroundColor%, .\Lib\S4.ini, S4Theme, BackgroundColor
IniWrite, %S4ControlColor%, .\Lib\S4.ini, S4Theme, ControlColor
IniWrite, %S4TextColor%, .\Lib\S4.ini, S4Theme, TextColor
Gosub,S4Unhide
Return


S4SetXY:
Gui,S4Checklist:Submit,Nohide
WinGetPos, S4X, S4Y, , , S4 Checklist
IniWrite, %S4X%, .\Lib\S4.ini, S4WinPos, XPos
IniWrite, %S4Y%, .\Lib\S4.ini, S4WinPos, YPos
GuiControl,S4Checklist:,S4XText,X =  %S4X%
GuiControl,S4Checklist:,S4YText,Y =  %S4Y%
Return


S4OnTop:
Gui,S4Checklist:Submit,Nohide
If S4OnTop = 1
{
	Gui,S4Checklist:+AlwaysOnTop
	IniWrite, 1, .\Lib\S4.ini, S4AlwaysOnTop, AlwaysOnTop
}
else
{
	Gui,S4Checklist:-AlwaysOnTop
	IniWrite, 0, .\Lib\S4.ini, S4AlwaysOnTop, AlwaysOnTop
}
Return


Greeting:
Gui,S4Checklist:Submit,Nohide
Calculate(Greeting, 3, EGreeting)
return


EGreeting:
Gui,S4Checklist:Submit,Nohide
Write_INI(EGreeting,"EGreeting")
return


Reflect:
Gui,S4Checklist:Submit,Nohide
Calculate(Reflect, 5, EReflect)
return


EReflect:
Gui,S4Checklist:Submit,Nohide
Write_INI(EReflect,"EReflect")
return


Relate:
Gui,S4Checklist:Submit,Nohide
Calculate(Relate, 5, ERelate)
return


ERelate:
Gui,S4Checklist:Submit,Nohide
Write_INI(ERelate,"ERelate")
return


Own:
Gui,S4Checklist:Submit,Nohide
Calculate(Own, 5, EOwn)
return


EOwn:
Gui,S4Checklist:Submit,Nohide
Write_INI(EOwn,"EOwn")
return


Auth:
Gui,S4Checklist:Submit,Nohide
Calculate(Auth, 4, EAuth)
return


EAuth:
Gui,S4Checklist:Submit,Nohide
Write_INI(EAuth,"EAuth")
return


Phone:
Gui,S4Checklist:Submit,Nohide
Calculate(Phone, 0, EPhone)
return


EPhone:
Gui,S4Checklist:Submit,Nohide
Write_INI(EPhone,"EPhone")
return


Obtain:
Gui,S4Checklist:Submit,Nohide
Calculate(Obtain, 7, EObtain)
return


EObtain:
Gui,S4Checklist:Submit,Nohide
Write_INI(EObtain,"EObtain")
return


Resolve:
Gui,S4Checklist:Submit,Nohide
Calculate(Resolve, 14, EResolve)
return


EResolve:
Gui,S4Checklist:Submit,Nohide
Write_INI(EResolve,"EResolve")
return


Build:
Gui,S4Checklist:Submit,Nohide
Calculate(Build, 6, EBuild)
return


EBuild:
Gui,S4Checklist:Submit,Nohide
Write_INI(EBuild,"EBuild")
return


Transition:
Gui,S4Checklist:Submit,Nohide
Calculate(Transition, 6, ETransition)
return


ETransition:
Gui,S4Checklist:Submit,Nohide
Write_INI(ETransition,"ETransition")
return


Present:
Gui,S4Checklist:Submit,Nohide
Calculate(Present, 6, EPresent)
return


EPresent:
Gui,S4Checklist:Submit,Nohide
Write_INI(EPresent,"EPresent")
return


Overcome:
Gui,S4Checklist:Submit,Nohide
Calculate(Overcome, 4, EOvercome)
return


EOvercome:
Gui,S4Checklist:Submit,Nohide
Write_INI(EOvercome,"EOvercome")
return


Ask:
Gui,S4Checklist:Submit,Nohide
Calculate(Ask, 4, EAsk)
return


EAsk:
Gui,S4Checklist:Submit,Nohide
Write_INI(EAsk,"EAsk")
return


Verification:
Gui,S4Checklist:Submit,Nohide
Calculate(Verification, 3, EVerification)
return


EVerification:
Gui,S4Checklist:Submit,Nohide
Write_INI(EVerification,"EVerification")
return


Bill:
Gui,S4Checklist:Submit,Nohide
Calculate(Bill, 4, EBill)
return


EBill:
Gui,S4Checklist:Submit,Nohide
Write_INI(EBill,"EBill")
return


Today:
Gui,S4Checklist:Submit,Nohide
Calculate(Today, 1, EToday)
return


EToday:
Gui,S4Checklist:Submit,Nohide
Write_INI(EToday,"EToday")
return


Expectation:
Gui,S4Checklist:Submit,Nohide
Calculate(Expectation, 3, EExpectation)
return


EExpectation:
Gui,S4Checklist:Submit,Nohide
Write_INI(EExpectation,"EExpectation")
return


Documentation:
Gui,S4Checklist:Submit,Nohide
Calculate(Documentation, 3, EDocumentation)
return


EDocumentation:
Gui,S4Checklist:Submit,Nohide
Write_INI(EDocumentation,"EDocumentation")
return


Tone:
Gui,S4Checklist:Submit,Nohide
Calculate(Tone, 3, ETone)
return


ETone:
Gui,S4Checklist:Submit,Nohide
Write_INI(ETone,"ETone")
return


Listen:
Gui,S4Checklist:Submit,Nohide
Calculate(Listen, 3, EListen)
return


EListen:
Gui,S4Checklist:Submit,Nohide
Write_INI(EListen,"EListen")
return


ContactM:
Gui,S4Checklist:Submit,Nohide
Calculate(ContactM, 3, EContactM)
return


EContactM:
Gui,S4Checklist:Submit,Nohide
Write_INI(EContactM,"EContactM")
return


Acknowledge:
Gui,S4Checklist:Submit,Nohide
Calculate(Acknowledge, 4, EAcknowledge)
return


EAcknowledge:
Gui,S4Checklist:Submit,Nohide
Write_INI(EAcknowledge,"EAcknowledge")
return


Rapport:
Gui,S4Checklist:Submit,Nohide
Calculate(Rapport, 4, ERapport)
return


ERapport:
Gui,S4Checklist:Submit,Nohide
Write_INI(ERapport,"ERapport")
return


S4Hide:
Gui,S4Checklist:Destroy
return

;F1::
WinActivate, S4 Checklist
Return

;F2::
S4Reset:
Gosub, S4Unhide
return

S4ChecklistGuiEscape:
S4ChecklistGuiClose:
S4Close:
Close:
ExitApp
return


S4Defaults:
For key in ArrayA
{
	raya := ArrayA[A_Index]
	rayb := ArrayB[A_Index]
	rayc := ArrayC[A_Index]
	IniRead, %raya%, .\Lib\S4.ini, Defaults, %raya%
	GuiControl,S4Checklist:,%rayc%,%rayb%
}
IniWrite, 0, .\Lib\S4.ini, S4Theme, Theme
IniWrite, 0, .\Lib\S4.ini, S4WinPos, XPos
IniWrite, 0, .\Lib\S4.ini, S4WinPos, YPos
IniWrite, 0, .\Lib\S4.ini, S4AlwaysOnTop, AlwaysOnTop
Reload
Return


Write_INI(ray,eray)
{
IniWrite, %ray%, .\Lib\S4.ini, Custom, %eray%
}


Read_INI(ray,eray)
{
IniRead, ray, .\Lib\S4.ini, Custom, %eray%, %ray%
GuiControl,S4Checklist:,%eray%,%ray%
}


Calculate(Checker, POINT, IndexB)
{
	Gui,S4Checklist:Submit,Nohide
	If Checker = 0
	{
		POINTS -= POINT
		GuiControl,S4Checklist:,Progress, %POINTS%
	}
	If Checker = 1
	{
		GuiControl,S4Checklist:,Progress, +%POINT%
		POINTS += POINT
	}
	GuiControl,S4Checklist:,TPOINTS,Total Points = (%POINTS%) of 100
	if (Checker = "0")
		GuiControl,S4Checklist:Enable,%IndexB%
	else
		GuiControl,S4Checklist:Disable,%IndexB%
}

;;; Tooltip for GUI Controls
WM_MOUSEMOVE_FUNC()
{
	static CurrControl, PrevControl, _TT
	CurrControl := A_GuiControl
	If (CurrControl <> PrevControl){
			SetTimer, DisplayToolTip, -1500 	; shorter wait, shows the tooltip quicker
			PrevControl := CurrControl
	}
	return
	
	DisplayToolTip:
	try
			ToolTip % %CurrControl%_TT
	catch
			ToolTip
	SetTimer, RemoveToolTip, -5000
	return
	
	RemoveToolTip:
	ToolTip
	return
}

^!+#s::
Reload