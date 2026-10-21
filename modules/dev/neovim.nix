{ ... }:
{
  flake.modules.nixos.dev = {
    home-manager.users.daniel =
      { config, ... }:
      {
        xdg.configFile."nvim".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/modules/dev/nvim";
      };
  };
}
