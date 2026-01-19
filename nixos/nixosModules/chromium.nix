{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    chromium
  ];

  programs.chromium = {
    enable = true;
    extraOpts = {
      "WebAppInstallForceList" = [
        {
          "custom_name" = "Pumble";
          "create_desktop_shortcut" = true;
          "default_launch_container" = "window";
          "url" = "https://basement.pumble.com";
        }
      ];
      "ExtensionManifestV2Availability" = 2;
    };
  };
}
