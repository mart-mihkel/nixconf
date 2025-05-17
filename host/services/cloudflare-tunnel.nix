{host}: {
  config,
  pkgs,
  ...
}: let
  tunnel = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
  token = config.age.secrets.cloudflare-tunnel.path;
in {
  age.secrets.cloudflare-tunnel.file = ../../secrets/${host}-tunnel.age;

  systemd.services.cloudflare-tunnel = {
    after = ["network.target" "systemd-resolved.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "/bin/sh -c '${tunnel} --token $(cat ${token})'";
      Restart = "always";
      RestartSec = 5;
    };
  };
}
