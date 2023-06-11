$adapterName="vEthernet (Default Switch)"

$ipConfig1=@{
    InterfaceAlias  = $adapterName
    IPAddress       = "1st_IP_Address"
    PrefixLength    =
}
New-NetIPAddress @ipConfig1

$ipConfig2=@{
    InterfaceAlias  = $adapterName
    IPAddress       = "2nd_IP_Address"
    PrefixLength    =
}
New-NetIPAddress @ipConfig2

$ipConfig3=@{
    InterfaceAlias  = $adapterName
    IPAddress       = "3rd_IP_Address"
    PrefixLength    =
}
New-NetIPAddress @ipConfig3