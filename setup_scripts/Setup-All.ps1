$url = "https://github.com/dorwi/windows-setup/archive/master.zip"
$zippedRepo = "$PSScriptRoot\windows-setup.zip"
$output = "$PSScriptRoot\windows-setup"
$setup_scripts = "$output\windows-setup-master\setup_scripts"

Invoke-WebRequest -Uri $url -OutFile $zippedRepo

Expand-Archive $zippedRepo -DestinationPath $output

# Enable WSL
Invoke-Expression -Command "$setup_scripts\Enable-DevelopperMode.ps1"

# Enable Winrm
Invoke-Expression -Command "$setup_scripts\winrm-setup.ps1"

# Set the distro for WSL
$ubuntuPath = 'C:\Program Files\Ubuntu'
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile "$ubuntuPath.zip" -UseBasicParsing
Expand-Archive "$ubuntuPath.zip" $ubuntuPath
Remove-Item -Path "$ubuntuPath.zip"
# info at: https://docs.microsoft.com/en-us/windows/wsl/install-on-server


# Add ubuntu to the the user path
$userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("PATH", $userenv + "$ubuntuPath;", "User")

# Restart the system
Restart-Computer
