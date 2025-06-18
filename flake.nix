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
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.darwin.follows = "";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {...} @ inputs: let
    agenix = inputs.agenix.nixosModules.default;
  in {
    nixosConfigurations = {
      dell = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./host/dell.nix];
      };

      jaam = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [./host/jaam.nix agenix];
      };

      alajaam = inputs.nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [./host/alajaam.nix agenix];
      };
    };
  };
}
