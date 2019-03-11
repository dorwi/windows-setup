# SETUP steps
From the power shell run:
```
powershell.exe -ExecutionPolicy ByPass -File setup_scripts/winrm-setup.ps1
```

# Removing spotify appx:
https://www.tenforums.com/software-apps/20372-remove-replace-all-windows-10-apps.html
https://answers.microsoft.com/en-us/windows/forum/windows_8-winapps/how-to-uninstall-a-windows-store-app-using/85ecc099-3de0-406e-a629-8c6c83ef8abe
https://www.tenforums.com/software-apps/14445-uninstall-bloatware-windows-10-came.html
https://www.makeuseof.com/tag/easily-remove-bloatware-windows-10/

# Using the linux subsystem for windows
https://www.jeffgeerling.com/blog/2017/using-ansible-through-windows-10s-subsystem-linux
https://www.infoworld.com/article/3204592/linux/get-started-with-the-windows-subsystem-for-linux.html

# Controlling windows from ansible within WSL
https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html

# Cheat sheet

```bash
# install galaxy roles
ansible-galaxy install --roles-path roles_galaxy weldpua2008.hugo
```


### To run the `ub-devel.yml` playbook, use
```bash
ansible-playbook -i ,localhost ub-devel.yml
```

### To run the `win-devel.yml` playbook, use
```bash
ansible-playbook -i inventory.ini win-devel.yml
```

## Docker
To be able to use docker from WSL, we need to install docker on Windows
since it doesn't work on WSL 
(info https://nickjanetakis.com/blog/docker-tip-73-connecting-to-a-remote-docker-daemon).
To do it (on Windows 10 Home) we need the following:
  1. Install VMWare player
  2. Install Centos7 the VM
    * create user admin
    * run `dhclient -v` (this helped getting an ip for the network device)
  3. Install docker (https://linuxize.com/post/how-to-install-and-use-docker-on-centos-7/)
    ```bash
      sudo yum update
      # dependencies
      sudo yum install yum-utils device-mapper-persistent-data lvm2

      # adding the docker repo
      sudo yum install yum-utils -y
      sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
      sudo yum install docker-ce -y

      sudo systemctl start docker
      sudo systemctl enable docker
    ```
  4. Install docker-compose
    ```bash
      # Install the latest version
      sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
    ```
  5. Configure docker daemon for remote connections
    ```bash
      sudo mkdir -p /etc/systemd/system/docker.service.d
      sudo vi /etc/systemd/system/docker.service.d/options.conf

      # The file should contain
      [Service]
      # Empty ExectStart needed for not getting the error of having more than one exec start
      ExecStart=
      ExecStart=/usr/bin/dockerd -H unix:// -H tcp://0.0.0.0:2375

      sudo systemctl daemon-reload
      sudo systemctl restart docker
    ```
  6. Stop the firewall to enable access
    ```bash
      sudo systemctl stop firewalld
    ```
  7. To run from WSL we need docker and docker-compose installed as well
  and export DOCKER_HOST=tcp://192.168.0.144:2375 
and expose the daemon for connecting from WSL. (info: https://nickjanetakis.com/blog/setting-up-docker-for-windows-and-wsl-to-work-flawlessly)
After that we'll install in WSL Docker and Docker compose (without running the daemon)
To connect to the docker daemon on windows, add:
```sh
echo "export DOCKER_HOST=tcp://localhost:2375" >> ~/.bashrc && source ~/.bashrc
```


# Michelanious

```bash
sudo vi /etc/wsl.conf
# Put the below content to the file
[automount]
root = /
options = "metadata" 
```
