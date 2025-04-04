{ pkgs, ... }:

let
  python = pkgs.python3.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
      jupyterlab-vim = pyfinal.callPackage ../packages/jupyterlab-vim.nix { };
    };
  };

  pycommon = p: with p; [
    scikit-learn
    matplotlib
    plotnine
    seaborn
    pandas
    numpy
    scipy
    tqdm
  ];
in
{
  environment = {
    systemPackages = with pkgs; [ libGL glib ];
    variables = {
      LD_LIBRARY_PATH = "/run/opengl-driver/lib:${pkgs.libGL}/lib:${pkgs.glib.out}/lib:$LD_LIBRARY_PATH";
    };
  };

  services = {
    jupyterhub = {
      enable = true;

      extraConfig = ''
        c.Authenticator.allowed_users = { 'kubujuss' }
        c.Authenticator.admin_users = { 'kubujuss' }

        c.SystemdSpawner.environment = {
          'SSL_CERT_FILE': '/etc/ssl/certs/ca-bundle.crt',

          'LD_LIBRARY_PATH': '/run/opengl-driver/lib:${pkgs.libGL}/lib:${pkgs.glib.out}/lib:$LD_LIBRARY_PATH',
          'CUDA_HOME': '/run/opengl-driver',
          'CUDA_PATH': '/run/opengl-driver',

          'TF_CPP_MIN_LOG_LEVEL': '3',
        }
      '';

      jupyterlabEnv = python.withPackages (p: with p; [
        jupyterlab-widgets
        jupyterlab-vim
        jupyterlab
        jupyterhub
      ] ++ (pycommon p));
    };
  };

  networking.firewall.allowedTCPPorts = [
    8000 # jupyterhub
  ];
}
