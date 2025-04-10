{ config, lib, pkgs, ... }:

{
  # Enable the uinput module
  boot.kernelModules = [ "uinput" ];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-G710.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };
  
  # Enable Service
  services.kanata = {
    enable = true;
    keyboards = {
      G710 = {
        devices = [
          # Use `ls /dev/input/by-path/` to find your keyboard devices.
          "/dev/input/by-path/pci-0000:3d:00.0-usbv2-0:1.3:1.0-event-kbd"
          "/dev/input/by-path/pci-0000:3d:00.0-usbv2-0:1.3:1.1-event-kbd"
          "/dev/input/by-path/pci-0000:3d:00.0-usb-0:1.3:1.0-event-kbd"
          "/dev/input/by-path/pci-0000:3d:00.0-usb-0:1.3:1.1-event-kbd"
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        configFile = ../kanata/.config/kanata.conf;
      };
    };
  };
}
