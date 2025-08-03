{pkgs, lib, config, ...}: {
  options = {
    dockerModule.enable = lib.mkEnableOption "enables Docker module";
  };

  config = lib.mkIf config.dockerModule.enable {
    # Enable rootless Docker
    virtualisation.docker = {
      enable = true;
      rootless = {
          enable = true;
          setSocketVariable = true;
      };
    };
  };
}
