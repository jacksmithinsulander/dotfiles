{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ted";
  home.homeDirectory = "/home/ted";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ted/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    #EDITOR = "helix";
  };

  # KITTY
  programs.kitty.enable = true;
  programs.kitty.settings = {
    # Font settings
    bold_font = "mononoki Bold";
    italic_font = "mononoki Italic";
    bold_italic_font = "mononoki Bold Italic";

    # Tab settings
    tab_bar_edge = "top";
    tab_bar_style = "slant";
    active_tab_foreground = "#fdf6e3";
    active_tab_background = "#268bd2";
    inactive_tab_foreground = "#073642";
    inactive_tab_background = "#eee8d5";
  };

  programs.kitty.theme = "Solarized Light";
  programs.kitty.font.name = "mononoki";

  # HELIX
  programs.helix.enable = true;
  programs.helix.settings = {
    theme = "solarized_light";
    editor = {
      line-number = "relative";
      mouse = false;
      rulers = [80];
      lsp.display-messages = true;
    };
    editor.cursor-shape = {
      insert = "bar";
    };
    keys.normal = {
      esc = ["collapse_selection" "keep_primary_selection"];
      A-up = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before"];
      A-down = ["extend_to_line_bounds" "delete_selection" "paste_after"];
    };
  };
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
