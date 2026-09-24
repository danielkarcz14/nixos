{ ... }:
{
  flake.modules.nixos.base = {
    networking.networkmanager.enable = true;
    time.timeZone = "Europe/Prague";
  };
}
