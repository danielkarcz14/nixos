{ config, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.noctalia.nixosModules.default
  ]; 

  networking.hostName = "nixos-btw";


  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --mode 3440x1440 --rate 180
  '';
  
  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;  # NetworkManager, Bluetooth, UPower, power-profiles-daemon
  };
 
  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = false;
  };

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

  # === NVIDIA + Wayland env vars ===
  environment.sessionVariables = {
    # Electron apps (Discord, VSCode, Slack) → nativní Wayland
    NIXOS_OZONE_WL = "1";
    # Firefox nativní Wayland
    MOZ_ENABLE_WAYLAND = "1";
    # Kurzor fix na NVIDIA (občas se hodí)
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;      # Streamovat hry
    dedicatedServer.openFirewall = true; # Pro dedicated servers
    gamescopeSession.enable = true;      # Gamescope wrapper (fajn pro Wayland)
  };

 
  # Citrix - musí přijmout EULA
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "citrix-workspace"
    "steam"
    "steam-original"
    "steam-run"
    "steam-unwrapped"
  ];
}
