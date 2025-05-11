{
  services.soft-serve = {
    enable = true;

    settings = {
      ssh = {public_url = "ssh://git.risuhunnik.xyz";};
      initial_admin_keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDvf3zuouOAR4EGLhsS5AWIE991ptA7gd1w0P0YoV1EF"
      ];
    };
  };

  networking.firewall.allowedTCPPorts = [23231]; # soft-serve ssh
}
