{ lib, config, ... }:
{
  options = {
    hyprlandConfig.enable = lib.mkEnableOption "enables hyprland config";
  };

  config = lib.mkIf config.hyprlandConfig.enable {
    home.file."hyprlandCofigFiles" = {
      enable = true;
      #source = ../../hyprland/.config/hypr;
      source = config.lib.file.mkOutOfStoreSymlink "/home/adam/.dotfiles/hyprland/.config/hypr";
      target = ".config/hypr";
    };
  };
}
