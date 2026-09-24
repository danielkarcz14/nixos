{ ... }:
{
  flake.modules.nixos.software =
    { pkgs, ... }:
    {
      programs.firefox.enable = true;

      home-manager.users.daniel = {
        home.packages = with pkgs; [
          chromium
        ];

        # PWA aplikace (přes Chromium --app)
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
