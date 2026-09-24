{ ... }:
{
  flake.modules.nixos.dev =
    { pkgs, ... }:
    {
      home-manager.users.daniel = {
        home.packages = with pkgs; [
          fastfetch
          neovim
          gcc
          gnumake
          ripgrep
          claude-code
        ];
      };
    };
}
