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

      (
        { pkgs, ... }:
        {
          networking.hostName = "nixos-btw";

          # === NVIDIA + Wayland env vars ===
          environment.sessionVariables = {
            # Electron apps (Discord, VSCode, Slack) → nativní Wayland
            NIXOS_OZONE_WL = "1";
            # Firefox nativní Wayland
            MOZ_ENABLE_WAYLAND = "1";
            # Kurzor fix na NVIDIA (občas se hodí)
            WLR_NO_HARDWARE_CURSORS = "1";
          };

          # Citrix + Steam - musí přijmout EULA / jsou unfree
          nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
            "citrix-workspace"
            "steam"
            "steam-original"
            "steam-run"
            "steam-unwrapped"
          ];
        }
      )
    ];
  };
}
