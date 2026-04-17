{
  perSystem = { pkgs, ...}: {
    devShells.js = pkgs.mkShell {
      packages = with pkgs; [
        nodejs
        pnpm
      ];
    };
  };
}
