{ ... }:
{
  flake.modules.nixos.dev = {
    home-manager.users.daniel = {
      programs.git = {
        enable = true;
        settings.user = {
          name = "DanielKarcz";
          email = "danielkarcz14@gmail.com";
        };
      };

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };

      programs.lazygit.enable = true;
    };
  };
}
