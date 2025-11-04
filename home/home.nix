{ config, pkgs, ... }:

{
    home.username = "fabian";
    # home.homeDirectory = "/home/fabian/";
    home.stateVersion = "25.05";

    programs.bash = {
         enable = true;
 	 shellAliases = {
 	     btw = "echo I use nixos, btw";
 	     btw2 = "echo I use nixos, btw btw";
         };
    };

    # Declerative Symlinks: Source is copied to store and then symlinks go into store
    home.file.".gitconfig".source = ./dotfiles/gitconfig;

    home.packages = with pkgs; [
    	gh # GitHub CLI tool for authentification allows to add public keys to git repo
	neovim
    ];
   
}
