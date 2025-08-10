let
  pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+eAbOpslZpfbchZmIEADHnxDTFvuEy1eblh4OnkZpm";
in {
  services.soft-serve = {
    enable = true;
    settings.initial_admin_keys = [pubkey];
  };

  networking.firewall.allowedTCPPorts = [23231];
}
