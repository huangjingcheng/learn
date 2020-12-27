@ echo off
chcp 65001 > nul 
title 多开vpn
color b0

set vpn1=zwvpn
set vpn2=youdongvpn
set pathdir=D:\Desktop\


rem set /p myCHOOSE="disconect vpn yes/no:"
rem if "%myCHOOSE%"=="yes" (
   rem  rasdial %vpn1% /DISCONNECT
   rem  rasdial %vpn2% /DISCONNECT
rem )

rasdial  %vpn1%
rasdial  %vpn2%
ipconfig | findstr /i "ppp * 10.31."


ipconfig | findstr /i "ppp * 10.31." > %pathdir%vpn.log
D:\kings\base\tool\php-7.1.9\php.exe .\vpn.php  %pathdir%  %pathdir%vpn.log


for /f  %%I in (%pathdir%%vpn1%) do set vpn1Ip=%%I
for /f  %%I in (%pathdir%%vpn2%) do set vpn2Ip=%%I

echo  yes|del %pathdir%vpn.log
echo  yes|del %pathdir%%vpn1%
echo  yes|del %pathdir%%vpn2%

echo 获取vpn的Ip：
echo             %vpn1%=%vpn1Ip%
echo             %vpn2%=%vpn2Ip%
echo             开始设置静态路由:

