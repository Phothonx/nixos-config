{
  pkgs,
  inputs,
  ...
}: {
  programs.gamemode = {
    enable = true;
    settings = {
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };

  programs.gamescope = {
    # package = pkgs-old.gamescope;
    enable = true;
  };
}
