{ config, pkgs, ... }:
{
  #
  #   ==> Toshiba Satellite P740D <==
  #

  system = {
    stateVersion = "17.09";
    copySystemConfiguration = true;
    autoUpgrade = {
      channel= "https://nixos.org/channels/nixos-unstable";
      enable = false;
    };
  };

  imports = [
    ./hardware-configuration.nix
    ./private.nix
  ];

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };
    extraModprobeConfig = "options snd_hda_intel enable=1,1";
    #blacklistedKernelModules = [ "snd_pcsp" ];
    kernel.sysctl = {
      "net.ipv4.tcp_keepalive_time" = 60;
      "net.core.rmem_max" = 4194304;
      "net.core.wmem_max" = 1048576;
    };
  };

  swapDevices = [
    { device = "/swapfile000";
      size = 16384; }
  ];

  hardware = {
    trackpoint = {
      enable = true;
      sensitivity = 50;
      speed = 50;
      fakeButtons = true;
    };
    pulseaudio.enable = true;
  };

  networking = {
    domain = "hex7.com";
    hostName = "abraxas";
    wireless.enable = true;
    useDHCP  = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  time = {
    timeZone = "America/New_York";
    hardwareClockInLocalTime = true;
  };

  i18n = {
     consoleKeyMap = "us";
     consoleFont = "${pkgs.terminus_font}/share/consolefonts/ter-i16n.psf.gz";
     defaultLocale = "en_US.UTF-8";
  };

  nixpkgs.config = {
    allowUnfree = true;
    #allowBroken = true;
  };

  virtualisation = {
     docker = {
        enable = true;
        storageDriver = "btrfs";
     };
     virtualbox = {
        host.enable = true;
     };
  };

  services = {
    openssh.enable = true;
    printing.enable = true;
    locate.enable = true;
    ntp.enable = true;
    transmission.enable = true;
    xserver = {
       enable = true;
       layout = "us";
       desktopManager.plasma5.enable = true;
       displayManager.sddm.enable = true;
       #windowManager.openbox.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    bind
    sysstat
    vnstat
    dstat
    htop
    screen
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
    docker
    terraform
    ansible2
    chefdk
    vagrant
    virtualbox
    packer
    jenkins
    buildbot-ui
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
    xpdf
    qutebrowser
    vivaldi
    dillo
    arora
    conkeror
    transmission
    transgui
    xscreensaver

    #sonos
    #xmms
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      terminus_font
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

}
