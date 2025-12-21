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
    nixpkgs.url = "nixpkgs/release-25.11";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: let
    nixos = inputs.nixpkgs.lib.nixosSystem;
    agenix = inputs.agenix.nixosModules.default;
  in {
    nixosConfigurations = {
      latitude = nixos {
        system = "x86_64-linux";
        modules = [./host/latitude.nix];
      };

      lab = nixos {
        system = "x86_64-linux";
        modules = [./host/lab.nix agenix];
      };

      raspi = nixos {
        system = "aarch64-linux";
        modules = [./host/raspi.nix agenix];
      };
    };
  };
}
