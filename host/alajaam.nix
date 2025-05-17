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

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.initrd.availableKernelModules = ["xhci_pci"];

  networking.hostName = "alajaam";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [22]; # ssh

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

  services.openssh.enable = true;
  services.getty.autologinUser = "kubujuss";
  services.cron = {
    enable = true;
    systemCronJobs = [
      "@reboot root echo 0 > /sys/class/leds/ACT/brightness"
      "@reboot root echo 0 > /sys/class/leds/PWR/brightness"
    ];
  };

  system.stateVersion = "24.05";
}
