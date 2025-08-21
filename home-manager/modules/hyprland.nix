{ lib, config, ... }:
{
  options = {
    hyprlandConfig.enable = lib.mkEnableOption "enables hyprland config";
  };

  config = lib.mkIf config.hyprlandConfig.enable {
    home.file."waybarConfigFiles" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/adam/.dotfiles/waybar/.config/waybar";
      target = ".config/waybar";
    };
    home.file."hyprlandConfigFiles" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/adam/.dotfiles/hyprland/.config/hypr";
      target = ".config/hypr";
    };
  };
}
