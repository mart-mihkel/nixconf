{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./services/cloudflare-tunnel.nix {host = "alajaam";})
    ./modules/common.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  boot = {
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
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
    cron = {
      enable = true;
      systemCronJobs = [
        "@reboot root echo 0 > /sys/class/leds/ACT/brightness"
        "@reboot root echo 0 > /sys/class/leds/PWR/brightness"
      ];
    };
  };

  system.stateVersion = "24.05";
}
