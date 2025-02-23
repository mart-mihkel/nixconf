{ lib, config, ... }:

{
  imports = [
    ../modules/common
    ./filesystems.nix
    ./networking.nix
    ./services.nix
    ./boot.nix
    ./gpu.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "24.05";
}
