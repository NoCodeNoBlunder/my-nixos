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

  outputs = { self, nixpkgs, home-manager, ... }: 
    # Define helper function to build different kinds of systems
    let 
	makeSystemfunc = { modules }: nixpkgs.lib.nixosSystem {
	   modules = modules ++ [
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
    in
  {
      # Use makeSystemfunc helper function to built different nixos desktop experiences
       nixosConfigurations = 
       let 
          # Define systems
          qtile-ly-system = makeSystemfunc { modules = [ ./desktop/qtile-ly.nix ]; };
          cosmic-system = makeSystemfunc { modules = [ ./desktop/cosmic.nix ]; };
          hyperland-system = makeSystemfunc { modules = [ ./desktop/hyperland.nix ]; };
       in 
       {
	  # Default system is nixos
          nixos = qtile-ly-system; 
          qtile-ly = qtile-ly-system;
          cosmic = cosmic-system;
          hyperland = hyperland-system;
       };
#
    #nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	#system = "x86_64-linux";
	#modules = [
	    #./system/configuration.nix 
	    #home-manager.nixosModules.home-manager  
	    #{
                  #home-manager = {
                       #useGlobalPkgs = true; # what does  this do?
                       #useUserPackages = true; # what does this do?
                       #users.fabian = import ./home/home.nix;
                       #backupFileExtension = "backup";
		  #};
   	    #}
	#];
    #};

  };
}
