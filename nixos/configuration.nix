
{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
    ];

  # Boot Loader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  boot.supportedFilesystems = [ "ntfs" ];

  # Network
  # networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.useDHCP = false;
  networking.interfaces.enp0s20f0u2u2.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;


  fonts.fontconfig.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Asia/Singapore";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    zsh
    nitrogen
    haskellPackages.xmobar
    dmenu
    vanilla-dmz
    xlibs.xmodmap xlibs.xset xlibs.setxkbmap
  ];

  environment.shells = [ pkgs.zsh ];


  # Enable the X11 windowing system.
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = haskellPackages: [
    	haskellPackages.xmonad-contrib
    	haskellPackages.xmonad-extras
    	haskellPackages.extra
    	haskellPackages.xmonad
    ];
  };
  
  services.xserver.dpi = 192;
  services.xserver.enable = true;
  services.xserver.layout = "us";

  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xlibs.xsetroot}/bin/xsetroot -cursor_name ${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ/cursors/left_ptr &disown
  '';

  # Enable touchpad support.
  services.xserver.libinput.enable = true;


  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  
  # OpenGL
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva];

  # Users
  users.users.rush = {
    isNormalUser = true;
    home = "/home/rush";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.rush = import ./home.nix;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

