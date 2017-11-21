:: parakeet
:: A trash .bat file to copy only playable extensions from one Retropie USB directory to another without copying .srm files or .state files (or whatever other unnecessary files). Trash name inspired by GitHub.

@echo off
setlocal EnableDelayedExpansion
title RetroPie Update In Progress!!!
color 1F

::Set Version Number
set version=Version Alpha 0.0.1 - 11/14/17

:: Header
echo ++++++++++++++++++++++++++++++++++++++++++++++
echo Retropie USB Update Script -- @hooperre
echo %version%
ver
echo ++++++++++++++++++++++++++++++++++++++++++++++
echo.

:: Define local variables

set x=0
set sys=0

::Set default directory

SET source=%cd%
echo "%source%" is default directory.
echo.

:: Set source directory and ask for validation

echo Confirm source is %source%?
:SetYN0
Set /P YN0= [Y/N]: 
	if /I "%YN0%" EQU "Y" goto :YN0Continue
	if /I "%YN0%" EQU "N" goto :SetSource
	goto :SetYN0
	
:SetSource
echo What will be used as source roms folder location [Should end with roms folder ie. H:\retropie-mount\roms]?
echo Use full pathway without a final "\" (eg: use C:\roms vs C:\roms\). Directories with spaces will not work.
Set /P source= Enter source location: 
echo.
echo Confirm source is "%source%"?
goto :SetYN0

:YN0Continue
echo.
echo "%source%" will be source directory.
echo.

:: Create log file in established source directory

echo Creating device log...
echo.
pause
echo ++++++++++++++++++++++++++++++++++++++++++++++ > "%source%\log.txt"
echo Retropie USB Update Script -- @hooperre >> "%source%\log.txt"
echo %version% >> "%source%\log.txt"
ver >> "%source%\log.txt"
echo ++++++++++++++++++++++++++++++++++++++++++++++ >> "%source%\log.txt"
echo. >> "%source%\log.txt"

:: Set Destination

:SetDestination
echo.
echo What will be used as destination roms folder location [Should end with roms folder ie. H:\retropie-mount\roms]?
echo Use full pathway without a final "\" (eg: use C:\roms vs C:\roms\).  Directories with spaces will not work.
set /P destination= Enter source location: 
echo.
echo Destination is "%destination%"? [Y/N]

:SetYN1
Set /P YN1= [Y/N]: 
	if /I "%YN1%" EQU "Y" goto :YN1Continue
	if /I "%YN1%" EQU "N" goto :SetDestination
	goto :SetYN1

:YN1Continue
echo.
echo "%destination%" will be destination directory.

:: ======================================================
:: Define System Pathways and Extensions
:: ======================================================

::Amiga
:AmigaPE

set amiga_source=%source%\Amiga
set amiga_dest=%destination%\Amiga
set amiga_extensions[0]=.zip
set amiga_extensions[1]=.adf
set amiga_extensions[2]=.sh
set amiga_extensions[3]=.config

::AppleII
:AppleIIPE
set appleII_source=%source%\AppleII
set appleII_dest=%destination%\AppleII
set appleII_extensions[0]=.dsk
set appleII_extensions[1]=.sh
set appleII_extensions[2]=.config

::Arcade
:arcadePE
set arcade_source=%source%\arcade
set arcade_dest=%destination%\arcade
set arcade_extensions[0]=.zip
set arcade_extensions[1]=.sh
set arcade_extensions[2]=.config

::Atari 2600
:Atari2600PE
set atari2600_source=%source%\Atari2600
set atari2600_dest=%destination%\Atari2600
set atari2600_extensions[0]=.zip
set atari2600_extensions[1]=.rom
set atari2600_extensions[2]=.bin
set atari2600_extensions[3]=.a26
set atari2600_extensions[2]=.sh
set atari2600_extensions[3]=.config

::Atari 7800
:Atari7800PE
set atari7800_source=%source%\Atari7800
set atari7800_dest=%destination%\Atari7800
set atari7800_extensions[0]=.7z
set atari7800_extensions[1]=.a78
set atari7800_extensions[2]=.bin
set atari7800_extensions[3]=.zip

::Commodore 64
:c64PE
set c64_source=%source%\c64
set c64_dest=%destination%\c64
set c64_extensions[0]=.crt
set c64_extensions[1]=.tap
set c64_extensions[2]=.x64
set c64_extensions[3]=.d64
set c64_extensions[4]=.g64
set c64_extensions[5]=.t64
set c64_extensions[6]=.zip
set c64_extensions[7]=.prg

