{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./modules/cloudflare-tunnel.nix {host = "sff";})
    ./modules/common.nix
  ];

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
    config.cudaSupport = true;
  };

  boot = {
    initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci"];
    loader.systemd-boot.enable = true;
    kernelModules = ["kvm-amd"];
  };

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics.enable = true;
    nvidia-container-toolkit.enable = true;
    nvidia = {
      open = true;
      nvidiaPersistenced = true;
    };
  };

  networking = {
    hostName = "lab";
    networkmanager.enable = true;
    interfaces = {
      eth0.wakeOnLan.enable = true;
      wlan0.useDHCP = false;
    };

    firewall = {
      allowedUDPPorts = [9]; # wakeonlan
      allowedTCPPorts = [
        2718 # marimo
        8000 # jupyterhub
      ];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [libGL glib];
  };

  services = {
    getty.autologinUser = "nixos";
    xserver.videoDrivers = ["nvidia"];

    openssh = {
      enable = true;
      openFirewall = true;
    };

    ollama = {
      enable = true;
      openFirewall = true;
    };

    jupyterhub = {
      enable = true;
      extraConfig = ''
        c.Authenticator.allowed_users = { 'nixos' }
        c.Authenticator.admin_users = { 'nixos' }
        c.Spawner.env_keep = [
          'LD_LIBRARY_PATH',
          'SSL_CERT_FILE',
          'SSL_CERT_DIR',
          'CUDA_HOME',
          'CUDA_PATH',
          'PATH',
        ]
      '';
    };
  };

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    CUDA_HOME = "/run/opengl-driver";
    CUDA_PATH = "/run/opengl-driver";
  };

  system.stateVersion = "24.05";
}
