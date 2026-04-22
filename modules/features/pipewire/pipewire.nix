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
          name = "libpipewire-module-filter-chain";
          args = {
            "node.description" = "Noise Treatment source";
            "filter.graph" = {
              nodes = [
                {
                  type = "ladspa";
                  name = "rnnoise";
                  plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                  label = "noise_suppressor_mono";
                  control = {
                    "VAD Threshold (%)" = 85.0;
                    "VAD Grace Period (ms)" = 100;
                    "Retroactive VAD Grace (ms)" = 0;
                  };
                }
                {
                  type = "builtin";
                  name = "micgain";
                  label = "linear";
                  control = {
                    "Mult" = 2;
                    "Add" = 0.0;
                  };
                }
              ];
            };
            links = [{ output = "rnnoise:Out"; input = "micgain:In"; }];
            inputs = [ "rnnoise:In" ];
            outputs = [ "micgain:Out" ];
            "capture.props" = {
              "node.name" = "capture.rnnoise_source";
              "node.passive" = true;
              "audio.rate" = 48000;
            };
            "playback.props" = {
              "node.name" = "rnnoise_source";
              "media.class" = "Audio/Source";
              "audio.rate" = 48000;
            };
          };
        }];

        "99-parametric-eq"."context.modules" = [{
          name = "libpipewire-module-parametric-equalizer";
          args = {
            "node.description" = "Parametric EQ for fiio ft1 pro";
            "equalizer.filepath" = ./fiio-ft1-pro-parametric-eq.txt;
            "capture.props" = {
              "node.name" = "eq_input.fiio_ft1_pro";
              "media.class" = "Audio/Sink";
              "audio.channels" = 2;
              "audio.position" = ["FL" "FR"];
              "audio.rate" = 48000;
            };
            "playback.props" = {
              "node.name" = "eq_output.fiio_ft1_pro";
              "node.passive" = true;
              "audio.channels" = 2;
              "audio.position" = ["FL" "FR"];
              "audio.rate" = 48000;
            };
          };
        }];

      };
    };
  };
}
