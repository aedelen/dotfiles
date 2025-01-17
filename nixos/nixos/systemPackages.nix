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
    duf
    stow
    zsh
    nodejs_22
    fzf
    fzf-zsh
    ripgrep
    rocmPackages.llvm.clang
    xorg.xmodmap
    xorg.xev
  ];
}
