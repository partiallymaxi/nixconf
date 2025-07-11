{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  options = {
    terminal = {
      default = mkOption {
        type = types.enum [ "kitty" ];
      };

      kitty = {
        enable = mkEnableOption "kitty terminal";
      };
    };
  };

  config = mkIf config.terminal.kitty.enable {
    terminal.exec = mkIf (config.terminal.default == "kitty") "${pkgs.kitty}/bin/kitty";

    programs.kitty = {
      enable = true;

      settings = {
        cursor_shape = "block";

        font_family = mkIf (config.style.fonts.enable) "Codelia Ligatures";
        font_size = 14;

        shell = mkIf (config.shell.exec != "") "${config.shell.exec}";
      };

      shellIntegration = {
        mode = "no-cursor";
      };
    };
  };
}
