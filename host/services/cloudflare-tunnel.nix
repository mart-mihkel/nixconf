{host}: {
  config,
  pkgs,
  ...
}: let
  tunnel = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
  token = config.sops.secrets."tunnel/${host}/token".path;
in {
  sops.secrets."tunnel/${host}/token" = {};

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
