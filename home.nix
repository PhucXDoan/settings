{ config, pkgs, ... }:
{
	config =
		{
			# Dotfiles.
			home.file =
				{
					".vimrc".source = ./.vimrc;
				};

			# Git.
			programs.git.enable    = true;
			programs.git.userName  = "PhucXDoan";
			programs.git.userEmail = "phucxdoan@gmail.com";

			# Miscellancious.
			home.username                = "phucxdoan";
			home.homeDirectory           = "/home/phucxdoan";
			home.stateVersion            = "24.05"; # Initial home-manager version. @/(home-manager-options.extranix.com/?query=home.stateVersion).
			programs.home-manager.enable = true;
		};
}
