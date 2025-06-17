# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, pkgs, pkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./systemPackages.nix
      ./nixos-keyboard.nix
      ../nixosModules/docker.nix
      #<home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkpad"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.rygel.enable = false; # Disable upnp server

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable ZSH
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = false;
  };

  # Define additional groups
  #users.groups.uinput = {};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    adam = {
      isNormalUser = true;
      description = "Adam";
      shell = pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" "input" ];
      packages = with pkgs; [
      ];
    };
    test = {
      isNormalUser = true;
      description = "Test";
      extraGroups = [ "networkmanager" "input" ];
      packages = [pkgs."discord" pkgs-unstable."gallery-dl"];
    };
  };


  #environment.systemPackages = with pkgs-unstable; [
  #  neovim
  #];

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Install Nerdfonts
  fonts.packages = with pkgs; [ 
    nerd-fonts.geist-mono
    nerd-fonts.commit-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.profont
    nerd-fonts.jetbrains-mono
  ];

  # Enable rootless Docker
  /*virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };*/

  dockerModule.enable = true;

  # Enable Hyprland
  programs.hyprland.enable = true;

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "adam";
    dataDir = "/home/adam/Documents/syncthing/";
    openDefaultPorts = true;
  };

  # Configure local domains
  networking.hosts = {
    "192.168.1.254" = ["adamnas.local"];
    "192.168.1.197" = ["onion.local"];
    "192.168.1.26" = ["dockerman.local" "dockerman"];
  };

  # Automount USB Drives
  services.devmon.enable = true;
  services.gvfs.enable = true; 
  services.udisks2.enable = true;
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
