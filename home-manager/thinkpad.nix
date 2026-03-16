# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ config, pkgs, lib, ... }:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    modules/home-manager-modules.nix
    modules/hyprland.nix
  ];

  home = {
    username = "adam";
    homeDirectory = "/home/adam";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    #communications
    discord
    thunderbird
    ghostty
    obsidian
    alacritty
    filezilla
    ksnip # Screenshot annotations
  ];

  # Play some games
  gamesModule.enable = false;

  # Enable home-manager
  programs.home-manager.enable = true;

  musicModule.enable = true;
  readingModule.enable = true;

  # Enable hyprland
  hyprlandConfig.enable = true;

  # Install Jetbrains IDEs
  jetbrainsModule.enable = true;

  # Set default apps
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "ksnip.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  xdg.desktopEntries.ksnip = {
    name = "kSnip";
    exec = "${pkgs.ksnip}/bin/ksnip";
  };

  home.file =
    let
      symlink = config.lib.file.mkOutOfStoreSymlink;
      dotfiles = config.home.homeDirectory + "/.dotfiles";
    in
    {
      ".ssh/config".source = symlink dotfiles + "/ssh/.ssh/config";
      ".config/kanshi/config".source = ../kanshi/.config/kanshi/config;
      ".npmrc".source = symlink dotfiles + "/node/.npmrc";
    };

  systemd.user.services.download-cleanup = {
    Unit = {
      Description = "Clean old files from download folder";
    };

    Service = {
      Type = "oneshot";
      # Provide the necessary binaries to the service environment
      Environment = [
        ''PATH=${ lib.makeBinPath [
            pkgs.coreutils-full # for date
            pkgs.findutils # for find
            pkgs.bash
          ]}''
      ];
      ExecStart = ''
        ${pkgs.bash}/bin/bash -c "date >> ~/Downloads/nightlyCleanup.log && find ~/Downloads/ -ctime +30 -print -delete >> ~/Downloads/nightlyCleanup.log"
      '';
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers.download-cleanup = {
    Timer = {
      # Run once a day at midnight
      OnCalendar = "daily";
      # Ensures the job runs shortly after boot if the computer was off during the scheduled time
      Persistent = true;
      Unit = "download-cleanup.service";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
