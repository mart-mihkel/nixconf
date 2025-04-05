{lib, ...}: {
  imports = [
    (import ./services/cloudflare-tunnel.nix {host = "alajaam";})
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

    initrd.availableKernelModules = ["xhci_pci"];
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

  networking = {
    hostName = "alajaam";
    networkmanager.enable = false;
    firewall.allowedTCPPorts = [
      22 # ssh
    ];
  };

  services = {
    openssh.enable = true;
    getty.autologinUser = "kubujuss";
  };

  system.stateVersion = "24.05";
}
