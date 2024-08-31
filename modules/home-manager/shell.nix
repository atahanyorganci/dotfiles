{ pkgs
, lib
, config
, user
, ...
}:
let
  cfg = config.shell;
  shellAliases = {
    # get OS name ex: "GNU/Linux", "Darwin"
    os = "uname -o";
    # `ll` - list files with long format with `eza`
    ll = "${pkgs.eza}/bin/eza --long --header --icons";
    # `tree` - list files in a tree format with `eza`
    tree = "${pkgs.eza}/bin/eza --tree --long --header --icons";
  };
  enable = cfg.fish.enable || cfg.zsh.enable || cfg.bash.enable;
  initExtra = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
in
{
  options.shell = {
    fish = {
      enable = lib.mkEnableOption "Fish shell";
      addInitExtra = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to add `initExtra` to other shells to run Fish shell by default";
      };
    };
    zsh.enable = lib.mkEnableOption "zsh";
    bash.enable = lib.mkEnableOption "bash";
  };
  config = lib.mkIf enable {
    home.shellAliases = shellAliases;
    home.sessionVariables = {
      GITHUB_HOME = "${config.xdg.userDirs.documents}/GitHub";
    };
    programs.bash = lib.mkIf cfg.bash.enable {
      enable = true;
      enableCompletion = true;
      historyFile = "${config.xdg.stateHome}/bash/history";
      initExtra = if cfg.fish.addInitExtra && cfg.bash.enable then initExtra else "";
    };
    programs.zsh = lib.mkIf cfg.zsh.enable {
      enable = true;
      enableCompletion = true;
      history = {
        path = "${config.xdg.stateHome}/zsh/history";
        share = true;
      };
      initExtra = if cfg.fish.addInitExtra && cfg.zsh.enable then initExtra else "";
    };
    programs.fish = lib.mkIf cfg.fish.enable {
      enable = true;
      plugins = [
        {
          name = "autopair.fish";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "autopair.fish";
            rev = "1.0.4";
            sha256 = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU=";
          };
        }
        {
          name = "gitnow";
          src = pkgs.fetchFromGitHub {
            owner = "joseluisq";
            repo = "gitnow";
            rev = "2.12.0";
            sha256 = "sha256-PuorwmaZAeG6aNWX4sUTBIE+NMdn1iWeea3rJ2RhqRQ=";
          };
        }
        {
          name = "sponge";
          src = pkgs.fetchFromGitHub {
            owner = "meaningful-ooo";
            repo = "sponge";
            rev = "1.1.0";
            sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
          };
        }
        {
          name = "${user.username}-config";
          src = ../../plugins/config;
        }
        {
          name = "${user.username}-tools";
          src = ../../plugins/tools;
        }
      ];
    };
    # starship - The minimal, blazing-fast, and infinitely customizable prompt for any shell!
    # GitHub Repository: https://github.com/starship/starship
    programs.starship = {
      enable = enable;
      enableBashIntegration = cfg.bash.enable;
      enableZshIntegration = cfg.zsh.enable;
      enableFishIntegration = cfg.fish.enable;
      settings = {
        aws.disabled = true;
        gcloud.disabled = true;
      };
    };
    # fzf - A command-line fuzzy finder
    # GitHub Repository: https://github.com/junegunn/fzf
    programs.fzf = {
      enable = enable;
      enableBashIntegration = cfg.bash.enable;
      enableZshIntegration = cfg.zsh.enable;
      enableFishIntegration = cfg.fish.enable;
      historyWidgetOptions = [ "--prompt='History> '" ];
    };
    # zoxide - A smarter cd command.
    # GitHub Repository: https://github.com/ajeetdsouza/zoxide
    programs.zoxide = {
      enable = enable;
      enableBashIntegration = cfg.bash.enable;
      enableZshIntegration = cfg.zsh.enable;
      enableFishIntegration = cfg.fish.enable;
    };
    home.packages = with pkgs; [
      eza
      bat
      delta
      fd
      sd
      ripgrep
      jq
    ];
  };
}
