{
  pkgs,
  lib,
  config,
  ...
}:
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

      # codelia
      # tabulamore-script

    ];

    fonts.fontconfig.enable = true;
  };
}
