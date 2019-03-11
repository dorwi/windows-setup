# Provisioning Windows 10 Home

The goal is to create a development and media consumption friendly environment in Windows 10. To achieve this, apart from installing various apps, the WSL will be also activated.

## Steps
Before we could run the ansible scripts from WSL, we have a long way to go.
1. Enable the Windows Subsystem for Linux 
    
    From the powershell run
    ```ps1
    ./setup_scripts/Enable-DevelopperMode.ps1
    ```
    additional info
    * https://stackoverflow.com/questions/40033608/enable-windows-10-developer-mode-programmatically

2. 
