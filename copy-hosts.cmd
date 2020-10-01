@echo off
REM ************************
REM name: copy-hosts.cmd
REM summary: script to copy hosts files from default to adblocker and vice-versa
REM author: Zach Strehlo
REM ************************

REM change to script directory.
REM this is important when running shortcurt in admin mode. 
REM shortcurt in admin mode defaults to cmd.exe directory so change to script dir or this script will fail.
cd "%~dp0"

set logfile=%userprofile%\scripts\logfile.txt

echo Start Blocker >> %logfile%

echo %1 >> %logfile%

echo Remove READ ONLY bit from hosts file  >> %logfile%
attrib -r %SYSTEMROOT%\system32\drivers\etc\hosts 

if "%1"=="blocker" (
REM update with the latest URLs
call .\curl-hosts-adcheck.cmd
copy hosts-adchecker %SYSTEMROOT%\system32\drivers\etc\hosts 
echo **Hosts file updated with entries to blackhole ads** echo here >> %logfile%
del "%userprofile%\desktop\Turn AdBlocker On.lnk"
copy "Turn AdBlocker Off.lnk" %userprofile%\desktop\
goto end
)
 
copy hosts-default %SYSTEMROOT%\system32\drivers\etc\hosts 
echo **Hosts file updated with default entries** >> %logfile%
del "%userprofile%\desktop\Turn AdBlocker Off.lnk"
copy "Turn AdBlocker On.lnk" %userprofile%\desktop\

:end

echo append the custom host file entries to the end of the file >> %logfile%
type hosts-custom.txt >> %SYSTEMROOT%\system32\drivers\etc\hosts 


echo turning on READ ONLY bit to prevent hijacking... >> %logfile%
attrib +r %SYSTEMROOT%\system32\drivers\etc\hosts 

echo flushing dns...
ipconfig /flushdns

echo on
