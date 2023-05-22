# Define the network interface name
$interfaceName = "イーサネット"

# Define the new settings
$ipAddress = "172.24.130"
$subnetMask = "255.255.255.0"
$defaultGateway = "172.24.130.1"
$preferredDns = "172.24.2.111"
$alternateDns = "172.28.1.131"

# Remove the existing IP address
Remove-NetIPAddress -InterfaceAlias $interfaceName -Confirm:$false

# Remove the existing DNS server settings
Set-DnsClientServerAddress -InterfaceAlias $interfaceName -ResetServerAddresses

# Set the new IP address
New-NetIPAddress -InterfaceAlias $interfaceName -IPAddress $ipAddress -PrefixLength $subnetMask -DefaultGateway $defaultGateway

# Set the new DNS server settings
Set-DnsClientServerAddress -InterfaceAlias $interfaceName -ServerAddresses $preferredDns,$alternateDns
