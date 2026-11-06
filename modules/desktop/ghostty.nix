{...}: {
  flake.modules.nixos.desktop = {
    home-manager.users.daniel = {
      programs.ghostty = {
        enable = true;
        settings = {
          theme = "Atom One Dark";
          background = "#282c34";
          background-opacity = 0.9;
          window-padding-color = "extend";

          font-family = "Lilex Nerd Font";
          font-size = 13;

          window-padding-x = 8;
          window-padding-y = 8;
          cursor-style = "block";

          window-decoration = "server";
        };
      };
    };
  };
}
