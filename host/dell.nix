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
  networking.hosts."192.168.0.1" = ["alajaam"];
  networking.hosts."192.168.0.2" = ["jaam"];

  fileSystems."/".device = "/dev/disk/by-uuid/c7dd8938-fe81-43d5-82bf-16a44fe28617";
  fileSystems."/".fsType = "ext4";
  fileSystems."/boot".device = "/dev/disk/by-uuid/2A12-F15C";
  fileSystems."/boot".fsType = "vfat";
  fileSystems."/boot".options = ["fmask=0077" "dmask=0077"];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  users.users.kubujuss.extraGroups = ["docker"];
  virtualisation.docker.enable = true;

  security.sudo.wheelNeedsPassword = false;

  xdg.portal.enable = true;

  programs.hyprland.enable = true;
  programs.steam.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [libGL glib glibc stdenv.cc.cc];
  };

  services.thermald.enable = true;
  services.undervolt = {
    enable = true;
    gpuOffset = -100;
    coreOffset = -100;
  };

  services.tlp = {
    enable = true;
    settings.START_CHARGE_THRESH_BAT0 = 70;
    settings.STOP_CHARGE_THRESH_BAT0 = 90;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };

  environment.systemPackages = with pkgs; [
    eduvpn-client
    qbittorrent
    qdigidoc
    obsidian
    spotify
    zoom-us
    discord
    slack
    brave
    vlc

    gnumake
    sqlite
    nodejs
    cargo
    clang
    cmake
    ninja
    meson
    nmap
    gcc
    wol
    uv
    jq

    p7zip
    unzip
    zstd
    zip
  ];

  system.stateVersion = "24.11";
}
