{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: let
  cloudflare-tunnel = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
  cloudflare-token = config.age.secrets.cloudflare-tunnel.path;
  munge-pwd = config.age.secrets.munge-pwd.path;
  gres = pkgs.writeTextDir "gres.conf" "NodeName=lab Name=gpu Type=rtx4060 Count=1 File=/dev/nvidia0";
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
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
    hostName = "lab";
    networkmanager.enable = true;
    interfaces = {
      eth0.wakeOnLan.enable = true;
      wlan0.useDHCP = false;
    };

    firewall = {
      allowedUDPPorts = [9]; # wakeonlan
      allowedTCPPorts = [8000]; # jupyterhub
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

  users.users.ninakoll = {
    shell = pkgs.zsh;
    createHome = true;
    isNormalUser = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [libGL glib];
  };

  age.secrets = {
    cloudflare-tunnel.file = ../secrets/lab-tunnel.age;
    munge-pwd = {
      owner = "munge";
      file = ../secrets/munge-pwd.age;
    };
  };

  services = {
    xserver.videoDrivers = ["nvidia"];

    openssh = {
      enable = true;
      openFirewall = true;
    };

    munge = {
      enable = true;
      password = munge-pwd;
    };

    slurm = {
      client.enable = true;
      server.enable = true;
      clusterName = "lab";
      controlMachine = "lab";
      nodeName = ["lab Sockets=1 CoresPerSocket=6 ThreadsPerCore=2 CPUs=12 Gres=gpu:rtx4060:1 RealMemory=15917 State=UNKNOWN"];
      partitionName = ["gpu Nodes=ALL Default=YES MaxTime=INFINITE State=UP"];
      extraConfig = "GresTypes=gpu";
      extraConfigPaths = [gres];
    };

    jupyterhub = {
      enable = true;
      extraConfig = ''
        c.Authenticator.allowed_users = {"nixos", "ninakoll"}
        c.Authenticator.admin_users = {"nixos"}
        c.Spawner.env_keep = ["PATH"]
        c.SystemdSpawner.environment = {
          "CUDA_HOME": "/run/opengl-driver",
          "LD_LIBRARY_PATH": "/run/opengl-driver/lib",
          "SSL_CERT_FILE": "/etc/ssl/certs/ca-bundle.crt",
          "SSL_CERT_DIR": "/etc/ssl/certs",
        }
      '';
    };
  };

  systemd.services.cloudflare-tunnel = {
    after = ["network.target" "systemd-resolved.service"];
    wantedBy = ["multi-user.target"];
    script = "${cloudflare-tunnel} --token $(cat ${cloudflare-token})";
    serviceConfig = {
      Restart = "always";
      RestartSec = 5;
    };
  };

  environment.sessionVariables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    CUDA_HOME = "/run/opengl-driver";
  };

  system.stateVersion = "24.05";
}
