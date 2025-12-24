{
  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://cache.nixos-cuda.org"
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/release-25.11";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
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
        specialArgs = {inherit inputs;};
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
