{ config, pkgs, ... }:

{
    networking.networkmanager.enable = true;

    services.pipewire = {
        enable = true;
        pulse.enable = true;
        alsa.enable = true;
    };

    services.xserver.enable = true;
    services.xserver.windowManager.i3.enable = true;
    services.xserver.displayManager.lightdm.enable = true;

    users.users.lio = {
        isNormalUser = true;
        extraGroups = ["wheel" "networkmanager"];
    }

    environment.systemPackages = with pkgs; [
        alacritty
        rofi
        firefox
        neovim
        git
        thunar
    ];

    zramSwap.enable = true;

    system.stateVersion = "24.11";
}