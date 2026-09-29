{ ... }:
{
  flake.modules.nixos.software =
    { pkgs, ... }:
    {
      home-manager.users.daniel = {
        # Prohlížeč PDF (vim-like, sám se obnoví při změně souboru)
        programs.zathura.enable = true;

        home.packages = with pkgs; [
          typst # sazba faktur (~/Downloads/osvc_prehled/fakturace_ds/faktury_vydane)
        ];

        xdg.mimeApps.defaultApplications = {
          "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
        };
      };
    };
}
