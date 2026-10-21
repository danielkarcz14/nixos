{...}: {
  flake.modules.nixos.desktop = {
    home-manager.users.daniel = {
      programs.ghostty = {
        enable = true;
        settings = {
          theme = "noctalia";
          background-opacity = 0.8;

          font-family = "JetBrainsMono Nerd Font";
          font-size = 16;

          window-padding-x = 8;
          window-padding-y = 8;
          cursor-style = "block";

          window-decoration = "none";
        };
      };
    };
  };
}
