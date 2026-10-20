# LSP servery pro Neovim (~/.config/nvim/lua/config/lsp.lua)
{ ... }:
{
  flake.modules.nixos.dev =
    { pkgs, ... }:
    {
      home-manager.users.daniel = {
        home.packages = with pkgs; [
          lua-language-server # Lua
          nil # Nix
          alejandra # formátovač pro .nix, volá ho nil
          clang-tools # clangd pro C/C++
          zls # Zig
        ];
      };
    };
}
