{ ... }:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      # Správce souborů (lehký, GTK)
      programs.thunar = {
        enable = true;
        plugins = with pkgs; [
          thunar-volman # automatické připojení USB disků
        ];
      };
      programs.xfconf.enable = true; # ukládá nastavení Thunaru
      services.gvfs.enable = true; # koš, USB disky, síťové složky
      services.tumbler.enable = true; # náhledy obrázků a PDF

      home-manager.users.daniel = {
        home.packages = with pkgs; [
          loupe # jednoduchý prohlížeč obrázků (šipkami listuje složkou)
        ];

        xdg.mimeApps.defaultApplications = {
          "inode/directory" = [ "thunar.desktop" ];
          "image/png" = [ "org.gnome.Loupe.desktop" ];
          "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
          "image/webp" = [ "org.gnome.Loupe.desktop" ];
          "image/gif" = [ "org.gnome.Loupe.desktop" ];
          "image/heic" = [ "org.gnome.Loupe.desktop" ];
        };

        wayland.windowManager.niri.settings.binds = {
          "Mod+E".spawn = [ "thunar" ];
        };
      };
    };
}
