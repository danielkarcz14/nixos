{inputs, ...}: {
  flake.modules.nixos.plasma = {pkgs, ...}: {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.defaultSession = "niri";

    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      khelpcenter
      kate
      konsole
      okular
      krdp
      discover
      plasma-browser-integration
    ];

    services.xserver.xkb = {
      layout = "us,cz";
      variant = ",qwerty";
      options = "grp:alt_shift_toggle";
    };

    home-manager.users.daniel = {
      imports = [inputs.plasma-manager.homeModules.plasma-manager];

      systemd.user.services.noctalia.Unit.ConditionEnvironment = "!XDG_CURRENT_DESKTOP=KDE";

      gtk.gtk2.force = true;
      xdg.configFile."fontconfig/conf.d/10-hm-fonts.conf".force = true;

      programs.plasma = {
        enable = true;

        hotkeys.commands.terminal = {
          key = "Meta+T";
          command = "ghostty";
        };

        shortcuts = {
          "services/org.kde.krunner.desktop"._launch = ["Meta+Space" "Meta+D"];

          ksmserver = {
            "Lock Session" = "Meta+Escape";
            "Log Out" = "Meta+Shift+E";
          };

          kwin = {
            "Window Close" = "Meta+Q";
            "Window Maximize" = "Meta+F";
            "Window Fullscreen" = "Meta+Shift+F";
            "Show Desktop" = "none";
            "Edit Tiles" = "none";

            "Switch Window Left" = ["Meta+Left" "Meta+H"];
            "Switch Window Right" = ["Meta+Right" "Meta+L"];
            "Switch Window Up" = ["Meta+Up" "Meta+K"];
            "Switch Window Down" = ["Meta+Down" "Meta+J"];

            "Window Quick Tile Left" = ["Meta+Shift+Left" "Meta+Shift+H"];
            "Window Quick Tile Right" = ["Meta+Shift+Right" "Meta+Shift+L"];
            "Window Quick Tile Top" = ["Meta+Shift+Up" "Meta+Shift+K"];
            "Window Quick Tile Bottom" = ["Meta+Shift+Down" "Meta+Shift+J"];
          };
        };
      };
    };
  };
}
