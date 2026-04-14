{
  flake.nixosModules.xkb = {...}: {
    # TODO
    services.xserver.xkb = {
      layout = "nico"; # fr
      variant = "basic";
      options = "caps:escape";
      extraLayouts = {
        nico = {
          description = "My custom xkb layout.";
          languages = ["eng" "fr"];
          symbolsFile = ../nico;
        };
      };
    };
  };
}
