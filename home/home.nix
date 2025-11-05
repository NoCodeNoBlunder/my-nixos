{ config, pkgs, lib, ... }:

{
    home.username = "fabian";
    # home.homeDirectory = "/home/fabian/";
    home.stateVersion = "25.05";

    programs.bash = {
        enable = true;
        shellAliases = {
            btw = "echo I use nixos, btw";
        };
    };

    # Declerative Symlinks: Source is copied to store and then symlinks go into store
    home.file.".gitconfig".source = ./dotfiles/gitconfig; # TODO: Change this path

    home.packages = with pkgs; [
        neovim
        inotify-tools # Watch for file writtes
        xclip # programm to save data in system clipboard
        # wl-clipboard # On wayland use this instead
        # Rust toolchain needed for alejandra nix code formatter
        cargo
        rustc
        neofetch
        discord
        # Nvim lsps and formatters
        stylua
        nixfmt-rfc-style
    ];

    # Declerative Out of store Symlinks
    # XGD_CONFIG_HOME is /home/username/.config 
    # where most software on linux expects the configuration

    xdg.configFile."nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/fabian/my-nixos/home/dotfiles/nvim"; 
        recursive = true; # recursive is needed for directories
    };
    # home.file.".config/nvim".source = config.file.mkOutOfStoreSymlink "/home/fabian/dotfiles/nvim";
}
