{ ... }:
{
  flake.modules.nixos.software =
    { pkgs, ... }:
    {
      programs.firefox = {
        enable = true;
        preferences."browser.fullscreen.autohide" = false;
      };

      home-manager.users.daniel = {
        home.packages = with pkgs; [
          chromium
        ];
       xdg.mimeApps.defaultApplications = {
          "text/html" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
          "x-scheme-handler/about" = [ "firefox.desktop" ];
          "x-scheme-handler/unknown" = [ "firefox.desktop" ];
          "x-scheme-handler/slack" = [ "slack.desktop" ];
        };
       xdg.desktopEntries.outlook = {
          name = "Outlook";
          genericName = "Email";
          comment = "Microsoft Outlook Web";
          exec = "chromium --app=https://outlook.office.com --class=Outlook";
          icon = "ms-outlook";
          terminal = false;
          categories = [ "Network" "Email" "Office" ];
          startupNotify = true;
          settings = {
            StartupWMClass = "Outlook";
          };
        };
      };
    };
}
