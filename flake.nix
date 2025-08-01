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

    # disabled flakes on work local
    # nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    #
    # agenix.url = "github:ryantm/agenix";
    # agenix-rekey.url = "github:oddlama/agenix-rekey";
    # agenix-rekey.inputs.nixpkgs.follows = "nixpkgs";
    #
    # private-fonts.url = "git+ssh://git@github.com/mostlymaxi/private-fonts.git?shallow=1";
    # private-fonts.inputs.nixpkgs.follows = "nixpkgs";

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
      homeConfigurations = {
        vdi-1 =
          let
            inherit (inputs.nixpkgs) lib;
            mylib = import ./utils.nix { inherit lib; };

            username = "masaparov";
            hostname = "masaparov-1";

            system = "x86_64-linux";

            pkgs = import nixpkgs {
              inherit system;
              config = {
                allowUnfree = true;
              };
            };

            extraSpecialArgs = {
              inherit hostname username mylib;
            };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit extraSpecialArgs pkgs;

            modules = [
              ./hosts/${hostname}/home.nix
            ];
          };
      };

      darwinConfigurations = {
        tangerine =
          let
            inherit (inputs.nixpkgs) lib;
            mylib = import ./utils.nix { inherit lib; };

            username = "masaparov";
            hostname = "tangerine";

            specialArgs = {
              inherit hostname username mylib;
            };
          in
          nix-darwin.lib.darwinSystem {
            inherit specialArgs;
            system = "aarch64-darwin";

            modules = [
              ./hosts/${hostname}

              home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = inputs // specialArgs;

                home-manager.users.${username} = import ./hosts/${hostname}/home.nix;

              }
            ];
          };

        orange =
          let
            inherit (inputs.nixpkgs) lib;
            mylib = import ./utils.nix { inherit lib; };

            username = "maxi";
            hostname = "orange";

            specialArgs = {
              inherit hostname username mylib;
            };
          in
          nix-darwin.lib.darwinSystem {
            inherit specialArgs;
            system = "aarch64-darwin";

            modules = [
              ./hosts/${hostname}

              home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = inputs // specialArgs;

                # home-manager.users.${username} = import ./hosts/${hostname}/${username}/home.nix;
                home-manager.users.${username} = import ./hosts/${hostname}/home.nix;

              }
            ];
          };
      };

      nixosConfigurations = {
        blueberry =
          let
            inherit (inputs.nixpkgs) lib;
            mylib = import ./utils.nix { inherit lib; };

            username = "maxi";
            hostname = "blueberry";

            specialArgs = { inherit hostname username mylib; };
          in
          nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "aarch64-linux";

            modules = [
              ./hosts/${hostname}

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.extraSpecialArgs = inputs // specialArgs;

                # home-manager.users.${username} = import ./hosts/${hostname}/${username}/home.nix;
                home-manager.users.${username} = import ./hosts/${hostname}/home.nix;
              }
            ];
          };

      };
    };

}
