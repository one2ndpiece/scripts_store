@REM エンコードをshift JISにしないと読み込んでくれなかったよ(泣)
@echo off
setlocal

set "interfaceName=イーサネット"
set "ipAddress=172.24.130.53"
set "subnetMask=255.255.255.0"
set "defaultGateway=172.24.130.1"
set "preferredDns=172.24.2.111"
set "alternateDns=172.28.1.131"

echo Interface Name: %interfaceName%
echo IP Address: %ipAddress%
echo Subnet Mask: %subnetMask%
echo Default Gateway: %defaultGateway%
echo Preferred DNS: %preferredDns%
echo Alternate DNS: %alternateDns%

echo Removing existing IP address...
netsh interface ip set address "%interfaceName%" dhcp

echo Setting new IP address...
netsh interface ip set address "%interfaceName%" static %ipAddress% %subnetMask% %defaultGateway%

echo Setting new DNS server settings...
netsh interface ip set dns "%interfaceName%" static %preferredDns% primary
netsh interface ip add dns "%interfaceName%" %alternateDns% index=2

echo Configuration complete.
endlocal
