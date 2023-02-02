$staticAttributes = @("AccountExpirationDate","extensionAttribute13","extensionAttribute14","Manager","Enabled","mail","mailnickname","proxyAddresses","whencreated","whenChanged","PasswordNeverExpires","PasswordLastSet","EmployeeNumber","targetaddress","info","Company","Accountexpires","LastLogon","Description","LastLogonDate","Office","physicalDeliveryOfficeName","extensionAttribute5","MemberOf","Title","legacyExchangeDN","AccountLockoutTime","LockedOut","LastBadPasswordAttempt","Department","Division","msExchRemoteRecipientType","msExchArchiveGUID","HomeDirectory","DisplayName","EmployeeID")
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
