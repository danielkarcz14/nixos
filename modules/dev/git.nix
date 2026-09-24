{ ... }:
{
  flake.modules.nixos.dev = {
    home-manager.users.daniel = {
      programs.git.enable = true;
    };
  };
}
