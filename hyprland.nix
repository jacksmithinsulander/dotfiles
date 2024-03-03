# home.nix

{ pkgs, lib, config, ... }:

  let
    startScript = pkgs.pkgs.writeShellScriptBin "start" ''
      ${pkgs.swww}/bin/swww init &
      ${pkgs.networkmanagerapplet}/bin/nm --indicator &

      hyprctl setcursor Bibata-M     hyprctl setcursor Bibata-Modern-Ice 16 &

      systemctl --user import-environment PATH &
      systemctl --user restart xdg-desktop-portal.service &

      # wait a tiny bit for wallpaper
      sleep 2
  
      ${pkgs.swww}/bin/swww img ${./black.png} &
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
            "alt, return, exec, kitty"
            "alt, space, exec, wezterm"
          ];
        exec-once = [
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "${pkgs.bash}/bin/bash ${startScript}/bin/start"
          "waybar"
        ];
      };
    };
  };
}
