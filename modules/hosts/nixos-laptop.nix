{ config, inputs, ... }:
let
  nixos = config.flake.modules.nixos;
in
{
  flake.nixosConfigurations.nixos-laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      nixos.base
      nixos.desktop
      nixos.shell
      nixos.dev
      nixos.software
      nixos.fingerprint

      ../../hosts/laptop/hardware-configuration.nix

      (
        { pkgs, ... }:
        {
          networking.hostName = "nixos-laptop";

          hardware.graphics = {
            enable = true;
            extraPackages = with pkgs; [ intel-media-driver ];
          };

          boot.loader.efi.efiSysMountPoint = "/boot/efi";

          time.hardwareClockInLocalTime = true;

          home-manager.users.daniel.wayland.windowManager.niri.settings.output = {
            _args = [ "eDP-1" ];
            mode = "2880x1800@90.000";
            scale = 1.75;
          };

          home-manager.users.daniel.programs.noctalia.settings.widget.battery.enabled = true;

          home-manager.users.daniel.wayland.windowManager.niri.settings.spawn-sh-at-startup =
            "echo 'Xft.dpi: 168' | ${pkgs.xrdb}/bin/xrdb -merge";


          services.fwupd.enable = true;

          services.thermald.enable = true;
        }
      )
    ];
  };
}
