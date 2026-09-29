{ ... }:
{
  flake.modules.nixos.software =
    { pkgs, ... }:
    {
      home-manager.users.daniel = {
        home.packages = with pkgs; [
	     citrix-workspace
        ];

        xdg.mimeApps = {
          enable = true;
          associations.added = {
            "application/x-ica" = [ "wfica.desktop" ];
            "x-scheme-handler/receiver" = [ "wfica.desktop" ];
            "x-scheme-handler/citrixreceiver" = [ "wfica.desktop" ];
          };
          defaultApplications = {
            "application/x-ica" = [ "wfica.desktop" ];
            "x-scheme-handler/receiver" = [ "wfica.desktop" ];
            "x-scheme-handler/citrixreceiver" = [ "wfica.desktop" ];
          };
        };
      };
    };
}
