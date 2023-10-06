{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jrenewhite";
  home.homeDirectory = "/home/jrenewhite";

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
    userName = "José René White Enciso";
    userEmail = "jrenewhite@gmail.com";
  };
  

  home.packages = with pkgs; [
    godot_4
    krita
    xournalpp
    obs-studio
    skypeforlinux
    onedrive
    zettlr
    # email
    thunderbird
    #Themes
    orchis-theme
    fluent-gtk-theme
    flat-remix-gtk
    # Icon themes
    fluent-icon-theme
    # Cursors
    nordzy-cursor-theme 
  ];
}
