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

  networking = {
    hostName = "dell";
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    usePredictableInterfaceNames = true;
    hosts = {
      "192.168.0.1" = ["alajaam"];
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

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  users.users.kubujuss = {
    shell = pkgs.zsh;
    extraGroups = ["docker" "networkmanager"];
  };

  security.sudo.wheelNeedsPassword = false;
  virtualisation.docker.enable = true;

  xdg = {
    portal.enable = true;
    icons.fallbackCursorThemes = ["Adwaita"];
  };

  programs = {
    zsh.enable = true;
    steam.enable = true;
    hyprland.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      withNodeJs = true;
      withPython3 = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [libGL glib glibc stdenv.cc.cc];
    };
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
        START_CHARGE_THRESH_BAT0 = 70;
        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    cozette
  ];

  environment.systemPackages = with pkgs; [
    nettools
    gnumake
    luajit
    sqlite
    nodejs
    cargo
    clang
    cmake
    ninja
    meson
    p7zip
    unzip
    nmap
    zstd
    zip
    gcc
    wol
    uv

    (rofi-wayland.override {plugins = with pkgs; [rofi-emoji];})
    wayland-pipewire-idle-inhibit
    adwaita-icon-theme
    brightnessctl
    wl-clipboard
    pulseaudio
    pulsemixer
    gammastep
    playerctl
    hyprpaper
    hyprland
    hypridle
    hyprlock
    bluetui
    waybar
    dunst
    wtype
    slurp
    grim
    foot
    feh

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
  ];

  system.stateVersion = "25.05";
}
