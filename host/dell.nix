{ lib, config, ... }:

{
  imports = [
    ./modules/common.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {};

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking = {
    hostName = "dell";
    networkmanager.enable = true;
  };

  fileSystems = {};

  swapDevices = [
    { device = "/var/lib/swapfile"; size = 16 * 1024; }
  ];

  services = {
    openssh.enable = true;
    getty.autologinUser = "kubujuss";
  };

  system.stateVersion = "24.11";
}
