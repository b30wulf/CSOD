net stop w32time
net start w32time
w32tm /register
w32tm /config /manualpeerlist:www.belgim.by /syncfromflags:manual /update
