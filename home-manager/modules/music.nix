{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    musicModule.enable = lib.mkEnableOption "Installs music players";
  };

  config = lib.mkIf config.musicModule.enable {
    home.packages = with pkgs; [
      # UI
      rhythmbox
      sayonara
      amberol

      # Terminal
      cmus
      moc
      musikcube

      rmpc
      mpd #daemon for rmpc
    ];
  };
}
