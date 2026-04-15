{inputs, ...}: {
  flake.nixosModules.sops = {...}: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age.sshKeyPaths = ["/home/nico/.ssh/id_ed25519"];
      age.generateKey = true;
      age.keyFile = "/home/nico/.config/sops/age/key.txt";
    };
  };
}
