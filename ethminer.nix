{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.ethminer;
in

{

  ###### interface

  options = {

    services.ethminer = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable ethminer ether mining";
      };

      recheck = mkOption {
        type = types.string;
        default = "1000";
        description = "time to recheck";
      };

      toolkit = mkOption {
        type = types.string;
        default = "cuda";
        description = "cuda or opencl";
      };

      apiPort = mkOption {
        type = types.string;
        default = "-3333";
        description = "ethminer api port";
      };

      wallet = mkOption {
        type = types.string;
        default = "ethereum-wallet-address-here";
        description = "ethereum waller address";
      };

      pool = mkOption {
        type = types.string;
        default = "mining pool address";
        description = "mining pool address";
      };

      stratumPort = mkOption {
        type = types.string;
        default = "9999";
        description = "stratum protocol tcp port";
      };

      rig = mkOption {
        type = types.string;
        default = "mining-rig-name";
        description = "mining rig name";
      };

      notify = mkOption {
        type = types.string;
        default = "email@example.org";
        description = "email address to register with pool";
      };

    };

  };


  ###### implementation

  config = mkIf cfg.enable {

    #users.users = ethminer
    #  { name = "ethminer";
    #    group = "ethminer";
    #    description = "ethminer service user";
    #    home = "/opt/ethminer";
    #    uid = config.ids.uids.ethminer;
    #  };

    #users.groups = singleton
    #  { name = "ethminer";
    #    gid = config.ids.gids.ethminer;
    #  };

    systemd.services.ethminer = {
      path = [ pkgs.cudatoolkit ];
      description = "ethminer ethereum mining service";
      wantedBy = [ "multi-user.target" ];
      script = "/nix/store/8q4wpq7cqq2q4wr9dawzhvj91v6908lp-ethminer-0.17.0/bin/ethminer --farm-recheck ${cfg.recheck} --report-hashrate --${cfg.toolkit} --api-port ${cfg.apiPort} stratum1+tcp://${cfg.wallet}@${cfg.pool}:${cfg.stratumPort}/${cfg.rig}/${cfg.notify}";
    };
  };
}
