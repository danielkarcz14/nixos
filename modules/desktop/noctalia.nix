{ inputs, ... }:
{
  flake.modules.nixos.desktop =
    { ... }:
    {
      imports = [ inputs.noctalia.nixosModules.default ];

      programs.noctalia = {
        enable = true;
        recommendedServices.enable = true;
      };

      home-manager.users.daniel =
        { lib, ... }:
        let
          wallpaper = "/home/daniel/Pictures/wallpapers/y4cxvsb8hbk71.png";
        in
        {
          imports = [ inputs.noctalia.homeModules.default ];

          xdg.configFile."noctalia/templates/neovim.lua".source = ./theme/neovim-palette.lua;

          # Whole look lives in config.toml below. The GUI still writes its tweaks to
          # ~/.local/state/noctalia/settings.toml, which overrides this file — to keep a
          # GUI change, copy it here and empty that file.
          home.activation.noctaliaSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            f="$HOME/.local/state/noctalia/settings.toml"
            if [ -L "$f" ]; then rm "$f"; fi
          '';

          programs.noctalia = {
            enable = true;
            systemd.enable = true;
            settings = {
              shell = {
                font_family = "JetBrains Mono";
                # Automaticky kopíruje vzhled do noctalia-greeter při změně wallpaperu/tématu/fontu
                greeter_sync.auto_sync = true;
              };

              theme = {
                mode = "dark";
                source = "wallpaper";
                wallpaper_scheme = "m3-content";
                builtin = "Catppuccin";
                community_palette = "Everforest Alt";
                templates = {
                  enable_builtin_templates = true;
                  builtin_ids = [ "ghostty" ];
                  user.neovim = {
                    input_path = "$XDG_CONFIG_HOME/noctalia/templates/neovim.lua";
                    output_path = "$XDG_CACHE_HOME/noctalia/neovim-palette.lua";
                  };
                };
              };

              wallpaper = {
                enabled = true;
                default.path = wallpaper;
                monitors.DP-2.path = wallpaper;
              };

              location.auto_locate = true;

              bar.default = {
                thickness = 30;
                background_opacity = 0.85;
                font_family = "JetBrains Mono";
                margin_edge = 5;
                margin_ends = 300;
                widget_spacing = 10;
                start = [ "workspaces" ];
                center = [
                  "clock"
                  "weather"
                  "media"
                ];
                end = [
                  "cpu"
                  "ram"
                  "tray"
                  "notifications"
                  "clipboard"
                  "network"
                  "bluetooth"
                  "volume"
                  "brightness"
                  "battery"
                  "control-center"
                  "session"
                ];
              };

              widget = lib.genAttrs [
                "battery"
                "bluetooth"
                "brightness"
                "control-center"
                "network"
                "notifications"
              ] (_: { enabled = false; });

              dock = {
                enabled = true;
                auto_hide = true;
                reserve_space = false;
                shadow = false;
                show_running = false;
                background_opacity = 0.8;
                icon_size = 30;
                magnification_scale = 1.3;
                main_axis_padding = 15;
                launcher_position = "start";
                pinned = [
                  "spotify"
                  "firefox"
                  "pcmanfm"
                  "slack"
                  "teams-for-linux"
                  "chrome-faolnafnngnfdaknnbpnkhgohbobgegn-Default"
                ];
              };

              desktop_widgets = {
                schema_version = 2;
                widget_order = [
                  "desktop-widget-0000000000000001"
                  "desktop-widget-0000000000000002"
                ];
                grid = {
                  cell_size = 64;
                  major_interval = 4;
                  visible = true;
                };
                widget = {
                  # Time
                  desktop-widget-0000000000000001 = {
                    type = "clock";
                    output = "DP-2";
                    cx = 1720.0;
                    cy = 1296.0;
                    box_width = 448.0;
                    box_height = 128.0;
                    placement_width = 3440.0;
                    placement_height = 1440.0;
                    rotation = 0.0;
                    settings = {
                      clock_style = "digital";
                      format = "{:%H:%M:%S}";
                      font_family = "JetBrains Mono";
                      background = false;
                      background_opacity = 0.0;
                      shadow = false;
                    };
                  };
                  # Date
                  desktop-widget-0000000000000002 = {
                    type = "clock";
                    output = "DP-2";
                    cx = 1720.0;
                    cy = 1200.0;
                    box_width = 704.0;
                    box_height = 64.0;
                    placement_width = 3440.0;
                    placement_height = 1440.0;
                    rotation = 0.0;
                    settings = {
                      format = "%A, %d %B %Y";
                      font_family = "JetBrains Mono";
                      background = false;
                      background_opacity = 0.0;
                      shadow = false;
                    };
                  };
                };
              };

              lockscreen_widgets = {
                enabled = false;
                schema_version = 2;
                widget_order = [ "lockscreen-login-box@DP-2" ];
                grid = {
                  cell_size = 16;
                  major_interval = 4;
                  visible = true;
                };
                widget."lockscreen-login-box@DP-2" = {
                  type = "login_box";
                  output = "DP-2";
                  cx = 1720.0;
                  cy = 1258.0;
                  box_width = 810.0;
                  box_height = 196.0;
                  placement_width = 3440.0;
                  placement_height = 1440.0;
                  rotation = 0.0;
                  settings = {
                    layout = "regular";
                    background_color = "surface_variant";
                    background_opacity = 0.88;
                    background_radius = 12.0;
                    input_opacity = 1.0;
                    input_radius = 6.0;
                    center_password_text = false;
                    show_caps_lock = true;
                    show_keyboard_layout = true;
                    show_login_button = true;
                    show_media = true;
                    show_session_buttons = true;
                    show_unlock_hint = true;
                    show_weather = true;
                  };
                };
              };
            };
          };
        };
    };
}
