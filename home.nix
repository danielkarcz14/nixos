{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.stateVersion = "26.05";

  programs.git.enable = true;

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

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

  programs.ghostty = {
    enable = true;
    settings = {
      # Průhlednost
      background-opacity = 0.75;

      # Font
      font-family = "JetBrainsMono Nerd Font";
      font-size = 16;

      # Vzhled
      window-padding-x = 8;
      window-padding-y = 8;
      cursor-style = "block";

      # Bez zvukového bell
      # audible-bell = false;

      # Šetří místo — bez tabs bar když je jen 1 tab
      window-decoration = "none";

      # Theme (volitelné - vyzkoušej si)
      # theme = "catppuccin-mocha";
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

  # PWA aplikace (přes Chromium --app)
  xdg.desktopEntries.outlook = {
    name = "Outlook";
    genericName = "Email";
    comment = "Microsoft Outlook Web";
    exec = "chromium --app=https://outlook.office.com --class=Outlook";
    icon = "ms-outlook";
    terminal = false;
    categories = [ "Network" "Email" "Office" ];
    startupNotify = true;
    settings = {
      StartupWMClass = "Outlook";
    };
  };

  home.file.".config/bat/config".text = ''
    --theme="Nord"
    --style="numbers,changes,grid"
    --paging=auto
  '';

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
    gcc
    gnumake
    ripgrep
    # Wayland tools (pro Niri)
    grim              # screenshot (nahrazuje maim)
    slurp             # region select (nahrazuje slop)
    wl-clipboard      # clipboard (nahrazuje xclip) - přidá wl-copy, wl-paste
    wev               # keyboard event viewer (nahrazuje xev)
    xwayland-satellite # spouští Xwayland démona pro X11 apky pod Niri
    fuzzel
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only  # jen ikony, fallback pro ostatní fonty
    spotify
    slack
    papirus-icon-theme
    hicolor-icon-theme    # fallback, měl by tam být default
    adwaita-icon-theme    # pro GTK apps default fallback
    discord
    teams-for-linux
    citrix_workspace
    chromium
    claude-code
  ];

  programs.home-manager.enable = true;

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/x-ica" = [ "wfica.desktop" ];
      "x-scheme-handler/receiver" = [ "wfica.desktop" ];
      "x-scheme-handler/citrixreceiver" = [ "wfica.desktop" ];
    };
    defaultApplications = {
      "application/x-ica" = [ "wfica.desktop" ];
      "x-scheme-handler/receiver" = [ "wfica.desktop" ];
      "x-scheme-handler/citrixreceiver" = [ "wfica.desktop" ];
    };
  };
}
