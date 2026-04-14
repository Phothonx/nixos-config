{inputs, ...}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: let
    gitIgnore = pkgs.writeText "git-ignore" (builtins.readFile ./ignore);

    gitConfig = pkgs.writeText "gitconfig" ''
      [init]
        defaultBranch = main

      [commit]
        verbose = true

      [core]
        editor = nvim
        hooksPath = .githooks
        excludesFile = ${gitIgnore}

      [merge]
        tool = nvimdiff
        conflictstyle = diff3
        ff = false

      [pull]
        rebase = false
        ff = only

      [mergetool]
        prompt = false
        keepBackup = false

      [mergetool "nvimdiff"]
        prompt = false
        keepBackup = false

      [diff]
        algorithm = histogram

      [rerere]
        enabled = true

      [includeIf "hasconfig:remote.*.url:git@github.com:*/**"]
        path = ~/.config/git/github_config

      [includeIf "hasconfig:remote.*.url:ssh://git@thor.enseirb-matmeca.fr:2222/**"]
        path = ~/.config/git/thor_config
    '';
  in {
    packages.git = inputs.wrappers.wrappers.git.wrap {
      inherit pkgs;

      extraPackages = [
        self'.packages.neovim
      ];

      configFile.content = builtins.readFile gitConfig;
    };
  };
}
