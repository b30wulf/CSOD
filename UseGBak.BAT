@echo off

echo Shut Down...
gfix -user sysdba -password masterkey -shut multi -force 0 D:\adapters\hEREEEEE\Kon2\SYSINFOAUTO.FDB

echo Backing up...
gbak -b -user sysdba -password masterkey D:\adapters\hEREEEEE\Kon2\SYSINFOAUTO.FDB  D:\adapters\hEREEEEE\Kon2\SYSINFOAUTO.FBK
 

echo Restoring up...
gbak -rep -user sysdba -password masterkey D:\adapters\hEREEEEE\Kon2\SYSINFOAUTO.Fbk  D:\adapters\hEREEEEE\Kon2\SYSINFOAUTO.FDB

pause

