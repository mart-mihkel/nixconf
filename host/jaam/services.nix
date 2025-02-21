{ pkgs, ... }:

let
  python = pkgs.python3.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
      jupyterlab-vim = pyfinal.callPackage ../modules/packages/jupyterlab-vim.nix { };
    };
  };
in
{
  services = {
    jupyterhub = {
      enable = true;

      extraConfig = ''
        c.Authenticator.allowed_users = { 'kubujuss' }
        c.Authenticator.admin_users = { 'kubujuss' }

        c.SystemdSpawner.environment = {
          'LD_LIBRARY_PATH': '/run/opengl-driver/lib:$LD_LIBRARY_PATH',
          'CUDA_HOME': '/run/opengl-driver',

          'SSL_CERT_FILE': '/etc/ssl/certs/ca-bundle.crt',

          'TF_CPP_MIN_LOG_LEVEL': '3',
        }
      '';

      jupyterlabEnv = python.withPackages (p: with p; [
        jupyterhub
        jupyterlab
        jupyterlab-widgets
        jupyterlab-vim
      ]);

    };
  };

  networking.firewall.allowedTCPPorts = [
    8000 # jupyterhub
  ];
}
