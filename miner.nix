{ config, ... }:
{
  users.extraUsers = {
    nando = {
      isNormalUser = true;
      createHome = true;
      home = "/home/nando";
      extraGroups = [ "wheel" ];
      uid = 1001;
      openssh.authorizedKeys.keys = [ pubkey ];
    };
    root.openssh.authorizedKeys.keys = [ pubkey ];
  };

  services.ethminer = {
    enable = true;
    rig = "rigname";
    pool = "eth-us-east1.nanopool.org";
    wallet = "ethereum wallet";
    notify = "notify email";
    power = 113;  # nvidia 1070
    recheck = 2000;
    toolkit = "cuda";
    apiPort = -3333;
  };

}

