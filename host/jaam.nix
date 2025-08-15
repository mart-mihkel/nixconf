{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./cloudflare-tunnel.nix {host = "jaam";})
    ./common.nix
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
    hostName = "jaam";
    networkmanager.enable = true;
    interfaces = {
      eth0.wakeOnLan.enable = true;
      wlan0.useDHCP = false;
    };

    firewall = {
      allowedTCPPorts = [8000 8787 23231]; # jupyterhub rstudio softserve
      allowedUDPPorts = [9]; # wakeonlan
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

  zramSwap.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [libGL glib];
  };

  services = {
    getty.autologinUser = "kubujuss";
    xserver.videoDrivers = ["nvidia"];

    openssh = {
      enable = true;
      openFirewall = true;
    };

    ollama = {
      enable = true;
      openFirewall = true;
    };

    rstudio-server = {
      enable = true;
      listenAddr = "0.0.0.0";
    };

    soft-serve = {
      enable = true;
      settings.initial_admin_keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+eAbOpslZpfbchZmIEADHnxDTFvuEy1eblh4OnkZpm"
      ];
    };

    jupyterhub = {
      enable = true;
      jupyterlabEnv = pkgs.python3.withPackages (p:
        with p; [
          jupyterlab-widgets
          jupyterlab
          jupyterhub

          torchvision
          torchaudio
          torch

          scikit-learn
          matplotlib
          plotnine
          seaborn
          opencv4
          plotly
          polars
          pandas
          numpy
          scipy
          tqdm
        ]);

      extraConfig = ''
        c.Authenticator.allowed_users = { 'kubujuss' }
        c.Authenticator.admin_users = { 'kubujuss' }
        c.SystemdSpawner.environment = {
          'SSL_CERT_FILE': '/etc/ssl/certs/ca-bundle.crt',
          'SSL_CERT_DIR': '/etc/ssl/certs',
          'CUDA_HOME': '/run/opengl-driver',
          'CUDA_PATH': '/run/opengl-driver',
        }
      '';
    };
  };

  environment.variables = {
    CUDA_HOME = "/run/opengl-driver";
    CUDA_PATH = "/run/opengl-driver";
  };

  system.stateVersion = "24.05";
}
