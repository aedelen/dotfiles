{ config, lib, pkgs, ... }:
{
  options = {
    games.enable = lib.mkEnableOption "Installs Games and associated programs";
  };

  config = lib.mkIf config.games.enable {
    environment.systemPackages = with pkgs; [
      # Games
      wineWowPackages.stagingFull
      winetricks
      mgba
      #xboxdrv
      mame-tools
      mupen64plus
      moonlight-qt
    ];
  };
}
