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
        # niri, package a systemd unit se instalují na systémové úrovni (programs.niri.enable
        # výše) — tenhle modul tu je jen kvůli generování ~/.config/niri/config.kdl z Nixu.
        wayland.windowManager.niri = {
          enable = true;
          package = null;
          systemd.enable = false;
          portalPackage = null;
          xwaylandSatellitePackage = null;

          settings = {
            # Monitor setup — force 180Hz on the MSI ultrawide
            output = {
              _args = [ "DP-2" ];
              mode = "3440x1440@180.000";
              scale = 1.0;
            };

            input = {
              keyboard.xkb.layout = "us";
              touchpad = {
                tap = { };
                natural-scroll = { };
              };
              mouse = { };
            };

            layout = {
              gaps = 6;
              center-focused-column = "never";
              preset-column-widths._children = [
                { proportion = 0.33333; }
                { proportion = 0.5; }
                { proportion = 0.66667; }
              ];
              default-column-width.proportion = 0.5;
              focus-ring.off = { };
              border.off = { };
            };

            cursor = {
              xcursor-theme = "default";
              xcursor-size = 24;
            };

            # Spawn xwayland-satellite at startup (for X11 apps)
            spawn-at-startup = "xwayland-satellite";

            binds = {
              # === Basic session ===
              "Mod+Shift+Slash".show-hotkey-overlay = { }; # Show all keybinds
              "Mod+T".spawn = [ "ghostty" ];
              "Mod+D".spawn = [ "noctalia" "msg" "panel-toggle" "launcher" ];
              "Mod+Q".close-window = { };
              "Mod+Shift+E".quit = { };
              "Mod+Shift+P".power-off-monitors = { };
              "Mod+Escape".spawn = [ "noctalia" "msg" "session" "lock" ];

              # === Screenshots (built-in in Niri) ===
              "Print".spawn = [ "noctalia" "msg" "screenshot-region" ];
              "Ctrl+Print".spawn = [ "noctalia" "msg" "screenshot-fullscreen" ];

              # === Focus (like vim) ===
              "Mod+Left".focus-column-left = { };
              "Mod+Right".focus-column-right = { };
              "Mod+Up".focus-window-up = { };
              "Mod+Down".focus-window-down = { };
              "Mod+H".focus-column-left = { };
              "Mod+L".focus-column-right = { };
              "Mod+K".focus-window-up = { };
              "Mod+J".focus-window-down = { };

              # === Move windows ===
              "Mod+Shift+Left".move-column-left = { };
              "Mod+Shift+Right".move-column-right = { };
              "Mod+Shift+Up".move-window-up = { };
              "Mod+Shift+Down".move-window-down = { };
              "Mod+Shift+H".move-column-left = { };
              "Mod+Shift+L".move-column-right = { };
              "Mod+Shift+K".move-window-up = { };
              "Mod+Shift+J".move-window-down = { };

              # === Workspaces (Niri má "nekonečné" workspaces vertikálně) ===
              "Mod+U".focus-workspace-down = { };
              "Mod+I".focus-workspace-up = { };
              "Mod+Ctrl+U".move-column-to-workspace-down = { };
              "Mod+Ctrl+I".move-column-to-workspace-up = { };

              "Mod+1".focus-workspace = 1;
              "Mod+2".focus-workspace = 2;
              "Mod+3".focus-workspace = 3;
              "Mod+4".focus-workspace = 4;
              "Mod+5".focus-workspace = 5;
              "Mod+6".focus-workspace = 6;
              "Mod+7".focus-workspace = 7;
              "Mod+8".focus-workspace = 8;
              "Mod+9".focus-workspace = 9;
              "Mod+Shift+1".move-column-to-workspace = 1;
              "Mod+Shift+2".move-column-to-workspace = 2;
              "Mod+Shift+3".move-column-to-workspace = 3;
              "Mod+Shift+4".move-column-to-workspace = 4;
              "Mod+Shift+5".move-column-to-workspace = 5;
              "Mod+Shift+6".move-column-to-workspace = 6;
              "Mod+Shift+7".move-column-to-workspace = 7;
              "Mod+Shift+8".move-column-to-workspace = 8;
              "Mod+Shift+9".move-column-to-workspace = 9;

              # === Column width ===
              "Mod+R".switch-preset-column-width = { };
              "Mod+F".maximize-column = { };
              "Mod+Shift+F".fullscreen-window = { };
              "Mod+C".center-column = { };

              # === Volume (media keys) ===
              "XF86AudioRaiseVolume".spawn = [ "noctalia" "msg" "volume-up" ];
              "XF86AudioLowerVolume".spawn = [ "noctalia" "msg" "volume-down" ];
              "XF86AudioMute".spawn = [ "noctalia" "msg" "volume-mute" ];
              "XF86AudioMicMute".spawn = [ "noctalia" "msg" "mic-mute" ];

              # === Noctalia ===
              "Mod+Space".spawn = [ "noctalia" "msg" "panel-toggle" "launcher" ];
              "Mod+N".spawn = [ "noctalia" "msg" "panel-toggle" "notifications" ];
              "Mod+Comma".spawn = [ "noctalia" "msg" "settings-toggle" ];
              "Mod+Ctrl+L".spawn = [ "noctalia" "msg" "panel-toggle" "session" ];
            };
          };
        };
      };
    };
}
