# Provisioning Windows 10 Home

The goal is to create a development and media consumption friendly environment in Windows 10. To achieve this, apart from installing various apps, the WSL will be also activated.

## Steps
1. Before we could run the ansible scripts from WSL, we need to enable the WSL, and enable the winrm access to the system.
    * Run the `Setup-All.ps1` powershell script, which will download the required scripts. From an elevated powershell run
      ```ps1
      .\Setup-All.ps1
      ```
      Note: it will restart the system
    * After the restart, run the ubuntu shell and setup a user
      ```bash
      user: dorwi
      password: secure
      ```  
2. Now we can clone the repo. Run from WSL:
   ```bash
   cd ~
   git clone https://github.com/dorwi/windows-setup.git
   ```
3. Install ansible
   ```bash
   sudo apt-add-repository ppa:ansible/ansible

   sudo apt-get update -y
   sudo apt-get upgrade -y
   
   sudo apt-get install ansible -y
   ```

4. Run the playbooks
   ```bash
   cd windows-setup
   ansible-galaxy install -r requirements.yml
   ansible-playbook -i ,localhost ub-devel.yml
   ansible-playbook -i inventory.ini win-devel.yml 
   ```
