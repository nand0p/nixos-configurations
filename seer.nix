{ config, pkgs, ... }:

{

  #
  #      ==> seer <==
  #

  imports = [
    ./hardware-configuration.nix
    ./hosts.nix
    ./buildbot.nix
    #./hologram.nix
  ];

  system = {
    stateVersion = "17.03";
    copySystemConfiguration = true;
    autoUpgrade = {
      channel= "https://nixos.org/channels/nixos-unstable";
      enable = true;
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
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
    pulseaudio.enable = true;
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
    interfaces.enp2s0 = {
      ipAddress = "192.168.140.13";
      prefixLength = 24;
    };
    defaultGateway = "192.168.140.1";
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
    #allowBroken = true;
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
    ntp.enable = true;
    transmission.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      #autorun = false;
      desktopManager.kde5.enable = true;
      displayManager.sddm.enable = true;
      #displayManager.kdm.enable = true;
      #desktopManager.kde4.enable = true;
      #windowManager.openbox.enable = true;
    };
    printing = {
      enable = true;
      #drivers = [ pkgs.gutenprint ];
    };
    hologram-agent = {
      enable = true;
      dialAddress = "hologram:3100";
    };
  };

  users.extraUsers = {
    jenkins = {
      isNormalUser = true;
      createHome = false;
      home = "/var/jenkins_home";
      extraGroups = [ "docker" "vboxusers" ];
      uid = 1000;
    };
    lori = {
      isNormalUser = true;
      createHome = true;
      home = "/home/lori";
      extraGroups = [ "transmission" "docker" ];
      uid = 1002;
    };
    nando = {
      isNormalUser = true;
      createHome = true;
      home = "/home/nando";
      extraGroups = [ "wheel" "transmission" "docker" "vboxusers" ];
      uid = 1001;
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwH1rWuQJXZXXgyWmJp6ripDLSyTGteNkvsn4AO/Bqo+TWSX1bxmDH4uk94D2/YOsRQiPs+dDHuJuBIqZnZicnOhbQFzi4EegV1S9Xw4ZWzJu9JT6dcI3ThOlQ2LVeEYajo+A1eoTdr5Hkfs79w+9FvLjYHgbuhvcsR5n9jFHynM0JPjcnDR7wNnDdqFoQqUFHG6nyJ3MotUBQGWuH/iDGOxcefHCbazdYTj4nFtbVtkAX8qRDz0ajlXGIhCVnV5/K7U1ZpXOlRIc8Ylt/v3DQsyvedUIyPrGLvzYx1tJXTbPWK3gXHAYRvDsydrCGfwiVCPK29Vfewy8fBaO/tdJB" ];
    };
    root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwH1rWuQJXZXXgyWmJp6ripDLSyTGteNkvsn4AO/Bqo+TWSX1bxmDH4uk94D2/YOsRQiPs+dDHuJuBIqZnZicnOhbQFzi4EegV1S9Xw4ZWzJu9JT6dcI3ThOlQ2LVeEYajo+A1eoTdr5Hkfs79w+9FvLjYHgbuhvcsR5n9jFHynM0JPjcnDR7wNnDdqFoQqUFHG6nyJ3MotUBQGWuH/iDGOxcefHCbazdYTj4nFtbVtkAX8qRDz0ajlXGIhCVnV5/K7U1ZpXOlRIc8Ylt/v3DQsyvedUIyPrGLvzYx1tJXTbPWK3gXHAYRvDsydrCGfwiVCPK29Vfewy8fBaO/tdJB" ];
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
      kochi-substitute-naga10
      source-code-pro
      noto-fonts
      noto-fonts-emoji
      cantarell_fonts
      dejavu_fontsEnv
      dejavu_fonts
      dina-font
      dina-font-pcf
      dosemu_fonts
      font-awesome-ttf
      font-droid
      freefont_ttf
      gohufont
      gyre-fonts
      hack-font
      ipaexfont
      ipafont
      kawkab-mono-font
      liberation_ttf
      mplus-outline-fonts
      norwester-font
      oxygenfonts
      profont
      proggyfonts
      tewi-font
      ttmkfdir
      ubuntu_font_family
      ucs-fonts
      unifont
      unifont_upper
      urxvt_font_size
      vistafonts
      xfontsel
      xlsfonts
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
    interactiveShellInit = ''
      alias mkpass="openssl rand -base64"
      export PS1="\[$(tput setaf 10)\]\h \[$(tput setaf 13)\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2) \[$(tput setaf 12)\]\$PWD \[$(tput setaf 5)\]:\[$(tput sgr0)\]\T\[$(tput setaf 5)\]: \[$(tput sgr0)\]";
      export BROWSER=google-chrome-stable;
      export EDITOR=vim;
      export AWS_DEFAULT_REGION=us-east-1;
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
      python27
      python27Packages.virtualenv
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
      go-mtpfs
      xscreensaver
      xorg.xhost
      hdparm
      gparted
      dmidecode
      screen
      qemu
      smartmontools
      wireshark
      mkpasswd
      openssl
      file
      telnet

      #BROKEN
      #electricsheep
      #xpdf
      #ansible2

      #MISSING
      #gerrit
      #puppet
      #sonos
      #xmms
    ];
  };

}
