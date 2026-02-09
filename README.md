# Adam's Dotfiles
## Theme
### Setting System Theme
```bash
# light
gsettings set org.gnome.desktop.interface color-scheme prefer-light
gsettings set org.gnome.desktop.interface gtk-theme 'Pop'

# dark
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface gtk-theme 'Pop-dark'
```
## NixOS
### Nix Store
[Cleaning the Nix Store](https://nixos.org/manual/nixos/stable/#sec-nix-gc)
```bash
nix-env --list-generations # Lists profile generations
nixos-rebuild -h list-generations # List NixOS Generations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system # alt way to list nixos generations
nix-store --optimise # Removes exact duplicates
nix-collect-garbage --delete-older-than 10d # might need sudo to clean old builds
nix-collect-garbage -d # Deletes everything not used by current build
```
