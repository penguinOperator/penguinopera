{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "nixos";

  # Network
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Root filesystem — replace /dev/sda1 with your actual root partition
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  # Bootloader (GRUB BIOS)
  boot.loader.grub = {
    enable = true;
    version = 2;
    devices = [ "/dev/sda" ];  # Update if needed
  };

  # State version (your nixos version)
  system.stateVersion = "25.05";

  # X server + SDDM display manager
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    autoLogin.enable = true;
    autoLogin.user = "abc";
  };

  # Hyprland compositor (Wayland)
  services.xserver.windowManager.hyprland.enable = true;

  # Pipewire for sound (replace deprecated sound.enable)
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # Users
  users.users.abc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
    # For security, replace with your password hash later
    password = "abc";  
  };

  # Sudo permissions
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # System packages
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

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    font-awesome
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  nixpkgs.config.allowUnfree = true;

  # Enable zsh shell globally
  programs.zsh.enable = true;

  # Enable xdg portals for Wayland apps
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
