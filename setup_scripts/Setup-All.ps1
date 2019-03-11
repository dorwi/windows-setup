$url = "https://github.com/dorwi/windows-setup/archive/master.zip"
$zippedRepo = "$PSScriptRoot\windows-setup.zip"
$output = "$PSScriptRoot\windows-setup"
$setup_scripts = "$output\windows-setup-master\setup_scripts"

Invoke-WebRequest -Uri $url -OutFile $zippedRepo

Expand-Archive $zippedRepo -DestinationPath $output

# Enable WSL
Invoke-Expression -Command "$setup_scripts\Enable-DevelopperMode.ps1"
# After this we need to restart


# Enable Winrm
Invoke-Expression -Command "$setup_scripts\winrm-setup.ps1"

# Set the distro for WSL
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.zip -UseBasicParsing
Expand-Archive Ubuntu.zip Ubuntu
# TODO!! Download to a proper location
# https://docs.microsoft.com/en-us/windows/wsl/install-on-server
# set the user path
$userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("PATH", $userenv + "C:\Users\Administrator\Ubuntu", "User")
