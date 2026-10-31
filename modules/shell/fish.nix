{...}: {
  flake.modules.nixos.shell = {pkgs, ...}: {
    programs.fish.enable = true;
    users.users.daniel.shell = pkgs.fish;

    home-manager.users.daniel.programs.fish = {
      enable = true;

      shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake $HOME/nixos-dotfiles#(hostname)";
        nrt = "sudo nixos-rebuild test --flake $HOME/nixos-dotfiles#(hostname)";
        nrb = "sudo nixos-rebuild boot --flake $HOME/nixos-dotfiles#(hostname)";
        nfu = "nix flake update --flake $HOME/nixos-dotfiles";
        ff = "fastfetch";
      };

      functions.faktura = ''"$HOME/Downloads/osvc_prehled/fakturace_ds/faktury_vydane/faktura.sh" $argv'';
      functions = {
        fish_greeting = "";
      };
    };
  };
}
