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
      tor-browser-bundle-bin
      googleearth
      vagrant
      virtualbox
      slack
      tdesktop

      # GAMES
      atari800
      #steam

      # BROKEN
      #electricsheep
      #libreoffice
      #mosh

      # REMOVED
      #arora
      #flashplayer

  ];
}
