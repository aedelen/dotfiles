{ config, lib, pkgs, ... }:
{
  options = {
    gamesModule.enable = lib.mkEnableOption "Installs Games and associated programs";
  };

  config = lib.mkIf config.gamesModule.enable {
    home.packages = with pkgs; [
      wineWowPackages.stagingFull
      winetricks
      mgba
      mame-tools
      mupen64plus
      moonlight-qt
    ];
  };
}
