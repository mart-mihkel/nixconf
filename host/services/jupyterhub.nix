{pkgs, ...}: let
  pypkgs = pkgs.python3.withPackages (p:
    with p; [
      jupyterlab-widgets
      jupyterlab
      jupyterhub

      torchvision
      torchaudio
      torch

      scikit-learn
      matplotlib
      plotnine
      seaborn
      opencv4
      pandas
      numpy
      scipy
      tqdm
    ]);
in {
  services.jupyterhub = {
    enable = true;
    jupyterlabEnv = pypkgs;
    extraConfig = ''
      c.Authenticator.allowed_users = { 'kubujuss' }
      c.Authenticator.admin_users = { 'kubujuss' }
      c.SystemdSpawner.environment = {
        'SSL_CERT_FILE': '/etc/ssl/certs/ca-bundle.crt',
        'CUDA_HOME': '/run/opengl-driver',
        'CUDA_PATH': '/run/opengl-driver',

        'PYTORCH_CUDA_ALLOC_CONF': 'expandable_segments:True',
        'TF_CPP_MIN_LOG_LEVEL': '3',
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [8000]; # jupyterhub
}
