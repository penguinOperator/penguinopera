{ config, pkgs, ... }:

{
  # Basic imports
  imports = [];

  # Set hostname
  networking.hostName = "nixos";

  # Enable networking with NetworkManager for internet
  networking.networkmanager.enable = true;

  # Set timezone and locale
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Root filesystem, replace /dev/sda1 if different
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  # Explicitly set stateVersion for stability
  system.stateVersion = "25.05";

  # Enable X server - required for SDDM
  services.xserver.enable = true;

  # Display manager SDDM with auto-login
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    autoLogin = {
      enable = true;
      user = "abc";
    };
  };

  # Enable Hyprland (Wayland compositor)
  programs.hyprland.enable = true;

  # Enable pipewire audio system
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # User definition
  users.users.abc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
    password = "abc"; # Change this ASAP in a real system
  };

  # Enable sudo for users in wheel group
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Basic packages to install
  environment.systemPackages = with pkgs; [
    kitty
    firefox
    neovim
    git
    wget
    curl
    unzip
    zsh
    starship
    waybar
    foot
    hyprpaper
    xdg-utils
    pavucontrol
    nerdfonts
  ];

  # Fonts config
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    font-awesome
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Allow unfree software for fonts/codecs
  nixpkgs.config.allowUnfree = true;

  # Enable zsh shell globally
  programs.zsh.enable = true;

  # Enable xdg portals for Wayland apps
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
