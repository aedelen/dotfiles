{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    readingModule.enable = lib.mkEnableOption "Installs Programs for reading/managing books, comics, and manga";
  };

  config = lib.mkIf config.readingModule.enable {
    home.packages = with pkgs; [
      calibre
      mcomix
      yacreader
    ];
  };
}
