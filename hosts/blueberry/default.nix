{ pkgs, ... }:
{
  imports = [ ../../modules/system.nix ];

  networking.hostName = "blueberry";

  boot = {
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
  };

}
