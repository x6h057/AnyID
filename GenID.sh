#!/bin/bash

# === Check for root privileges ===
if [ "$EUID" -ne 0 ]; then
  echo "[!] This script must be run with sudo or as root."
  exit 1
fi

echo "[*] Current AnyDesk ID (if available):"
anydesk --get-id 2>/dev/null || echo "[!] Unable to retrieve AnyDesk ID."

echo
echo "[*] Closing AnyDesk application..."
pkill anydesk 2>/dev/null && echo "[+] AnyDesk process terminated." || echo "[*] No running AnyDesk process found."

echo "[*] Stopping AnyDesk service..."
systemctl stop anydesk && echo "[+] AnyDesk service stopped." || echo "[!] Failed to stop AnyDesk service."

echo "[*] Deleting AnyDesk configuration and ID..."
rm -rf /etc/anydesk /var/lib/anydesk ~/.anydesk && echo "[+] AnyDesk data removed." || echo "[!] Some config files could not be removed."

echo "[*] Starting AnyDesk service..."
systemctl start anydesk && echo "[+] AnyDesk service started." || echo "[!] Failed to start AnyDesk service."

echo
echo "[✓] AnyDesk ID has been reset."