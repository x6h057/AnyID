//go:build linux
// +build linux

package main

import (
	"fmt"
	"os"
	"os/exec"
)

const shScript = `#!/bin/bash

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
`

func main() {
	tmpFile := "reset_anydesk.sh"

	err := os.WriteFile(tmpFile, []byte(shScript), 0755)
	if err != nil {
		fmt.Println("[!] Failed to write shell script:", err)
		return
	}

	fmt.Println("[*] Executing embedded shell script...")
	cmd := exec.Command("sudo", "bash", tmpFile)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin // Required for sudo password prompt

	if err := cmd.Run(); err != nil {
		fmt.Println("[!] Error executing shell script:", err)
		return
	}

	fmt.Println("[✓] Shell script completed.")
}
