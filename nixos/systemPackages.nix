{ config, inputs, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    zsh
    rocmPackages.llvm.clang
    brightnessctl
    rhythmbox # music player

    #Keyboard
    #kanata
    wev # Key id finder

    # Development Env
    tmux
    nodejs_22
    fzf
    fzf-zsh
    ripgrep # find alternative used by neovim telescope
    jdk17
    maven
    fd # find alternative used by neovim telescope

    # CLI Utilites
    fastfetch
    stow
    wget
    curl
    unzip

    # System monitoring
    htop
    btop
    duf

    # Hyprland
    waybar # system bar
    wofi #app launcher
    hyprshot #screenshots
    swaynotificationcenter #recieve notifications
    libnotify #send notifications
    hyprlock # lockscreen
    hypridle # sleep
    hyprpaper # wallpaper
    networkmanagerapplet
    blueman # bluetooth manager
    matugen # gen theme based on image
    rofi # app launcher
    kanshi # monitor management
    pywalfox-native # Theme firefox

    # Clipboard
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
    xboxdrv
    mame-tools
    mupen64plus
    moonlight-qt

    # Utilities
    bitwarden-desktop
  ];
}
