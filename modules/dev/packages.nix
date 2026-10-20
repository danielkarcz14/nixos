{ ... }:
{
  flake.modules.nixos.dev =
    { pkgs, ... }:
    {
      home-manager.users.daniel = {
        home.packages = with pkgs; [
          fastfetch
          neovim
	  tree-sitter
          gcc
          gdb
          gnumake
          ripgrep
          claude-code
          codex
        ];
      };
    };
}
