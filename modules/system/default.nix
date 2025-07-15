{
  username,
  ...
}:
{

  imports = [ ./core.nix ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "i was here";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];

    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDrwB1o6SQRY7DlJ2JxPw9dedIkbZBCnzpd777RQW3hCAAAABHNzaDo="
    ];
  };

  virtualisation.docker.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  # ssh timeout
  services.fail2ban.enable = true;

}
