{
  nixConfig = {
    extra-substituters = [
      "https://cuda-maintainers.cachix.org"
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/release-25.05";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: let
    nixos = inputs.nixpkgs.lib.nixosSystem;
    agenix = inputs.agenix.nixosModules.default;
    hman = inputs.home-manager.lib.homeManagerConfiguration;
    forEachSupportedSystem = f:
      inputs.nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"] (
        system: f {pkgs = import inputs.nixpkgs {inherit system;};}
      );
  in {
    nixosConfigurations = {
      dell = nixos {
        system = "x86_64-linux";
        modules = [./host/dell.nix];
      };

      jaam = nixos {
        system = "x86_64-linux";
        modules = [./host/jaam.nix agenix];
      };

      rasp = nixos {
        system = "aarch64-linux";
        modules = [./host/rasp.nix agenix];
      };
    };

    homeConfigurations = {
      kubujuss = hman {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [./home/kubujuss.nix];
      };

      kubujuss-x86 = hman {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [./home/kubujuss-headless.nix];
      };

      kubujuss-arm = hman {
        pkgs = inputs.nixpkgs.legacyPackages.aarch64-linux;
        modules = [./home/kubujuss-headless.nix];
      };
    };

    devShells = forEachSupportedSystem ({pkgs}: {
      default = pkgs.mkShell {
        packages = with pkgs; [
          home-manager
          alejandra
          ragenix
        ];
      };
    });
  };
}
