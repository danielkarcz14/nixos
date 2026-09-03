{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia.url = "github:noctalia-dev/noctalia";
    # Note: záměrně NEmáme inputs.nixpkgs.follows — zachovává kompatibilitu s Cachix cache
  };

  outputs = { self, nixpkgs, home-manager, noctalia, ... }@inputs:
    let
      commonModules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            users.daniel = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];

      mkHost = hostModule: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = commonModules ++ [ hostModule ];
      };
    in {
      nixosConfigurations = {
        nixos-btw    = mkHost ./hosts/desktop;
        nixos-laptop = mkHost ./hosts/laptop;
      };
    };
}
