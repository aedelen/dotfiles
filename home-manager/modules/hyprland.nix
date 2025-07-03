{ lib, config, ... }:
{
  options = {
    hyprlandConfig.enable = lib.mkEnableOption "enables hyprland config";
  };

  config = lib.mkIf config.hyprlandConfig.enable {
    home.file."hyprlandCofigFiles" = {
      enable = true;
      source = ../../hyprland/.config/hypr;
      target = ".config/hypr";
    };
  };
}
