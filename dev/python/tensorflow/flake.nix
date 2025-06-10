{
  inputs.nixpkgs.url = "nixpkgs/release-25.05";
  outputs = inputs: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      inputs.nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
            config.cudaSupport = true;
          };
        });
  in {
    devShells = forEachSupportedSystem ({pkgs}: {
      default = pkgs.mkShell {
        venvDir = ".venv";
        shellHook = ''
          export TF_CPP_MIN_LOG_LEVEL=3
          export CUDA_HOME="/run/opengl-driver"
          export CUDA_PATH="/run/opengl-driver"
        '';

        packages = with pkgs.python312.pkgs; [
          venvShellHook
          scikit-learn
          tensorflow
          opencv4
          pandas
          numpy
          scipy
          tqdm
          pip
        ];
      };
    });
  };
}
