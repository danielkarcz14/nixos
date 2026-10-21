{...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    home-manager.users.daniel = {
      gtk = {
        enable = true;
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };

      home.packages = with pkgs; [
        hicolor-icon-theme
        adwaita-icon-theme
      ];
    };
  };
}
