{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./modules/common.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
  boot.kernelModules = ["kvm-intel"];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.bluetooth.enable = true;

  networking.hostName = "dell";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  networking.usePredictableInterfaceNames = true;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c7dd8938-fe81-43d5-82bf-16a44fe28617";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2A12-F15C";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  security.sudo.wheelNeedsPassword = false;

  xdg.portal.enable = true;

  programs.hyprland.enable = true;
  programs.steam.enable = true;

  services.thermald.enable = true;
  services.undervolt = {
    enable = true;
    gpuOffset = -100;
    coreOffset = -100;
  };

  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 70;
      STOP_CHARGE_THRESH_BAT0 = 90;
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    eduvpn-client
    qbittorrent
    qdigidoc
    obsidian
    zoom-us
    spotify
    discord
    slack
  ];

  system.stateVersion = "24.11";
}
