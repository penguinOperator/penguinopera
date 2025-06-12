{ config, pkgs, ... }:

{
  imports = [ ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname & networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Root filesystem - update device accordingly
  fileSystems."/" = {
    device = "/dev/sda1"; # <-- replace this with your root partition
    fsType = "ext4";
  };

  # Set system version explicitly
  system.stateVersion = "25.05";

  # Enable user
  users.users.abc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
    password = "abc"; # for VM demo only, change on real system
  };

  # Sound via pipewire (remove sound.enable)
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = false;
  };

  # Hyprland + Wayland essentials
  programs.hyprland.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Display Manager with autologin
  services.displayManager.sddm = {
    enable = true;
    autoLogin.enable = true;
    autoLogin.user = "abc";
  };

  # Packages
  environment.systemPackages = with pkgs; [
    kitty
    waybar
    firefox
    zsh
    git
    neovim
    hyprpaper
    foot
    wget
    curl
    unzip
    xdg-utils
    xdg-user-dirs
    pavucontrol
    nerdfonts
    starship
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    font-awesome
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
}
