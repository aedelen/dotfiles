# Ubuntu Setup
## Install Ansible
```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```
## Nerd Fonts
1. Download font [from here](https://www.nerdfonts.com/font-downloads)
2. unzip into ~/.fonts
3. Update font list
   ```bash
   fc-cache -fv
   ```
4. Verify its installed
   ```bash
   fc-list|grep Nerd
   ```
### View list of all font names
```bash
    fc-list :lang=en:style=Regular family|sort|more
```
## Brightness controlls
```sudo touch /etc/sudoers.d/brightness```

add the folloing line to it
```%sudo ALL = (root) NOPASSWD: /usr/bin/light```

## Git Credential Manager
```bash
curl -L https://aka.ms/gcm/linux-install-source.sh | sh
git-credential-manager configure
```

## Random Commands

### Keycodes
Determine name of keyboard key
``` xev ```

# Stuff to automate
- [x] add instructions to install Ansible
- [ ] install Neovim
- [ ] install oh-my-zsh
- [ ] install docker
- [ ] install node version manager
- [ ] install nerd font
- [ ] add light command to sudoer file
- [ ] git credential manager
