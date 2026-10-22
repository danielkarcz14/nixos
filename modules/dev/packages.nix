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
          (python3.withPackages (ps: [ ps.tomlkit ]))
          uv
          ripgrep
          claude-code
          codex
        ];
      };
    };
}
