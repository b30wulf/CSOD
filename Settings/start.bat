cd %systemroot%\system32
start Rasdial GPRSROUT /disconnect
ping -n 55 127.0.0.1
start rasdial GPRSROUT web1 web1