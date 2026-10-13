# =====================================================================
# PowerShell Environment Bootstrap
# GitHub: my-digital-life/scripts
# =====================================================================

$ProfileUrl = "https://raw.githubusercontent.com/my-digital-life/scripts/refs/heads/master/powershell/Microsoft.PowerShell_profile.ps1"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " PowerShell Environment Bootstrap" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ---------------------------------------------------------------------
# Verify Winget
# ---------------------------------------------------------------------

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "Winget is not installed. Install App Installer from Microsoft Store."
    exit 1
}

# ---------------------------------------------------------------------
# Install Oh My Posh
# ---------------------------------------------------------------------

if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {

    Write-Host "Installing Oh My Posh..." -ForegroundColor Yellow

    winget install `
        JanDeDobbeleer.OhMyPosh `
        --source winget `
        --accept-package-agreements `
        --accept-source-agreements

} else {
    Write-Host "Oh My Posh already installed." -ForegroundColor Green
}

# ---------------------------------------------------------------------
# Install Nerd Font
# ---------------------------------------------------------------------

$JetBrainsInstalled = Get-ChildItem `
    "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" `
    -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -match "JetBrains" }

if (-not $JetBrainsInstalled) {

    Write-Host "Installing JetBrains Mono Nerd Font..." -ForegroundColor Yellow

    winget install `
        DEVCOM.JetBrainsMonoNerdFont `
        --accept-package-agreements `
        --accept-source-agreements

}
else {
    Write-Host "JetBrains Mono Nerd Font already installed." -ForegroundColor Green
}

# ---------------------------------------------------------------------
# Install PSReadLine
# ---------------------------------------------------------------------

if (-not (Get-Module -ListAvailable PSReadLine)) {

    Write-Host "Installing PSReadLine..." -ForegroundColor Yellow

    Install-Module `
        PSReadLine `
        -Scope CurrentUser `
        -Force `
        -SkipPublisherCheck

}
else {
    Write-Host "PSReadLine already installed." -ForegroundColor Green
}

# ---------------------------------------------------------------------
# Refresh Environment
# ---------------------------------------------------------------------

$env:PATH = (
    [System.Environment]::GetEnvironmentVariable("PATH", "Machine") +
    ";" +
    [System.Environment]::GetEnvironmentVariable("PATH", "User")
)

# ---------------------------------------------------------------------
# Create Profile Directory
# ---------------------------------------------------------------------

$ProfileDir = Split-Path $PROFILE.CurrentUserCurrentHost
$ProfileFile = $PROFILE.CurrentUserCurrentHost

New-Item `
    -Path $ProfileDir `
    -ItemType Directory `
    -Force | Out-Null

# ---------------------------------------------------------------------
# Download Latest Profile
# ---------------------------------------------------------------------

Write-Host "Downloading profile..." -ForegroundColor Yellow

Invoke-WebRequest `
    -Uri $ProfileUrl `
    -OutFile $ProfileFile

# ---------------------------------------------------------------------
# Configure PSReadLine Defaults
# ---------------------------------------------------------------------

Add-Content $ProfileFile @'

# PSReadLine Defaults
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -MaximumHistoryCount 10000

'@

# ---------------------------------------------------------------------
# Complete
# ---------------------------------------------------------------------

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host " Setup Complete" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "Profile: $ProfileFile" -ForegroundColor Cyan
Write-Host ""

Write-Host "Restart PowerShell to load changes." -ForegroundColor Yellow
