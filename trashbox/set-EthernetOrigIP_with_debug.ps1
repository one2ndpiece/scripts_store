# Define the network interface name
$interfaceName = "Ethernet"
Write-Host "Interface Name: $interfaceName"

# Define the new settings
$ipAddress = "172.24.130.53"
$subnetMask = "255.255.255.0"
$defaultGateway = "172.24.130.1"
$preferredDns = "172.24.2.111"
$alternateDns = "172.28.1.131"

Write-Host "IP Address: $ipAddress"
Write-Host "Subnet Mask: $subnetMask"
Write-Host "Default Gateway: $defaultGateway"
Write-Host "Preferred DNS: $preferredDns"
Write-Host "Alternate DNS: $alternateDns"

# Remove the existing IP address
Write-Host "Removing existing IP address..."
Remove-NetIPAddress -InterfaceAlias $interfaceName -Confirm:$false

# Remove the existing DNS server settings
Write-Host "Removing existing DNS server settings..."
Set-DnsClientServerAddress -InterfaceAlias $interfaceName -ResetServerAddresses

# Set the new IP address
Write-Host "Setting new IP address..."
New-NetIPAddress -InterfaceAlias $interfaceName -IPAddress $ipAddress -PrefixLength $subnetMask -DefaultGateway $defaultGateway

# Set the new DNS server settings
Write-Host "Setting new DNS server settings..."
Set-DnsClientServerAddress -InterfaceAlias $interfaceName -ServerAddresses $preferredDns,$alternateDns

Write-Host "Configuration complete."
