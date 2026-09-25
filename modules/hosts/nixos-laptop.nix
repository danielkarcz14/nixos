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
          # ASUS Zenbook 14 OLED (UX3402ZA) — i5-1240P, Intel Iris Xe, 2880x1800@90 OLED
          networking.hostName = "nixos-laptop";

          # Intel Iris Xe — iHD VA-API driver pro HW dekódování videa (YouTube, Teams)
          hardware.graphics = {
            enable = true;
            extraPackages = with pkgs; [ intel-media-driver ];
          };

          # EFI oddíl je jen 260 MB a sdílený s Windows → mountuje se na /boot/efi, ne /boot.
          # /boot pak leží na ext4 rootu (GRUB ho umí číst), takže se kernely+initrd
          # nekopírují na malý ESP a ten se nezaplní. Viz README, sekce instalace.
          boot.loader.efi.efiSysMountPoint = "/boot/efi";

          # Dual boot: Windows drží hardwarové hodiny v lokálním čase — bez tohohle
          # se čas po přepnutí OS posune o 1–2 h. Po odstranění Windows smazat.
          time.hardwareClockInLocalTime = true;

          # Interní displej — ověř název přes `niri msg outputs` (typicky eDP-1)
          home-manager.users.daniel.wayland.windowManager.niri.settings.output = {
            _args = [ "eDP-1" ];
            mode = "2880x1800@90.000";
            scale = 1.75;
          };

          # Power management řeší power-profiles-daemon z noctalia recommendedServices
          # (TLP NEzapínat — konfliktuje s ním). Touchpad řeší niri (settings.input.touchpad).
        }
      )
    ];
  };
}
