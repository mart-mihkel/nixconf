{
  lib,
  pkgs,
  inputs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./common.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  boot = {
    kernelModules = ["kvm-intel"];
    initrd.availableKernelModules = [
      "xhci_pci"
      "nvme"
      "usbhid"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];

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
    hostName = "latitude";
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };

    hosts = {
      "192.168.0.1" = ["raspi"];
      "192.168.0.2" = ["lab"];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/nvme0n1p2";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };

  swapDevices = [{device = "/dev/nvme0n1p3";}];

  users.users.nixos.extraGroups = ["networkmanager"];
  security.sudo.wheelNeedsPassword = false;
  xdg.portal.enable = true;

  programs = {
    steam.enable = true;
    nix-ld.enable = true;
    chromium.enable = true;
    hyprland.enable = true;

    neovim = {
      enable = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      defaultEditor = true;

      # TODO: delete when neovim 0.12 is released
      package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };

    dconf.profiles.user.databases = [
      {
        settings."org/gnome/desktop/interface".font-name = "Noto Sans Medium 10";
      }
    ];
  };

  services = {
    pcscd.enable = true;
    thermald.enable = true;
    auto-cpufreq.enable = true;
    getty.autologinUser = "nixos";

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

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts

    material-symbols
    jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    cloudflared
    opencode
    sqlite
    nodejs
    typst
    cargo
    rustc
    pnpm
    bun
    go
    uv

    brightnessctl
    imagemagick
    pulsemixer
    fastfetch
    grimblast
    gammastep
    playerctl
    bluetui
    ffmpeg
    hellwal
    impala
    dunst
    rofi
    swww
    feh

    wayland-pipewire-idle-inhibit
    swaynotificationcenter
    adwaita-icon-theme
    wl-clipboard
    wl-mirror
    alacritty
    hyprland
    hypridle
    hyprlock
    waybar
    wtype
    foot

    eduvpn-client
    qdigidoc
    spotify
    zathura
    discord
    brave
    vlc
  ];

  system.stateVersion = "25.05";
}
