{...}: {
  flake.modules.nixos.dev = {pkgs, ...}: {
    home-manager.users.daniel = {
      home.packages = with pkgs; [
        fastfetch
        neovim
        zed-editor
        tree-sitter
        gcc
        gdb
        gnumake
        (python3.withPackages (ps: [
          ps.tomlkit
          ps.pytest
          ps.debugpy
        ]))
        uv
        ripgrep
        claude-code
        codex
      ];
    };
  };
}
