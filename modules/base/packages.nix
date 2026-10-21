{...}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      vim
      wget
      neovim
      btop
      git
      pfetch
      tealdeer
      pciutils
      usbutils
      unzip
      zip
      p7zip
      unrar
    ];
  };
}
