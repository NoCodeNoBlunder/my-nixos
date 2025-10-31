{
  description = "My first flake";

  # Define homemanager in the flake so the flake can manage homemanager
  # Man kann hier auch kurz vorm schreiben: "nigpkgs/nixos-25.05"

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
	url = "github:nix-community/home-manager/release-25.05";
	inputs.nixpkgs.follows = "nixpkgs"; # Prevent Home Manager from pulling its own version of nixpkgs
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	system = "x86_64-linux";
	modules = [
	    ./system/configuration.nix 
	    home-manager.nixosModules.home-manager  
	    {
                  home-manager = {
                       useGlobalPkgs = true; # what does  this do?
                       useUserPackages = true; # what does this do?
                       users.fabian = import ./home/home.nix;
                       backupFileExtension = "backup";
		  };
   	    }
	];
    };
  };
}