::Dreamcast
:dreamcastPE
set dreamcast_source=%source%\dreamcast
set dreamcast_dest=%destination%\dreamcast
set dreamcast_extensions[0]=.cdi
set dreamcast_extensions[1]=.gdi

::Gamegear
:gamegearPE
set gamegear_source=%source%\gamegear
set gamegear_dest=%destination%\gamegear
set gamegear_extensions[0]=.7z
set gamegear_extensions[1]=.bin
set gamegear_extensions[2]=.gg
set gamegear_extensions[3]=.sms
set gamegear_extensions[4]=.zip

::Gameboy
:gbPE
set gb_source=%source%\gb
set gb_dest=%destination%\gb
set gb_extensions[0]=.7z
set gb_extensions[1]=.gb
set gb_extensions[2]=.zip

::Gameboy Color
:gbcPE
set gbc_source=%source%\gbc
set gbc_dest=%destination%\gbc
set gbc_extensions[0]=.7z
set gbc_extensions[1]=.gbc
set gbc_extensions[2]=.zip

::Gameboy Advance
:gbaPE
set gba_source=%source%\gba
set gba_dest=%destination%\gba
set gba_extensions[0]=.7z
set gba_extensions[1]=.zip
set gba_extensions[2]=.gba

::Intellivision
:intellivisionPE
set intellivision_source=%source%\intellivision
set intellivision_dest=%destination%\intellivision
set intellivision_extensions[0]=.int
set intellivision_extensions[1]=.bin

::Sega Master System
:mastersystemPE
set mastersystem_source=%source%\mastersystem
set mastersystem_dest=%destination%\mastersystem
set mastersystem_extensions[0]=.7z
set mastersystem_extensions[1]=.bin
set mastersystem_extensions[2]=.sms
set mastersystem_extensions[3]=.zip

::Sega Genesis
:megadrivePE
set megadrive_source=%source%\megadrive
set megadrive_dest=%destination%\megadrive
set megadrive_extensions[0]=.7z
set megadrive_extensions[1]=.bin
set megadrive_extensions[2]=.gen
set megadrive_extensions[3]=.md
set megadrive_extensions[4]=.sg
set megadrive_extensions[5]=.smd
set megadrive_extensions[6]=.zip

::Nintendo 64
:n64PE
set n64_source=%source%\n64
set n64_dest=%destination%\n64
set n64_extensions[0]=.z64
set n64_extensions[1]=.n64
set n64_extensions[2]=.v64

::Nintendo DS
:ndsPE
set nds_source=%source%\nds
set nds_dest=%destination%\nds
set nds_extensions[0]=.nds
set nds_extensions[1]=.zip

::Nintendo Entertainment System
:nesPE
set nes_source=%source%\nes
set nes_dest=%destination%\nes
set nes_extensions[0]=.7z
set nes_extensions[1]=.fds
set nes_extensions[2]=.fig
set nes_extensions[3]=.mgd
set nes_extensions[4]=.nes
set nes_extensions[5]=.sfc
set nes_extensions[6]=.smc
set nes_extensions[7]=.swc
set nes_extensions[7]=.zip

::PC
:pcPE
set pc_source=%source%\pc
set pc_dest=%destination%\pc


::Global Save State and Saved Drive Files --- WIP!!!
::No source or destination addresses necessary
:SavesPE
set save_extensions[1]=.state
set save_extensions[2]=.srm

:: ======================================================
:: Begin Amiga Script
:: ======================================================

:: Check for amiga files and append log file
:Amiga
echo.
echo =========================================
echo Amiga Files
echo =========================================
echo.
if exist %source%\Amiga (
    echo Amiga found. ["%amiga_source%" -- "%amiga_dest%"]
	goto :AmigaFound
) else (
	echo Amiga not found.  Skipping.
	echo.
	pause
	goto :AmigaEnd
)

:AmigaFound
chdir /d "%amiga_source%"
echo Working Directory: "%cd%"
pause
goto :AmigaStart

:: Initialize Amiga File Transfer
:AmigaStart
echo.
echo Begin Amiga update from "%amiga_source%" to "%amiga_dest%?" (Y/N/(S)kip)?
Set /P YNAmiga= [Y/N/(S)kip]: 
	if /I "%YNAmiga%" EQU "Y" goto :AmigaTransfer
	if /I "%YNAmiga%" EQU "N" goto :Amiga
	if /I "%YNAmiga%" EQU "S" goto :AmigaEnd
	goto :AmigaStart

:AmigaTransfer
echo Transferring...
echo ========================================= >> "%source%\log.txt"
echo Amiga Files >> "%source%\log.txt"
echo ========================================= >> "%source%\log.txt"
echo. >> "%source%\log.txt"

