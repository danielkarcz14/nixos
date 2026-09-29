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

      home-manager.users.daniel = {
        imports = [ inputs.noctalia.homeModules.default ];

        programs.noctalia = {
          enable = true;
          systemd.enable = true;
          settings = {
            theme = {
              mode = "dark";
              source = "builtin";
              builtin = "Catppuccin";
            };
            wallpaper = {
              enabled = true;
              default.path = "/home/daniel/Pictures/wallpapers/wolf.jpg";
            };
            # Automaticky kopíruje vzhled do noctalia-greeter při změně wallpaperu/tématu/fontu
            shell.greeter_sync.auto_sync = true;
          };
        };
      };
    };
}
