{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./modules/cloudflare-tunnel.nix {host = "jaam";})
    ./modules/soft-serve.nix
    ./modules/jupyterhub.nix
    ./modules/rstudio.nix
    ./modules/ollama.nix
    ./modules/common.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
    config.cudaSupport = true;
  };

  boot = {
    loader.systemd-boot.enable = true;
    initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci"];
    kernelModules = ["kvm-amd"];
  };

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics.enable = true;
    nvidia-container-toolkit.enable = true;
    nvidia = {
      open = true;
      nvidiaPersistenced = true;
    };
  };

  networking = {
    hostName = "jaam";
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    usePredictableInterfaceNames = true;
    interfaces.enp9s0.wakeOnLan.enable = true;
    firewall.allowedUDPPorts = [9]; # wakeonlan
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
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  services = {
    getty.autologinUser = "kubujuss";
    xserver.videoDrivers = ["nvidia"];
    openssh = {
      enable = true;
      openFirewall = true;
    };
  };

  environment = {
    variables = {
      CUDA_HOME = "/run/opengl-driver";
      CUDA_PATH = "/run/opengl-driver";
    };

    systemPackages = with pkgs; [
      tree-sitter
      alejandra
      nil
      uv
    ];
  };

  system.stateVersion = "24.05";
}
