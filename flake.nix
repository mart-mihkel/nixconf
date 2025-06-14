{
  nixConfig.extra-substituters = [
    "https://cuda-maintainers.cachix.org"
    "https://nix-community.cachix.org"
  ];

  nixConfig.extra-trusted-public-keys = [
    "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  inputs = {
    nixpkgs.url = "nixpkgs/release-25.05";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.darwin.follows = "";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {...} @ inputs: let
    mk-users = users: {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users = users;
    };

    mk-modules = users: [
      inputs.agenix.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      (mk-users users)
    ];

    headed = mk-modules {kubujuss = import ./home/kubujuss.nix;};
    headless = mk-modules {kubujuss = import ./home/kubujuss-headless.nix;};
  in {
    nixosConfigurations = {
      dell = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = headed ++ [./host/dell.nix];
      };

      jaam = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = headless ++ [./host/jaam.nix];
      };

      alajaam = inputs.nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = headless ++ [./host/alajaam.nix];
      };
    };
  };
}
