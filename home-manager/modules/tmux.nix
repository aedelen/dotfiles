{ lib, pkgs, ... }:
{
  options = {
    tmuxModule.enable = lib.mkEnableOption "enables tmux enviroment";
  };
  config = {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      prefix = "C-s";
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      sensibleOnTop = true;

      plugins = with pkgs; [
        tmuxPlugins.sensible

        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            set -g @catppuccin_window_status_style "rounded"

            set -g @catppuccin_window_default_fill "number"
            set -g @catppuccin_window_text "#W"

            set -g @catppuccin_window_current_fill "number"
            set -g @catppuccin_window_current_text "[#W]"
          '';
        }
      ];

      extraConfig = ''
        # Enable mouse support
        set -g mouse on

        # Move tmux status bar to top of screen
        set-option -g status-position top

        # Enabling color support in tmux
        set-option -a terminal-features 'xterm-256color:RGB'

		# Kill session
		bind-key Q kill-session
      '';
    };
  };
}
