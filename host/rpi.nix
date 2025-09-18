{
  lib,
  pkgs,
  config,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (import ./modules/cloudflare-tunnel.nix {host = "rpi";})
    ./modules/common.nix
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  age.secrets.wpa-psk.file = ../secrets/wpa-psk.age;

  boot = {
    initrd.availableKernelModules = ["xhci_pci"];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  networking = {
    hostName = "rpi";
    networkmanager.enable = false;
    interfaces = {
      eth0.useDHCP = false;
      wlan0.ipv4.addresses = [
        {
          address = "192.168.0.1";
          prefixLength = 24;
        }
      ];

      usb0.ipv4.routes = [
        {
          address = "0.0.0.0";
          prefixLength = 0;
          via = "0.0.0.0";
        }
      ];
    };

    nat = {
      enable = true;
      internalInterfaces = ["wlan0"];
      externalInterface = "usb0";
    };

    firewall = {
      allowedUDPPorts = [53 67]; # dns dhcp
      allowedTCPPorts = [53]; # dns
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  zramSwap.enable = true;

  services = {
    getty.autologinUser = "nixos";
    openssh = {
      enable = true;
      openFirewall = true;
    };

    dnsmasq = {
      enable = true;
      settings = {
        interface = "wlan0";
        server = ["9.9.9.9" "8.8.8.8" "1.1.1.1"];
        dhcp-host = ["10:3d:1c:4b:6d:b5,192.168.0.2"];
        dhcp-range = ["192.168.0.50,192.168.0.150,12h"];
      };
    };

    hostapd = {
      enable = true;
      radios.wlan0 = {
        band = "5g";
        channel = 0;
        countryCode = "EE";
        networks.wlan0 = {
          ssid = "kukerpall83";
          authentication = {
            mode = "wpa2-sha1";
            wpaPasswordFile = config.age.secrets.wpa-psk.path;
          };
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [wol];

  system.stateVersion = "24.05";
}
