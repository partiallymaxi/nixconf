{ hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system
  ];

  networking.hostName = "${hostname}";

  host.is_headless = true;

  boot = {
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
  };

  system = {
    stateVersion = "25.11";
  };
}
