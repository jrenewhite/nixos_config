# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  # vscode-base = import ./vscode-base.nix { inherit pkgs; };
in
{
  # If home-manager channel is not available, add it with the following lines
  # sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
  # sudo nix-channel --update
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      
      # Importing home-manager
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  #To allow obs virtual camera
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_MX.UTF-8";
    LC_IDENTIFICATION = "es_MX.UTF-8";
    LC_MEASUREMENT = "es_MX.UTF-8";
    LC_MONETARY = "es_MX.UTF-8";
    LC_NAME = "es_MX.UTF-8";
    LC_NUMERIC = "es_MX.UTF-8";
    LC_PAPER = "es_MX.UTF-8";
    LC_TELEPHONE = "es_MX.UTF-8";
    LC_TIME = "es_MX.UTF-8";
  };

  # Install Fcitx5
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };


  # Install Japanese fonts
  fonts.fonts = with pkgs; [
    ipafont
    ipaexfont
    mplus-outline-fonts.githubRelease
    noto-fonts-cjk
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "es";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "es";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable drawing tablets
  hardware.opentabletdriver.enable = true;
  
  # Enable solaar and logitech stuff
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true; # for solaar to be included

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jrenewhite = {
    isNormalUser = true;
    description = "José René White Enciso";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  
  users.users.rwhite = {
    isNormalUser = true;
    description = "René White @ Apex";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    uid = null;  # Let NixOS automatically assign a UID
    home = "/home/rwhite";  # Set the home directory path
    createHome = true;  # Create the home directory
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jrenewhite = import ./jrenewhite-home.nix;
    users.rwhite = import ./rwhite-home.nix;
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neofetch
    gnome.gnome-tweaks
    libreoffice
    joplin-desktop
    dynamic-wallpaper
    # browsers
    firefox
    microsoft-edge
    #development
    gitFull
    # vscode.fhs
    azuredatastudio
    #coding stuff
    vscode.fhs
    docker
    powershell
    #SDKs
    dotnet-sdk_7
    python3
    # Fcitx5 configuration tool
    fcitx5-configtool
    # Mozc tool
    fcitx5-mozc
  ];

  # Default apps
  environment.variables = {
    EDITOR = "code";
    BROWSER = "microsoft-edge";
    MAILTOOL = "thunderbird";
  };

  #remove pre installed packages:
  environment.gnome.excludePackages = (with pkgs; [
    # gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    # gnome-terminal
    # gedit # text editor
    epiphany # web browser
    geary # email reader
    # evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);
  
  virtualisation.docker.enable = true;
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
