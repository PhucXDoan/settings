{ config, pkgs, ...  }:
{
	imports = [./hardware-configuration.nix];

	config =
		{
			environment.systemPackages =
				with pkgs;
				[
					git
					git-credential-manager
					gcc14
					python314
					cloc
					gcc-arm-embedded-13
					vimHugeX  # Vim with stuff for X11 (e.g. clipboard).
					usbutils  # For `lsusb`.
				];

			# For my TP-Link Archer T2U Plus USB WiFi adapter.
			boot.extraModulePackages = [config.boot.kernelPackages.rtl8821au];

			# Allow usage for the new Nix CLI and Nix flakes.
			nix.settings.experimental-features = ["nix-command" "flakes"];

			# User profile.
			networking.hostName = "phucxdoan-nixos";
			users.users         =
				{
					phucxdoan =
						{
							isNormalUser = true;
							description  = "Phuc X. Doan";
							extraGroups  =
								[
									"networkmanager"
									"wheel"
								];
						};
				};
			services.displayManager.autoLogin.enable = true;
			services.displayManager.autoLogin.user   = "phucxdoan";
			systemd.services."getty@tty1".enable     = false; # Workaround for GNOME autologin. @/(github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229).
			systemd.services."autovt@tty1".enable    = false; # "

			# Miscellancious.
			time.timeZone                                = "America/New_York";
			i18n.defaultLocale                           = "en_US.UTF-8";
			networking.networkmanager.enable             = true;
			boot.loader.systemd-boot.enable              = true;
			boot.loader.efi.canTouchEfiVariables         = true;
			programs.firefox.enable                      = true;
			services.xserver.enable                      = true;
			services.xserver.displayManager.gdm.enable   = true;
			services.xserver.desktopManager.gnome.enable = true;
			services.printing.enable                     = true;
			services.pulseaudio.enable                   = false;
			security.rtkit.enable                        = true;
			services.pipewire.enable                     = true;
			services.pipewire.alsa.enable                = true;
			services.pipewire.alsa.support32Bit          = true;
			services.pipewire.pulse.enable               = true;
			nixpkgs.config.allowUnfree                   = true;
			system.stateVersion                          = "24.11"; # Initial NixOS version. @/(search.nixos.org/options?show=system.stateVersion).
		};
}
