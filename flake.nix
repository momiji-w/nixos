{
  description = "momiji's nixos flakes";

  inputs = {
    nixpkgs.url          = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    momiji-nvim.url = "github:momiji-w/nvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = let 
          pkgs-unstable = import nixpkgs-unstable {
            config.allowUnfree = true;
            localSystem = "x86_64-linux";
          };
        in {
          inherit inputs outputs;
          inherit pkgs-unstable;
        };
        # > Our main nixos configuration file <
        modules = [./nixos/configuration.nix];
      };
    };
    homeConfigurations = {
      "momiji@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [./home-manager/home.nix];
      };
    };
  };
}
