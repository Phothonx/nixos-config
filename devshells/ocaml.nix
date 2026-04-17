{
  perSystem = { pkgs, ...}: {
    devShells.ocaml = pkgs.mkShell {
      packages = with pkgs; [
        ocaml
        ocamlPackages.utop
      ];
    };
  };
}
