{ ... }:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      home-manager.users.daniel = {
        home.packages = with pkgs; [
          grim # screenshot
          slurp # region select
          wl-clipboard # clipboard - wl-copy, wl-paste
          wev # keyboard event viewer
          xwayland-satellite # spouští Xwayland démona pro X11 apky pod Niri

          nerd-fonts.jetbrains-mono
          nerd-fonts.symbols-only # jen ikony, fallback pro ostatní fonty
        ];
      };
    };
}
