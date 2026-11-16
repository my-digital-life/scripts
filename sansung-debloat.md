# Samsung A05 (SM-A055M) Debloat & Remote Management Notes

## Device Information

```bash
# Generate Android/Termux report
./android-report.sh

# Display report
cat ~/android-report.txt

# Show Android version
getprop ro.build.version.release

# Show device model
getprop ro.product.model

# Show security patch
getprop ro.build.version.security_patch

# Show bootloader state
getprop ro.boot.flash.locked

# Show vbmeta state
getprop ro.boot.vbmeta.device_state
```

---

## ADB Over Wi-Fi

### Verify USB device

```bash
adb devices
```

Expected:

```text
R92X115KKNF    device
```

### Enable TCP/IP mode

```bash
adb -s R92X115KKNF tcpip 5555
```

Expected:

```text
restarting in TCP mode port: 5555
```

### Connect over Wi-Fi

```bash
adb connect 192.168.1.192:5555
```

### Verify network ADB

```bash
adb devices
```

Expected:

```text
R92X115KKNF            device
192.168.1.192:5555     device
```

### Open ADB shell

```bash
adb -s 192.168.1.192:5555 shell
```

---

## scrcpy

### Basic connection

```bash
scrcpy -s 192.168.1.192:5555
```

### PowerShell version

```powershell
& "C:\Program Files\Adb Device Manager\All helper\scrcpy\scrcpy.exe" -s 192.168.1.192:5555
```

### Turn phone screen off

```powershell
& "C:\Program Files\Adb Device Manager\All helper\scrcpy\scrcpy.exe" `
-s 192.168.1.192:5555 `
--turn-screen-off `
--stay-awake
```

### Full preferred settings

```powershell
& "C:\Program Files\Adb Device Manager\All helper\scrcpy\scrcpy.exe" `
-s 192.168.1.192:5555 `
--turn-screen-off `
--stay-awake `
--audio-source=playback `
--audio-dup `
--disable-screensaver `
-b 32M `
--window-height=1029
```

---

## SSH (Termux)

### Install OpenSSH

```bash
pkg install openssh
```

### Start SSH server

```bash
sshd
```

### Verify SSH daemon

```bash
ps -A | grep sshd
```

### Verify listening ports

```bash
ss -tln | grep 8022
```

Expected:

```text
LISTEN 0.0.0.0:8022
LISTEN *:8022
```

### Connect from PC

```bash
ssh -p 8022 u0_a248@192.168.1.192
```

### Test SSH Port (PowerShell)

```powershell
Test-NetConnection 192.168.1.192 -Port 8022
```

---

## tmux

### Create session

```bash
tmux new -s phone
```

### List sessions

```bash
tmux ls
```

### Reattach

```bash
tmux attach -t phone
```

### Detach

Press:

```text
Ctrl+B
D
```

### Basic tmux config

```bash
nano ~/.tmux.conf
```

Contents:

```text
set -g mouse on
set -g history-limit 50000
set -g set-clipboard on
```

Reload config:

```bash
tmux source-file ~/.tmux.conf
```

---

## Network Information

### Interfaces

```bash
ifconfig
```

### IP Address

```bash
ip addr show wlan0
```

### Routes

```bash
ip route
```

### DNS

```bash
getprop | grep dns
```

---

## Root / Bootloader Inspection

### Check current user

```bash
id
```

### Check for root

```bash
which su
which magisk
```

### Bootloader lock status

```bash
getprop ro.boot.flash.locked
```

Expected:

```text
1
```

### Verified boot state

```bash
getprop ro.boot.vbmeta.device_state
```

Expected:

```text
locked
```

### OEM unlock state

```bash
getprop | grep -i oem
```

Observed:

```text
sys.oem_unlock_allowed=0
```

---

## Samsung Debloat

### List Samsung packages

```bash
pm list packages | grep samsung
```

### Samsung Health

```bash
pm uninstall --user 0 com.sec.android.app.shealth
```

### SmartThings

```bash
pm uninstall --user 0 com.samsung.android.oneconnect
```

### Samsung Members

```bash
pm uninstall --user 0 com.samsung.android.voc
```

### Samsung Free

```bash
pm uninstall --user 0 com.samsung.android.app.spage
```

### Samsung Global Goals

```bash
pm uninstall --user 0 com.samsung.sree
```

### Smart Switch

```bash
pm uninstall --user 0 com.sec.android.easyMover
```

### Samsung Internet

```bash
pm uninstall --user 0 com.sec.android.app.sbrowser
```

---

## Useful Aliases

Create aliases:

```bash
nano ~/.bash_aliases
```

Contents:

```bash
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cls='clear'
alias ports='ss -tulpn'
alias mem='free -h'
alias disks='df -h'
alias myip='ifconfig wlan0'
```

Load aliases:

```bash
echo 'source ~/.bash_aliases' >> ~/.bashrc
source ~/.bashrc
```

---

## Current Device Summary

```text
Model: SM-A055M
Device: a05m
Android: 15
Security Patch: 2026-09-05
CPU: MediaTek MT6768
RAM: 4 GB
Storage: 64 GB
ABI: arm64-v8a

Bootloader: Locked
VBMeta: Locked
OEM Unlock Allowed: No

ADB over Wi-Fi: Working
scrcpy over Wi-Fi: Working
Termux: Working
SSH: Installed
tmux: Working
```
