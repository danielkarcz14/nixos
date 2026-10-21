{...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-volman
      ];
    };
    programs.xfconf.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    home-manager.users.daniel = {
      home.packages = with pkgs; [
        loupe
      ];

      xdg.mimeApps.defaultApplications = {
        "inode/directory" = ["thunar.desktop"];
        "image/png" = ["org.gnome.Loupe.desktop"];
        "image/jpeg" = ["org.gnome.Loupe.desktop"];
        "image/webp" = ["org.gnome.Loupe.desktop"];
        "image/gif" = ["org.gnome.Loupe.desktop"];
        "image/heic" = ["org.gnome.Loupe.desktop"];
      };

      wayland.windowManager.niri.settings.binds = {
        "Mod+E".spawn = ["thunar"];
      };
    };
  };
}
