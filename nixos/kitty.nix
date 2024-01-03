{
  # KITTY
  programs.kitty = {
    enable = true;
    settings = {
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

    theme = "Solarized Light";
    font.name = "mononoki";
  };
}