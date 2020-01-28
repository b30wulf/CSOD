@echo off
ping -n 10 127.0.0.1
instsvc start
MKDIR r:\ascue
start c:\a2000\ascue\CopyFL.exe
