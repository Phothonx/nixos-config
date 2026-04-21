{
  flake.nixosModules.pipewire = {pkgs, ...}: {
    security.rtkit.enable = true;
    services.pulseaudio.enable = false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;

      extraConfig.pipewire = {

        "99-input-denoising"."context.modules" = [{
          "name" = "libpipewire-module-filter-chain";
          "args" = {
            "node.description" = "DeepFilter Noise Cancelling Source";
            "media.name" = "DeepFilter Noise Cancelling Source";
            "filter.graph" = {
              "nodes" = [
                {
                  "type" = "ladspa";
                  "name" = "DeepFilter Mono";
                  "plugin" = "${pkgs.deepfilternet}/lib/ladspa/libdeep_filter_ladspa.so";
                  "label" = "deep_filter_mono";
                  # "control" = {
                  #   "Attenuation Limit (dB)" = cfg.source.attenuation;
                  # };
                }
              ];
            };
            "audio.rate" = 48000;
            "capture.props" = {
              "node.name" = "deep_filter_mono_input";
              "node.passive" = true;
            };
            "playback.props" = {
              "node.name" = "deep_filter_mono_output";
              "media.class" = "Audio/Source";
            };
          };
        }];

        "99-parametric-eq"."context.modules" = [{
          name = "libpipewire-module-parametric-equalizer";
          args = {
            "node.description" = "Parametric EQ for fiio ft1 pro";
            "media.name" = "Parametric EQ for fiio ft1 pro";
            "equalizer.filepath" = ./fiio-ft1-pro-parametric-eq.txt;
            "audio.channels" = 2;
            "audio.position" = ["FL" "FR"];
            "capture.props" = {
              "node.name" = "parametric-eq-input-fiio-ft1-pro";
              "node.description" = "Parametric EQ Input for fiio ft1 pro";
              "audio.channels" = 2;
              "audio.position" = ["FL" "FR"];
              "media.class" = "Audio/Sink";
            };
            "audio.rate" = 48000;
            "playback.props" = {
              "node.name" = "parametric-eq-output-fiio-ft1-pro";
              "node.description" = "Parametric EQ Output for fiio ft1 pro";
              "audio.channels" = 2;
              "audio.position" = ["FL" "FR"];
              "node.passive" = true;
            };
          };
        }];

      };
    };
  };
}
