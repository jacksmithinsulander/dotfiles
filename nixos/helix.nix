{
    # HELIX
  programs.helix = {
    enable = true;
    settings = {
      
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
  };
}