:AmigaLoop
if defined amiga_extensions[%x%] (
    for %%F in (%amiga_source%*!amiga_extensions[%x%]!) do (
		copy /v /-y "%%~F" %amiga_dest%
		echo "%%~F" copied from "%amiga_source%" to "%amiga_dest%"
		echo "%%~F" copied from "%amiga_source%" to "%amiga_dest%" >> "%source%\log.txt"
    )
    set /a x+=1
    goto :AmigaLoop
) else (
	goto :AmigaEnd
)

:AmigaEnd

::Copy Image Folder, Video Folder, and gamelist.xml File

if exist %amiga_source%\images (
	echo.
	echo Image folder found. Will copy all .png image files.
	xcopy %amiga_source%\images\*.png %amiga_dest%\images\ /w /v /f /s
	echo.
	echo  Image files copied from "%amiga_source%" to "%amiga_dest%" >> "%source%\log.txt"
) else (
	echo No image folder found.
)

if exist %amiga_source%\videos (
	echo.
	echo Video folder found. Will copy all .mp4 video files.
	xcopy %amiga_source\%videos\*.mp4 %amiga_dest%\videos\*.mp4 /w /v /f /s
	echo.
	echo  Video files copied from "%amiga_source%" to "%amiga_dest%" >> "%source%\log.txt"
) else (
	echo No video folder found.
)

if exist %amiga_source%\gamelist.xml (
	echo.
	echo Gamelist.xml file found. Will copy the gamelist file.
	cd %amiga_source%
	copy /v /-y gamelist.xml %amiga_dest%
	echo.
	echo gamelist.xml copied from "%amiga_source%" to "%amiga_dest%" >> "%source%\log.txt"
) else (
	echo No gamelist.xml file found.
)

echo.
echo Amiga files complete.
	
:: ======================================================
:: Begin PC Script
:: ======================================================

:: Check for PC System Files
:PC
echo.
echo =========================================
echo PC Files
echo =========================================

echo.
if exist "%source%\pc" (
    echo PC found. ["%pc_source%"  -- "%pc_dest%"]
	goto :PCFound
) else (
	echo PC not found.  Skipping.
	echo.
	pause
	goto :PCEnd
)

:PCFound
echo.
chdir /d "%pc_source%"
echo Working Directory: "%cd%"
pause
goto :PCStart

:: Initialize PC File Transfer
:PCStart
echo Begin PC update from "%pc_source%" to "%pc_dest%"? (Y/N/(S)kip)?
Set /P YNPC= [Y/N/(S)kip]: 
	if /I "%YNPC%" EQU "Y" goto :PCTransfer
	if /I "%YNPC%" EQU "N" goto :PC
	if /I "%YNPC%" EQU "S" goto :PCEnd
	goto :PCStart

:PCTransfer
echo Transferring...
echo. >> "%source%\log.txt"
echo ========================================= >> "%source%\log.txt"
echo PC Files >> "%source%\log.txt"
echo ========================================= >> "%source%\log.txt"
echo. >> "%source%\log.txt"

:PC
::PC Copying slightly different given many directories are copied as well.
xcopy "%pc_source%." "%pc_dest%." /w /v /f /s

:PCEnd

::Copy Image Folder, Video Folder, and gamelist.xml File

if exist %pc_source%\images (
	echo.
	echo Image folder found. Will copy all .png image files.
	xcopy %pc_source%\images\*.png %pc_dest%\images\ /w /v /f /s
	echo.
	echo  Image files copied from "%pc_source%" to "%pc_dest%" >> "%source%\log.txt"
) else (
	echo No image folder found.
)

if exist %pc_source%\videos (
	echo.
	echo Video folder found. Will copy all .mp4 video files.
	xcopy %pc_source\%videos\*.mp4 %pc_dest%\videos\*.mp4 /w /v /f /s
	echo.
	echo  Video files copied from "%pc_source%" to "%pc_dest%" >> "%source%\log.txt"
) else (
	echo No video folder found.
)

if exist %pc_source%\gamelist.xml (
	echo.
	echo Gamelist.xml file found. Will copy the gamelist file.
	cd %pc_source%
	copy /v /-y gamelist.xml %pc_dest%
	echo.
	echo gamelist.xml copied from "%pc_source%" to "%pc_dest%" >> "%source%\log.txt"
) else (
	echo No gamelist.xml file found.
)

echo.
echo PC files complete.

:: End Utility Script
echo This concludes the USB Update Utility.
pause
exit
