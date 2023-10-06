{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rwhite";
  home.homeDirectory = "/home/rwhite";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  programs.git = {
    enable = true;
    userName = "René White";
    userEmail = "rwhite@apexsystems.com";
  };
  
  home.packages = with pkgs; [
    #Themes
    fluent-gtk-theme
    flat-remix-gtk
    graphite-gtk-theme
    juno-theme
    # Icon themes
    colloid-icon-theme
    vimix-icon-theme
    flat-remix-icon-theme
    numix-icon-theme
    numix-icon-theme-circle
    numix-icon-theme-square
    papirus-icon-theme
    # Cursors
    nordzy-cursor-theme
  ];
}
