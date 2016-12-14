Clear-Host

$path = "PowerOS"
If(!(Test-Path $path)) {
    New-Item -ItemType Directory -Force -Path $path
}
Set-Location $path
Get-Location

If(!(Test-Path $username)) {
    &$SetUpUsername
}
If(!(Test-Path networking\hostname)) {
    &$SetUpHostname
}
If(!(Test-Path networking\hosts)) {
    &$SetUpHosts
}


$SetUpUsername = {
    $username = Read-Host -Prompt "Enter a suitable username: "
    New-Item -ItemType Directory -Force -Path $username
    Set-Location $username
    echo $username > username
    Set-Location ..
}

$SetUpHostname = {
    $hostname = Read-Host -Prompt "Enter a suitable hostname: "
    New-Item -ItemType Directory -Force -Path networking
    echo $hostname > hostname
    Set-Location ..
}

$SetUpHosts = {
    $domainname = Read-Host -Prompt "Enter a suitable domain name: "
    New-Item -ItemType Directory -Force -Path networking
    echo "127.0.0.1 $hostname $hostname.$domainname" > hosts
    echo ":11 $hostname $hostname.$domainname" >> hosts
    Set-Location ..
}

$date = Get-Date
echo $date > date.txt

Write-Host "The date today is: "
Get-Date

Set-Location ..
Get-Location

Clear-History