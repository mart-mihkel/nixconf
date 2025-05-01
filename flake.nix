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
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.darwin.follows = "";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {...} @ inputs: let
    build-modules = users: [
      inputs.agenix.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          inherit users;
        };
      }
    ];

    modules = build-modules {kubujuss = import ./home/kubujuss.nix;};
    modules-headless = build-modules {kubujuss = import ./home/kubujuss-headless.nix;};
  in {
    nixosConfigurations = {
      dell = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = modules ++ [./host/dell.nix];
      };

      jaam = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = modules-headless ++ [./host/jaam.nix];
      };

      alajaam = inputs.nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = modules-headless ++ [./host/alajaam.nix];
      };
    };
  };
}
