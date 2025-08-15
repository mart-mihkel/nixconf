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
    initrd.availableKernelModules = ["xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
    kernelModules = ["kvm-intel"];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth.enable = true;
  };

  networking = {
    hostName = "dell";
    networkmanager.enable = true;
    hosts = {
      "192.168.0.1" = ["rasp"];
      "192.168.0.2" = ["jaam"];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/de099741-5035-4505-906a-81718b7ebc02";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/3E9B-209A";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };

  zramSwap.enable = true;
  users.users.kubujuss.extraGroups = ["networkmanager"];
  security.sudo.wheelNeedsPassword = false;

  xdg = {
    portal.enable = true;
    wlr.portal.enable = true;
  };

  programs = {
    sway.enable = true;
    steam.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      withPython3 = true;
      withNodeJs = true;
      withRuby = true;
      vimAlias = true;
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [libGL glib glibc stdenv.cc.cc];
    };
  };

  services = {
    thermald.enable = true;
    auto-cpufreq.enable = true;

    undervolt = {
      enable = true;
      gpuOffset = -100;
      coreOffset = -100;
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true;
    };
  };

  system.stateVersion = "25.05";
}
