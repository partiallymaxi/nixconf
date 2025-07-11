{
  pkgs,
  lib,
  config,
  ...
}:
let
  codelia = pkgs.callPackage ../../../packages/codelia { };
in
{

  # options = {
  #   style = {
  #     fonts = {
  #       default = "Caskaydia";
  #     };
  #   };
  # };

  config = lib.mkIf (config.style.fonts.enable == true) {
    home.packages = with pkgs; [
      nerd-fonts.caskaydia-cove # includes ligatures <=>
      nerd-fonts.caskaydia-mono

      noto-fonts
      noto-fonts-emoji

      codelia

    ];

    fonts.fontconfig.enable = true;
  };
}
