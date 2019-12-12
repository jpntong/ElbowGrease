@echo off
echo Waiting to connect Network Drives
echo Press any key to skip countdown and connect immediately
timeout /t 45
Rem drives connect as follows
net use Z: \\fs\transfer
net use R: \\s-001.corp.local\renders
net use T: \\s-014.corp.local\textures
net use S: \\s-001.corp.local\temp
Rem net use by itself echos a list of connected drives
net use
echo "Drives are mapped if R:, S:, T:, and Z: are listed above"
timeout /t 1 /nobreak >NUL
echo exiting...
timeout /t 5 /nobreak >NUL
exit