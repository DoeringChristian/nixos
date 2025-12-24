{
  config,
  pkgs,
  inputs,
  ...
}: {
   Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "doeringc";
  home.homeDirectory = "/home/doeringc";

  # allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
  
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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
    
    # Development tools
    git
    vim
    neovim
    tmux
    htop
    tree
    ripgrep
    fd
    fzf
    jq
    curl
    wget
    
    # Utilities
    unzip
    zip
    gzip
    which
    file
    less
    
# System monitoring
    btop
    ncdu
    duf
    
    tev
    
    # Network tools
    net-tools
    inetutils
    nmap
    traceroute
    
    # Fonts
    nerd-fonts.fira-code
    
  # Ubuntu-specific: fontconfig for better font rendering
  fonts.fontconfig.enable = true;
    
    # Inkscape with TexText extension
    (pkgs.inkscape-with-extensions.override {
      inkscapeExtensions = [
        pkgs.inkscape-extensions.textext
      ];
    })

    # Usefull high-level software
    easyeffects
    pika-backup
    syncthing
    bitwarden-desktop
    discord
    slack
    obsidian
    darktable
  ];

 # XDG configuration files
  xdg.configFile = {
    "fish" = {
      source = ./.config/fish;
      recursive = true;
    };
    "kitty" = {
      source = ./.config/kitty;
      recursive = true;
    };
  };
  


# Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Add custom paths
  home.sessionPath = [
    "$HOME/.pixi/bin"
  ];
  home.shell = {
    enableFishIntegration = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      direnv = {
        disabled = false;
      };
    };
  };
  programs.direnv = {
    enable = true;
    # enableFishIntegration = true;
    nix-direnv.enable = true;
  };
  programs.eza = {
    enable = true;
    git = true;
  };
  programs.bat = {
    enable = true;
  };
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };
  programs.claude-code = {
    enable = true;
  };
  programs.atuin = {
    enable = true;
    settings = {
      keymap_mode = "vim-insert";
    };
  };
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.fish = {
    enable = true;
    generateCompletions = true;
    shellInit = ''
      set -gx fish_key_bindings fish_user_key_bindings
    '';
    interactiveShellInit = ''
      set -gx fish_key_bindings fish_user_key_bindings
    '';
    functions = {
      fish_user_key_bindings = {
        body = ''
          fish_vi_key_bindings

          # Emulates vim's cursor shape behavior
          # Set the normal and visual mode cursors to a block
          set fish_cursor_default block
          # Set the insert mode cursor to a line
          set fish_cursor_insert line
          # Set the replace mode cursor to an underscore
          set fish_cursor_replace_one underscore
          # The following variable can be used to configure cursor shape in
          # visual mode, but due to fish_cursor_default, is redundant here
          set fish_cursor_visual block

          # Set timeout
          set -g fish_sequence_key_delay_ms 200

          # Mapping for jk to escape
          bind --mode insert --sets-mode default jk cancel repaint-mode
          # Mapping for jj to j
          bind -M insert jj 'commandline -i j'

          #Mapping for clipboard in vim mode
          bind yy fish_clipboard_copy
          bind Y fish_clipboard_copy
          bind p fish_clipboard_paste

          # Accept auto suggestions with `l`
          bind -M default l accept-autosuggestion
        '';
      };
      tb.body = "tensorboard $argv --samples_per_plugin images=1000000";
      "...".body = "../..";
      "....".body = "../../..";
    };
    shellAliases = {
      l = "eza -l -g --icons";
      ll = "l -a";
      la = "ll";
      jn = "jupyter notebook";
      jt = "jupytext --update --to notebook";
      je = "jupyter execute";
      cookie = "cookiecutter my --directory";
      jpg2webm = "ffmpeg -r 30 -i %d.jpg output.webmm";
    };
  };

  catppuccin = {
    enable = true;
    flavor = "macchiato";
  };
  #
  programs.fzf = {
    enable = true;
  };
  programs.gh = {
    enable = true;
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      core = {
        editor = "nvim";
      };
      user = {
        name = "Christian Döring";
        email = "christian.doering@tum.de";
      };
      credential = {
        helper = "store";
      };
      alias = {
        lg = "log --decorate --graph --abbrev-commit";
        adog = "log --all --decorate --oneline --graph --abbrev-commit";
        adogs = "log --all --decorate --oneline --graph --abbrev-commit --stat";
        dog = "log --decorate --oneline --graph --abbrev-commit";
        dogs = "log --decorate --oneline --graph --abbrev-commit --stat";
      };
      pull = {
        ff = "only";
      };
      merge = {
        ff = "only";
      };
    };
  };
  programs.kitty = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.kitty;
    enableGitIntegration = true;
    shellIntegration.enableFishIntegration = true;
    font = {
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
    };
    settings = {
      "tab_bar_min_tabs" = "1";
      "tab_bar_edge" = "bottom";
      "tab_bar_style" = "powerline";
      "tab_powerline_style" = "slanted";
      "tab_title_template" = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      "update_check_interval" = 0;
      "wayland_titlebar_color" = "background";
      "shell" = "fish";
      "allow_remote_control" = "yes";
      "listen_on" = "unix:/tmp/kitty";
      "kitty_mod" = "Alt";
      "startup_session" = "startup.conf";
    };
    keybindings = {
      "Alt+equal" = "change_font_size all +1.0";
      "Alt+plus" = "change_font_size all +1.0";
      "Alt+minus" = "change_font_size all -1.0";

      "kitty_mod+enter" = "launch --cwd=current";
      "kitty_mod+x" = "close_window";

      "kitty_mod+h" = "neighboring_window left";
      "kitty_mod+j" = "neighboring_window down";
      "kitty_mod+k" = "neighboring_window up";
      "kitty_mod+l" = "neighboring_window right";

      "kitty_mod+m" = "toggle_layout stack";
      "kitty_mod+w" = "new_tab";
      "kitty_mod+n" = "next_tab";
      "kitty_mod+p" = "previous_tab";

      "kitty_mod+e" = "kitty_scrollback_nvim";
      "kitty_mod+u" = "show_scrollback";

      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
    extraConfig = ''
      action_alias kitty_scrollback_nvim kitten ~/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py --nvim-args -u ~/.config/nvim/ksb.lua
    '';
  };

  programs.zathura = {
    enable = true;
  };

  # Brave Browser
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {id = "nngceckbapebfimnlniiiahkandclblb";} # bitwarden
    ];
    commandLineArgs = [
      "--disable-features=WebRtcAllowInputVolumeAdjustment"
    ];
  };

  dconf = {
    enable = true;

    settings = {
      "org/gnome/shell" = {
        # Set power profile
        last-selected-power-profile = "performance";
        # Add extensions
        enabled-extensions = [
          "gsconnect@andyholmes.github.io"
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
      };
      # Some UI changes (color-scheme, hot-corners and battery percentage)
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        show-battery-percentage = true;
      };
      # Mouse config
      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
        speed = 0.5;
      };
      # Touchpad config
      "org/gnome/desktop/peripherals/touchpad" = {
        natural-scroll = false;
      };
      # Configure keybindings
      "org/gnome/desktop/wm/keybindings" = {
        switch-windows = ["<Alt>Tab"];
      };
      "org/gnome/desktop/sound" = {
        event-sounds = false;
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,close";
      };
    };
  };
}
