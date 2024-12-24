{
  # Very useful guide
  # https://vtimofeenko.com/posts/practical-nix-flake-anatomy-a-guided-tour-of-flake.nix/#packages

  description = "momiji's nixos flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	
	hypr-qtutils.url = "github:hyprwm/hyprland-qtutils";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hypr-qtutils,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [./nixos/configuration.nix];
      };
    };
    homeConfigurations = {
      "momiji@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        # > Our main home-manager configuration file <
        modules = [
          ./home-manager/home.nix
          inputs.nixvim.homeManagerModules.nixvim
        ];
      };
    };
  };
}
