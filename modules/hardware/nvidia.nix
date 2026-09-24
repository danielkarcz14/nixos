{ ... }:
{
  flake.modules.nixos.nvidia =
    { config, ... }:
    {
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
    };
}
