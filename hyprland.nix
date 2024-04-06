# home.nix

{ pkgs, lib, config, ... }:

  let
    startScript = pkgs.pkgs.writeShellScriptBin "start" ''
      ${pkgs.swww}/bin/swww init &
      ${pkgs.networkmanagerapplet}/bin/nm --indicator &

      hyprctl setcursor Bibata-Modern-Ice 16 &

      systemctl --user import-environment PATH &
      systemctl --user restart xdg-desktop-portal.service &

      sleep 2 
  
      ${pkgs.swww}/bin/swww img ${./black.png} &
      waybar
    '';
in
{
  # wayland.windowManager.hyprland = {
  #  enable = true;
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
        bind = 
          [
            "alt, return, exec, wofi --show drun"
            "alt, space, exec, tofi-drun --drun-launch=true"
            "alt, n, exec, wezterm"
            
            # Work
            "alt, w, exec, slack & spotify & codium & wezterm & discord"

            # Chill
            "alt, c, exec, firefox & codium & wezterm & discord"

            # Programming
            "alt, p, exec, codium & wezterm"           

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
