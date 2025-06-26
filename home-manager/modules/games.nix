{ config, lib, pkgs, ... }:
{
  options = {
    games.enable = lib.mkEnableOption "Installs Games and associated programs";
  };

  config = lib.mkIf config.games.enable {
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
