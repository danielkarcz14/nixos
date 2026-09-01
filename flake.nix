{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      # Modules shared by every host
      commonModules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.daniel = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];

      # Helper: build a nixosSystem given a host-specific module
      mkHost = hostModule: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ [ hostModule ];
      };
    in {
      nixosConfigurations = {
        nixos-btw    = mkHost ./hosts/desktop;
        nixos-laptop = mkHost ./hosts/laptop;
      };
    };
}
