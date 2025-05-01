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

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.availableKernelModules = ["xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
    kernelModules = ["kvm-intel"];
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/c7dd8938-fe81-43d5-82bf-16a44fe28617";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/2A12-F15C";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    hostName = "dell";
  };

  security.sudo.wheelNeedsPassword = false;

  xdg.portal.enable = true;

  programs = {
    hyprland.enable = true;
    steam.enable = true;
  };

  services = {
    thermald.enable = true;

    undervolt = {
      enable = true;
      gpuOffset = -100;
      coreOffset = -100;
    };

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        START_CHARGE_THRESH_BAT0 = 70;
        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;
      autorun = false;
      displayManager.startx.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    eduvpn-client
    qbittorrent
    qdigidoc
    zoom-us
    discord
    slack
  ];

  system.stateVersion = "24.11";
}
