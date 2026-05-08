{
  description = "Wölfchen's nixos configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-grub = {
      url = "github:w-lfchen/catppuccin-grub";
      flake = false;
    };

    eww = {
      # see https://github.com/elkowar/eww/pull/1217
      url = "github:w-lfchen/eww/feat/updates";
      # url = "github:elkowar/eww";
      inputs = {
        flake-compat.follows = "";
        nixpkgs.follows = "nixpkgs";
      };
    };

    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs = {
        flake-utils.follows = "flake-utils";
        lix.follows = "lix";
        nixpkgs.follows = "nixpkgs";
      };
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    scripts-flake = {
      url = "github:w-lfchen/eww-scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    # just for 'follows'
    systems.url = "github:nix-systems/default";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      catppuccin-grub,
      eww,
      lix,
      lix-module,
      nix-vscode-extensions,
      scripts-flake,
      spicetify-nix,
      # not used
      flake-utils,
      systems,
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      specialArgs = { inherit inputs; };
      extraSpecialArgs = { inherit inputs; };
    in
    {
      nixosConfigurations = {
        refuge = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ./modules/nixos
            ./hosts/refuge/configuration.nix
          ];
        };
        voyage = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ./modules/nixos
            ./hosts/voyage/configuration.nix
          ];
        };
      };

      # currently using home-manager through a standalone install, this might change in the future
      homeConfigurations = {
        refuge = home-manager.lib.homeManagerConfiguration {
          inherit extraSpecialArgs pkgs;
          modules = [
            ./modules/home
            ./hosts/refuge/home.nix
          ];
        };
        voyage = home-manager.lib.homeManagerConfiguration {
          inherit extraSpecialArgs pkgs;
          modules = [
            ./modules/home
            ./hosts/voyage/home.nix
          ];
        };
      };

      formatter.${system} = pkgs.nixfmt;
    };
}
