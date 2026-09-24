{ ... }:
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      fonts.packages = with pkgs; [
        jetbrains-mono
      ];
    };
}
