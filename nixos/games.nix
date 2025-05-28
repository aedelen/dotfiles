{ config, inputs, pkgs, ... }:
{
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
}
