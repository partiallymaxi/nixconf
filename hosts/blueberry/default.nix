{ ... }:
{
  imports = [ ../../modules/system.nix ];

  isoImage.makeEfiBootable = true;

  # USB booting
  isoImage.makeUsbBootable = true;

}
