{ ... }:
{
  flake.modules.nixos.shell = {
    home-manager.users.daniel = {
      home.sessionPath = [ "$HOME/bin" ];

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

          # fakturace (Typst + Toggl), např. `faktura -nova -pdf -open`
          faktura() { "$HOME/Downloads/osvc_prehled/fakturace_ds/faktury_vydane/faktura.sh" "$@"; }
        '';
      };
    };
  };
}
