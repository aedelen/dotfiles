{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    gitModule.enable = lib.mkEnableOption "enables personal git config";
  };
  config = lib.mkIf config.gitModule.enable {
    programs.git = {
      enable = true;
      userName = "Adam Edelen";
      userEmail = "aedelen42@gmail.com";
      package = pkgs.gitFull;
      aliases = {
        tree = "log --graph --all --format='%Cblue%ae %Creset%ch%n %Cgreen%h %Creset%s'";
      };
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        credential.helper = "libsecret";
      };
    };
  };
}
