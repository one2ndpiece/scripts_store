$adapterName="vEthernet (Default Switch)"

$ipConfig1=@{
    InterfaceAlias  = $adapterName
    IPAddress       = "192.168.5.100"
    PrefixLength    =24
}
New-NetIPAddress @ipConfig1

$ipConfig2=@{
    InterfaceAlias  = $adapterName
    IPAddress       = "192.168.5.44"
    PrefixLength    =24
}
New-NetIPAddress @ipConfig2

$ipConfig3=@{
    InterfaceAlias  = $adapterName
    IPAddress       = "192.168.5.102"
    PrefixLength    =24
}
New-NetIPAddress @ipConfig3