{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      wget
      curl
      bind
      htop
      screen
      nmap
      zip
      unzip
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
      docker
      terraform
      packer
      git
      vlc
      mplayer
      ruby
      python38Full
      awscli
      gnupg
      arora
      transmission
      transgui
      xscreensaver
      dmidecode
      openssl
      file
      ansible
      kdiff3
      spectacle
      jq
      traceroute
      lshw
      flashplayer
      tor-browser-bundle-bin
      googleearth
      libreoffice
      vagrant

      # GAMES
      atari800
      #steam

      # BROKEN
      #electricsheep
      #mosh

  ];
}
