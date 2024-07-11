{ pkgs, lib, config, ... }:

  let
    startScript = pkgs.pkgs.writeShellScriptBin "start" ''
      ${pkgs.swww}/bin/swww init &
      ${pkgs.networkmanagerapplet}/bin/nm --indicator &

      hyprctl setcursor Bibata-Modern-Ice 16 &

      systemctl --user import-environment PATH &
      systemctl --user restart xdg-desktop-portal.service &

      swaync &
      waybar &

      sleep 2 & 
  
      ${pkgs.swww}/bin/swww img ${./black.png} &
    '';
in
{
  options = {
    hyprlandExtra = lib.mkOption {
      default = "";
      description = ''
        extra hyprland config lines
      '';
    };
  };

  config = {
    wayland.windowManager.hyprland = {
      #package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      enable = true;
      # enableNvidiaPatches = true;

      settings = {
        input = {
          kb_layout = "se";
          kb_variant = "";
          kb_model = "";
        };

        bind = 
          [
            "alt, space, exec, rofi -show drun -show-icons"
            "alt, n, exec, wezterm"

            #PRESETS            
            # Work
            "alt, w, exec, slack & spotify & codium & wezterm & discord"

            # Chill
            "alt, c, exec, firefox & codium & wezterm & discord"

            # Programming
            "alt, p, exec, codium & wezterm"           

            "alt, s, exec, grim -g $(slurp) $(xdg-user-dir PICTURES)/$(date +'%s_grim.png')"
            "alt shift, s, exec, grim $(xdg-user-dir PICTURES)/$(date +'%s_grim.png')"

            "alt, q, killactive"
            "alt shift, f, togglefloating,"
            
            "alt, left, movefocus, l"
            "alt, up, movefocus, u"
            "alt, down, movefocus, d"
            "alt, right, movefocus, r"
            "super, left, movewindow, l"
            "super, up, movewindow, u"
            "super, down, movewindow, d"
            "super, right, movewindow, r"
          ];
        exec-once = [
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "${pkgs.bash}/bin/bash ${startScript}/bin/start"
        ];
      };
    };
  };
}
