{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    podmanModule.enable = lib.mkEnableOption "enables Podman module";
  };

  config = lib.mkIf config.podmanModule.enable {
    virtualisation.podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    environment.systemPackages = with pkgs; [ podman-compose ];
  };
}
