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
    home-man = inputs.home-manager.lib.homeManagerConfiguration;
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

      alajaam = nixos {
        system = "aarch64-linux";
        modules = [./host/alajaam.nix agenix];
      };
    };

    homeConfigurations = {
      kubujuss = home-man {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [./home/kubujuss.nix];
      };

      kubujuss-x86 = home-man {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        modules = [./home/kubujuss-headless.nix];
      };

      kubujuss-arm = home-man {
        pkgs = inputs.nixpkgs.legacyPackages.aarch64-linux;
        modules = [./home/kubujuss-headless.nix];
      };
    };
  };
}
