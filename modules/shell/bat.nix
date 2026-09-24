{ ... }:
{
  flake.modules.nixos.shell =
    { pkgs, ... }:
    {
      home-manager.users.daniel = {
        home.packages = [ pkgs.bat ];

        home.file.".config/bat/config".text = ''
          --theme="Nord"
          --style="numbers,changes,grid"
          --paging=auto
        '';
      };
    };
}
