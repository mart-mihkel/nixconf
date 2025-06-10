{
  inputs.nixpkgs.url = "nixpkgs/release-25.05";
  outputs = inputs: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      inputs.nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [inputs.self.overlays.default];
          };
        });
  in {
    overlays.default = final: prev: {
      rEnv = final.rWrapper.override {
        packages = with final.rPackages; [knitr ggplot2 tidyverse];
      };
    };

    devShells = forEachSupportedSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          texlive.combined.scheme-full
          rstudio
          pandoc
          rEnv
        ];
      };
    });
  };
}
