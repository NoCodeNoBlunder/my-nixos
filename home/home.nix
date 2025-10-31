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

    # Declerative Symlinks
    home.file.".gitconfig".source = ./dotfiles/gitconfig;
}
