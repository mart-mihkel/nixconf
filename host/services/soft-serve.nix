let
  pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDvf3zuouOAR4EGLhsS5AWIE991ptA7gd1w0P0YoV1EF";
in {
  services.soft-serve = {
    enable = true;
    settings.initial_admin_keys = [pubkey];
  };

  networking.firewall.allowedTCPPorts = [23231]; # soft-serve ssh
}
