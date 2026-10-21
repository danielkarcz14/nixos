{ ... }:
{
  flake.modules.nixos.fingerprint =
    { pkgs, ... }:
    let
      libfprint = pkgs.libfprint.overrideAttrs (old: {
        version = "1.94.10-elanpress-0ab4821";
        src = pkgs.fetchFromGitHub {
          owner = "filip-rs";
          repo = "libfprint";
          rev = "0ab4821cbb99b9f7701d1f53fa9abb34b9d77959";
          hash = "sha256-1+Jj67Jfg/iCVRSQfwBjWtDurk8wMfojusbicUlOBIw=";
        };
        postBuild = (old.postBuild or "") + ''
          ninja sync-udev-hwdb
        '';
      });
    in
    {
      services.fprintd = {
        enable = true;
        package = pkgs.fprintd.override { inherit libfprint; };
      };

      services.udev.packages = [ libfprint ];
      services.udev.extraRules = ''
        ACTION=="add|change", SUBSYSTEM=="usb", ATTR{idVendor}=="04f3", ATTR{idProduct}=="0c6e", TEST=="power/control", ATTR{power/control}="on"
      '';
    };
}
