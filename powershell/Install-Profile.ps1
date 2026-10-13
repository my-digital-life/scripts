# Install-Profile.ps1

$ProfileUrl = 'https://raw.githubusercontent.com/my-digital-life/scripts/refs/heads/master/powershell/Microsoft.PowerShell_profile.ps1'

Write-Host "Checking for Oh My Posh..." -ForegroundColor Cyan

if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {

    Write-Host "Oh My Posh not found. Installing..." -ForegroundColor Yellow

    if (Get-Command winget -ErrorAction SilentlyContinue) {

        winget install JanDeDobbeleer.OhMyPosh `
            --source winget `
            --accept-package-agreements `
            --accept-source-agreements

    }
    else {
        Write-Warning "winget is not installed. Install Oh My Posh manually."
        exit 1
    }
}
else {
    Write-Host "Oh My Posh already installed." -ForegroundColor Green
}

# Refresh PATH in case winget just installed it
$env:PATH = [System.Environment]::GetEnvironmentVariable("PATH","Machine") + ";" +
            [System.Environment]::GetEnvironmentVariable("PATH","User")

$ProfileDir = Split-Path $PROFILE.CurrentUserCurrentHost
$ProfileFile = $PROFILE.CurrentUserCurrentHost

Write-Host "Installing PowerShell profile..." -ForegroundColor Cyan

New-Item -ItemType Directory -Path $ProfileDir -Force | Out-Null

Invoke-WebRequest `
    -Uri $ProfileUrl `
    -OutFile $ProfileFile

Write-Host ""
Write-Host "Profile installed successfully." -ForegroundColor Green
Write-Host "Location: $ProfileFile"
