$psmFileDir = Split-Path ($MyInvocation.MyCommand.Path) -Parent
#Write-Host $psmFileDir
Get-ChildItem -Path "$psmFileDir/common" -Filter *.ps1 | ForEach-Object {
    . $_.FullName
}