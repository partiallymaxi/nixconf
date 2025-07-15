{ pkgs, ... }:
{
  imports = [
    ../../home/default.nix
  ];

  host.is_headless = true;

  shell.fish.enable = true;
  shell.default = "fish";

  programs.core.enable = true;
}
