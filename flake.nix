{
  # Very useful guide
  # https://vtimofeenko.com/posts/practical-nix-flake-anatomy-a-guided-tour-of-flake.nix/#packages

  description = "momiji's nixos flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser.url = "github:MarceColl/zen-browser-flake";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    momiji-nixvim = {
      url = "github:momiji-w/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let inherit (self) outputs;
    in {
      nixosConfigurations = {
        home = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/home/configuration.nix ];
        };
        work = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/work/configuration.nix ];
	};
      };
      homeConfigurations = {
        "momiji@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            config = {
              allowUnfree = true;
            };
            system = "x86_64-linux";
          };
          extraSpecialArgs = { inherit inputs outputs; };
          # > Our main home-manager configuration file <
          modules = [ ./home-manager/home.nix ];
        };
        "momiji@CBR-NB010" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            config = {
              allowUnfree = true;
            };
            system = "x86_64-linux";
          };
          extraSpecialArgs = { inherit inputs outputs; };
          # > Our main home-manager configuration file <
          modules = [ ./home-manager/home.nix ];
        };
      };
    };
}
