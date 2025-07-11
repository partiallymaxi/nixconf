{ utils, lib, config, ... }: with lib; {
  imports = utils.listFiles ./.;
}
