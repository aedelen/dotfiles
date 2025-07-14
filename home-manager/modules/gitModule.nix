{ lib, config, ... }:
{
  options = {
    gitModule.enable = lib.mkEnableOption "enables personal git config";
  };
  config = lib.mkIf config.gitModule.enable {
    programs.git = {
      enable = true;
      userName = "Adam Edelen";
      userEmail = "aedelen42@gmail.com";
      aliases = {
        tree = "log --oneline --graph --decorate --all";
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
    };
  };
}
