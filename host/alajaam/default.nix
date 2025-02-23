{ lib, ... }:

{
  imports = [
    ../modules/common
    ./filesystems.nix
    ./networking.nix
    ./services.nix
    ./boot.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  system.stateVersion = "24.05";
}
