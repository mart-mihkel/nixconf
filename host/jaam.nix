{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./services/cloudflare-tunnel.nix {host = "jaam";})
    ./services/jupyterhub.nix
    ./services/ollama.nix
    ./modules/common.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;

  boot.loader.systemd-boot.enable = true;
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci"];
  boot.kernelModules = ["kvm-amd"];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.graphics.enable = true;
  hardware.nvidia.open = true;
  hardware.nvidia.nvidiaPersistenced = true;
  hardware.nvidia-container-toolkit.enable = true;

  networking.hostName = "jaam";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  networking.usePredictableInterfaceNames = true;
  networking.interfaces.enp9s0.wakeOnLan.enable = true;
  networking.firewall.allowedUDPPorts = [9]; # wol

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  services.getty.autologinUser = "kubujuss";
  services.xserver.videoDrivers = ["nvidia"];

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib:${pkgs.libGL}/lib:${pkgs.glib.out}/lib:$LD_LIBRARY_PATH";
    CUDA_HOME = "/run/opengl-driver";
    CUDA_PATH = "/run/opengl-driver";
  };

  system.stateVersion = "24.05";
}
