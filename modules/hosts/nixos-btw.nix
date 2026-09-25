# Declares the nixos-btw (desktop) NixOS configuration by composing named modules.
{ config, inputs, ... }:
let
  nixos = config.flake.modules.nixos;
in
{
  flake.nixosConfigurations.nixos-btw = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      nixos.base
      nixos.desktop
      nixos.shell
      nixos.dev
      nixos.software
      nixos.steam
      nixos.nvidia

      ../../hosts/desktop/hardware-configuration.nix

      {
        networking.hostName = "nixos-btw";

        # Monitor setup — force 180Hz on the MSI ultrawide
        home-manager.users.daniel.wayland.windowManager.niri.settings.output = {
          _args = [ "DP-2" ];
          mode = "3440x1440@180.000";
          scale = 1.0;
        };
      }
    ];
  };
}
