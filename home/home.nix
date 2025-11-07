{ config, pkgs, lib, ... }:

{
    home.username = "fabian";
    # home.homeDirectory = "/home/fabian/";
    home.stateVersion = "25.05";

    # There is modules in Homemanager for certain pkgs
    # programs.bash = {
    #     enable = true;
    #     shellAliases = {
    #         btw = "echo I use nixos, btw";
    #     };
    # };

    # programs.zsh = {
    #     enable = true;
    #     shellAliases = {
    #         btw = "echo I use nixos, btw";
    #     };
    # };

    # Declerative Symlinks: Source is copied to store and then symlinks go into store
    home.file.".gitconfig".source = ./dotfiles/gitconfig; # TODO: Change this path

    home.packages = with pkgs; [
        nh # Nix cli helper
        inotify-tools # Watch for file writtes
        xclip # programm to save data in system clipboard
        # wl-clipboard # On wayland use this instead
        # Rust toolchain needed for alejandra nix code formatter
        cargo
        rustc
        neofetch
        discord

        # Nvim lsps and formatters
        # stylua
        # nixfmt-rfc-style
        neovim
        # vimPlugins.lazy-nvim
        # vimPlugins.telescope-nvim
        zsh-autosuggestions
        zsh-syntax-highlighting
        zsh-completions
        # oh-my-zsh
        lazygit
    ];

    # TODO hardcoded absolute paths use something like this: ${config.home.homeDirectory}
    home.file.".zshrc" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/fabian/my-nixos/home/dotfiles/zsh/zshrc";
        # recursive = true;  # Needed because it's a directory
    };

    # Declerative Out of store Symlinks
    # XGD_CONFIG_HOME is /home/username/.config 
    # where most software on linux expects the configuration

    # -- Neovim configuration via Home Manager module not sure that is what I want
    # programs.neovim = {
    #     enable = true;
    #     defaultEditor = true; # TODO this does not work
    #
    #     plugins = with pkgs.vimPlugins; [
    #         lazy-nvim
    #         telescope-nvim
    #     ];
    # };

    # xdg.configFile."nvim" = {
    #     source = config.lib.file.mkOutOfStoreSymlink "/home/fabian/my-nixos/home/dotfiles/nvim"; 
    #     recursive = true; # recursive is needed for directories
    # };

    home.file.".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/fabian/my-nixos/home/dotfiles/nvim";
        recursive = true;  # Needed because it's a directory
    };

    # Proposes syntax but not implemented ... see https://github.com/nix-community/home-manager/issues/3514
    # home.file.".config/nvim" = {
    #   source = "/home/fabian/my-nixos/home/dotfiles/nvim";
    #   recursive = true;
    #   outOfStoreSymlink = true;
    # };
}
