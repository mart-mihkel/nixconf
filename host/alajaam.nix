{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./modules/cloudflare-tunnel.nix {host = "alajaam";})
    ./modules/common.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    initrd.availableKernelModules = ["xhci_pci"];
  };

  networking = {
    hostName = "alajaam";
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    usePredictableInterfaceNames = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  services = {
    getty.autologinUser = "kubujuss";
    openssh = {
      enable = true;
      openFirewall = true;
    };
  };

  system.stateVersion = "24.05";
}
