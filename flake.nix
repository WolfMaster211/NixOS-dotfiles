{
  description = "NixOS configuration with Hyprland (flake-based)";

  inputs = {
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nix-gaming.url = "github:fufexan/nix-gaming";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-xivlauncher-rb = {
      url = "github:The1Penguin/nixos-xivlauncher-rb";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    "nix-alien" = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hyprland, stylix, nixos-xivlauncher-rb, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      nixAlien = inputs."nix-alien";
      nixAlienPkg = nixAlien.packages.${system}.nix-alien;
    in
    {
      nixosConfigurations.wolfy = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
          ./nixos/hardware-configuration.nix
          stylix.nixosModules.stylix
          nixos-xivlauncher-rb.nixosModules.default

          {
            # Add Hyprland module from the Hyprland flake
            imports = [ hyprland.nixosModules.default ];

            # Enable the Hyprland session and basic Wayland environment
            programs.hyprland.enable = true;

            # Fonts
            fonts = {
              fontconfig.enable = true;
            };

            # Enable polkit and desktop integration
            security.polkit.enable = true;
            services.dbus.enable = true;
            services.displayManager.sddm.enable = true;
            services.gvfs.enable = true;
            services.power-profiles-daemon.enable = true;

            # Optional: make Hyprland default for display manager
            services.xserver.enable = false;
            programs.hyprland.xwayland.enable = true;
            programs.nix-ld.enable = true;

            # <-- ADDED: put nix-alien on system PATH
            environment.systemPackages = with pkgs; [
              nixAlienPkg
            ];
          }
        ];
      };
    };
}