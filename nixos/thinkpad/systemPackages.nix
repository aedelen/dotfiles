{
  config,
  inputs,
  pkgs,
  pkgs-syncthing,
  pkgs-unstable,
  ...
}:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    zsh
    rocmPackages.llvm.clang
    brightnessctl
    vlc

    #Keyboard
    wev # Key id finder

    # Development Env
    nodejs_22
    fzf
    fzf-zsh
    jdk
    maven

    # CLI Utilites
    fastfetch
    stow
    wget
    curl
    unzip
    file

    # Hyprland
    waybar # system bar
    wofi # app launcher
    hyprshot # screenshots
    swaynotificationcenter # recieve notifications
    libnotify # send notifications
    hyprlock # lockscreen
    hypridle # sleep
    hyprpaper # wallpaper
    networkmanagerapplet
    blueman # bluetooth manager
    matugen # gen theme based on image
    rofi # app launcher
    kanshi # monitor management
    #syncthingtray
    pkgs-syncthing.syncthingtray

    # Clipboard
    wl-clip-persist
    wl-clipboard
    cliphist

    # Mount USB Drives
    usbutils
    udiskie
    udisks

    # Utilities
    bitwarden-desktop

    firefoxpwa
  ];
}
