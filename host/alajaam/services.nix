let
  tunnel-token = builtins.readFile "/run/secrets/tunnel/alajaam/token";
in
{
  services = {
    openssh.enable = true;
    getty.autologinUser = "kubujuss";

    soft-serve = {
      enable = true;

      settings = {
        ssh = {
          public_url = "ssh://git.risuhunnik.xyz";
        };

        initial_admin_keys = [
          ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9gAe8X398YBgMrHoRIPjnEiDoTRMg0VMM3Ll/MxSYh kubujuss@uss''
        ];
      };
    };
  };

  virtualisation.oci-containers.containers = {
    tunnel = {
      image = "cloudflare/cloudflared:latest";
      cmd = [ "tunnel" "--no-autoupdate" "run" "--token" "${tunnel-token}" ];
    };
  };

  networking.firewall.allowedTCPPorts = [
    23231 # soft-serve ssh
    22 #ssh
  ];
}
