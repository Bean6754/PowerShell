$staticAttributes = @("AccountExpirationDate","extensionAttribute13","extensionAttribute14","manager","enabled","mail","mailnickname","proxyaddresses","whencreated","whenChanged","passwordNeverExpires","passwordLastSet","employeeNumber","targetaddress","info","company","accountexpires","LastLogon","description","lastlogondate","office","physicalDeliveryOfficeName","extensionAttribute5","extensionAttribute13","memberof","title","legacyExchangeDN","AccountLockoutTime","LockedOut","LastBadPasswordAttempt","department","division","msExchRemoteRecipientType","office","msExchArchiveGUID","HomeDirectory","DisplayName","employeeid")
$inputDomain = Read-Host -Prompt "Enter full-domain: (E.G: domain.name) "

if (($inputDomain -eq "") -Or (!$inputDomain))
{
    $inputDomain = (Get-WmiObject Win32_ComputerSystem).Domain
    
    try
    {
        $inputUsername = Read-Host -Prompt "Enter username: "
        Get-ADUser $inputUsername -Server $inputDomain -Properties $staticAttributes
        Write-Host "`n`n======================================`nExpanded AD attribute 'proxyAddresses' `n======================================`n"
        Get-ADUser $inputUsername -Server $inputDomain -Properties proxyaddresses | Select-Object -ExpandProperty proxyaddresses | Out-Host
        Remove-Variable inputUsername
    }
    catch
    {
        $inputFullname = Read-Host -Prompt "Enter full-name: "
        Get-ADUser -Server $inputDomain -Filter {Name -eq $inputFullname} -Properties $staticAttributes
        Write-Host "`n`n======================================`nExpanded AD attribute 'proxyAddresses' `n======================================`n"
        Get-ADUser $inputUsername -Server $inputDomain -Properties proxyaddresses | Select-Object -ExpandProperty proxyaddresses | Out-Host
        Remove-Variable inputFullname
    }
}
else
{
    try
    {
        $inputUsername = Read-Host -Prompt "Enter username: "
        Get-ADUser $inputUsername -Server $inputDomain -Properties $staticAttributes
        Write-Host "`n`n======================================`nExpanded AD attribute 'proxyAddresses' `n======================================`n"
        Get-ADUser $inputUsername -Server $inputDomain -Properties proxyaddresses | Select-Object -ExpandProperty proxyaddresses | Out-Host
        Remove-Variable inputUsername
    }
    catch
    {
        $inputFullname = Read-Host -Prompt "Enter full-name: "
        Get-ADUser -Server $inputDomain -Filter {Name -eq $inputFullname} -Properties $staticAttributes
        Write-Host "`n`n======================================`nExpanded AD attribute 'proxyAddresses' `n======================================`n"
        Get-ADUser $inputUsername -Server $inputDomain -Properties proxyaddresses | Select-Object -ExpandProperty proxyaddresses | Out-Host
        Remove-Variable inputFullname
    }
}
