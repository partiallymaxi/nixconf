{
  agenix,
  agenix-rekey,
  osConfig,
  pkgs,
  ...
}:
{
  # imports = [
  #   agenix.homeManagerModules.default
  #   agenix-rekey.homeManagerModules.default
  # ];
  #
  # age.rekey = {
  #   # Obtain this using `ssh-keyscan` or by looking it up in your ~/.ssh/known_hosts
  #   hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI...";
  #   # The path to the master identity used for decryption. See the option's description for more information.
  #   masterIdentities = [ ../../identity.pub ];
  #   #masterIdentities = [ "/home/myuser/master-key" ]; # External master key
  #   #masterIdentities = [
  #   #  # It is possible to specify an identity using the following alternate syntax,
  #   #  # this can be used to avoid unecessary prompts during encryption.
  #   #  {
  #   #    identity = "/home/myuser/master-key.age"; # Password protected external master key
  #   #    pubkey = "age1qyqszqgpqyqszqgpqyqszqgpqyqszqgpqyqszqgpqyqszqgpqyqs3290gq"; # Specify the public key explicitly
  #   #  }
  #   #];
  #   storageMode = "local";
  #   # Choose a directory to store the rekeyed secrets for this host.
  #   # This cannot be shared with other hosts. Please refer to this path
  #   # from your flake's root directory and not by a direct path literal like ./secrets
  #   localStorageDir = ../../. + "/hosts/${osConfig.networking.hostName}/secrets";
  #
  # };

}
