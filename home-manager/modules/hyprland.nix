{ lib, config, ... }:
{
  options = {
    hyprlandConfig.enable = lib.mkEnableOption "enables hyprland config";
  };

  config = lib.mkIf config.hyprlandConfig.enable {
    home.file."waybarConfigFiles" = {
      enable = true;
      source = ../../waybar/.config/waybar;
      recursive = false;
      target = ".config/waybar";
    };
    home.file."hyprlandConfigFiles" = {
      enable = true;
      source = ../../hyprland/.config/hypr;
      recursive = false;
      target = ".config/hypr";
    };
  };
}
