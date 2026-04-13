{
  flake.nixosModules.pipewire = {...}: {
    security.rtkit.enable = true;
    services.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      # wireplumber.enable = true;
    };

    # TODO add input RNNoise
    # TODO add output EQ
  };
}
