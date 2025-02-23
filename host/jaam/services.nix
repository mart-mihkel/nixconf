{ pkgs, ... }:

let
  python = pkgs.python3.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
      jupyterlab-vim = pyfinal.callPackage ../modules/packages/jupyterlab-vim.nix { };
    };
  };

  tensorflow = python.withPackages (p: with p; [
    tensorflow
    matplotlib
    ipykernel
    plotnine
    seaborn
    pandas
    numpy
    scipy
  ]);

  torch = python.withPackages (p: with p; [
    torchvision
    torchaudio
    matplotlib
    ipykernel
    plotnine
    seaborn
    pandas
    numpy
    scipy
    torch
  ]);
in
{
  services = {
    openssh.enable = true;
    getty.autologinUser = "kubujuss";

    jupyterhub = {
      enable = true;

      extraConfig = ''
        c.Authenticator.allowed_users = { 'kubujuss' }
        c.Authenticator.admin_users = { 'kubujuss' }

        c.SystemdSpawner.environment = {
          'LD_LIBRARY_PATH': '/run/opengl-driver/lib',
          'TF_CPP_MIN_LOG_LEVEL': '3',
        }
      '';

      kernels = {
        tensorflow = {
          displayName = "Tensoflow Nix";
          argv = [ "${tensorflow.interpreter}" "-m" "ipykernel_launcher" "-f" "{connection_file}" ];
          logo32 = "${tensorflow}/${tensorflow.sitePackages}/ipykernel/resources/logo-32x32.png";
          logo64 = "${tensorflow}/${tensorflow.sitePackages}/ipykernel/resources/logo-64x64.png";
          language = "python";
          env = {
            LD_LIBRARY_PATH = "/run/opengl-driver/lib";
            TF_CPP_MIN_LOG_LEVEL = "3";
          };
        };

        torch = {
          displayName = "PyTorch Nix";
          argv = [ "${torch.interpreter}" "-m" "ipykernel_launcher" "-f" "{connection_file}" ];
          logo32 = "${torch}/${torch.sitePackages}/ipykernel/resources/logo-32x32.png";
          logo64 = "${torch}/${torch.sitePackages}/ipykernel/resources/logo-64x64.png";
          language = "python";
        };
      };

      jupyterlabEnv = python.withPackages (p: with p; [
        jupyterlab-widgets
        jupyterlab-vim
        jupyterlab
        jupyterhub
      ]);
    };
  };

  networking.firewall.allowedTCPPorts = [
    8000 # jupyterhub
    22 # ssh
  ];
}
