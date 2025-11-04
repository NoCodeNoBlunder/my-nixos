{ config, pkgs, lib, ... }:

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
    home.file.".gitconfig".source = ./dotfiles/gitconfig; # TODO: Change this path

    home.packages = with pkgs; [
    	gh # GitHub CLI tool for authentification allows to add public keys to git repo
	neovim
    ];

    # Declerative Out of store Symlinks
    # XGD_CONFIG_HOME is /home/username/.config 
    # where most software on linux expects the configuration

    xdg.configFile."nvim" = {
	source = config.lib.file.mkOutOfStoreSymlink "/home/fabian/dotfiles/nvim";
	recursive = true; # recursive is needed for directories
    };
    # home.file.".config/nvim".source = config.file.mkOutOfStoreSymlink "/home/fabian/dotfiles/nvim";
}
