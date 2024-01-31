{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware-acceleration.nix
      ./musnix
    ];

  # Bootloader.
  boot = {
    loader = {
      grub.enable = true;
      grub.device = "/dev/sda";
      grub.useOSProber = true;
    };
  };

  networking = {
    hostName = "unabomber"; # Define your hostname.
    networkmanager.enable = true;  
    firewall.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  services = {
    # Enable the X11 windowing system.
    xserver.enable = true;
    xserver = {
      # Enable the Plasma Desktop Environment.
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      # Configure keymap in X11
      layout = "se";
      xkbVariant = "";
    };
    mysql = {
      enable = true;
      package = pkgs.mysql80;
    };
    # Enable fwupd.
    fwupd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;                                                                                                                                                                                 
      pulse.enable = true;
      jack.enable = true;
    };    
    gvfs.enable = true;
    mullvad-vpn.enable = true;
    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };
  
  system.autoUpgrade.enable = true;

  # Generate caches for `apropos`, `whatis`, etc.
  documentation.man.generateCaches = true;

  # Set shell aliases for all users
  environment.shellAliases = {
    ls = "eza";
    ll = "ls -l";
  };

  musnix ={
    enable = true;
    kernel.realtime = true;
  };

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    gwenview
    okular
    oxygen
    khelpcenter
    konsole
    plasma-browser-integration
    print-manager
  ];

  services.xserver.excludePackages = [ pkgs.xterm ];

  # Configure console keymap
  console.keyMap = "sv-latin1";

  nix = {
    settings = { 
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    # Enable automatic pruning of generations older than 30 days
    gc.automatic = true;
    gc.options = "--delete-older-than 30d";
  };
 
  programs.fish.enable = true;

  programs.spacefm.enable = true;

  security.rtkit.enable = true;
  # Enable sound with pipewire.
  sound.enable = true;
  
  hardware = { 
    pulseaudio.enable = false;
    opengl.enable = true;
    nvidia.open = true;
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = true;
    steam-hardware.enable = true;
    # ENable closed source firmware
    enableRedistributableFirmware = true;
  };
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ted = {
    isNormalUser = true;
    description = "Theodore Kaczynski";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker"];
    shell = pkgs.fish;
    packages = with pkgs; [
      #BROWSERS
      firefox
      ungoogled-chromium
      brave
      tor
      vivaldi

      #VPN
      mullvad-vpn

      #CHATT
      tdesktop
      discord
      #teams
      slack

      #MUSIC
      spotify

      #PASSWORDMANAGER
      keepassxc

      #CREATIVE
      gimp
      blender
      obs-studio
      mpv
      kdenlive
      libreoffice-qt
      
      #ORG
      evolution
      spaceFM
      liferea
      claws-mail
      obsidian

      #SINS
      lutris
      heroic
      vulkan-tools
    ];
  };

  users.extraGroups.docker.members = ["ted"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    #TEXT EDITORS
    (vis.overrideAttrs (old: {patches = [./patches/vis/communicate.patch];}))
    emacs
    wily
    helix
    vscodium

    #FONTS
    mononoki

    #PROG
    python311
    nodejs_20
    (lua.withPackages(ps: with ps; [ http ]))
    gcc
    rustup
    rust-analyzer-unwrapped    
    lldb
    nil
    lua-language-server
    python311Packages.python-lsp-server
    python311Packages.pytest
    mypy
    editorconfig-checker
    luajitPackages.lua-lsp
    luajitPackages.luarocks-nix
    (python311.withPackages(ps: with ps; [ pip pandas matplotlib numpy pypytools ]))
    #(pkgs.callPackage /home/ted/prog/nixpkgs/pkgs/development/interpreters/zenroom/default.nix {})
    docker
    solc
    nodePackages.typescript-language-server
    mysql80  
    evcxr
 
    #TOOLS
    wget
    curl
    imagemagick
    sqlite
    sent
    plan9port
    git
    neofetch
    htop
    zip
    unzip
    virtualenv
    gnumake
    eza
    lf

    #TERM AND SHELL
    kitty
    fish

    #MUSIC MAKING
    ardour
    drumgizmo
    zynaddsubfx
    carla
    bespokesynth
    sonic-pi
    puredata
    cardinal
    calf
    tunefish
    airwindows-lv2
    odin2
    helm
    vcv-rack
    boops
    distrho
    lsp-plugins
    surge-XT
    surge
    ninjas2
    artyFX
    fmsynth
    fverb
    metersLv2
    zam-plugins
    molot-lite
    vocproc
    guitarix
    gxplugins-lv2
    geonkick
    schismtracker

    #AUDIO
    pipewire
    qpwgraph
    jack2
    qjackctl
  ];

  programs.git = {
    enable = true;
    config = {
      user.email="666.jack.smith@protonmail.com";
      user.name="jacksmithinsulander";
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "teams-1.5.00.23861"
    "electron-24.8.6"
    "electron-25.9.0"
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = { 
    enable = true;
    setSocketVariable = true;
  };

#  environment.variables = {
#    DSSI_PATH   = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
#    LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
#    LV2_PATH    = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2";
#    LXVST_PATH  = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst";
#    VST_PATH    = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst";
#    VST3_PATH   = "$HOME/.vst3:$HOME/.nix-profile/lib/vst3:/run/current-system/sw/lib/vst3";
#  };

  programs.steam.enable = true;
  system.stateVersion = "22.11"; 
}
