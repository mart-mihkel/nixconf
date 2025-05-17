{
  inputs = {
    nixpkgs.url = "nixpkgs/release-25.05";
  };

  outputs = {nixpkgs, ...}: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
      config.cudaSupport = true;
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
      '';
    };
  };
}
