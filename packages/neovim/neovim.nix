{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.neovim = let
      mark2html = pkgs.writeShellApplication {
        name = "mark2html";
        runtimeInputs = [pkgs.pandoc];
        text = builtins.readFile ./mark2html.sh;
      };
    in
      inputs.wrappers.wrappers.neovim.wrap {
        inherit pkgs;

        settings.config_directory = ./nvim;

        specs.plugins = {
          data = with pkgs.vimPlugins; [
            # lazy-nvim

            # COLORSHEMES
            catppuccin-nvim

            # LSP / TS
            pkgs.vimPlugins.nvim-treesitter.withAllGrammars

            # DEPS
            nvim-web-devicons

            # MINI & SNACKS
            mini-nvim
            snacks-nvim

            # OTHER
            vimwiki
            friendly-snippets
            iron-nvim
            blink-cmp
            flash-nvim
            which-key-nvim
            Coqtail

            # from old extraLuaPackages
            # pathlib-nvim
            # lua-utils-nvim
          ];
        };

        extraPackages = with pkgs; [
          gcc
          tree-sitter
          cmake
          git
          curl
          fzf
          imagemagick
          sqlite
          mermaid-cli
          ghostscript
          trashy

          mark2html

          zathura

          biber
          pstree
          xdotool

          markdown-oxide
          stylua
          ccls
          lua-language-server
          basedpyright
          texlab
          ocamlPackages.ocaml-lsp
          nixd
          asm-lsp
          typescript-language-server
          bash-language-server

          luarocks
        ];
      };
  };
}
