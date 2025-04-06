{
  lib,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./services/cloudflare-tunnel.nix {host = "jaam";})
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
    initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "sd_mod"];
    kernelModules = ["kvm-amd"];
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

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
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
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

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

  services = {
    openssh.enable = true;
    getty.autologinUser = "kubujuss";
    xserver.videoDrivers = ["nvidia"];
  };

  system.stateVersion = "24.05";
}
