{
  username,
  pkgs,
  ...
}:
{

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    curl
    wget
    git
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nix.linux-builder.enable = true;

  nix.linux-builder = {
    ephemeral = true;
    maxJobs = 4;
    config = {
      virtualisation = {
        darwin-builder = {
          diskSize = 80 * 1024;
          memorySize = 16 * 1024;
        };
        cores = 6;
      };
    };
  };

  networking.hostName = "orange";

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;
    defaults = {
      CustomUserPreferences = {
        # Avoid creating .DS_Store files on network or USB volumes
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

      };
      # Show hidden files in Finder
      finder = {
        AppleShowAllFiles = true;
      };

      dock = {
        mineffect = "scale";
        autohide = false;
      };

      trackpad = {
        Clicking = true;
      };

      # Disable "Natural" scrolling direction
      NSGlobalDomain."com.apple.swipescrolldirection" = false;
    };

    primaryUser = "${username}";
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # annoying MacOS stuff
  # this needs to be enabled both here AND in home-manager
  programs.fish.enable = true;

  users.users.${username} = {
    name = "${username}";
    home = "/Users/${username}";
  };

  # Enables TouchID for sudo operations
  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    # install apps from the Mac App Store
    masApps = { };

    brews = [ "mas" ];

    casks = [
      "discord"
      "kitty"
      "steam"
      "spotify"
      "firefox"
    ];

    enable = true;
    global.autoUpdate = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    # remove all Homebrew packages and casks not managed by nix-darwin
    onActivation.cleanup = "zap";
  };
}
