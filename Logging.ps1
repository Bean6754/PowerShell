Clear-Host

# if (Test-Path  ($i.fullname + "\*logging-data*.txt")) {
if (Test-Path ($i.fullname + "\xoTKfwzqSL")) {
  $filename = Get-Content .\xoTKfwzqSL -Raw
} else {
  $filename = Read-Host -Prompt 'Enter filename you want to save log to: '
  $filename > xoTKfwzqSL
}

Write-Host "Logging to file:' $filename

while ($true) {
  sleep 10
  Get-Host > $filename
}
