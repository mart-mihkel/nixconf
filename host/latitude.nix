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
    # TODO: delete when neovim 0.12 is released
    overlays = [
      (import (builtins.fetchTarball {
        url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
      }))
    ];
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

  swapDevices = [
    {
      device = "/dev/nvme0n1p3";
    }
  ];

  users.users.nixos.extraGroups = ["networkmanager"];
  security.sudo.wheelNeedsPassword = false;
  xdg.portal.enable = true;

  programs = {
    sway.enable = true;
    steam.enable = true;
    chromium.enable = true;
    obs-studio.enable = true;

    neovim = {
      enable = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      defaultEditor = true;
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [libGL glib glibc stdenv.cc.cc];
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

    undervolt = {
      enable = true;
      gpuOffset = -100;
      coreOffset = -100;
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true;
    };

    greetd = {
      enable = true;
      settings.default_session = {
        user = "nixos";
        command = "sway";
      };
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    material-symbols
    jetbrains-mono
    noto-fonts
  ];

  environment.systemPackages = with pkgs; [
    cloudflared
    imagemagick
    opencode
    sqlite
    nodejs
    ffmpeg
    typst
    cargo
    rustc
    pnpm
    bun
    go
    uv

    wayland-pipewire-idle-inhibit
    sway-contrib.grimshot
    autotiling-rs
    brightnessctl
    wl-clipboard
    pulsemixer
    playerctl
    gammastep
    swayidle
    bluetui
    impala
    dunst
    wtype
    tofi
    foot
    feh

    ungoogled-chromium
    qdigidoc
    audacity
    gnumeric
    spotify
    zathura
    discord
    blender
    brave
    gimp
    vlc
  ];

  system.stateVersion = "25.05";
}
