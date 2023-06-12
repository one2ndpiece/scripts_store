@REM �G���R�[�h��shift JIS�ɂ��Ȃ��Ɠǂݍ���ł���Ȃ�������(��)
@echo off
setlocal

set "interfaceName=�C�[�T�l�b�g"
set "ipAddress=YourIPAddress"
set "subnetMask=255.255.255.0�݂����Ȃ��"
set "defaultGateway=�f�t�H���g�Q�[�g�E�F�C"
set "preferredDns=�D��DNS"
set "alternateDns=���DNS"

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
