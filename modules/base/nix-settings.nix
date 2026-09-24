{ ... }:
{
  flake.modules.nixos.base = {
    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];

      # Cachix binary caches
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
  };
}
