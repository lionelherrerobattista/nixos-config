{ config, pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    time.timeZone = "America/Argentina/Buenos_Aires";
    i18n.defaultLocale = "en_US.UTF-8";
    console.keyMap = "la-latin1";

    networking.networkmanager.enable = true;

    services.pipewire = {
        enable = true;
        pulse.enable = true;
        alsa.enable = true;
    };

    services.xserver.enable = true;
    services.xserver.windowManager.i3.enable = true;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.xkb.layout = "latam";

    users.users.lio = {
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager"];
    };

    environment.systemPackages = with pkgs; [
        kitty
        rofi
        firefox
        neovim
        git
        alsa-utils
        pavucontrol

        # defaults
        xdg-utils       # to open things
        xdg-user-dirs   # folder structure

        # dialogs
        xdg-desktop-portal
        xdg-desktop-portal-gtk

        # theming
        papirus-icon-theme
        arc-theme

        # i3
        i3status
        dmenu
        picom
        xclip
        networkmanagerapplet
        
    ];

    fonts.packages = with pkgs; [
        inter
        jetbrains-mono
        fira-code
    ];

    services.gvfs.enable = true; 	# mounts, USB, trash
    services.tumbler.enable = true; 	# thumbnails
    programs.thunar.enable = true;
    programs.xfconf.enable = true; 	# saving settings for Xfce apps (legacy)
    programs.dconf.enable = true;   # save settings for GTK apps

    # portal - optional
    xdg.portal = {
        enable = true;
        config.common.default = "gtk";
        extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
        ];
    };

    zramSwap.enable = true;

    environment.variables = {
        GTK_THEME = "Arc-Dark";
    };

    system.stateVersion = "24.11";
}
