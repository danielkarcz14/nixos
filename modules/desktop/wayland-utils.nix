{...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    home-manager.users.daniel = {
      home.packages = with pkgs; [
        grim
        slurp
        wl-clipboard
        wev
        xwayland-satellite

        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
      ];
    };
  };
}
