{
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/var/lib/swapfile"; size = 8 * 1024; }
  ];
}
