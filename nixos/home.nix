{ pkgs, lib, ... }:

let
  configPath = ".config";  
in {

  nixpkgs.config.allowUnfree = true;

  programs.home-manager.enable = true;


  home.packages = with pkgs; [

    # Apps
    transmission-gtk
    firefox-bin

    # Games
    steam

    # Music
    spotify

    # Video
    vlc

    # Text Editors
    emacs

    # Fonts
    mononoki
    jetbrains-mono
    fira-code
    fira-code-symbols
    source-code-pro
    font-awesome

    # Utils
    unzip
    xclip
    neofetch
    exa
    ripgrep
    bat
    curl
    wget
    jq
    tldr
    ripgrep

    # Image
    gimp
    gthumb

    # Go
    go

    # Haskell
    stack
  ];

  programs.alacritty = {
    enable = true;
    settings = lib.attrsets.recursiveUpdate (import ./alacritty.nix) {
    };
  };

  programs.git = {
    enable = true;
    userName = "Hrishikesh Sawant";
    userEmail = "hrishikesh.sawant322@gmail.com";
    extraConfig = {
      color.ui = true;
    };
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./neovim.vim;

    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-surround
      vim-commentary
      vim-easy-align
      nerdtree
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    autocd = true;
    shellAliases = import ./aliases.nix;
    defaultKeymap = "emacs";
  };

  programs.starship.enable = true;

  xresources = {
    properties = {
      "Xft.dpi" = 192;
      "Xft.antialias" = true;
      "Xft.rgba" = "rgb";

      "XTerm*renderFont" = true;
      "XTerm*faceName" = "xft =Mononoki Nerd Font, xft =Jetbrains Mono =size=14, xft =Monospace =style=Medium =size=14";
      "XTerm*faceSize" = 11;
      "XTerm*utf8" = 2;
      "XTerm*locale" = true;
      "Xcursor.size" = 128;
      "XTerm*loginshell" = true;
      "XTerm*savelines" = 16384;
      "XTerm*charClass" = [ "33 =48" "36-47 =48" "58-59 =48" "61 =48" "63-64 =48" "95 =48" "126 =48" ];
    };
  };

  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
  };


}
