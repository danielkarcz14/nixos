{ ... }:
{
  flake.modules.nixos.base = {
    boot.loader.systemd-boot.enable = false;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev"; # EFI systém, GRUB se nezapisuje do MBR
      useOSProber = true; # najde Windows (a jiné OS) a přidá je do menu
    };
  };
}
