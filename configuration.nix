{ config, lib, pkgs, ... }:

{
 
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";     # EFI systém, GRUB se nezapisuje do MBR
    useOSProber = true;   # najde Windows (a jiné OS) a přidá je do menu
  };


  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Prague";

  services.xserver = {
	enable = true;
	displayManager.sessionCommands = ''
	  ${pkgs.xwallpaper}/bin/xwallpaper --zoom /home/daniel/Downloads/walls/wolf.jpg
	  ${pkgs.xset}/bin/xset r rate 200 35 & 
	'';
  };
  services.displayManager.ly.enable = true;


 
#  services.picom = {
#    enable = true;
#    backend = "glx";
#    fade = true;
#  };

   users.users.daniel = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; 
      packages = with pkgs; [
        tree
      ];
    };

   programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    neovim
    alacritty
    btop
    xwallpaper
    pcmanfm
    rofi
    git
    pfetch
    tealdeer
    xclip
    bat
    libxcvt
    pciutils
    usbutils
  ];
  
  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  # Cachix binary caches
  nix.settings = {
    extra-substituters = [
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "libsoup-2.74.3"
    ];
  };    
  system.stateVersion = "26.05";
}

