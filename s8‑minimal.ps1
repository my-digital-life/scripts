# Create log file in the current working directory (works in ISE)
$timestamp = (Get-Date).ToString("yyyyMMdd-HHmmss")
$logFile = Join-Path $PWD.Path "DebloatLog-$timestamp.txt"

# Counters for summary
$successCount = 0
$failCount = 0

# List of packages for ultra-minimal mode
$packages = @(
"com.sec.android.app.chromecustomizations",
"com.android.chrome",
"com.facebook.katana",
"com.facebook.system",
"com.facebook.appmanager",
"com.fivemobile.myaccount",
"com.microsoft.office.excel",
"com.microsoft.office.powerpoint",
"com.microsoft.office.word",
"com.nhl.gc1112.free",
"com.spotify.music",
"com.instagram.android",
"com.whatsapp",
"com.skype.raider",
"flipboard.boxer.app",

# Carrier (Virgin / Rogers)
"ca.virginmobile.myaccount.virginmobile",
"ca.virginmobile.mybenefits",
"com.rogers.npd.appzone",
"com.sec.android.fido.uaf.client",

# Samsung Pay
"com.samsung.android.spay",

# Samsung Bixby (full removal)
"com.samsung.android.app.spage",
"com.samsung.android.bixby.agent",
"com.samsung.android.bixby.agent.dummy",
"com.samsung.android.bixby.es.globalaction",
"com.samsung.android.bixby.service",
"com.samsung.android.bixby.voiceinput",
"com.samsung.android.bixby.wakeup",
"com.samsung.systemui.bixby2",
"com.samsung.android.bixbyvision.framework",
"com.samsung.android.app.settings.bixby",

# Samsung Routines / Automation
"com.samsung.android.app.routines",

# Samsung VR / AR
"com.samsung.android.hmt.vrshell",
"com.samsung.android.hmt.vrsvc",
"com.samsung.android.app.vrsetupwizardstub",
"com.samsung.android.app.vrsetupwizard",

# Samsung Edge junk
"com.samsung.android.widgetapp.yahooedge.finance",
"com.samsung.android.widgetapp.yahooedge.sport",

# Samsung extras (safe to remove)
"com.samsung.android.app.tips",
"com.samsung.android.app.social",
"com.samsung.android.app.simplesharing",
"com.samsung.android.app.smartcapture",
"com.samsung.android.app.reminder",
"com.samsung.android.app.memo",
"com.samsung.android.app.contacts",
"com.samsung.android.messaging",
"com.samsung.android.email.provider",
"com.samsung.android.app.watchmanager",
"com.samsung.android.app.watchmanagerstub",

# Samsung analytics + tracking
"com.samsung.android.da.daagent",
"com.samsung.android.mateagent",
"com.samsung.android.sm.devicesecurity",
"com.samsung.android.scloud",
"com.samsung.android.sdk.handwriting",
"com.samsung.android.app.sbrowser",
"com.samsung.android.app.sbrowseredge"
)

# Run uninstall loop with logging + summary
foreach ($pkg in $packages) {
    Write-Host "Uninstalling $pkg ..."
    $result = .\adb.exe shell pm uninstall --user 0 $pkg

    # Log entry
    "$pkg : $result" | Out-File -FilePath $logFile -Append -Encoding utf8

    # Count success/failure
    if ($result -match "Success") {
        $successCount++
    } else {
        $failCount++
    }
}

# Summary output
Write-Host "`n==================== SUMMARY ===================="
Write-Host "Successful removals : $successCount"
Write-Host "Failed removals     : $failCount"
Write-Host "Log file saved to   : $logFile"
Write-Host "=================================================="
