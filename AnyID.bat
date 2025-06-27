@ECHO OFF
TITLE Reset AnyDesk ID on Windows

:: === Check for Administrator Rights ===
NET SESSION >NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO [!] This script must be run as Administrator.
    PAUSE
    EXIT /B
)

ECHO [*] Attempting to get current AnyDesk ID (if installed)...
START /B "" "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" --get-id 2>NUL

ECHO.
ECHO [*] Stopping AnyDesk service...
SC stop AnyDesk >NUL 2>&1 && ECHO [+] Service stopped. || ECHO [!] Failed or not running.

ECHO [*] Disabling AnyDesk service startup...
SC config AnyDesk start= disabled >NUL 2>&1

ECHO [*] Killing AnyDesk process...
TASKKILL /F /IM AnyDesk.exe /T >NUL 2>&1 && ECHO [+] Process terminated. || ECHO [*] No running process found.

ECHO [*] Removing AnyDesk from ProgramData...
TAKEOWN /F "%ProgramData%\AnyDesk" /A /R /D Y >NUL 2>&1
ICACLS "%ProgramData%\AnyDesk" /T /C /Q /GRANT Administrators:F System:F >NUL 2>&1
RMDIR /S /Q "%ProgramData%\AnyDesk" >NUL 2>&1 && ECHO [+] ProgramData cleaned.

ECHO [*] Removing AnyDesk from all user profiles...
FOR /D %%U IN ("%SystemDrive%\Users\*") DO (
    IF EXIST "%%U\AppData\Roaming\AnyDesk" (
        TAKEOWN /F "%%U\AppData\Roaming\AnyDesk" /A /R /D Y >NUL 2>&1
        ICACLS "%%U\AppData\Roaming\AnyDesk" /T /C /Q /GRANT Administrators:F System:F >NUL 2>&1
        RMDIR /S /Q "%%U\AppData\Roaming\AnyDesk" >NUL 2>&1
        ECHO [+] Removed AnyDesk config for %%U
    )
)

ECHO [*] Re-enabling AnyDesk service...
SC config AnyDesk start= auto >NUL 2>&1
SC failure AnyDesk reset= 0 actions= restart/5000 >NUL 2>&1
SC start AnyDesk >NUL 2>&1 && ECHO [+] AnyDesk service restarted.

ECHO [*] Trying to relaunch AnyDesk GUI...
IF EXIST "C:\Program Files (x86)\AnyDesk\AnyDesk.exe" (
    START "" "C:\Program Files (x86)\AnyDesk\AnyDesk.exe"
) ELSE IF EXIST "C:\Program Files\AnyDesk\AnyDesk.exe" (
    START "" "C:\Program Files\AnyDesk\AnyDesk.exe"
) ELSE (
    ECHO [!] AnyDesk not found in default locations. Please start it manually.
)

ECHO.
ECHO [✓] AnyDesk reset complete.
PAUSE