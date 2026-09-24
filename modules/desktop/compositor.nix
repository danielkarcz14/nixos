{ ... }:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      # Required for the NVIDIA kernel modules (nvidia/nvidia_modeset/nvidia_drm) to be
      # loaded, even though there's no X11 window manager anymore — niri is Wayland-only.
      services.xserver.enable = true;
      services.displayManager.ly.enable = true;

      programs.niri.enable = true;

      # xdg-desktop-portal pro Wayland (potřeba pro screensharing, file pickers atd.)
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
      };

      home-manager.users.daniel = {
        home.file.".config/niri".source = ../../niri;
      };
    };
}
