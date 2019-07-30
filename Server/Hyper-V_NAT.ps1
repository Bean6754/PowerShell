# Thanks to: https://www.petri.com/using-nat-virtual-switch-hyper-v

New-VMSwitch -SwitchName “NATSwitch” -SwitchType Internal
New-NetIPAddress -IPAddress 192.168.0.1 -PrefixLength 24 -InterfaceAlias "vEthernet (NATSwitch)"
New-NetNAT -Name “NATNetwork” -InternalIPInterfaceAddressPrefix 192.168.0.0/24

# Set VM network to newly created NAT and set VM IP to 192.168.0.2 or 192.168.0.3 or 192.168.0.4, etc..
