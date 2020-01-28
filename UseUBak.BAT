@echo off

echo Shut Down...
gfix -user sysdba -password masterkey -shut multi -force 0 "D:\Kon2\SYSINFOAUTO.FDB"

 

echo Back up...
gbak -b -user sysdba -password masterkey "D:\Kon2\SYSINFOAUTO.FDB"  "D:\Kon2\SYSINFOAUTO.Fbk"

pause

