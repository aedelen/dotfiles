# Ubuntu Setup
## Install Ansible
```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```
Run ansible playbooks in PC_Setup
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
## Brightness controls
```sudo touch /etc/sudoers.d/brightness```

add the folloing line to it
```%sudo ALL = (root) NOPASSWD: /usr/bin/light```

## Git Credential Manager
```bash
curl -L https://aka.ms/gcm/linux-install-source.sh | sh
git-credential-manager configure
```
## Setting System Theme
```bash
# light
gsettings set org.gnome.desktop.interface color-scheme prefer-light
gsettings set org.gnome.desktop.interface gtk-theme 'Pop'

# dark
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme 'Pop-dark'
```

## Random Commands

### Keycodes
Determine name of keyboard key
``` xev ```
### Mod Keys
List mod keys
```xmodmap```
https://wiki.archlinux.org/title/Xmodmap

### WIFI
Open terminal ui to manage wifi connection
```nmtui```

### Monitors
Show names of active monitors
```xrandr```

# Stuff to automate
- [x] add instructions to install Ansible
- [ ] install [Neovim](https://github.com/neovim/neovim)
- [ ] install [oh-my-zsh](https://ohmyz.sh/#install)
- [x] install docker
  - [ ] make user to add to docker group a var instead of hardcoded as 'adam'
- [ ] install [node version manager](https://github.com/nvm-sh/nvm)
- [ ] install [nerd font](https://www.nerdfonts.com/)
- [ ] add light command to sudoer file
- [ ] git credential manager
- [ ] tmux plugin manager
- [ ] setup Download cleanup cron
- [ ] install [hurl](https://github.com/Orange-OpenSource/hurl)
