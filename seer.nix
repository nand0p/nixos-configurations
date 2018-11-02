{ config, pkgs, ... }:
{

  #
  #      ==> seer <==
  #

  imports = [
    ./hardware-configuration.nix
    ./private.nix
  ];

  system = {
    stateVersion = "19.03";
    copySystemConfiguration = true;
    autoUpgrade = {
      channel= "https://nixos.org/channels/nixos-unstable";
      enable = false;
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.memtest86 = true;
    };
    kernel.sysctl = {
      "net.ipv4.tcp_keepalive_time" = 60;
      "net.core.rmem_max" = 4194304;
      "net.core.wmem_max" = 1048576;
    };
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  hardware = {
    trackpoint = {
      enable = true;
      sensitivity = 50;
      speed = 50;
      fakeButtons = false;
    };
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
    opengl.driSupport32Bit = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  networking = {
    domain = "hex7.com";
    hostName = "seer";
    wireless.enable = false;
    useDHCP  = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 8010 8080 8888 ];
      allowPing = true;
    };
    interfaces.enp4s0.ipv4.addresses = [ {
      address = "192.168.100.13";
      prefixLength = 24;
    } ];
    defaultGateway = "192.168.100.1";
    nameservers = [ "8.8.8.8" ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  time = {
    timeZone = "America/New_York";
    hardwareClockInLocalTime = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  virtualisation = {
    docker = {
      enable = true;
      #storageDriver = "btrfs";
    };
    virtualbox = {
      host.enable = true;
    };
  };

  services = {
    openssh.enable = true;
    locate.enable = true;
    transmission.enable = true;
    cron.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      #autorun = false;
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
    };
    printing = {
      enable = true;
      #drivers = [ pkgs.gutenprint ];
    };
    udev.extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
      KERNEL=="uinput", MODE="0660", GROUP="users", OPTIONS+="static_node=uinput"
    '';
    #hologram-agent = {
    #  enable = false;
    #  dialAddress = "hologram:3100";
    #};
    #buildbot-master = {
    #  enable = false;
    #  package = pkgs.buildbot-full;
    #  masterCfg = /etc/nixos/buildbot/master.cfg;
    #};
    #buildbot-worker = {
    #  enable = false;
    #};
  };

  programs = {
    bash = {
      enableCompletion = true;
    };
    ssh = {
      startAgent = true;
    };
  };

  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      terminus_font
      font-awesome-ttf
      freefont_ttf
      hack-font
      liberation_ttf
    ];
  };

  environment = {
    etc = {
      "gitconfig".text = ''
        [core]
          editor = vim
        [user]
          email = fernando.pando@stelligent.com
          name = Fernando J Pando
      '';
    };

    variables = {
      NIX_PATH = pkgs.lib.mkOverride 0 "nixpkgs=/etc/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix";
      BROWSER = "google-chrome-stable";
      EDITOR = "vim";
      AWS_DEFAULT_REGION = "us-east-1";
    };

    interactiveShellInit = ''
      alias mkpass="openssl rand -base64"
      export PS1="\[$(tput setaf 10)\]\h \[$(tput setaf 13)\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2) \[$(tput setaf 12)\]\$PWD \[$(tput setaf 5)\]:\[$(tput sgr0)\]\T\[$(tput setaf 5)\]: \[$(tput sgr0)\]";
    '';

    systemPackages = with pkgs; [
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
      slurm-llnl-full
      nethogs
      speedtest-cli
      vim
      vimPlugins.vim-nix
      vimPlugins.vim-go
      vimPlugins.vim-jsonnet
      vimPlugins.vim-jinja
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
      python3
      python3Packages.virtualenv
      python3Packages.distutils_extra
      python3Packages.psycopg2
      python3Packages.boto3
      awscli
      nginx
      gnupg
      parted
      imagemagick
      qutebrowser
      vivaldi
      dillo
      arora
      conkeror
      transmission
      transgui
      virtualbox
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
      electricsheep
      gcc
      binutils
      ansible2
      kdiff3
      hologram
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
      xpdf
      git-review
      kubernetes
      gpgme
      sddm
      cmake
      boost
      libofx
      cpuminer
      cpuminer-multi
      libreoffice
      iotop
      atop
      ctop
      ftop
      beep
      php
      ib-tws
      jdk8
      pinentry
      wireshark
      httperf
      hostapd
      wirelesstools
      pcmciaUtils
      cdrtools
      lsscsi
      lshw

      # GAMES
      atari800
      steam

      # BROKEN
      #buildbot-full
      #buildbot-worker

      # MISSING
      #gerrit
      #puppet
      #sonos
      #xmms
    ];
  };

}
