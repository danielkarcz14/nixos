{ ... }:
{
  flake.modules.nixos.software =
    { pkgs, ... }:
    {
      home-manager.users.daniel = {
        home.packages = with pkgs; [
          spotify
        ];
      };
    };
}
