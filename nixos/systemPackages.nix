{ config, inputs, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    neovim
    tmux
    fastfetch
    stow
    zsh
    nodejs_22
    fzf
    fzf-zsh
    ripgrep
    rocmPackages.llvm.clang
    xorg.xmodmap
    xorg.xev
    brightnessctl
    rhythmbox # music player
    unzip

    # System monitoring
    htop
    btop
    duf

    # Hyprland
    waybar
    wofi
    hyprshot #screenshots
    swaynotificationcenter #recieve notifications
    libnotify #send notifications
    hyprlock
    hypridle
    hyprpaper
    networkmanagerapplet
    blueman
    matugen # gen theme based on image
    rofi
    kanshi
    pywalfox-native
    wl-clip-persist
    wl-clipboard
    cliphist

    # Mount USB Drives
    usbutils
    udiskie
    udisks

    # Games
    wineWowPackages.stagingFull 
    winetricks
    mgba
  ];
}
