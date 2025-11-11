{ config, pkgs, ... }: {

    services.desktopManager = {
        # Enable the COSMIC desktop environment
        cosmic.enable = true;
    };

    services.displayManager = {
        # Enable the COSMIC login manager
        cosmic-greeter.enable = true;

        autoLogin = {
            enable = true;
            user = "fabian";
        };
    };
}
