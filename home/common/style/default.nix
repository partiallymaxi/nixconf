{ config, utils, lib, ... }: with lib; {
  imports = utils.listFiles ./.;

  options = {
    style = {
      enable = mkEnableOption "all style settings";

      fonts = {
        enable = mkEnableOption "default fonts";
      };
    };
  };

  config = mkIf config.style.enable {
    style.fonts.enable = true;
  };

}
