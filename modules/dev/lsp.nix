{ ... }:
{
  flake.modules.nixos.dev =
    { pkgs, ... }:
    {
      home-manager.users.daniel = {
        home.packages = with pkgs; [
          lua-language-server
          nil
          alejandra
          clang-tools
          zls
        ];
      };
    };
}
