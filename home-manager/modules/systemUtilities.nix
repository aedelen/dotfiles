{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    systemUtilModule.enable = lib.mkEnableOption "Installs system utilities";
  };

  config = lib.mkIf config.systemUtilModule.enable {
    home.packages = with pkgs; [
      # System Monitoring
      btop
      htop
      duf

      # REST TUI
      posting

      # terminal display
      bat
      less
      yazi
      lazygit
    ];
  };
}
