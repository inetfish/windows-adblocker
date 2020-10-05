# windows-adblocker
Free Windows AdBlocker

 - summary: free and priave adblocker leveraging hosts file blacklist.
 - features:
   - free and private.
   - desktop shortcut to quickly turn blocking on/off.
   - lightweight windows batch script.
 - pre-requisites & setup:
   - extract/download to %userprofile%\scripts\adblocker, shortcuts are configured to run from the path.
   - requires curl (default in windows10).
   - bootstrap by starting administrator command window and executing copy-hosts.cmd. A shortcut can also be run.
  - other details:
    - hosts file blacklist is updated each time adblocker is enabled.
    - add or update hosts-custom.txt for hosts file entries that need to persist.
    - hosts-default is default windows 10 hosts file.

  - credits:
    - https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts for hosts file blacklist.
