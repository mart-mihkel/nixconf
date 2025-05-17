{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
  };

  outputs = {nixpkgs, ...}: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      config.cudaSupport = true;
    };

    pypkgs = pkgs.python3.withPackages (p:
      with p; [
        scikit-learn
        torchvision
        torchaudio
        opencv4
        pandas
        numpy
        scipy
        torch
        tqdm
      ]);
  in {
    devShell.x86_64-linux = pkgs.mkShell {
      buildInputs = [pypkgs];
      shellHook = ''
        export PYTORCH_CUDA_ALLOC_CONF = "expandable_segments:True";
        export LD_LIBRARY_PATH="/run/opengl-driver/lib:$LD_LIBRARY_PATH"
        export CUDA_HOME="/run/opengl-driver"
        export CUDA_PATH="/run/opengl-driver"
      '';
    };
  };
}
