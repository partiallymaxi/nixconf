{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    agenix.url = "github:ryantm/agenix";
    agenix-rekey.url = "github:oddlama/agenix-rekey";
    agenix-rekey.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }:
    {
      darwinConfigurations = {
        orange =
          let
            inherit (inputs.nixpkgs) lib;
            utils = import ./utils.nix { inherit lib; };
            username = "maxi";
            specialArgs = {
              inherit username utils;
            };
          in
          nix-darwin.lib.darwinSystem {
            inherit specialArgs;
            system = "aarch64-darwin";

            modules = [
              ./hosts/orange

              home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.${username} = import ./users/${username}/darwin-home.nix;

              }
            ];
          };
      };

      nixosConfigurations = {
        blueberry =
          let
            username = "maxi";
            specialArgs = { inherit username; };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "aarch64-linux";

            modules = [
              ./hosts/blueberry

              # nixos-hardware.nixosModules.raspberry-pi-4
              "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"

              # "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
              # "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"

              # home-manager.nixosModules.home-manager
              # {
              #   home-manager.useGlobalPkgs = true;
              #   home-manager.useUserPackages = true;
              #
              #   home-manager.extraSpecialArgs = inputs // specialArgs;
              #   home-manager.users.${username} = import ./users/${username}/home.nix;
              # }
            ];
          };

      };
    };

}
