{...}: {
  flake.modules.nixos.docker = {
    virtualisation.docker.enable = true;
    users.users.daniel.extraGroups = ["docker"];
  };
}
