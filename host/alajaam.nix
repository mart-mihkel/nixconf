{ lib, config, pkgs, ... }:


let
  tunnel = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
  token = config.sops.secrets."tunnel/alajaam/token".path;
in
{
  imports = [
    ./services/soft-serve.nix
    ./modules/common.nix
    ./modules/sops.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    initrd = {
      availableKernelModules = [ "xhci_pci" ];
      kernelModules = [ ];
    };

    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  networking = {
    hostName = "alajaam";
    networkmanager.enable = false;
    firewall.allowedTCPPorts = [
      22 #ssh
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/var/lib/swapfile"; size = 8 * 1024; }
  ];

  services = {
    openssh.enable = true;
    getty.autologinUser = "kubujuss";
  };

  sops.secrets."tunnel/alajaam/token" = { };
  systemd.services.cloudflare-tunnel = {
    after = [ "network.target" "systemd-resolved.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "/bin/sh -c '${tunnel} --token $(cat ${token})'";

      Restart = "always";
      RestartSec = 5;
    };
  };

  system.stateVersion = "24.05";
}
