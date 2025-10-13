{
  config,
  lib,
  pkgs,
  pkgs-jetbrains,
  ...
}:
{
  options = {
    jetbrainsModule.enable = lib.mkEnableOption "Installs Jetbrains IDEs";
  };

  config = lib.mkIf config.jetbrainsModule.enable {
    home.packages = with pkgs-jetbrains; [
      jetbrains.idea-ultimate
      jetbrains.webstorm
      jetbrains.goland
      jetbrains.datagrip
    ];
  };
}
