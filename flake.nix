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

    # private configuration
    # CAUTION: this configuration will be world readable in the nix store
    private-configs.url = "git+ssh://git@github.com/w-lfchen/private-nixos-configs";

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
      eww,
      lix,
      lix-module,
      nix-vscode-extensions,
      scripts-flake,
      private-configs,
      spicetify-nix,
      # not used
      flake-utils,
      systems,
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        # extend nixpks lib with own lib
        overlays = [ (final: prev: { lib = prev.lib // import ./lib prev; }) ];
      };
      lib = pkgs.lib;

      modules = lib.dirToSet ./modules;
      # relative paths in the config directory
      paths = {
        config = ./config;
        patches = ./patches;
        wallpapers = ./wallpapers;
      };

      specialArgs = {
        inherit
          inputs
          lib
          modules
          paths
          ;
      };
      extraSpecialArgs = { inherit inputs modules paths; };
    in
    {
      nixosConfigurations = {
        mirage = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ./hosts/mirage/configuration.nix
            private-configs.mirage.configuration
          ];
        };
        refuge = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            ./hosts/refuge/configuration.nix
            private-configs.refuge.configuration
          ];
        };
        voyage = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [ ./hosts/voyage/configuration.nix ];
        };
      };

      # currently using home-manager through a standalone install, this might change in the future
      homeConfigurations = {
        mirage = home-manager.lib.homeManagerConfiguration {
          inherit extraSpecialArgs pkgs;
          modules = [
            ./hosts/mirage/home.nix
            private-configs.mirage.home
          ];
        };
        refuge = home-manager.lib.homeManagerConfiguration {
          inherit extraSpecialArgs pkgs;
          modules = [
            ./hosts/refuge/home.nix
            private-configs.refuge.home
          ];
        };
        voyage = home-manager.lib.homeManagerConfiguration {
          inherit extraSpecialArgs pkgs;
          modules = [ ./hosts/voyage/home.nix ];
        };
      };

      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
