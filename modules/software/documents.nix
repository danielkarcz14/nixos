{ ... }:
{
  flake.modules.nixos.software =
    { pkgs, ... }:
    {
      home-manager.users.daniel = {
        programs.zathura.enable = true;

        home.packages = with pkgs; [
          typst
          jq
          qalculate-gtk
          libreoffice
        ];

        xdg.mimeApps.defaultApplications = {
          "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
        };
      };
    };
}
