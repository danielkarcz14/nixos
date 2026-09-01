{ config, lib, pkgs, ... }:

{
 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "Europe/Prague";

  services.xserver = {
	enable = true;
	windowManager.qtile.enable = true;
	displayManager.sessionCommands = ''
	  ${pkgs.xwallpaper}/bin/xwallpaper --zoom /home/daniel/Downloads/walls/wolf.jpg
	  ${pkgs.xset}/bin/xset r rate 200 35 & 
	'';
  };
  services.displayManager.ly.enable = true;


 
  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
  };

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
    
  system.stateVersion = "26.05";
}

