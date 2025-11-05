{ config, pkgs, ... }: {
    # Enable the X11 windowing system.
    # services.xserver.enable = true;
    services.xserver = {
        enable = true;
        windowManager.qtile.enable = true;
    };

    services.displayManager.ly.enable = true;
}
