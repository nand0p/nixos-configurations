{ config, pkgs, ... }:
{

  #
  #      ==> miner <==
  #

  imports = [
    ./hardware-configuration.nix
    ./private.nix
  ];

  system = {
    copySystemConfiguration = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.device = /dev/sda;
      grub.memtest86 = true;
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
      sensitivity = 40;
      speed = 40;
      fakeButtons = false;
    };
    pulseaudio = {
      enable = false;
    };
  };

  networking = {
    useDHCP  = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      allowPing = true;
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

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    cudaSupport = true;
    enableCuda = true;
  };

  services = {
    openssh.enable = true;
    xserver = {
      videoDrivers = [ "nvidia" ];
      enable = true;
      layout = "us";
      autorun = true;
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
    };
  };

  environment = {
    variables = {
      NIX_PATH = pkgs.lib.mkOverride 0 "nixpkgs=/etc/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix";
      #NIX_PATH = pkgs.lib.mkOverride 0 "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix";
      BROWSER = "google-chrome-stable";
      EDITOR = "vim";
    };

    interactiveShellInit = ''
      alias vi="vim-with-plugins"
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
      iftop
      iptraf-ng
      bmon
      tcptrack
      nethogs
      speedtest-cli
      vim
      lsof
      pciutils
      tcpdump
      netcat
      jwhois
      strace
      openvpn
      git
      ruby
      python3
      gnupg
      parted
      hdparm
      gparted
      dmidecode
      screen
      smartmontools
      openssl
      file
      gcc
      binutils
      kdiff3
      vpnc
      openconnect
      jq
      traceroute
      atop
      libffi
      exiftool
      libpqxx
      groff
      sddm
      cmake
      boost
      libofx
      iotop
      atop
      ctop
      ftop
      lsscsi
      lshw

      # GUI
      xscreensaver
      spectacle
      wireshark
      firefox
      google-chrome
    ];

  };
}
