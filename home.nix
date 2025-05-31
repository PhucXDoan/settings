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
            programs.git.enable                 = true;
            programs.git.userName               = "phucxdoan";
            programs.git.userEmail              = "phucxdoan@gmail.com";
            programs.git.extraConfig.credential =
                {
#                    helper                        = "libsecret";
                    "https://github.com".username = "phucxdoan";
#                    credentialStore               = "cache";
                };

            # Miscellancious.
            home.username                = "root";
            home.homeDirectory           = "/root";
#            home.username                = "phucxdoan";
#            home.homeDirectory           = "/home/phucxdoan";
            home.stateVersion            = "24.05"; # Initial home-manager version. @/(home-manager-options.extranix.com/?query=home.stateVersion).
            programs.home-manager.enable = true;
        };
}
