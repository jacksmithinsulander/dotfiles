{
  pkgs,
  ...
}: let

  mainWaybarConfig = {
    layer = "top";
    gtk-layer-shell = true;
    height = 60;
    position = "top";
    modules-center = ["hyprland/workspaces"];
    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = {
        empty = "<span font='11' rise='-3000'>󰑊</span>";
        active = "<span font='13' rise='-3000'>󰮯</span>";
        default = "<span font='13' rise='-3000'>󰊠</span>";
      };
    };
  };

in {
  programs.waybar = {
    enable = true;
    #package = pkgs.waybar.overrideAttrs (oldAttrs: {
    #  mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
    #});
    settings = {mainBar = mainWaybarConfig;};
  };
}
