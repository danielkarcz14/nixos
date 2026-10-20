{ ... }:
{
  flake.modules.nixos.fingerprint =
    { pkgs, ... }:
    let
      # ELAN 04f3:0c6e is a press sensor; upstream's elan swipe driver
      # does not handle it correctly. Keep the community driver pinned.
      # https://github.com/filip-rs/libfprint/tree/elanpress
      libfprint = pkgs.libfprint.overrideAttrs (old: {
        version = "1.94.10-elanpress-0ab4821";
        src = pkgs.fetchFromGitHub {
          owner = "filip-rs";
          repo = "libfprint";
          rev = "0ab4821cbb99b9f7701d1f53fa9abb34b9d77959";
          hash = "sha256-1+Jj67Jfg/iCVRSQfwBjWtDurk8wMfojusbicUlOBIw=";
        };
        # The fork moves two USB IDs to elanpress but ships an old hwdb.
        # Regenerate it before installation; keep the upstream tests enabled.
        postBuild = (old.postBuild or "") + ''
          ninja sync-udev-hwdb
        '';
      });
    in
    {
      # NixOS also enables fingerprint PAM authentication when fprintd is on.
      services.fprintd = {
        enable = true;
        package = pkgs.fprintd.override { inherit libfprint; };
      };

      services.udev.packages = [ libfprint ];
      # Keep this sensor awake during enrollment and verification.
      services.udev.extraRules = ''
        ACTION=="add|change", SUBSYSTEM=="usb", ATTR{idVendor}=="04f3", ATTR{idProduct}=="0c6e", TEST=="power/control", ATTR{power/control}="on"
      '';
    };
}
