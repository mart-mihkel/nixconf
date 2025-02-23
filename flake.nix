{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
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
          modules = kubujuss-headless ++ [ ./host/jaam ];
        };

        alajaam = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = kubujuss-headless ++ [ ./host/alajaam ];
        };
      };
    };
}
