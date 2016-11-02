{ config, pkgs, ... }:
{
  #
  # This NixOS configuration is for the
  #   ==> Toshiba Satellite P740D <==
  #

  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };
    extraModprobeConfig = "options snd_hda_intel enable=1,1";
    #blacklistedKernelModules = [ "snd_pcsp" ];
  };

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

  time.timeZone = "US/Eastern";
  i18n = {
     consoleKeyMap = "us";
     #consoleFont = "Lat2-Terminus16";
     defaultLocale = "en_US.UTF-8";
  };

  nixpkgs.config = {
    allowUnfree = true;
    #allowBroken = true;
  };

  environment.systemPackages = with pkgs; [
    wget
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
    python27Full
    python27Packages.virtualenv
    awscli
    nginx
    htop
    gnupg
    parted
    nmap
    imagemagick
    screen
    xpdf
    unzip
    qutebrowser
    vivaldi
    dillo
    arora
    conkeror
    bind
    sysstat
    vnstat
    dstat
    transmission
    transgui
    xscreensaver
    kde4.kdeadmin
    kde4.kdeartwork
    kde4.kdebindings
    kde4.kdegraphics
    kde4.kdelibs
    kde4.kdemultimedia
    kde4.kdenetwork
    kde4.kdepim
    kde4.kdesdk
    kde4.kdeutils

    #gerrit
    #puppet
    #sonos
    #xmms
  ];

  services = {
    openssh.enable = true;
    printing.enable = true;
    locate.enable = true;
    ntp.enable = true;
    transmission.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      displayManager.kdm.enable = true;
      desktopManager.kde4.enable = true;
      #windowManager.openbox.enable = true;
    };
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs";
  };

  users.extraUsers = {
    lori = {
      isNormalUser = true;
      createHome = true;
      home = "/home/lori";
      uid = 1000;
    };
    nando = {
      isNormalUser = true;
      createHome = true;
      home = "/home/nando";
      extraGroups = [ "wheel" ];
      uid = 1001;
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwH1rWuQJXZXXgyWmJp6ripDLSyTGteNkvsn4AO/Bqo+TWSX1bxmDH4uk94D2/YOsRQiPs+dDHuJuBIqZnZicnOhbQFzi4EegV1S9Xw4ZWzJu9JT6dcI3ThOlQ2LVeEYajo+A1eoTdr5Hkfs79w+9FvLjYHgbuhvcsR5n9jFHynM0JPjcnDR7wNnDdqFoQqUFHG6nyJ3MotUBQGWuH/iDGOxcefHCbazdYTj4nFtbVtkAX8qRDz0ajlXGIhCVnV5/K7U1ZpXOlRIc8Ylt/v3DQsyvedUIyPrGLvzYx1tJXTbPWK3gXHAYRvDsydrCGfwiVCPK29Vfewy8fBaO/tdJB" ];
    };
    root.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwH1rWuQJXZXXgyWmJp6ripDLSyTGteNkvsn4AO/Bqo+TWSX1bxmDH4uk94D2/YOsRQiPs+dDHuJuBIqZnZicnOhbQFzi4EegV1S9Xw4ZWzJu9JT6dcI3ThOlQ2LVeEYajo+A1eoTdr5Hkfs79w+9FvLjYHgbuhvcsR5n9jFHynM0JPjcnDR7wNnDdqFoQqUFHG6nyJ3MotUBQGWuH/iDGOxcefHCbazdYTj4nFtbVtkAX8qRDz0ajlXGIhCVnV5/K7U1ZpXOlRIc8Ylt/v3DQsyvedUIyPrGLvzYx1tJXTbPWK3gXHAYRvDsydrCGfwiVCPK29Vfewy8fBaO/tdJB" ];
  };

  system.stateVersion = "16.09";

}
