{
  lib,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./modules/cloudflare-tunnel.nix {host = "alajaam";})
    ./modules/common.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    initrd.availableKernelModules = ["xhci_pci"];
  };

  networking = {
    hostName = "rasp";
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    usePredictableInterfaceNames = true;
    interfaces.wlan0.ipv4.addresses = [
      {
        address = "192.168.0.1";
        prefixLength = 24;
      }
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  age.secrets.kukerpall-psk.file = ./secrets/kukerpall-psk.age;

  services = {
    getty.autologinUser = "kubujuss";
    openssh = {
      enable = true;
      openFirewall = true;
    };

    dnsmasq = {
      enable = true;
      settings = {
        interface = "wlan0";
        server = ["8.8.8.8" "1.1.1.1"];
        dhcp-range = ["192.168.0.50,192.168.0.150,12h"];
      };
    };

    hostapd = {
      enable = true;
      radios.wlan0 = {
        channel = 0;
        band = "5g";
        countryCode = "EE";
        networks.wlan0 = {
          ssid = "kukerpall83";
          authentication.saePasswords = [
            {passwordFile = config.age.secrets.kukerpall-psk.path;}
          ];
        };
      };
    };
  };

  system.stateVersion = "24.05";
}
