{
  description = "A very basic flake";
  inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
	home-manager = {
	    url = "github:nix-community/home-manager/release-26.05";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
  };    
  outputs = { self, nixpkgs, home-manager, ... }: {
      nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";	
	  modules = [ 
		./configuration.nix
		./hosts/desktop
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
      };
    };
}
