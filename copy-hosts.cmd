@echo off
REM ************************
REM name: copy-hosts.cmd
REM summary: script to copy hosts files from default to adblocker and vice-versa
REM https://github.com/inetfish/windows-adblocker
REM ************************

REM change to script directory.
REM this is important when running shortcurt in admin mode. 
REM shortcurt in admin mode defaults to cmd.exe directory so change to script dir or this script will fail.
cd "%~dp0"

set logfile=%userprofile%\inetfish\windows-adblocker\adblocker.log

echo ====start copy-hosts.cmd==== >> %logfile%
date /t >> %logfile%
time /t >> %logfile%

echo Remove READ ONLY bit from hosts file  >> %logfile%
attrib -r %SYSTEMROOT%\system32\drivers\etc\hosts 

echo Check if 'blocker' option was passed to script >> %logfile%
if "%1"=="blocker" (
echo Yes 'blocker' is passed >> %logfile%
echo Get latest URLs to block and update hosts file >> %logfile%
call .\curl-hosts-adcheck.cmd
copy hosts-adchecker %SYSTEMROOT%\system32\drivers\etc\hosts 
echo **Hosts file updated with entries to blackhole ads** >> %logfile%
echo Update desktop shortcut >> %logfile%
del "%userprofile%\desktop\Turn AdBlocker On.lnk"
copy "Turn AdBlocker Off.lnk" %userprofile%\desktop\
goto end
)

echo No 'blocker' was not passed. So disable adblocking >> %logfile%
 
copy hosts-default %SYSTEMROOT%\system32\drivers\etc\hosts 
echo **Hosts file updated with default entries** >> %logfile%
del "%userprofile%\desktop\Turn AdBlocker Off.lnk"
copy "Turn AdBlocker On.lnk" %userprofile%\desktop\

:end

echo Append the custom host file entries to the end of the file >> %logfile%
type hosts-custom.txt >> %SYSTEMROOT%\system32\drivers\etc\hosts 

echo Turning on READ ONLY bit to prevent hijacking... >> %logfile%
attrib +r %SYSTEMROOT%\system32\drivers\etc\hosts 

echo Flushing dns... >> %logfile%
ipconfig /flushdns

echo ====end copy-hosts.cmd==== >> %logfile%

echo on
