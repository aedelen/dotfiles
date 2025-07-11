{
  config,
  inputs,
  pkgs,
  pkgs-syncthing,
  ...
}:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #environment.systemPackages = [ nixpkgs-syncthingtray.syncthingtray ];

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

    # System monitoring
    htop
    btop
    duf

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
    pywalfox-native # Theme firefox
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
  ];
}
