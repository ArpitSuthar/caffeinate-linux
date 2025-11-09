# `caffeinate` for Linux

> **Prevent your Linux system from sleeping — just like macOS**

A lightweight, battery-aware, **Linux-only** reimplementation of macOS’s [`caffeinate`](https://ss64.com/mac/caffeinate.html) command.
Prevents idle sleep, display sleep, or full system sleep — safely and efficiently.

Perfect for:
- Long downloads/uploads
- Remote sessions
- Presentations or demos
- Unattended builds or backups

> ⚡ **No disk sleep support (`-m`)** — intentionally excluded for simplicity and portability.

---

## ✨ Features

- ✅ Prevent **idle sleep** (`-i`) — safe on battery
- ✅ Prevent **full sleep** (`-s`) — **only on AC power**
- ✅ **Wake display** & simulate user activity (`-u`)
- ✅ Prevent **display sleep** (`-d`) (GNOME/KDE)
- ✅ Run with **command**, **PID**, or **timeout**
- ✅ **Verbose mode** (`-v`) for transparency
- ✅ **Auto-cleanup** on exit, timeout, or crash
- ✅ **Zero dependencies** beyond systemd & Bash

---

## 📦 Installation

### One-liner (recommended)
```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/caffeinate-linux/main/caffeinate \
  | sudo install -m 755 /dev/stdin /usr/local/bin/caffeinate
```

### Manual install
```bash
# Download script
wget https://raw.githubusercontent.com/yourusername/caffeinate-linux/main/caffeinate
chmod +x caffeinate

# Install
sudo install -m 755 caffeinate /usr/local/bin/

# (Optional) Install man page
sudo install -Dm644 caffeinate.1 /usr/local/share/man/man1/caffeinate.1
sudo mandb  # refresh man database
```

### 🛠️ Make

#### Install (default: `/usr/local`)
```bash
make
sudo make install
```

#### Install to custom prefix (e.g., for testing)
```bash
make PREFIX=/tmp/test
make install DESTDIR=/tmp/staging
```

#### Uninstall
```bash
sudo make uninstall
```

#### Validate before commit
```bash
make validate
```

> ✅ Works on Ubuntu, Fedora, Debian, Arch, and any **systemd-based desktop Linux**.

---

## 🚀 Usage

```bash
# Keep system awake until you press Ctrl+C
caffeinate

# Keep awake for 1 hour
caffeinate -t 3600

# Simulate user activity (wake screen, reset idle timer)
caffeinate -u -t 600

# Run a command with idle sleep prevented
caffeinate -i ./long_task.sh

# Wait until a background process (PID 1234) exits
caffeinate -i -w 1234

# Verbose mode (see what's happening)
caffeinate -v -d -t 120
```

> 💡 **Note**: `-t` is **ignored** when used with a command or `-w`.

---

## 🔋 Battery Safety

- Full sleep prevention (`-s`) is **automatically disabled on battery**.
- Only low-impact idle prevention (`-i`) is allowed when unplugged.
- AC detection uses `upower` or `/sys/class/power_supply`.

---

## ⚙️ Requirements

- `systemd` (for `systemd-inhibit`)
- `bash` 4+
- D-Bus session (for display control in GNOME/KDE)
- Optional: `upower` (improves AC detection)

> Works over SSH — skips display actions when no GUI is detected.

---

## 📚 Man Page

After installing the man page:

```bash
man caffeinate
```

---

## 📄 License

MIT License — free to use, modify, and distribute.

---

## 🙌 Inspired By

- macOS [`caffeinate`](https://ss64.com/mac/caffeinate.html)
- Windows [PowerToys Awake](https://learn.microsoft.com/en-us/windows/powertoys/awake)

---

## 🤖 AI-Assisted Development

This tool was designed and implemented with the assistance of a large language model (LLM).
The core logic, script, man page, and build automation were co-developed through iterative collaboration with an AI agent to ensure correctness, efficiency, and adherence to macOS `caffeinate` semantics — while respecting Linux power management standards.
