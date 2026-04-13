{inputs, ...}: {
  perSystem = {pkgs, lib, self', ...}: {
    packages.environment = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;

      package = self'.packages.fish;
      extraPackages = with pkgs; [
        self'.packages.neovim

        # CLI Tools
        yazi
        jq
        ffmpeg-full
        zoxide
        fd
        eza
        killall
        wget
        file
        imagemagick
        cfspeedtest
        duf
        dust
        zip
        unzip
        p7zip
        unp
        tree
        # unrar
        wev
        just
        yt-dlp
        bc
        libnotify
        htop
        btop
        lazygit
        lz4
        gnuplot
        wl-screenrec
        openvpn
        usbutils
        net-tools
        caligula
        usbutils

        # Secu
        # vulnix
        # lynis
        # veracrypt
        kryptor
        nmap
        netcat-gnu
        gobuster

        # Quality of life
        catimg
        rsync
        bat
        ripgrep
        fzf
        fd

        # Fun/fetching
        cowsay
        tt
        pipes
        cbonsai
        cmatrix
        lolcat
        nitch
        colorpanes
      ];

      env = {
        EDITOR = lib.getExe self'.packages.neovim;
        VISUAL = lib.getExe self'.packages.neovim;
        PAGER = "less -R";
        FZF_DEFAULT_COMMAND = "fd --type f";
        LESS = "-R";
      };
    };
  };
}
