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
      package = pkgs.gitFull;
      settings = {
        alias = {
          tree = "log --graph --all --format='%Cblue%ae %Creset%ch%n %Cgreen%h %Creset%s'";
        };
        user.name = "Adam Edelen";
        user.email = "aedelen42@gmail.com";
        init = {
          defaultBranch = "main";
        };
        credential.helper = "libsecret";
        url = {
          "ssh://git@github.com" = {
            insteadOf = "https://github.com";
          };
        };
      };
    };
  };
}
