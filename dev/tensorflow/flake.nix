{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
  };

  outputs = {nixpkgs, ...}: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        cudaSupport = true;
      };
    };

    pypkgs = pkgs.python311.withPackages (p:
      with p; [
        scikit-learn
        tensorflow
        opencv4
        pandas
        numpy
        scipy
        tqdm
      ]);
  in {
    devShell.x86_64-linux = pkgs.mkShell {
      buildInputs = [pypkgs];

      shellHook = ''
        export TF_CPP_MIN_LOG_LEVEL=3

        export LD_LIBRARY_PATH="/run/opengl-driver/lib:$LD_LIBRARY_PATH"
        export CUDA_HOME="/run/opengl-driver"
        export CUDA_PATH="/run/opengl-driver"

        echo 📦 tensorflow nix-shell
        echo 🐍 python-${pkgs.python3.version}
        echo 🤖 tensorflow-${pkgs.python3Packages.tensorflow.version}
      '';
    };
  };
}
