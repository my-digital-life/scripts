# PowerShell Profile
# Repository: https://github.com/my-digital-life/scripts/
# https://raw.githubusercontent.com/my-digital-life/scripts/refs/heads/master/powershell/Microsoft.PowerShell_profile.ps1
# Last Updated: 2026-10-12
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kali.omp.json" | Invoke-Expression
Set-Alias open explorer.exe
# Set-Alias cat type
Set-Alias grep findstr
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
function ll {
    Get-ChildItem -Force |
    Select-Object Name,
                  @{Name="Size";Expression={ if ($_.PSIsContainer) {"<DIR>"} else {"{0:N0}" -f $_.Length} }},
                  @{Name="Modified";Expression={$_.LastWriteTime.ToString("yyyy-MM-dd HH:mm")}} |
    Format-Table -AutoSize
}
function ip-h {
    ipconfig /all |
        findstr /R `
            /C:"^[A-Za-z].*:$" `
            /C:"192\.168" `
            /C:"169\.254" `
            /C:"172\." `
            /C:"DNS Servers" `
            /C:"^[ ]\+[0-9][0-9]*\."
}

Set-Alias ip ip-h
