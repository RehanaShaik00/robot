Write-Output "testing"
Start-Process -FilePath ChromeSetup.exe -Args "/silent /install" -Verb RunAs -Wait
