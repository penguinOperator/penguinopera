{ config, pkgs, ... }:

{
  imports = [ ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Basic networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Enable necessary X11 services
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.hyprland.enable = true;

  # Pipewire audio
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    font-awesome
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Enable automatic login (optional)
  services.displayManager.autoLogin = {
    enable = true;
    user = "abc";
  };

  # XDG desktop portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # Environment variables for Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  # Users
  users.users.abc = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    hyprland
    kitty
    waybar
    mako
    wlogout
    swaylock
    wofi
    firefox
    git
    neovim
    curl
    wget
    unzip
    zsh
    starship
    xdg-utils
    xdg-user-dirs
    file
    pavucontrol
    htop
    pciutils
    usbutils
  ];

  # Enable zsh
  programs.zsh.enable = true;

  # Allow unfree packages (e.g., some fonts or firmwares)
  nixpkgs.config.allowUnfree = true;
}
