Clear-Host

Write-Output "Place .msu files here."
Write-Output "http://www.catalog.update.microsoft.com/search.aspx?q=4012598"

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

$dir = (Get-Item -Path ".\" -Verbose).FullName
 Foreach($item in (ls $dir *.msu -Name))
 {
    echo $item
    $item = $dir + "\" + $item
    wusa $item /quiet /norestart | Out-Null
 }
 
