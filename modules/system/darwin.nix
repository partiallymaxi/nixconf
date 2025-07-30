{
  username,
  config,
  lib,
  ...
}:
{

  imports = [ ./core.nix ];

  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };

  nix.gc = lib.mkIf config.nix.enable {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
    options = "--delete-older-than 7d";
  };

}
