$inputDomain = Read-Host -Prompt "Enter full-domain: (E.G: domain.name) "

if (($inputDomain -eq "") -Or (!$inputDomain))
{
    $inputDomain = (Get-WmiObject Win32_ComputerSystem).Domain
    
    try
    {
        $inputUsername = Read-Host -Prompt "Enter username: "
        Get-ADUser $inputUsername -Server $inputDomain -Properties EmployeeID,EmployeeNumber
        Remove-Variable inputUsername
    }
    catch
    {
        $inputFullname = Read-Host -Prompt "Enter full-name: "
        Get-ADUser -Server $inputDomain -Filter {Name -eq $inputFullname} -Properties EmployeeID,EmployeeNumber
        Remove-Variable inputFullname
    }
}
else
{
    try
    {
        $inputUsername = Read-Host -Prompt "Enter username: "
        Get-ADUser $inputUsername -Server $inputDomain -Properties EmployeeID,EmployeeNumber
        Remove-Variable inputUsername
    }
    catch
    {
        $inputFullname = Read-Host -Prompt "Enter full-name: "
        Get-ADUser -Server $inputDomain -Filter {Name -eq $inputFullname} -Properties EmployeeID,EmployeeNumber
        Remove-Variable inputFullname
    }
}
