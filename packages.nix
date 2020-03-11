{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
      wget
      curl
      bind
      sysstat
      vnstat
      dstat
      htop
      screen
      tmux
      mosh
      nmap
      zip
      unzip
      nload
      iftop
      iptraf-ng
      bmon
      tcptrack
      vim
      firefox
      lsof
      pciutils
      tcpdump
      netcat
      jwhois
      strace
      google-chrome
      spotify
      openvpn
      gimp
      go
      docker
      terraform
      chefdk
      vagrant
      packer
      jenkins
      git
      vlc
      mplayer
      ruby
      python38Full
      awscli
      nginx
      gnupg
      parted
      imagemagick
      dillo
      arora
      conkeror
      transmission
      transgui
      xscreensaver
      xorg.xhost
      hdparm
      gparted
      dmidecode
      screen
      qemu
      smartmontools
      mkpasswd
      openssl
      file
      telnet
      gcc
      binutils
      ansible
      kdiff3
      spectacle
      stella
      vpnc
      openconnect
      jq
      traceroute
      atop
      libffi
      bundler
      exiftool
      nodejs-10_x
      maven
      jdk8
      postgresql96
      libpqxx
      groff
      go-mtpfs
      git-review
      kubernetes
      gpgme
      sddm
      cmake
      boost
      libofx
      iotop
      atop
      ctop
      ftop
      php
      jdk8
      pinentry
      wireshark
      httperf
      cdrtools
      lsscsi
      lshw
      stdenv
      gnumake
      autoconf
      automake
      patchelf
      pet
      gerrit
      flashplayer
      tor-browser-bundle-bin
      tdesktop
      signal-desktop
      libtiff
      #cudatoolkit
      #ethminer
      googleearth
      libreoffice

      #python3Packages.buildbot-full
      #python3Packages.buildbot-plugins
      #python3Packages.buildbot-ui
      #python3Packages.buildbot-pkg
      #python3Packages.buildbot-worker
      #python3Packages.virtualenv
      #python3Packages.distutils_extra
      #python3Packages.psycopg2
      #python3Packages.boto3
      #buildbot
      #buildbot-full
      #buildbot-plugins
      #buildbot-ui
      #buildbot-pkg
      #buildbot-worker

      # GAMES
      atari800

      # BROKEN
      #electricsheep
      #steam
      #vivaldi

      # MISSING
      #puppet
      #sonos
      #xmms

      # DEACTIVATE
      #ethash
      #pkg-config
      #cpuminer
      #cpuminer-multi
      #hostapd
      #wirelesstools
      #pcmciaUtils
      #hologram
      #ib-tws
      #slurm-llnl-full
      #nethogs
      #speedtest-cli
      #qutebrowser

      # INSECURE
      #xpdf
      #beep

      (
        vim_configurable.customize {
          name = "vim-with-plugins";

          vimrcConfig.packages.myVimPackage = with pkgs.vimPlugins; {
            start = [
              youcompleteme
              fugitive
              vim-nix
              vim-go
              vim-jsonnet
              vim-jinja
            ];
          };

          vimrcConfig.customRC = ''
            syntax enable
          '';
          # autocmd FileType php :packadd phpCompletion
        }
      )
  ];
}
