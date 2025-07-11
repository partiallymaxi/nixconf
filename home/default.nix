{ utils, lib, config, ... }: with lib; {
  imports = lists.remove darwin.nix utils.listFiles ./.;

}
