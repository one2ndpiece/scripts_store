$adapterName = "vEthernet (Default Switch)"
$newIPaddress = "172.24.130.53"
$newPrefixLength=24
$newDefaultGateWay="172.24.130.1"
$newprimaryDNS="172.24.130.53"
$newsecondaryDNS="172.28.1.131"
Remove-NetIPAddress -Confirm:$false -InterfaceAlias "$adapterName" -AddressFamily "IPv4"
Remove-NetRoute -Confirm:$false -InterfaceAlias "$adapterName" -DestinationPrefix 0.0.0.0/0

New-NetIPAddress -InterfaceAlias "$adapterName" -IPAddress $newIPaddress -AddressFamily IPv4 -PrefixLength $newPrefixLength -DefaultGateway $newDefaultGateway
Set-DnsClientServerAddress -InterfaceAlias "$adapterName" -ResetServerAddresses
Set-DnsClientServerAddress -InterfaceAlias "$adapterName" -ServerAddresses $newprimaryDNS,$newsecondaryDNS