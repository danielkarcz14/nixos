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

      # GitHub CLI — `gh auth login`, zároveň slouží jako git credential helper pro HTTPS
      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };
    };
  };
}
