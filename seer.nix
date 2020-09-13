{ config, pkgs, ... }:
{

  #
  #      ==> seer <==
  #

  imports = [
    ./hardware-configuration.nix
    ./packages-slim.nix
    ./private.nix
  ];

  system = {
    stateVersion = "19.09";
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
      grub.memtest86 = {
        enable = true;
      };
    };
    kernel.sysctl = {
      "net.ipv4.tcp_keepalive_time" = 60;
      "net.core.rmem_max" = 4194304;
      "net.core.wmem_max" = 1048576;
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  #console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "us";
  #};

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
    sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
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
    interfaces.eno1.ipv4.addresses = [ {
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
    cudaSupport = false;
    enableCuda = false;
    allowUnfree = true;
    allowBroken = true;
    oraclejdk.accept_license = true;
    packageOverrides = pkgs: {
      xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
    };
    permittedInsecurePackages = [
      "google-chrome-81.0.4044.138"
    ];
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      liveRestore = true;
      listenOptions = [ "/var/run/docker.sock" ];
      logDriver = "journald";
      enableNvidia = false;
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [];
      };
      extraOptions = "";
      storageDriver = null;  # [ "aufs" "btrfs" "devicemapper" "overlay" "overlay2" "zfs" ]
    };
    virtualbox = {
      guest = {
        enable = true;
        x11 = true;
      };
      host = {
        enable = true;
        enableExtensionPack = true;
        enableHardening = false;
        addNetworkInterface = true;
        headless = false;
      };
    };
  };

  services = {
    openssh.enable = true;
    locate.enable = false;
    transmission.enable = false;
    cron.enable = false;
    xserver = {
      videoDrivers = [ "nvidiaLegacy390" ];
      enable = true;
      layout = "us";
      autorun = true;
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
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
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
          email = nando@hex7.com
          name = nando
          signingkey = 22A06220A64D170143F987BA74F8771C340E27B8
        [push]
          default = simple
        [pull]
          rebase = true      
        [commit]
          gpgsign = true
        [gpg]
          program = gpg2
        [credential]
          helper = !aws codecommit --profile default credential-helper $@
          UseHttpPath = true
      '';
    };

    variables = {
      NIX_PATH = pkgs.lib.mkOverride 0 "nixpkgs=/etc/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix";
      BROWSER = "google-chrome-stable";
      EDITOR = "vim";
      AWS_DEFAULT_REGION = "us-east-1";
    };

    interactiveShellInit = ''
      alias mkpass="openssl rand -base64 24"
      export PS1="\[$(tput setaf 10)\]\h \[$(tput setaf 13)\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2) \[$(tput setaf 12)\]\$PWD \[$(tput setaf 5)\]:\[$(tput sgr0)\]\T\[$(tput setaf 5)\]: \[$(tput sgr0)\]";
    '';

  };

}
