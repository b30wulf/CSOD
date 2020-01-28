@echo off

echo Shut Down...
gfix -user sysdba -password masterkey -shut multi -force 0 "D:\Kon2\BASE_NIL\SYSINFOAUTO.FDB"


echo Restoring up...
gbak -rep -user sysdba -password masterkey "D:\Kon2\BASE_NIL\SYSINFOAUTO.Fbk" "D:\Kon2\BASE_NIL\SYSINFOAUTO.Fdb"

pause

