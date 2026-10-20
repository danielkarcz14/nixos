{ ... }:
{
  flake.modules.nixos.base = {
    # Realtime scheduling for PipeWire/WirePlumber (prevents crackling under load)
    security.rtkit.enable = true;
  };
}
