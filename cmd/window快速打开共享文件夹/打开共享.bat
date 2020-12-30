@echo off
ECHO Y|net use * /del >NUL
net use \\192.168.10.3 "ZhangWan!" /user:zhangwan >NUL
explorer \\192.168.10.3
exit
@echo on