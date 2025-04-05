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

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    sops-nix,
    ...
  }: let
    build-modules = users: [
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          inherit users;
        };
      }
    ];

    modules = build-modules {kubujuss = import ./home/kubujuss.nix;};
  in {
    nixosConfigurations = {
      dell = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = modules ++ [./host/dell.nix];
      };

      jaam = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = modules ++ [./host/jaam.nix];
      };

      alajaam = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = modules ++ [./host/alajaam.nix];
      };
    };
  };
}
