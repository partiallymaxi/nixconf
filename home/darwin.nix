{ username, ... }: {
  home.homeDirectory = "/Users/${username}";

  imports = [ ./core.nix ];
}
