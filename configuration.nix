{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Basic system info
  system.stateVersion = "25.05"; # match your NixOS version
  networking.hostName = "nixos"; # change if you want

  # Timezone and locale
  time.timeZone = "Asia/Taipei";
  i18n.defaultLocale = "en_US.UTF-8";

  # User account
  users.users.6hw = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    password = "yourpassword"; # Change this, or better use hashed password
    shell = pkgs.fish;
  };

  # Enable sudo for wheel group without password (optional)
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Enable networking - both ethernet and wifi (NetworkManager)
  networking.networkmanager.enable = true;

  # Enable sound with PulseAudio (default)
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Fonts
  fonts.fontconfig.enable = true;
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  # Enable SDDM as display manager
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.hyprland.enable = true;

  # Use Wayland (Hyprland is Wayland compositor)
  services.xserver.displayManager.sddm.wayland = true;

  # Enable Hyprland from nixpkgs
  environment.systemPackages = with pkgs; [
    hyprland
    wayland-protocols
    xorg.xwayland
    fish
    starship
    kitty
    wlogout
  ];

  # Boot loader (adjust for BIOS or UEFI)
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # Adjust if your disk is different

  # Enable NTP for time synchronization
  services.ntp.enable = true;

  # Misc
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # Enable OpenSSH (optional)
  services.openssh.enable = true;

  # Enable firewall (basic)
  networking.firewall.enable = true;

  # Other services or packages you want can be added here

}
