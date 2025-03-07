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
  ];
}
