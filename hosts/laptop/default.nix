{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.noctalia.nixosModules.default
  ];

  networking.hostName = "nixos-laptop";  # change to whatever you want

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;  # NetworkManager, Bluetooth, UPower, power-profiles-daemon
  };

  nixpkgs.config.allowUnfree = true;

  # === Niri (Wayland compositor) ===
  programs.niri.enable = true;

  # xdg-desktop-portal pro Wayland (potřeba pro screensharing, file pickers atd.)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome  # dobrý default pro Niri
    ];
  };

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
