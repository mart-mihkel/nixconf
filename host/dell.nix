{
  lib,
  config,
  ...
}: {
  imports = [
    ./modules/common.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {};

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = true;
  };

  fileSystems = {};

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  networking.hostName = "dell";

  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
    };
  };

  system.stateVersion = "24.11";
}
