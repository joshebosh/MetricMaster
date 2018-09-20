SET MMVer=MetricMaster_v1.0.0
mkdir %MMVer%
mkdir %MMVer%\Lib\Pics
cp Lib\Pics\AvayaButtons.png %MMVer%\Lib\Pics\AvayaButtons.png
cp Lib\Pics\AvayaButtonsA.png %MMVer%\Lib\Pics\AvayaButtonsA.png
cp Lib\Pics\AvayaButtonsB.png %MMVer%\Lib\Pics\AvayaButtonsB.png
cp Lib\Class_CtlColors.ahk %MMVer%\Lib\Class_CrlColors.ahk
cp Lib\Pics\ColorChart.png %MMVer%\Lib\Pics\ColorChart.png
cp Lib\Pics\dg.ico %MMVer%\Lib\Pics\dg.ico
cp Lib\Pics\error.png %MMVer%\Lib\Pics\error.png
cp Lib\Pics\info.png %MMVer%\Lib\Pics\info.png
cp Lib\Pics\MetricMaster.png %MMVer%\Lib\Pics\MetricMaster.png
cp Lib\Pics\PerfectCall.png %MMVer%\Lib\Pics\PerfectCall.png
cp Lib\Pics\MM.ico %MMVer%\Lib\Pics\MM.ico
cp Lib\MM.ini %MMVer%\Lib\MM.ini
cp Lib\Pics\PM.ico %MMVer%\Lib\Pics\PM.ico
cp Lib\PM.ini %MMVer%\Lib\PM.ini
cp Lib\Pics\RDSPotD.png %MMVer%\Lib\Pics\RDSPotD.png
cp Lib\Pics\Remedy_IE_Bars.png %MMVer%\Lib\Pics\Remedy_IE_Bars.png
cp Lib\Pics\S4.ico %MMVer%\Lib\Pics\S4.ico
cp Lib\S4.ini %MMVer%\Lib\S4.ini
cp Lib\Pics\S4Checklist.png %MMVer%\Lib\Pics\S4Checklist.png
cp Lib\README.txt %MMVer%\Lib\README.txt
cp Lib\UIA_Interface.ahk %MMVer%\Lib\UIA_Interface.ahk
cp Lib\Pics\warn.png %MMVer%\Lib\Pics\warn.png
cp WindowManager_Clean.ahk %MMVer%\WindowManager.ahk
..\..\Ahk2Exe112400\Ahk2Exe.exe /in RDS_PotD.ahk /out %MMVer%\RDS_PotD.exe /icon %MMVer%\Lib\Pics\PM.ico
..\..\Ahk2Exe112400\Ahk2Exe.exe /in S4Checklist.ahk /out %MMVer%\S4Checklist.exe /icon %MMVer%\Lib\Pics\S4.ico
..\..\Ahk2Exe112400\Ahk2Exe.exe /in MetricMaster.ahk /out %MMVer%\MetricMaster.exe /icon %MMVer%\Lib\Pics\MM.ico
