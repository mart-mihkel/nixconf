{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: let
  marimo-token = config.age.secrets.marimo-token.path;
in {
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
    hostName = "sff";
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
        c.SystemdSpawner.environment = {
          'SSL_CERT_FILE': '/etc/ssl/certs/ca-bundle.crt',
          'SSL_CERT_DIR': '/etc/ssl/certs',
          'LD_LIBRARY_PATH': '/run/opengl-driver/lib',
          'CUDA_HOME': '/run/opengl-driver',
          'CUDA_PATH': '/run/opengl-driver',
        }
      '';
    };
  };

  age.secrets.marimo-token.file = ../secrets/marimo-token.age;
  systemd.services.marimo = {
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    script = "${pkgs.uv}/bin/uv run marimo edit --host 0.0.0.0 --token-password $(cat ${marimo-token})";
    serviceConfig = {
      WorkingDirectory = "/home/nixos/marimo";
      Restart = "always";
      RestartSec = 5;
      Environment = [
        "LD_LIBRARY_PATH=/run/opengl-driver/lib"
        "CUDA_HOME=/run/opengl-driver"
        "CUDA_PATH=/run/opengl-driver"
      ];
    };
  };

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    CUDA_HOME = "/run/opengl-driver";
    CUDA_PATH = "/run/opengl-driver";
  };

  system.stateVersion = "24.05";
}
