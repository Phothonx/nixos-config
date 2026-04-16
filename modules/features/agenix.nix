{inputs, ...}: {
  flake.nixosModules.agenix = {pkgs, ...}: {
    imports = [
      inputs.agenix.nixosModules.default
    ];

    environment.systemPackages = [
      inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    age.identityPaths = [
      "/home/nico/.ssh/id_ed25519"
      "/etc/ssh/ssh_host_ed25519_key"
    ];

    age.secrets = {
      github_config.file = ../../secrets/github_config.age;
      thor_config.file = ../../secrets/thor_config.age;

      psswd_nico.file = ../../secrets/psswd_nico.age;

      id_ed25519_enseirb.file = ../../secrets/id_ed25519_enseirb.age;
      id_ed25519_thor.file = ../../secrets/id_ed25519_thor.age;
      id_ed25519_github.file = ../../secrets/id_ed25519_github.age;
    };
  };
}
