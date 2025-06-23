# 📦 AnyID – Cross-Platform AnyDesk ID Reset Utility

**AnyID** is a cross-platform utility that resets the **AnyDesk ID and configuration** on both Windows and Linux systems. It provides both:

- 🔧 **Compiled Go binaries** (self-contained, fast, portable)
- 🛠 **Manual scripts** (`GenID.bat` and `GenID.sh`) for users who prefer to inspect or modify the reset logic

Ideal for IT admins, pentesters, or power users who need to wipe AnyDesk identifiers and restore it to a clean state.

---

## ⚙ Features

- ✅ Resets AnyDesk ID and deletes config files
- ✅ Kills AnyDesk processes and stops/restarts services
- ✅ Works across all user profiles (Windows)
- ✅ Both scripted (`.bat` / `.sh`) and compiled (`.exe` / ELF) versions
- ✅ Fully standalone — no dependencies
- ✅ Cross-platform & multi-architecture support

---

## 📁 Project Structure

```
├── AnyID-Windows.go       # Embedded Go version for Windows
├── AnyID-Linux.go         # Embedded Go version for Linux
├── GenID.bat              # Manual batch script for Windows
├── GenID.sh               # Manual shell script for Linux
├── build.sh               # Build automation script for all platforms
├── builds/                # Output binaries
└── README.md              # You're reading it!
```

---

## 🛠 Build Instructions

Make sure you have [Go installed](https://golang.org/dl/).

Then simply run:

```bash
chmod +x build.sh
./build.sh
```

This will produce the following binaries in the `builds/` directory:

- `AnyID-Windows32.exe`
- `AnyID-Windows64.exe`
- `AnyID-Linux32`
- `AnyID-Linux64`

Each one embeds and executes the reset logic internally.

---

## 📄 Manual Scripts

If you prefer or require editable/reset scripts, you can use the **manual versions** directly.

### 🔹 On Windows:

Run `GenID.bat` as **Administrator**:

```cmd
Right-click > Run as administrator
```

This will:
- Stop the AnyDesk service
- Kill AnyDesk.exe
- Remove config from ProgramData and user profiles
- Restart AnyDesk and show the new ID

### 🔹 On Linux:

Run `GenID.sh` with `sudo`:

```bash
chmod +x GenID.sh
sudo ./GenID.sh
```

This will:
- Kill AnyDesk
- Remove all config directories
- Restart the service and show the new ID

> These are functionally equivalent to the compiled versions, just easier to modify or extend.

---

## ✅ Usage (Compiled Binaries)

### On Windows:
```cmd
AnyID-Windows64.exe | Right-click > Run as administrator
```

### On Linux:
```bash
chmod +x AnyID-Linux64
sudo ./AnyID-Linux64
```

---

## 💡 Supported Platforms

| OS       | Arch   | Output                   |
|----------|--------|---------------------------|
| Windows  | 64-bit | `AnyID-Windows64.exe`     |
| Windows  | 32-bit | `AnyID-Windows32.exe`     |
| Linux    | 64-bit | `AnyID-Linux64`           |
| Linux    | 32-bit | `AnyID-Linux32`           |

---

## 📋 Requirements

- Go 1.18 or newer (for building)
- Admin / Root
- AnyDesk installed in standard directories

---

## 🛡 Disclaimer

This project is for **educational and administrative use** only. Modifying AnyDesk configuration or identifiers without authorization may violate the AnyDesk Terms of Service or local laws. Use responsibly and at your own risk.
