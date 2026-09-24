{ ... }:
{
  flake.modules.nixos.steam = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Streamovat hry
      dedicatedServer.openFirewall = true; # Pro dedicated servers
      gamescopeSession.enable = true; # Gamescope wrapper (fajn pro Wayland)
    };
  };
}
