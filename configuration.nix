{ config, pkgs, ... }:

{
  imports = [];

  # Hostname
  networking.hostName = "nixos";

  # Networking: NetworkManager for internet
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Filesystem - change /dev/sda1 if your root partition differs
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  # Bootloader GRUB for BIOS systems (most VMs)
  boot.loader.grub = {
    enable = true;
    version = 2;
    devices = [ "/dev/sda" ];  # Replace if your disk is different
  };

  # State version for stability
  system.stateVersion = "25.05";

  # X server & display manager (SDDM) with auto-login
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    autoLogin.enable = true;
    autoLogin.user = "abc";
  };

  # Hyprland (Wayland compositor)
  programs.hyprland.enable = true;

  # Audio via Pipewire
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
    password = "abc";  # Change this ASAP
  };

  # Enable sudo for wheel group without password (optional)
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

  # Allow unfree packages (fonts/codecs)
  nixpkgs.config.allowUnfree = true;

  # Enable zsh globally
  programs.zsh.enable = true;

  # Enable xdg portals for Wayland apps
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
