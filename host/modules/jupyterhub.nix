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
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [libGL glib];
  };

  services.jupyterhub = {
    enable = true;
    jupyterlabEnv = pypkgs;
    extraConfig = ''
      c.Authenticator.allowed_users = { 'kubujuss' }
      c.Authenticator.admin_users = { 'kubujuss' }
      c.SystemdSpawner.environment = {
        'SSL_CERT_FILE': '/etc/ssl/certs/ca-bundle.crt',
        'SSL_CERT_DIR': '/etc/ssl/certs',
        'CUDA_HOME': '/run/opengl-driver',
        'CUDA_PATH': '/run/opengl-driver',
      }
    '';
  };

  networking.firewall.allowedTCPPorts = [8000]; # jupyterhub
}
