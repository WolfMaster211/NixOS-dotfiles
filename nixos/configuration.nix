# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [

    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.useOSProber = true;
  zramSwap.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs = {
   java.enable = true;
   hyprland = {
   enable = true;
   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
   portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    gamemode.enable = true;
    gamescope = {
      enable = true;
      capSysNice = true;
      };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = false;
    };
    fish = {
      enable = true;
      generateCompletions = true;
      shellAliases = {
        update = "sudo nixos-rebuild switch --flake ./nix";
     };
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
       wlrobs
       obs-backgroundremoval
       obs-pipewire-audio-capture
       obs-vaapi #optional AMD hardware acceleration
       obs-gstreamer
       obs-vkcapture
      ];
    };
  };

  programs.nautilus-open-any-terminal.enable = true;
  programs.nautilus-open-any-terminal.terminal = "kitty";

  users.extraUsers.wolfy = {
   enable = true;
   shell = pkgs.fish;
  };

  programs.zsh = {
   enable = true;
   enableCompletion = true;
   enableBashCompletion = true;
   autosuggestions.enable = true;
   syntaxHighlighting.enable = true;
   ohMyZsh.enable = true;
   };

  networking.hostName = "wolfy"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Tallinn";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "et_EE.UTF-8";
    LC_IDENTIFICATION = "et_EE.UTF-8";
    LC_MEASUREMENT = "et_EE.UTF-8";
    LC_MONETARY = "et_EE.UTF-8";
    LC_NAME = "et_EE.UTF-8";
    LC_NUMERIC = "et_EE.UTF-8";
    LC_PAPER = "et_EE.UTF-8";
    LC_TELEPHONE = "et_EE.UTF-8";
    LC_TIME = "et_EE.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.gvfs.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.defaultUserShell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wolfy = {
    isNormalUser = true;
    description = "wolfy";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  services.flatpak.enable = true;
  nixpkgs.config.allowUnfree = true;
  services.gnome.gnome-keyring.enable = true;

  stylix = {
    enable = true;
    base16Scheme = {
      base00 = "191724";
      base01 = "1f1d2e";
      base02 = "26233a";
      base03 = "6e6a86";
      base04 = "908caa";
      base05 = "e0def4";
      base06 = "e0def4";
      base07 = "524f67";
      base08 = "eb6f92";
      base09 = "f6c177";
      base0A = "ebbcba";
      base0B = "31748f";
      base0C = "9ccfd8";
      base0D = "c4a7e7";
      base0E = "f6c177";
      base0F = "524f67";
    };
    polarity = "dark";
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
  };

  hardware = {
    graphics = {
        enable = true;
        enable32Bit = true;
    };
  };

  #Packages
  environment.systemPackages = with pkgs; import ./packages.nix { inherit pkgs inputs; };

  system.stateVersion = "25.05"; # Did you read the comment?

}