rem 掌玩vpn
rem ---------------------------------------------------------
rem zsjefunbm.hnyoulu.com
route add 54.183.135.175 mask 255.255.255.255  %vpn1Ip%
rem www.google.com.hk
route add 74.125.203.199 mask 255.255.255.255 %vpn1Ip%
rem www.youtube.com
route add 172.217.27.142 mask 255.255.255.255 %vpn1Ip%  
rem 中世纪efun北美测试服
route add 18.144.40.153 mask 255.255.255.255 %vpn1Ip%
rem 服务器1：zsjefunbm_web1
route add 13.52.140.195 mask 255.255.255.255 %vpn1Ip%
rem 服务器2：zsjefunbm_web2
route add 54.183.231.141 mask 255.255.255.255 %vpn1Ip%
rem 服务器3：zsjefunbm_web3
route add 13.57.139.18 mask 255.255.255.255 %vpn1Ip%
rem 服务器4：zsjefunbm_web4
route add 52.53.102.254 mask 255.255.255.255 %vpn1Ip%
rem 服务器5：zsjefunbm_web5
route add 52.53.136.221 mask 255.255.255.255 %vpn1Ip%
rem 服务器6：zsjefunbm_web6
route add 13.56.43.166 mask 255.255.255.255 %vpn1Ip%
rem 服务器7：zsjefunbm_web7
route add 13.52.14.83 mask 255.255.255.255 %vpn1Ip%
rem 服务器8：zsjefunbm_web8
route add 13.52.87.159 mask 255.255.255.255 %vpn1Ip%
rem 服务器9：zsjefunbm_web9
route add 52.9.31.76 mask 255.255.255.255 %vpn1Ip%
rem 服务器10：zsjefunbm_web10
route add 52.52.24.126 mask 255.255.255.255 %vpn1Ip%
rem 服务器11: zsjefunbm_web11
route add 52.8.184.189 mask 255.255.255.255 %vpn1Ip%
rem 服务器12: zsjefunbm_web12
route add 54.183.44.124 mask 255.255.255.255 %vpn1Ip%
rem 服务器13: zsjefunbm_web13
route add 13.52.233.37 mask 255.255.255.255 %vpn1Ip%
rem 服务器14: zsjefunbm_web14
route add 54.193.44.65 mask 255.255.255.255 %vpn1Ip%
rem 服务器15: zsjefunbm_web15
route add 13.52.121.247 mask 255.255.255.255 %vpn1Ip%
rem 服务器16: zsjefunbm_web16
route add 54.193.75.178 mask 255.255.255.255 %vpn1Ip%
rem 服务器17：zsjefunbm_web17
route add 54.219.66.184 mask 255.255.255.255 %vpn1Ip%
rem 服务器18：zsjefunbm_web18
route add 50.18.25.144 mask 255.255.255.255 %vpn1Ip%
rem 服务器19：zsjefunbm_web19
route add 54.67.57.181 mask 255.255.255.255 %vpn1Ip%
rem 服务器20：zsjefunbm_web20
route add 184.72.30.131 mask 255.255.255.255 %vpn1Ip%
rem 服务器21：zsjefunbm_web21
route add 13.52.236.188 mask 255.255.255.255 %vpn1Ip%
rem 服务器22：zsjefunbm_web22
route add 54.215.1.221 mask 255.255.255.255 %vpn1Ip%
rem 服务器23：zsjefunbm_web23
route add 52.9.79.116 mask 255.255.255.255 %vpn1Ip%
rem 服务器24：zsjefunbm_web24
route add 204.236.142.46 mask 255.255.255.255 %vpn1Ip%
rem 服务器25：zsjefunbm_web25
route add 13.57.101.66 mask 255.255.255.255 %vpn1Ip%
rem 服务器26：zsjefunbm_web26
route add 54.177.154.111 mask 255.255.255.255 %vpn1Ip%
rem 服务器27：zsjefunbm_web27
route add 50.18.235.164 mask 255.255.255.255 %vpn1Ip%
rem 服务器28：zsjefunbm_web28
route add 50.18.80.130 mask 255.255.255.255 %vpn1Ip%
rem 服务器29：zsjefunbm_web29
route add 54.215.32.52 mask 255.255.255.255 %vpn1Ip%
rem 服务器30：zsjefunbm_web30
route add 54.176.208.58 mask 255.255.255.255 %vpn1Ip%
rem 服务器31：zsjefunbm_web31
route add 50.18.8.43 mask 255.255.255.255 %vpn1Ip%
rem 服务器32：zsjefunbm_web32
route add 52.8.248.211 mask 255.255.255.255 %vpn1Ip%
rem 服务器33：zsjefunbm_web33
route add 54.215.63.114 mask 255.255.255.255 %vpn1Ip%
rem 服务器34：zsjefunbm_web34
route add 52.52.237.55 mask 255.255.255.255 %vpn1Ip%
rem 服务器35：zsjefunbm_web35
route add 50.18.10.83 mask 255.255.255.255 %vpn1Ip%
rem 定时任务服务器1: zsjefunbm_cron1
route add 52.52.232.205 mask 255.255.255.255 %vpn1Ip%
rem 定时任务服务器2: zsjefunbm_cron2
route add 13.56.113.208 mask 255.255.255.255 %vpn1Ip%
rem 定时任务服务器3: zsjefunbm_cron3
route add 54.241.43.198 mask 255.255.255.255 %vpn1Ip%
rem 定时任务服务器4: zsjefunbm_cron4
route add 54.219.131.249 mask 255.255.255.255 %vpn1Ip%

route add 52.74.223.119 mask 255.255.255.255 %vpn1Ip%


rem -----------------------------------------------------------------

rem youdongvpn

rem 中世纪美漫测试服
route add 119.29.61.120 mask 255.255.255.255 %vpn2Ip%
rem 中世纪efun北美预上线
route add 47.112.118.51 mask 255.255.255.255 %vpn2Ip%
rem 日本黑帮测试服
route add 47.115.130.166 mask 255.255.255.255 %vpn2Ip%


rem delete
rem route delete 10.0.0.0 mask 255.0.0.0
rem route delete 10.0.0.0 mask 255.0.0.0

rem route delete 224.0.0.0 mask 240.0.0.0
rem route delete 224.0.0.0 mask 240.0.0.0 


rem route delete 255.255.255.255 mask 255.255.255.255
rem route delete 255.255.255.255 mask 255.255.255.255

rem route delete 10.255.255.255 mask 255.255.255.255
rem route delete 10.255.255.255 mask 255.255.255.255

rem route delete 111.230.129.189 mask 255.255.255.255

rem route delete  %vpn2Ip% mask 255.255.255.255
rem route delete  %vpn1Ip% mask 255.255.255.255

rem route print
pause