{ config, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "nixos-laptop";  # change to whatever you want

  # TODO: fill in when you install NixOS on the laptop
  # Common laptop-specific things you'll likely want:
  #
  # - Power management
  # services.tlp.enable = true;              # or services.power-profiles-daemon.enable
  # powerManagement.enable = true;
  #
  # - Touchpad
  # services.libinput.enable = true;
  #
  # - Backlight control
  # programs.light.enable = true;
  #
  # - GPU (depends on the laptop):
  #   * Intel-only: hardware.graphics.enable = true; (nothing else needed usually)
  #   * AMD-only: services.xserver.videoDrivers = [ "amdgpu" ];
  #   * NVIDIA hybrid (Optimus): hardware.nvidia.prime config — see NixOS wiki
  #
  # - Bluetooth (laptops usually have it)
  # hardware.bluetooth.enable = true;
  # services.blueman.enable = true;
}
