{ pkgs, inputs, ... }:
with pkgs; [
    wget curl unzip git gh vim neovim figlet nixfmt-rfc-style
    jq rsync xdg-utils xdg-user-dirs
    flatpak gum fzf libnotify
    polkit hyprpolkitagent
    vulkan-tools
    meson ninja pipx
    gcc pkg-config cairo python313
    python313Packages.screeninfo
    python313Packages.pygobject3
    python313Packages.pycairo
    # Tools
    eza imagemagick htop blueman
    grim slurp cliphist
    # Hyprland ecosystem
    hyprpaper hyprlock hypridle
    hyprpicker hyprland-qt-support
    qt6Packages.qt6ct papirus-icon-theme colloid-icon-theme bibata-cursors
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    waybar rofi swaynotificationcenter
    nwg-look nwg-dock-hyprland
    zsh zsh-completions fish
    power-profiles-daemon
    kitty pavucontrol vlc mpv
    nautilus nautilus-open-any-terminal code-nautilus nautilus-python
    wlogout waypaper python3
    oh-my-posh fastfetch
    material-icons
    # Fonts
    cantarell-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome
    fira-code
    fira-code-symbols
    #Personal
    gnome-keyring
    vscode virtualgl
    solaar gnomeExtensions.solaar-extension
	prismlauncher
    (xivlauncher-rb.override { useGameMode = true; })
	kitty qbittorrent
    steam lutris mangohud
    steamtinkerlaunch
    winetricks protontricks
    wineWowPackages.waylandFull
    ed-odyssey-materials-helper
	spice-vdagent
    vesktop spotify-player
    #obs-studio-plugins.wlrobs obs-studi-plugins.obs-vkcapture obs-studio-plugins.obs-vaapi
    #obs-studio-plugins.obs-pipewire-audio-capture
    inputs.zen-browser.packages."${system}".default
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.osu-stable
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-osu
]
