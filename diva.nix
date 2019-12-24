{ config, pkgs, ... }:
{

  #
  #      ==> diva <==
  #

  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./private.nix
  ];

  system = {
    copySystemConfiguration = true;
    stateVersion = "20.03";
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.device = /dev/sda;
      grub.memtest86 = true;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  i18n = {
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
      enable = true;
      support32Bit = true;
    };
    #opengl.driSupport32Bit = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  networking = {
    domain = "hex7.com";
    hostName = "diva";
    wireless.enable = false;
    useDHCP  = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      allowPing = true;
    };
    interfaces.eno1.ipv4.addresses = [
      {
        address = "192.168.130.24";
        prefixLength = 24;
      }
    ];
    defaultGateway = "192.168.130.1";
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
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
    oraclejdk.accept_license = true;
    #cudaSupport = true;
    #enableCuda = true;
  };

  virtualisation = {
    docker = {
      enable = true;
    };
    virtualbox = {
      host.enable = true;
    };
  };

  services = {
    openssh.enable = true;
    locate.enable = true;
    transmission.enable = false;
    cron.enable = true;
    xserver = {
      videoDrivers = [ "nvidia" "intel" ];
      enable = true;
      layout = "us";
      autorun = true;
      desktopManager.plasma5.enable = true;
      displayManager.sddm.enable = true;
    };
    printing = {
      enable = false;
      #drivers = [ pkgs.gutenprint ];
    };
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
          email = fernando.pando@stelligent.com
          name = Fernando J Pando
      '';
    };

    variables = {
      NIX_PATH = pkgs.lib.mkOverride 0 "nixpkgs=/etc/nixos/nixpkgs:nixos-config=/etc/nixos/configuration.nix";
      #NIX_PATH = pkgs.lib.mkOverride 0 "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix";
      BROWSER = "google-chrome-stable";
      EDITOR = "vim";
      AWS_DEFAULT_REGION = "us-east-1";
    };

    interactiveShellInit = ''
      alias mkpass="openssl rand -base64 16"
      alias vi="vim-with-plugins"
      export PS1="\[$(tput setaf 10)\]\h \[$(tput setaf 13)\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2) \[$(tput setaf 12)\]\$PWD \[$(tput setaf 5)\]:\[$(tput sgr0)\]\T\[$(tput setaf 5)\]: \[$(tput sgr0)\]";
    '';

  };
}
