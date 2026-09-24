{ ... }:
{
  flake.modules.nixos.desktop = {
    home-manager.users.daniel = {
      programs.ghostty = {
        enable = true;
        settings = {
          # Průhlednost
          background-opacity = 0.75;

          # Font
          font-family = "JetBrainsMono Nerd Font";
          font-size = 16;

          # Vzhled
          window-padding-x = 8;
          window-padding-y = 8;
          cursor-style = "block";

          # Šetří místo — bez tabs bar když je jen 1 tab
          window-decoration = "none";
        };
      };
    };
  };
}
