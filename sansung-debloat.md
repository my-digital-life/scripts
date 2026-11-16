# Samsung A05 (SM-A055M)

Android 15 / Termux / ADB / scrcpy / SSH Notes

---

# Device Information

```text
Model: SM-A055M
Device: a05m
Android: 15
Security Patch: 2026-09-05

CPU: MediaTek MT6768
RAM: 4 GB
Storage: 64 GB

Bootloader: Locked
VBMeta: Locked
OEM Unlock Allowed: No

ADB over Wi‑Fi: Working
scrcpy over Wi‑Fi: Working
Termux: Working
SSH: Working
tmux: Working
```

---

# Windows Software Installation

## scrcpy

```powershell
winget install -e --id Genymobile.scrcpy
```

Verify:

```powershell
scrcpy --version
```

## Android Platform Tools (ADB)

```powershell
winget install -e --id Google.PlatformTools
```

Verify:

```powershell
adb version
```

## WinSCP

```powershell
winget install -e --id WinSCP.WinSCP
```

Verify:

```powershell
winget list WinSCP
```

## If Installation Fails

Search for package IDs:

```powershell
winget search scrcpy
winget search platform
winget search winscp
```

---

# ADB

## Verify USB Device

```powershell
adb devices
```

Expected:

```text
R92X115KKNF    device
```

## Enable Wi‑Fi ADB

```powershell
adb -s R92X115KKNF tcpip 5555
```

## Connect Over Wi‑Fi

```powershell
adb connect 192.168.1.192:5555
```

Verify:

```powershell
adb devices
```

Expected:

```text
192.168.1.192:5555    device
```

## Open Android Shell

```powershell
adb -s 192.168.1.192:5555 shell
```

---

# APK Installation

## Install APK

```powershell
adb -s 192.168.1.192:5555 install app.apk
```

## Replace Existing App

```powershell
adb -s 192.168.1.192:5555 install -r app.apk
```

## Install Via USB

```powershell
adb -s R92X115KKNF install -r app.apk
```

## Uninstall Package

```powershell
adb uninstall package.name
```

---

# scrcpy

## Basic

```powershell
scrcpy -s 192.168.1.192:5555
```

## Preferred Settings

```powershell
scrcpy `
-s 192.168.1.192:5555 `
--turn-screen-off `
--stay-awake `
--audio-source=playback `
--audio-dup `
--disable-screensaver `
-b 32M `
--window-height=1060
```

Current preferred window height:

```text
1060
```

---

# Display Settings

Physical display:

```text
720 x 1600
Density 300
```

Check current settings:

```powershell
adb shell wm size
adb shell wm density
```

Current preferred density:

```powershell
adb shell wm density 260
```

Restore default density:

```powershell
adb shell wm density reset
```

Restore default size:

```powershell
adb shell wm size reset
```

---

# Termux

## Install OpenSSH

```bash
pkg install openssh
```

## Start SSH

```bash
sshd
```

## Connect From PC

```bash
ssh -p 8022 u0_a248@192.168.1.192
```

---

# SSH Troubleshooting

## Connection Refused

Restart SSH from **Termux**:

```bash
pkill sshd
sshd
```

Test:

```bash
ssh -p 8022 u0_a248@192.168.1.192
```

Expected:

```text
Welcome to Termux!
```

## Important

Do NOT run:

```bash
sshd
```

from:

```text
a05m:/ $
```

(Android shell)

Run it from:

```text
u0_a248@localhost:~$
```

(Termux)

---

# WinSCP

Protocol:

```text
SFTP
```

Host:

```text
192.168.1.192
```

Port:

```text
8022
```

Username:

```text
u0_a248
```

Password:

```text
Termux password
```

Termux home:

```text
/data/data/com.termux/files/home
```

Shared storage:

```bash
termux-setup-storage
```

Location:

```text
/storage/emulated/0
```

---

# tmux

Create session:

```bash
tmux new -s phone
```

List sessions:

```bash
tmux ls
```

Attach:

```bash
tmux attach -t phone
```

Detach:

```text
Ctrl+B
D
```

Configuration:

```text
set -g mouse on
set -g history-limit 50000
set -g set-clipboard on
```

---

# Installed Applications

## Firefox

```powershell
adb -s R92X115KKNF install -r firefox.apk
```

Source:

https://f-droid.org/

Mozilla Releases:

https://ftp.mozilla.org/pub/fenix/releases/

## Termux

Source:

https://f-droid.org/

## Termux API

Source:

https://f-droid.org/

---

# Samsung Debloat

List packages:

```bash
pm list packages | grep samsung
```

Samsung Health:

```bash
pm uninstall --user 0 com.sec.android.app.shealth
```

SmartThings:

```bash
pm uninstall --user 0 com.samsung.android.oneconnect
```

Samsung Members:

```bash
pm uninstall --user 0 com.samsung.android.voc
```

Samsung Free:

```bash
pm uninstall --user 0 com.samsung.android.app.spage
```

Samsung Global Goals:

```bash
pm uninstall --user 0 com.samsung.sree
```

Smart Switch:

```bash
pm uninstall --user 0 com.sec.android.easyMover
```

Samsung Internet:

```bash
pm uninstall --user 0 com.sec.android.app.sbrowser
```
