{
    description = "Flake for configuring NixOS.";

    inputs =
        {
            nixpkgs.url                         = "github:nixos/nixpkgs/release-25.05";
            nixos-wsl.url                       = "github:nix-community/NixOS-WSL/main";
            home-manager.url                    = "github:nix-community/home-manager/release-25.05";
            home-manager.inputs.nixpkgs.follows = "nixpkgs";
        };

    outputs =
        { self, nixpkgs, nixos-wsl, home-manager }:
        let system = "x86_64-linux"; in
        {
            nixosConfigurations.phucxdoan-nixos =
                nixpkgs.lib.nixosSystem
                {
                    system      = system;
                    modules     =
                        [
                            nixos-wsl.nixosModules.default
                            ./configuration.nix
                        ];
                };

#            homeConfigurations.phucxdoan =
            homeConfigurations.root =
                home-manager.lib.homeManagerConfiguration
                {
                    pkgs    = nixpkgs.legacyPackages.${system};
                    modules = [./home.nix];
                };
        };
}
