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
    services.xserver.xkb = {
        layout = "latam";
    };

    users.users.lio = {
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager"];
    };

    security.sudo.enable = true;

    environment.systemPackages = [
        pkgs.kitty
        pkgs.rofi
        pkgs.firefox
        pkgs.neovim
        pkgs.git
        pkgs.alsa-utils
        pkgs.pavucontrol

        # i3
        pkgs.i3status
        pkgs.dmenu
        pkgs.picom
        pkgs.xclip
        pkgs.networkmanagerapplet
    ];

    programs.thunar.enable = true;

    programs.xfconf.enable = true; 	# for saving settings

    services.gvfs.enable = true; 	# mounts, USB, trash
    services.tumbler.enable = true; 	# thumbnails

    zramSwap.enable = true;

    system.stateVersion = "24.11";
}
