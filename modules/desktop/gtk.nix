{ ... }:
{
  flake.modules.nixos.desktop =
    { pkgs, ... }:
    {
      home-manager.users.daniel = {
        gtk = {
          enable = true;
          iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
          };
        };

        home.packages = with pkgs; [
          hicolor-icon-theme # fallback, měl by tam být default
          adwaita-icon-theme # pro GTK apps default fallback
        ];
      };
    };
}
