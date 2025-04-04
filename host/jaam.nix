{ lib, config, pkgs, ... }:


let
  tunnel = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
  token = config.sops.secrets."tunnel/jaam/token".path;
in
{
  imports = [
    ./services/jupyterhub.nix
    ./modules/common.nix
    ./modules/sops.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };

  boot = {
    loader.systemd-boot.enable = true;

    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics.enable = true;

    nvidia = {
      open = false;
      nvidiaSettings = false;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    nvidia-container-toolkit.enable = true;
  };

  networking = {
    hostName = "jaam";
    networkmanager.enable = false;

    interfaces.enp9s0.wakeOnLan.enable = true;

    firewall.allowedUDPPorts = [
      9 # wol
    ];

    firewall.allowedTCPPorts = [
      22 # ssh
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    "/media/ssd" = {
      device = "/dev/disk/by-label/ssd";
      fsType = "ext4";
    };

    "/media/hdd" = {
      device = "/dev/disk/by-label/hdd";
      fsType = "ext4";
    };
  };

  swapDevices = [
    { device = "/var/lib/swapfile"; size = 32 * 1024; }
  ];

  services = {
    openssh.enable = true;
    getty.autologinUser = "kubujuss";
    xserver.videoDrivers = [ "nvidia" ];
  };

  sops.secrets."tunnel/jaam/token" = { };
  systemd.services.cloudflare-tunnel = {
    after = [ "network.target" "systemd-resolved.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "/bin/sh -c '${tunnel} --token $(cat ${token})'";

      RestartSec = 5;
      Restart = "always";
    };
  };

  system.stateVersion = "24.05";
}
