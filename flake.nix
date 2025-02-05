{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: let
    x86 = "x86_64-linux";
    arm = "aarch64-linux";

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
  in {
    nixosConfigurations = {
      jaam = nixpkgs.lib.nixosSystem {
        system = "${x86}";
        modules =  kubujuss-headless ++ [ ./host/jaam ];
      };

      alajaam = nixpkgs.lib.nixosSystem {
        system = "${arm}";
        modules = kubujuss-headless ++ [ ./host/alajaam ];
      };
    };
  };
}
