{ inputs, ... }:
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      system.stateVersion = "26.05";

      users.users.daniel = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        packages = with pkgs; [
          tree
        ];
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
      };

      home-manager.users.daniel = {
        home = {
          username = "daniel";
          homeDirectory = "/home/daniel";
          stateVersion = "26.05";
        };

        programs.home-manager.enable = true;
      };
    };
}
