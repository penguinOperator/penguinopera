{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.hyprland.enable = true;

  users.users.abc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    hyprland
    kitty
    foot
    waybar
    fuzzel
    mako
    wlogout
    starship
    git
    neovim
    fish
    zsh
    qt5ct
    qt6ct
    mpv
    unzip
    wget
    curl
    networkmanagerapplet
    ags
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
