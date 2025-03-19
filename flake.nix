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

  outputs = { nixpkgs, home-manager, sops-nix, ... }:
    let
      make-users = users: [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            inherit users;
          };
        }
      ];

      kubujuss-headless = make-users { kubujuss = import ./home/kubujuss-headless.nix; };
    in
    {
      nixosConfigurations = {
        jaam = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = kubujuss-headless ++ [ ./host/jaam sops-nix.nixosModules.sops ];
        };

        alajaam = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = kubujuss-headless ++ [ ./host/alajaam sops-nix.nixosModules.sops ];
        };
      };
    };
}
