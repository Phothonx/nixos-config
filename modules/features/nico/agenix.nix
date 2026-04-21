{inputs, self, ...}: {
  flake.nixosModules.nico = {pkgs, ...}: {
    imports = [ inputs.agenix.nixosModules.default ];

    environment.systemPackages = [
      inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
      self.packages.${pkgs.stdenv.hostPlatform.system}.git
    ];

    age.identityPaths = [ "/home/nico/.ssh/id_ed25519" ];

    age.secrets = {
      psswd_nico.file = ../../../secrets/psswd_nico.age;

      github_config = {
        file = ../../../secrets/github_config.age;
        path = "/home/nico/.config/git/github_config";
        mode = "0644";
      };
      thor_config = {
        file = ../../../secrets/thor_config.age;
        path = "/home/nico/.config/git/thor_config";
        mode = "0644";
      };

      ssh_config = {
        file = ../../../secrets/ssh_config.age;
        path = "/home/nico/.ssh/config";
        owner = "nico";
        group = "users";
        mode = "0600";
      };

      id_ed25519_enseirb = {
        file = ../../../secrets/id_ed25519_enseirb.age;
        path = "/home/nico/.ssh/id_ed25519_enseirb";
        owner = "nico";
        group = "users";
        mode = "0600";
      };

      id_ed25519_thor = {
        file = ../../../secrets/id_ed25519_thor.age;
        path = "/home/nico/.ssh/id_ed25519_thor";
        owner = "nico";
        group = "users";
        mode = "0600";
      };

      id_ed25519_github = {
        file = ../../../secrets/id_ed25519_github.age;
        path = "/home/nico/.ssh/id_ed25519_github";
        owner = "nico";
        group = "users";
        mode = "0600";
      };
    };
  };
}
