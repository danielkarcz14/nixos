# Declares the nixos-laptop NixOS configuration by composing named modules.
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

      ../../hosts/laptop/hardware-configuration.nix

      (
        { pkgs, ... }:
        {
          networking.hostName = "nixos-laptop"; # change to whatever you want

          # Safe default that works for Intel/AMD/hybrid — swap or extend once the
          # real GPU is known (see TODO block below).
          hardware.graphics.enable = true;

          # Citrix - musí přijmout EULA
          nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
            "citrix-workspace"
          ];

          # TODO: fill in once installed on the actual laptop hardware
          # Common laptop-specific things you'll likely want:
          #
          # - Power management
          # services.tlp.enable = true;              # or services.power-profiles-daemon.enable (noctalia's recommendedServices already turns this on)
          # powerManagement.enable = true;
          #
          # - Touchpad
          # services.libinput.enable = true;
          #
          # - Backlight control
          # programs.light.enable = true;
          #
          # - GPU driver specifics (depends on the laptop; hardware.graphics.enable above covers the common case):
          #   * AMD-only: services.xserver.videoDrivers = [ "amdgpu" ];
          #   * NVIDIA hybrid (Optimus): hardware.nvidia.prime config — see NixOS wiki
          #
          # - Bluetooth (usually covered by noctalia recommendedServices above, but if not:)
          # hardware.bluetooth.enable = true;
          # services.blueman.enable = true;
        }
      )
    ];
  };
}
