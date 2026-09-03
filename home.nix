{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.stateVersion = "26.05";

  programs.git.enable = true;

  programs.bash = {
    enable = true;
  shellAliases = {
    btw = "echo i use nixos btw";
   };

  initExtra = ''
    PS1='\[\e[38;5;41m\]\u\[\e[0m\] in \[\e[38;5;39m\]\w\[\e[0m\] \$ '

    nrs() { sudo nixos-rebuild switch --flake "$HOME/nixos-dotfiles#$(hostname)" "$@"; }
    nrt() { sudo nixos-rebuild test   --flake "$HOME/nixos-dotfiles#$(hostname)" "$@"; }
    nrb() { sudo nixos-rebuild boot   --flake "$HOME/nixos-dotfiles#$(hostname)" "$@"; }
    nfu() { nix flake update "$HOME/nixos-dotfiles"; }
  '';
 };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      font.normal = {
        family = "JetBrains Mono";
        style = "Regular";
      };
      font.size = 16;
    };
  };

  programs.noctalia = {
    enable = true;
    systemd.enable = true;  # Noctalia poběží jako systemd user service (doporučené)
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
      wallpaper = {
        enabled = true;
        default.path = "/home/daniel/Pictures/wallpapers/wolf.jpg";
      };
    };
  };

  home.file.".config/bat/config".text = ''
    --theme="Nord"
    --style="numbers,changes,grid"
    --paging=auto
  '';

  home.file.".config/qtile".source = ./qtile;
  home.file.".config/niri".source = ./niri;

  home.packages = with pkgs; [
    bat
    fastfetch
    flameshot
    maim
    xclip
    slop
    xorg.xev
    neovim
    # Wayland tools (pro Niri)
    grim              # screenshot (nahrazuje maim)
    slurp             # region select (nahrazuje slop)
    wl-clipboard      # clipboard (nahrazuje xclip) - přidá wl-copy, wl-paste
    wev               # keyboard event viewer (nahrazuje xev)
    xwayland-satellite # spouští Xwayland démona pro X11 apky pod Niri
    fuzzel
  ];

  programs.home-manager.enable = true;
}
