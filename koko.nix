{ config, pkgs, ... }:
{

  #
  #      ==> koko <==
  #

  imports = [
    ./hardware-configuration.nix
    ./packages-slim.nix
    ./private.nix
  ];

  system = {
    copySystemConfiguration = true;
    stateVersion = "20.09";
    #autoUpgrade = {
    #  channel= "https://nixos.org/channels/nixos-unstable";
    #  enable = false;
    #};
  };

  boot = {

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      grub.memtest86.enable = true;
    };
    #extraModprobeConfig = ''
    #  install nouveau /run/current-system/sw/bin/false
    #  #options nvidia-drm modeset=1
    #'';
    #extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
    #kernelParams = [ "acpi_rev_override" ];
    #initrd.kernelModules = [
    #  "nvidia"
    #  "nvidia_modeset"
    #  "nvidia_uvm"
    #  "nvidia_drm"
    #];
    kernel.sysctl = {
      "net.ipv4.tcp_keepalive_time" = 60;
      "net.core.rmem_max" = 4194304;
      "net.core.wmem_max" = 1048576;
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  hardware = {
    #nvidia.modesetting.enable = true;
    #opengl.driSupport32Bit = true;
    trackpoint = {
      enable = true;
      sensitivity = 50;
      speed = 40;
      fakeButtons = false;
    };
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
  };

  networking = {
    domain = "hex7.com";
    hostName = "koko";
    wireless.enable = false;
    useDHCP  = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 6000 6001 ];
      allowPing = true;
    };
    interfaces.eno1.ipv4.addresses = [ {
      address = "192.168.100.21";
      prefixLength = 24;
    } ];
    defaultGateway = "192.168.100.1";
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
    #cudaSupport = true;
    #enableCuda = true;

    allowUnfree = true;
    allowBroken = true;
    oraclejdk.accept_license = true;
    #manual.manpages.enable = false;
    packageOverrides = pkgs: {
      xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      liveRestore = true;
      listenOptions = [ "/var/run/docker.sock" ];
      logDriver = "journald";
      autoPrune = {
        enable = true;
        dates = "weekly";
        flags = [];
      };
      extraOptions = "";
      storageDriver = null;  # [ "aufs" "btrfs" "devicemapper" "overlay" "overlay2" "zfs" ]
      #enableNvidia = true;
    };
    virtualbox = {
      guest = {
        enable = true;
        x11 = true;
      };
      host = {
        enable = true;
        enableExtensionPack = true;
        enableHardening = true;
        addNetworkInterface = true;
        headless = false;
      };
    };
  };

  services = {
    openssh.enable = true;
    locate.enable = true;
    transmission.enable = true;
    cron.enable = true;
    xserver = {
      videoDrivers = [ "nvidia" ];
      #videoDrivers = [ "modesetting" "nvidia" ];
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
  };

  #systemd.services.nvidia-control-devices = {
  #  wantedBy = [ "multi-user.target" ];
  #  serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  #};

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

      #hack-font
      #liberation_ttf
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
      export PS1="\[$(tput setaf 10)\]\h \[$(tput setaf 13)\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2) \[$(tput setaf 12)\]\$PWD \[$(tput setaf 5)\]:\[$(tput sgr0)\]\T\[$(tput setaf 5)\]: \[$(tput sgr0)\]";
    '';

  };
}
